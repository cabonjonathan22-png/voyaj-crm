import 'package:postgres/postgres.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../audit/audit_log.dart';
import '../db/database.dart';
import '../errors.dart';
import '../security/passwords.dart';
import 'auth_context.dart';
import 'auth_service.dart';

/// Administration des utilisateurs et des rôles.
final class UsersService {
  UsersService({required this._db, required this._hasher});

  final Database _db;
  final PasswordHasher _hasher;

  SessionsRevokedListener? onSessionsRevoked;

  static final _roleKey = RegExp(r'^[a-z][a-z0-9_]{1,39}$');

  // ── Rôles système ────────────────────────────────────────────────────

  /// Crée ou met à jour les rôles système selon [SystemRole] (au
  /// démarrage). Les permissions des rôles système suivent le code.
  Future<void> syncSystemRoles() => _db.tx((tx) async {
    for (final role in SystemRole.values) {
      final row = await tx.queryOne(
        'INSERT INTO roles (id, key, name, description, is_system) '
        'VALUES (@id, @key, @name, @desc, true) ON CONFLICT (key) DO UPDATE '
        'SET name = excluded.name, description = excluded.description, '
        'is_system = true RETURNING id',
        {
          'id': newId(),
          'key': role.key,
          'name': role.label,
          'desc': role.description,
        },
      );
      final roleId = row!['id'] as String;
      await tx.query('DELETE FROM role_permissions WHERE role_id = @r', {
        'r': roleId,
      });
      for (final permission in role.permissions) {
        await tx.query(
          'INSERT INTO role_permissions (role_id, permission) VALUES (@r, @p)',
          {'r': roleId, 'p': permission.key},
        );
      }
    }
  });

  // ── Utilisateurs ─────────────────────────────────────────────────────

  Future<List<UserSummary>> listUsers(AuthContext ctx) async {
    ctx.require(Permission.userRead);
    final rows = await _db.run(
      (s) => s.queryAll(
        'SELECT u.id, u.email::text AS email, u.display_name, u.status, '
        'u.last_login_at, '
        'u.created_at, u.totp_enabled_at IS NOT NULL AS totp, '
        'coalesce(array_agg(r.key ORDER BY r.key) FILTER (WHERE r.key IS NOT '
        'NULL), ARRAY[]::text[]) AS roles FROM users u '
        'LEFT JOIN user_roles ur ON ur.user_id = u.id '
        'LEFT JOIN roles r ON r.id = ur.role_id '
        'GROUP BY u.id ORDER BY u.display_name',
      ),
    );
    return [for (final r in rows) _userSummary(r)];
  }

  Future<UserSummary> createUser(
    AuthContext ctx,
    CreateUserRequest request,
  ) async {
    ctx.require(Permission.userManage);
    final email = request.email.trim().toLowerCase();
    final displayName = request.displayName.trim();
    final issues = collectIssues([
      validateEmail('email', email),
      validateRequiredText(
        'display_name',
        displayName,
        label: 'Le nom',
        max: 120,
      ),
      validatePassword('password', request.password),
    ]);
    if (issues.isNotEmpty) throw ApiException.validation(issues);

    final hash = await _hasher.hash(request.password);
    final id = newId();
    try {
      await _db.tx((tx) async {
        await tx.query(
          'INSERT INTO users (id, email, display_name, password_hash) '
          'VALUES (@id, @e, @n, @h)',
          {'id': id, 'e': email, 'n': displayName, 'h': hash},
        );
        await _setRoles(tx, id, request.roles);
        await AuditLog.append(
          tx,
          AuditEvent(
            action: AuditActions.userCreated,
            actorUserId: ctx.userId,
            sessionId: ctx.sessionId,
            entity: 'users',
            entityId: id,
            payload: {'email': email, 'roles': request.roles},
            ip: ctx.meta.ip,
          ),
        );
      });
    } on ServerException catch (e) {
      if (e.code == uniqueViolation) {
        throw const ApiException.conflict(
          'Un utilisateur utilise déjà cette adresse email.',
        );
      }
      rethrow;
    }
    return _getUser(id);
  }

