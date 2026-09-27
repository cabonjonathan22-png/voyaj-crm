import 'package:logging/logging.dart';
import 'package:postgres/postgres.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../audit/audit_log.dart';
import '../db/database.dart';
import '../errors.dart';
import '../security/passwords.dart';
import '../security/rate_limiter.dart';
import '../security/secret_cipher.dart';
import '../security/tokens.dart';
import '../security/totp.dart';
import 'auth_context.dart';

/// Appelé après la révocation de sessions (fermeture des WebSockets).
typedef SessionsRevokedListener = void Function(List<String> sessionIds);

final _log = Logger('auth');

/// Authentification : connexion, 2FA TOTP, sessions et jetons.
///
/// Jetons opaques : le jeton d'accès (courte durée) et le jeton de
/// rafraîchissement (rotation à chaque usage) sont stockés hachés. Chaque
/// requête vérifie la session en base : une révocation est immédiate.
final class AuthService {
  AuthService({
    required this._db,
    required this._hasher,
    required this._cipher,
    required this.accessTtl,
    required this.refreshTtl,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now,
       _loginLimiter = RateLimiter(
         maxAttempts: 10,
         window: const Duration(minutes: 15),
         clock: clock,
       );

  final Database _db;
  final PasswordHasher _hasher;
  final SecretCipher _cipher;
  final DateTime Function() _clock;
  final RateLimiter _loginLimiter;
  final Duration accessTtl;
  final Duration refreshTtl;

  static const challengeTtl = Duration(minutes: 5);
  static const maxChallengeAttempts = 5;
  static const recoveryCodeCount = 10;

  /// Délai pendant lequel la réutilisation de l'ancien jeton de
  /// rafraîchissement est tolérée (requêtes concurrentes du même poste).
  static const refreshReuseGrace = Duration(seconds: 30);

  SessionsRevokedListener? onSessionsRevoked;

  DateTime _now() => _clock().toUtc();

  // ── Connexion ────────────────────────────────────────────────────────

  Future<LoginResponse> login(LoginRequest request, RequestMeta meta) async {
    final email = request.email.trim().toLowerCase();
    final limiterKey = '$email|${meta.ip}';
    if (!_loginLimiter.allow(limiterKey)) {
      throw const ApiException.tooManyAttempts();
    }

    final user = await _db.run(
      (s) => s.queryOne(
        'SELECT id, password_hash, status, totp_enabled_at FROM users '
        'WHERE email = @email',
        {'email': email},
      ),
    );

    final passwordOk = user == null
        ? await _hasher.burn(request.password).then((_) => false)
        : await _hasher.verify(
            request.password,
            user['password_hash'] as String,
          );

    if (!passwordOk) {
      _loginLimiter.recordFailure(limiterKey);
      await _db.tx(
        (tx) => AuditLog.append(
          tx,
          AuditEvent(
            action: AuditActions.loginFailed,
            actorUserId: user?['id'] as String?,
            payload: {'email': email},
            ip: meta.ip,
          ),
        ),
      );
      throw const ApiException(
        401,
        ApiErrorCodes.invalidCredentials,
        'Email ou mot de passe incorrect.',
      );
    }
    _loginLimiter.reset(limiterKey);
    final userId = user!['id'] as String;

    if (user['status'] != UserStatus.active.name) {
      throw const ApiException(
        403,
        ApiErrorCodes.accountDisabled,
        'Ce compte est désactivé.',
      );
    }

    if (_hasher.needsRehash(user['password_hash'] as String)) {
      final rehashed = await _hasher.hash(request.password);
      await _db.query('UPDATE users SET password_hash = @h WHERE id = @id', {
        'h': rehashed,
        'id': userId,
      });
    }

    if (user['totp_enabled_at'] != null) {
      final token = randomToken();
      await _db.query(
        'INSERT INTO auth_challenges (token_hash, user_id, device, ip, '
        'user_agent, expires_at) VALUES (@h, @u, @device:jsonb, @ip, @ua, '
        '@exp)',
        {
          'h': hashToken(token),
          'u': userId,
          'device': request.device.toJson(),
          'ip': meta.ip,
          'ua': meta.userAgent,
          'exp': _now().add(challengeTtl),
        },
      );
      return LoginResponse.mfaRequired(mfaToken: token);
    }

    return _db.tx((tx) => _openSession(tx, userId, request.device, meta));
  }

  /// Seconde étape de connexion : code TOTP ou code de secours.
  Future<LoginResponse> verifyMfa(
    MfaVerifyRequest request,
    RequestMeta meta,
  ) async {
    final outcome = await _db.tx((tx) async {
      final challenge = await tx.queryOne(
        'SELECT * FROM auth_challenges WHERE token_hash = @h FOR UPDATE',
        {'h': hashToken(request.mfaToken)},
      );
      if (challenge == null ||
          (challenge['expires_at'] as DateTime).isBefore(_now())) {
        return const _MfaOutcome.failure(
          ApiException(
            401,
            ApiErrorCodes.unauthenticated,
            'La vérification a expiré. Reconnectez-vous.',
          ),
        );
      }
      final userId = challenge['user_id'] as String;
      if ((challenge['attempts'] as int) >= maxChallengeAttempts) {
        await tx.query('DELETE FROM auth_challenges WHERE token_hash = @h', {
          'h': challenge['token_hash'],
        });
        return const _MfaOutcome.failure(ApiException.tooManyAttempts());
      }

      if (!await _checkSecondFactor(tx, userId, request.code, meta)) {
        await tx.query(
          'UPDATE auth_challenges SET attempts = attempts + 1 '
          'WHERE token_hash = @h',
          {'h': challenge['token_hash']},
        );
        await AuditLog.append(
          tx,
          AuditEvent(
            action: AuditActions.mfaFailed,
            actorUserId: userId,
            ip: meta.ip,
          ),
        );
        return const _MfaOutcome.failure(
          ApiException(401, ApiErrorCodes.invalidMfaCode, 'Code invalide.'),
        );
      }

      await tx.query('DELETE FROM auth_challenges WHERE token_hash = @h', {
        'h': challenge['token_hash'],
      });
      final device = DeviceInfo.fromJson(
        (challenge['device'] as Map).cast<String, dynamic>(),
      );
      return _MfaOutcome.success(await _openSession(tx, userId, device, meta));
    });
    return outcome.response ?? (throw outcome.error!);
  }

  /// Vérifie un code TOTP (anti-rejeu) ou consomme un code de secours.
  Future<bool> _checkSecondFactor(
    TxSession tx,
    String userId,
    String code,
    RequestMeta meta,
  ) async {
    final user = await tx.queryOne(
      'SELECT totp_secret_enc, totp_last_step FROM users WHERE id = @id '
      'FOR UPDATE',
      {'id': userId},
    );
    final secretEnc = user?['totp_secret_enc'] as String?;
    if (secretEnc == null) return false;

    final secret = await _cipher.decrypt(secretEnc);
    final step = Totp.verify(
      secret,
      code,
      _now(),
      lastUsedStep: user!['totp_last_step'] as int?,
    );
    if (step != null) {
      await tx.query('UPDATE users SET totp_last_step = @s WHERE id = @id', {
        's': step,
        'id': userId,
      });
      return true;
    }

    final used = await tx.queryOne(
      'UPDATE user_recovery_codes SET used_at = now() WHERE id = ('
      'SELECT id FROM user_recovery_codes WHERE user_id = @u '
      'AND code_hash = @h AND used_at IS NULL LIMIT 1) RETURNING id',
      {'u': userId, 'h': hashToken(normalizeRecoveryCode(code))},
    );
    if (used == null) return false;
    await AuditLog.append(
      tx,
      AuditEvent(
        action: AuditActions.recoveryCodeUsed,
        actorUserId: userId,
        ip: meta.ip,
      ),
    );
    return true;
  }

  Future<LoginResponse> _openSession(
    TxSession tx,
    String userId,
    DeviceInfo device,
    RequestMeta meta,
  ) async {
    if (!isValidId(device.id)) {
      throw const ApiException.badRequest('Identifiant de poste invalide.');
    }
    final sessionId = newId();
    final tokens = _issueTokens(sessionId);
    await tx.query(
      'INSERT INTO sessions (id, user_id, device_id, device_name, platform, '
      'app_version, access_token_hash, access_expires_at, refresh_token_hash, '
      'refresh_expires_at, ip, user_agent) VALUES (@id, @u, @d, @dn, @p, '
      '@v, @ah, @ae, @rh, @re, @ip, @ua)',
      {
        'id': sessionId,
        'u': userId,
        'd': device.id,
        'dn': device.name,
        'p': device.platform,
        'v': device.appVersion,
        'ah': hashToken(tokens.accessToken),
        'ae': tokens.accessExpiresAt,
        'rh': hashToken(tokens.refreshToken),
        're': tokens.refreshExpiresAt,
        'ip': meta.ip,
        'ua': meta.userAgent,
      },
    );
    await tx.query('UPDATE users SET last_login_at = now() WHERE id = @id', {
      'id': userId,
    });
    await AuditLog.append(
      tx,
      AuditEvent(
        action: AuditActions.loginSucceeded,
        actorUserId: userId,
        sessionId: sessionId,
        payload: {'device': device.name, 'platform': device.platform},
        ip: meta.ip,
      ),
    );
    return LoginResponse.authenticated(
      tokens: tokens,
      user: await _currentUser(tx, userId),
    );
  }

  AuthTokens _issueTokens(String sessionId) {
    final now = _now();
    return AuthTokens(
      sessionId: sessionId,
      accessToken: randomToken(),
      accessExpiresAt: now.add(accessTtl),
      refreshToken: randomToken(),
      refreshExpiresAt: now.add(refreshTtl),
    );
  }

  // ── Jetons ───────────────────────────────────────────────────────────

  /// Rotation des jetons. La réutilisation d'un ancien jeton de
  /// rafraîchissement (hors délai de grâce) révoque la session : c'est le
  /// signe qu'il a été volé.
  Future<AuthTokens> refresh(RefreshRequest request, RequestMeta meta) async {
    final hash = hashToken(request.refreshToken);
    final outcome = await _db.tx((tx) async {
      final session = await tx.queryOne(
        'SELECT s.*, u.status FROM sessions s JOIN users u ON u.id = s.user_id '
        'WHERE s.refresh_token_hash = @h FOR UPDATE OF s',
        {'h': hash},
      );
      if (session == null) {
        final reused = await tx.queryOne(
          'SELECT id, user_id, refreshed_at FROM sessions '
          'WHERE previous_refresh_hash = @h AND revoked_at IS NULL FOR UPDATE',
          {'h': hash},
        );
        if (reused == null) {
          return const _RefreshOutcome.failure(
            ApiException(
              401,
              ApiErrorCodes.unauthenticated,
              'Session inconnue. Reconnectez-vous.',
            ),
          );
        }
        final refreshedAt = reused['refreshed_at'] as DateTime?;
        if (refreshedAt != null &&
            _now().difference(refreshedAt) < refreshReuseGrace) {
          return const _RefreshOutcome.failure(
            ApiException(
              401,
              ApiErrorCodes.tokenExpired,
              'Jeton déjà renouvelé.',
            ),
          );
        }
        final id = reused['id'] as String;
        await _revoke(tx, [id], 'refresh_reuse');
        await AuditLog.append(
          tx,
          AuditEvent(
            action: AuditActions.refreshReuse,
            actorUserId: reused['user_id'] as String,
            sessionId: id,
            ip: meta.ip,
          ),
        );
        return _RefreshOutcome.failure(
          const ApiException(
            401,
            ApiErrorCodes.sessionRevoked,
            'Session révoquée par sécurité. Reconnectez-vous.',
          ),
          revoked: [id],
        );
      }

      if (session['revoked_at'] != null) {
        return const _RefreshOutcome.failure(
          ApiException(
            401,
            ApiErrorCodes.sessionRevoked,
            'Session révoquée. Reconnectez-vous.',
          ),
        );
      }
      if ((session['refresh_expires_at'] as DateTime).isBefore(_now()) ||
          session['status'] != UserStatus.active.name) {
        return const _RefreshOutcome.failure(
          ApiException(
            401,
            ApiErrorCodes.tokenExpired,
            'Session expirée. Reconnectez-vous.',
          ),
        );
      }

      final sessionId = session['id'] as String;
      final tokens = _issueTokens(sessionId);
      await tx.query(
        'UPDATE sessions SET access_token_hash = @ah, access_expires_at = @ae, '
        'refresh_token_hash = @rh, refresh_expires_at = @re, '
        'previous_refresh_hash = @prev, refreshed_at = now(), '
        'last_seen_at = now(), ip = coalesce(@ip, ip) WHERE id = @id',
        {
          'ah': hashToken(tokens.accessToken),
          'ae': tokens.accessExpiresAt,
          'rh': hashToken(tokens.refreshToken),
          're': tokens.refreshExpiresAt,
          'prev': hash,
          'ip': meta.ip,
          'id': sessionId,
        },
      );
      return _RefreshOutcome.success(tokens);
    });
    if (outcome.revoked.isNotEmpty) onSessionsRevoked?.call(outcome.revoked);
    return outcome.tokens ?? (throw outcome.error!);
  }

  /// Authentifie un jeton d'accès.
  Future<AuthContext> authenticate(String accessToken) async {
    final row = await _db.run(
      (s) => s.queryOne(
        'SELECT s.id, s.user_id, s.device_id, s.access_expires_at, '
        's.revoked_at, s.last_seen_at, u.status, u.email::text AS email, u.display_name '
        'FROM sessions s JOIN users u ON u.id = s.user_id '
        'WHERE s.access_token_hash = @h',
        {'h': hashToken(accessToken)},
      ),
    );
    if (row == null) throw const ApiException.unauthenticated();
    if (row['revoked_at'] != null) {
      throw const ApiException(
        401,
        ApiErrorCodes.sessionRevoked,
        'Session révoquée.',
      );
    }
    if ((row['access_expires_at'] as DateTime).isBefore(_now())) {
      throw const ApiException(
        401,
        ApiErrorCodes.tokenExpired,
        'Jeton expiré.',
      );
    }
    if (row['status'] != UserStatus.active.name) {
      throw const ApiException(
        403,
        ApiErrorCodes.accountDisabled,
        'Ce compte est désactivé.',
      );
    }
    final userId = row['user_id'] as String;
    final sessionId = row['id'] as String;
    if (_now().difference(row['last_seen_at'] as DateTime) >
        const Duration(minutes: 1)) {
      await _db.query(
        'UPDATE sessions SET last_seen_at = now() WHERE id = @id',
        {'id': sessionId},
      );
    }
    return AuthContext(
      userId: userId,
      sessionId: sessionId,
      deviceId: row['device_id'] as String,
      email: row['email'] as String,
      displayName: row['display_name'] as String,
      permissions: await _db.run((s) => permissionsOf(s, userId)),
    );
  }

  // ── Sessions ─────────────────────────────────────────────────────────

  Future<void> logout(AuthContext ctx) =>
      revokeSessions(ctx, [ctx.sessionId], reason: 'logout');

  Future<List<SessionInfo>> listSessions(AuthContext ctx) async {
    final rows = await _db.run(
      (s) => s.queryAll(
        'SELECT id, device_name, platform, ip, user_agent, created_at, '
        'last_seen_at FROM sessions WHERE user_id = @u AND revoked_at IS NULL '
        'AND refresh_expires_at > now() ORDER BY last_seen_at DESC',
        {'u': ctx.userId},
      ),
    );
    return [
      for (final r in rows)
        SessionInfo(
          id: r['id'] as String,
          deviceName: r['device_name'] as String,
          platform: r['platform'] as String,
          ip: r['ip'] as String?,
          userAgent: r['user_agent'] as String?,
          createdAt: r['created_at'] as DateTime,
          lastSeenAt: r['last_seen_at'] as DateTime,
          current: r['id'] == ctx.sessionId,
        ),
    ];
  }

  /// Révoque des sessions de l'utilisateur courant.
  Future<void> revokeSessions(
    AuthContext ctx,
    List<String> sessionIds, {
    required String reason,
  }) async {
    final revoked = await _db.tx((tx) async {
      final owned = await tx.queryAll(
        'SELECT id FROM sessions WHERE user_id = @u AND id = ANY(@ids:_uuid) '
        'AND revoked_at IS NULL',
        {'u': ctx.userId, 'ids': sessionIds},
      );
      final ids = [for (final r in owned) r['id'] as String];
      if (ids.isEmpty) return ids;
      await _revoke(tx, ids, reason);
      await AuditLog.append(
        tx,
        AuditEvent(
          action: reason == 'logout'
              ? AuditActions.logout
              : AuditActions.sessionRevoked,
          actorUserId: ctx.userId,
          sessionId: ctx.sessionId,
          payload: {'sessions': ids, 'reason': reason},
          ip: ctx.meta.ip,
        ),
      );
      return ids;
    });
    if (revoked.isEmpty && sessionIds.any((id) => id != ctx.sessionId)) {
      throw const ApiException.notFound('Session introuvable.');
    }
    if (revoked.isNotEmpty) onSessionsRevoked?.call(revoked);
  }

  /// Révoque toutes les sessions actives d'un utilisateur (sauf
  /// [exceptSessionId]). Retourne les sessions révoquées.
  static Future<List<String>> revokeAllOf(
    TxSession tx,
    String userId, {
    required String reason,
    String? exceptSessionId,
  }) async {
    final rows = await tx.queryAll(
      'UPDATE sessions SET revoked_at = now(), revoke_reason = @r '
      'WHERE user_id = @u AND revoked_at IS NULL '
      'AND (@except:uuid IS NULL OR id <> @except:uuid) RETURNING id',
      {'r': reason, 'u': userId, 'except': exceptSessionId},
    );
    return [for (final r in rows) r['id'] as String];
  }

  static Future<void> _revoke(TxSession tx, List<String> ids, String reason) =>
      tx.query(
        'UPDATE sessions SET revoked_at = now(), revoke_reason = @r '
        'WHERE id = ANY(@ids:_uuid)',
        {'r': reason, 'ids': ids},
      );

  // ── Compte ───────────────────────────────────────────────────────────

  Future<CurrentUser> currentUser(AuthContext ctx) =>
      _db.run((s) => _currentUser(s, ctx.userId));

  Future<void> changePassword(
    AuthContext ctx,
    ChangePasswordRequest request,
  ) async {
    final issue = validatePassword('new_password', request.newPassword);
    if (issue != null) throw ApiException.validation([issue]);
    final row = await _db.run(
      (s) => s.queryOne('SELECT password_hash FROM users WHERE id = @id', {
        'id': ctx.userId,
      }),
    );
    if (row == null ||
        !await _hasher.verify(
          request.currentPassword,
          row['password_hash'] as String,
        )) {
      throw const ApiException(
        401,
        ApiErrorCodes.invalidCredentials,
        'Mot de passe actuel incorrect.',
      );
    }
    final hash = await _hasher.hash(request.newPassword);
    final revoked = await _db.tx((tx) async {
      await tx.query(
        'UPDATE users SET password_hash = @h, updated_at = now() '
        'WHERE id = @id',
        {'h': hash, 'id': ctx.userId},
      );
      final revoked = await revokeAllOf(
        tx,
        ctx.userId,
        reason: 'password_changed',
        exceptSessionId: ctx.sessionId,
      );
      await AuditLog.append(
        tx,
        AuditEvent(
          action: AuditActions.passwordChanged,
          actorUserId: ctx.userId,
          sessionId: ctx.sessionId,
          payload: {'revoked_sessions': revoked.length},
          ip: ctx.meta.ip,
        ),
      );
      return revoked;
    });
    if (revoked.isNotEmpty) onSessionsRevoked?.call(revoked);
  }

  // ── 2FA ──────────────────────────────────────────────────────────────

  /// Démarre l'activation de la 2FA : nouveau secret en attente.
  Future<TotpSetupResponse> totpSetup(AuthContext ctx) async {
    final row = await _db.run(
      (s) => s.queryOne('SELECT totp_enabled_at FROM users WHERE id = @id', {
        'id': ctx.userId,
      }),
    );
    if (row?['totp_enabled_at'] != null) {
      throw const ApiException.conflict(
        'La double authentification est déjà activée.',
      );
    }
    final secret = Totp.generateSecret();
    await _db.query(
      'UPDATE users SET totp_pending_secret_enc = @s WHERE id = @id',
      {'s': await _cipher.encrypt(secret), 'id': ctx.userId},
    );
    return TotpSetupResponse(
      secret: secret,
      otpauthUri: Totp.otpauthUri(secret: secret, account: ctx.email),
    );
  }

  /// Confirme l'activation avec un premier code ; retourne les codes de
  /// secours (affichés une seule fois).
  Future<RecoveryCodesResponse> totpConfirm(
    AuthContext ctx,
    CodeRequest request,
  ) => _db.tx((tx) async {
    final row = await tx.queryOne(
      'SELECT totp_pending_secret_enc FROM users WHERE id = @id FOR UPDATE',
      {'id': ctx.userId},
    );
    final pending = row?['totp_pending_secret_enc'] as String?;
    if (pending == null) {
      throw const ApiException.conflict(
        "Aucune activation en cours : recommencez l'activation.",
      );
    }
    final secret = await _cipher.decrypt(pending);
    final step = Totp.verify(secret, request.code, _now());
    if (step == null) {
      throw const ApiException(
        422,
        ApiErrorCodes.invalidMfaCode,
        'Code invalide. Vérifiez l’heure de votre téléphone.',
      );
    }
    await tx.query(
      'UPDATE users SET totp_secret_enc = totp_pending_secret_enc, '
      'totp_pending_secret_enc = NULL, totp_enabled_at = now(), '
      'totp_last_step = @s, updated_at = now() WHERE id = @id',
      {'s': step, 'id': ctx.userId},
    );
    final codes = await _replaceRecoveryCodes(tx, ctx.userId);
    await AuditLog.append(
      tx,
      AuditEvent(
        action: AuditActions.totpEnabled,
        actorUserId: ctx.userId,
        sessionId: ctx.sessionId,
        ip: ctx.meta.ip,
      ),
    );
    return RecoveryCodesResponse(codes: codes);
  });

  /// Désactive la 2FA (code TOTP ou code de secours exigé).
  Future<void> totpDisable(AuthContext ctx, CodeRequest request) =>
      _db.tx((tx) async {
        await _requireSecondFactor(tx, ctx, request.code);
        await tx.query(
          'UPDATE users SET totp_secret_enc = NULL, '
          'totp_pending_secret_enc = NULL, totp_enabled_at = NULL, '
          'totp_last_step = NULL, updated_at = now() WHERE id = @id',
          {'id': ctx.userId},
        );
        await tx.query('DELETE FROM user_recovery_codes WHERE user_id = @u', {
          'u': ctx.userId,
        });
        await AuditLog.append(
          tx,
          AuditEvent(
            action: AuditActions.totpDisabled,
            actorUserId: ctx.userId,
            sessionId: ctx.sessionId,
            ip: ctx.meta.ip,
          ),
        );
      });

  /// Génère de nouveaux codes de secours (les anciens sont invalidés).
  Future<RecoveryCodesResponse> regenerateRecoveryCodes(
    AuthContext ctx,
    CodeRequest request,
  ) => _db.tx((tx) async {
    await _requireSecondFactor(tx, ctx, request.code);
    final codes = await _replaceRecoveryCodes(tx, ctx.userId);
    await AuditLog.append(
      tx,
      AuditEvent(
        action: AuditActions.recoveryCodesRegenerated,
        actorUserId: ctx.userId,
        sessionId: ctx.sessionId,
        ip: ctx.meta.ip,
      ),
    );
    return RecoveryCodesResponse(codes: codes);
  });

  Future<void> _requireSecondFactor(
    TxSession tx,
    AuthContext ctx,
    String code,
  ) async {
    if (!await _checkSecondFactor(tx, ctx.userId, code, ctx.meta)) {
      throw const ApiException(
        422,
        ApiErrorCodes.invalidMfaCode,
        'Code invalide.',
      );
    }
  }

  Future<List<String>> _replaceRecoveryCodes(
    TxSession tx,
    String userId,
  ) async {
    await tx.query('DELETE FROM user_recovery_codes WHERE user_id = @u', {
      'u': userId,
    });
    final codes = List.generate(recoveryCodeCount, (_) => recoveryCode());
    for (final code in codes) {
      await tx.query(
        'INSERT INTO user_recovery_codes (id, user_id, code_hash) '
        'VALUES (@id, @u, @h)',
        {'id': newId(), 'u': userId, 'h': hashToken(code)},
      );
    }
    return codes;
  }

  /// Supprime les étapes 2FA expirées (appelé périodiquement).
  Future<void> purgeExpiredChallenges() async {
    final result = await _db.query(
      'DELETE FROM auth_challenges WHERE expires_at < now()',
    );
    if (result.affectedRows > 0) {
      _log.fine('${result.affectedRows} vérification(s) 2FA expirée(s)');
    }
  }
}

/// Permissions effectives d'un utilisateur (union de ses rôles).
Future<Set<String>> permissionsOf(Session session, String userId) async {
  final rows = await session.queryAll(
    'SELECT DISTINCT rp.permission FROM user_roles ur '
    'JOIN role_permissions rp ON rp.role_id = ur.role_id '
    'WHERE ur.user_id = @u',
    {'u': userId},
  );
  return {for (final r in rows) r['permission'] as String};
}

Future<CurrentUser> _currentUser(Session session, String userId) async {
  final user = await session.queryOne(
    'SELECT id, email::text AS email, display_name, totp_enabled_at FROM users '
    'WHERE id = @id',
    {'id': userId},
  );
  if (user == null) throw const ApiException.unauthenticated();
  final roles = await session.queryAll(
    'SELECT r.key FROM user_roles ur JOIN roles r ON r.id = ur.role_id '
    'WHERE ur.user_id = @u ORDER BY r.key',
    {'u': userId},
  );
  return CurrentUser(
    id: userId,
    email: user['email'] as String,
    displayName: user['display_name'] as String,
    totpEnabled: user['totp_enabled_at'] != null,
    roles: [for (final r in roles) r['key'] as String],
    permissions: (await permissionsOf(session, userId)).toList()..sort(),
  );
}

final class _MfaOutcome {
  const _MfaOutcome.success(LoginResponse this.response) : error = null;
  const _MfaOutcome.failure(ApiException this.error) : response = null;

  final LoginResponse? response;
  final ApiException? error;
}

final class _RefreshOutcome {
  const _RefreshOutcome.success(AuthTokens this.tokens)
    : error = null,
      revoked = const [];
  const _RefreshOutcome.failure(
    ApiException this.error, {
    this.revoked = const [],
  }) : tokens = null;

  final AuthTokens? tokens;
  final ApiException? error;
  final List<String> revoked;
}