  Future<UserSummary> updateUser(
    AuthContext ctx,
    String userId,
    UpdateUserRequest request,
  ) async {
    ctx.require(Permission.userManage);
    if (userId == ctx.userId && request.status == UserStatus.disabled) {
      throw const ApiException.conflict(
        'Vous ne pouvez pas désactiver votre propre compte.',
      );
    }
    final displayName = request.displayName?.trim();
    if (displayName != null) {
      final issue = validateRequiredText(
        'display_name',
        displayName,
        label: 'Le nom',
        max: 120,
      );
      if (issue != null) throw ApiException.validation([issue]);
    }

    final revoked = await _db.tx((tx) async {
      final exists = await tx.queryOne(
        'SELECT id FROM users WHERE id = @id FOR UPDATE',
        {'id': userId},
      );
      if (exists == null) throw const ApiException.notFound();
      await tx.query(
        'UPDATE users SET display_name = coalesce(@n, display_name), '
        'status = coalesce(@s, status), updated_at = now() WHERE id = @id',
        {'n': displayName, 's': request.status?.name, 'id': userId},
      );
      if (request.roles != null) await _setRoles(tx, userId, request.roles!);
      await _ensureAnAdminRemains(tx);

      var revoked = const <String>[];
      if (request.status == UserStatus.disabled) {
        revoked = await AuthService.revokeAllOf(
          tx,
          userId,
          reason: 'account_disabled',
        );
      }
      await AuditLog.append(
        tx,
        AuditEvent(
          action: AuditActions.userUpdated,
          actorUserId: ctx.userId,
          sessionId: ctx.sessionId,
          entity: 'users',
          entityId: userId,
          payload: {
            'display_name': ?displayName,
            'status': ?request.status?.name,
            'roles': ?request.roles,
          },
          ip: ctx.meta.ip,
        ),
      );
      return revoked;
    });
    if (revoked.isNotEmpty) onSessionsRevoked?.call(revoked);
    return _getUser(userId);
  }

  /// Révoque toutes les sessions d'un utilisateur (administrateur).
  Future<void> revokeUserSessions(AuthContext ctx, String userId) async {
    ctx.require(Permission.userManage);
    final revoked = await _db.tx((tx) async {
      final revoked = await AuthService.revokeAllOf(
        tx,
        userId,
        reason: 'revoked_by_admin',
      );
      await AuditLog.append(
        tx,
        AuditEvent(
          action: AuditActions.sessionRevoked,
          actorUserId: ctx.userId,
          sessionId: ctx.sessionId,
          entity: 'users',
          entityId: userId,
          payload: {'sessions': revoked, 'reason': 'revoked_by_admin'},
          ip: ctx.meta.ip,
        ),
      );
      return revoked;
    });
    if (revoked.isNotEmpty) onSessionsRevoked?.call(revoked);
  }

  /// Création d'un administrateur en ligne de commande (installation).
  Future<String> createAdmin({
    required String email,
    required String displayName,
    required String password,
  }) async {
    final normalized = email.trim().toLowerCase();
    final issues = collectIssues([
      validateEmail('email', normalized),
      validateRequiredText('display_name', displayName, label: 'Le nom'),
      validatePassword('password', password),
    ]);
    if (issues.isNotEmpty) throw ApiException.validation(issues);
    await syncSystemRoles();
    final hash = await _hasher.hash(password);
    final id = newId();
    try {
      await _db.tx((tx) async {
        await tx.query(
          'INSERT INTO users (id, email, display_name, password_hash) '
          'VALUES (@id, @e, @n, @h)',
          {'id': id, 'e': normalized, 'n': displayName.trim(), 'h': hash},
        );
        await _setRoles(tx, id, [SystemRole.admin.key]);
        await AuditLog.append(
          tx,
          AuditEvent(
            action: AuditActions.userCreated,
            entity: 'users',
            entityId: id,
            payload: {
              'email': normalized,
              'roles': [SystemRole.admin.key],
              'source': 'cli',
            },
          ),
        );
      });
    } on ServerException catch (e) {
      if (e.code == uniqueViolation) {
        throw const ApiException.conflict(
          'Un utilisateur utilise déjà cette adresse email.',
        );
      }
      rethrow;
    }
    return id;
  }

  Future<void> _setRoles(TxSession tx, String userId, List<String> keys) async {
    final roles = await tx.queryAll(
      'SELECT id, key FROM roles WHERE key = ANY(@keys:_text)',
      {'keys': keys},
    );
    if (roles.length != keys.toSet().length) {
      throw const ApiException.validation([
        ValidationIssue(
          field: 'roles',
          code: ValidationCodes.invalidFormat,
          message: 'Rôle inconnu.',
        ),
      ]);
    }
    await tx.query('DELETE FROM user_roles WHERE user_id = @u', {'u': userId});
    for (final role in roles) {
      await tx.query(
        'INSERT INTO user_roles (user_id, role_id) VALUES (@u, @r)',
        {'u': userId, 'r': role['id']},
      );
    }
  }

  /// Garantit qu'au moins un administrateur actif existe toujours.
  Future<void> _ensureAnAdminRemains(TxSession tx) async {
    final row = await tx.queryOne(
      'SELECT count(*) AS n FROM users u JOIN user_roles ur ON ur.user_id = '
      'u.id JOIN roles r ON r.id = ur.role_id WHERE r.key = @admin '
      "AND u.status = 'active'",
      {'admin': SystemRole.admin.key},
    );
    if ((row!['n'] as int) == 0) {
      throw const ApiException.conflict(
        'Il doit rester au moins un administrateur actif.',
      );
    }
  }

  Future<UserSummary> _getUser(String id) async {
    final row = await _db.run(
      (s) => s.queryOne(
        'SELECT u.id, u.email::text AS email, u.display_name, u.status, '
        'u.last_login_at, '
        'u.created_at, u.totp_enabled_at IS NOT NULL AS totp, '
        'coalesce(array_agg(r.key ORDER BY r.key) FILTER (WHERE r.key IS NOT '
        'NULL), ARRAY[]::text[]) AS roles FROM users u '
        'LEFT JOIN user_roles ur ON ur.user_id = u.id '
        'LEFT JOIN roles r ON r.id = ur.role_id WHERE u.id = @id '
        'GROUP BY u.id',
        {'id': id},
      ),
    );
    if (row == null) throw const ApiException.notFound();
    return _userSummary(row);
  }

  UserSummary _userSummary(Map<String, dynamic> r) => UserSummary(
    id: r['id'] as String,
    email: r['email'] as String,
    displayName: r['display_name'] as String,
    status: UserStatus.values.byName(r['status'] as String),
    roles: (r['roles'] as List).cast<String>(),
    totpEnabled: r['totp'] as bool,
    lastLoginAt: r['last_login_at'] as DateTime?,
    createdAt: r['created_at'] as DateTime,
  );

  // ── Rôles ────────────────────────────────────────────────────────────

  Future<List<RoleInfo>> listRoles(AuthContext ctx) async {
    ctx.require(Permission.userRead);
    final rows = await _db.run(
      (s) => s.queryAll(
        'SELECT r.id, r.key, r.name, r.description, r.is_system, '
        'coalesce(array_agg(rp.permission ORDER BY rp.permission) FILTER '
        '(WHERE rp.permission IS NOT NULL), ARRAY[]::text[]) AS permissions '
        'FROM roles r LEFT JOIN role_permissions rp ON rp.role_id = r.id '
        'GROUP BY r.id ORDER BY r.is_system DESC, r.name',
      ),
    );
    return [for (final r in rows) _roleInfo(r)];
  }

  Future<RoleInfo> createRole(AuthContext ctx, SaveRoleRequest request) async {
    ctx.require(Permission.roleManage);
    final key = request.key?.trim() ?? '';
    final issues = [
      if (!_roleKey.hasMatch(key))
        const ValidationIssue(
          field: 'key',
          code: ValidationCodes.invalidFormat,
          message:
              'Identifiant : 2 à 40 caractères, minuscules, chiffres et _.',
        ),
      ..._checkRole(request),
    ];
    if (issues.isNotEmpty) throw ApiException.validation(issues);
    final id = newId();
    try {
      await _db.tx((tx) async {
        await tx.query(
          'INSERT INTO roles (id, key, name, description) '
          'VALUES (@id, @k, @n, @d)',
          {
            'id': id,
            'k': key,
            'n': request.name.trim(),
            'd': request.description?.trim(),
          },
        );
        await _setPermissions(tx, id, request.permissions);
        await _auditRole(tx, ctx, AuditActions.roleCreated, id, request);
      });
    } on ServerException catch (e) {
      if (e.code == uniqueViolation) {
        throw const ApiException.conflict('Ce rôle existe déjà.');
      }
      rethrow;
    }
    return _getRole(id);
  }

  Future<RoleInfo> updateRole(
    AuthContext ctx,
    String roleId,
    SaveRoleRequest request,
  ) async {
    ctx.require(Permission.roleManage);
    final issues = _checkRole(request);
    if (issues.isNotEmpty) throw ApiException.validation(issues);
    await _db.tx((tx) async {
      await _requireCustomRole(tx, roleId);
      await tx.query(
        'UPDATE roles SET name = @n, description = @d, updated_at = now() '
        'WHERE id = @id',
        {
          'n': request.name.trim(),
          'd': request.description?.trim(),
          'id': roleId,
        },
      );
      await _setPermissions(tx, roleId, request.permissions);
      await _auditRole(tx, ctx, AuditActions.roleUpdated, roleId, request);
    });
    return _getRole(roleId);
  }

  Future<void> deleteRole(AuthContext ctx, String roleId) async {
    ctx.require(Permission.roleManage);
    await _db.tx((tx) async {
      await _requireCustomRole(tx, roleId);
      await tx.query('DELETE FROM roles WHERE id = @id', {'id': roleId});
      await AuditLog.append(
        tx,
        AuditEvent(
          action: AuditActions.roleDeleted,
          actorUserId: ctx.userId,
          sessionId: ctx.sessionId,
          entity: 'roles',
          entityId: roleId,
          ip: ctx.meta.ip,
        ),
      );
    });
  }

  List<ValidationIssue> _checkRole(SaveRoleRequest request) => [
    ?validateRequiredText('name', request.name, label: 'Le nom', max: 80),
    if (request.permissions.any((p) => Permission.fromKey(p) == null))
      const ValidationIssue(
        field: 'permissions',
        code: ValidationCodes.invalidFormat,
        message: 'Permission inconnue.',
      ),
  ];

  Future<void> _requireCustomRole(TxSession tx, String roleId) async {
    final role = await tx.queryOne(
      'SELECT is_system FROM roles WHERE id = @id FOR UPDATE',
      {'id': roleId},
    );
    if (role == null) throw const ApiException.notFound('Rôle introuvable.');
    if (role['is_system'] as bool) {
      throw const ApiException.conflict(
        'Les rôles système ne sont pas modifiables.',
      );
    }
  }

  Future<void> _setPermissions(
    TxSession tx,
    String roleId,
    List<String> permissions,
  ) async {
    await tx.query('DELETE FROM role_permissions WHERE role_id = @r', {
      'r': roleId,
    });
    for (final permission in permissions.toSet()) {
      await tx.query(
        'INSERT INTO role_permissions (role_id, permission) VALUES (@r, @p)',
        {'r': roleId, 'p': permission},
      );
    }
  }

  Future<void> _auditRole(
    TxSession tx,
    AuthContext ctx,
    String action,
    String roleId,
    SaveRoleRequest request,
  ) => AuditLog.append(
    tx,
    AuditEvent(
      action: action,
      actorUserId: ctx.userId,
      sessionId: ctx.sessionId,
      entity: 'roles',
      entityId: roleId,
      payload: {'name': request.name, 'permissions': request.permissions},
      ip: ctx.meta.ip,
    ),
  );

  Future<RoleInfo> _getRole(String id) async {
    final row = await _db.run(
      (s) => s.queryOne(
        'SELECT r.id, r.key, r.name, r.description, r.is_system, '
        'coalesce(array_agg(rp.permission ORDER BY rp.permission) FILTER '
        '(WHERE rp.permission IS NOT NULL), ARRAY[]::text[]) AS permissions '
        'FROM roles r LEFT JOIN role_permissions rp ON rp.role_id = r.id '
        'WHERE r.id = @id GROUP BY r.id',
        {'id': id},
      ),
    );
    if (row == null) throw const ApiException.notFound('Rôle introuvable.');
    return _roleInfo(row);
  }

  RoleInfo _roleInfo(Map<String, dynamic> r) => RoleInfo(
    id: r['id'] as String,
    key: r['key'] as String,
    name: r['name'] as String,
    description: r['description'] as String?,
    isSystem: r['is_system'] as bool,
    permissions: (r['permissions'] as List).cast<String>(),
  );
}
