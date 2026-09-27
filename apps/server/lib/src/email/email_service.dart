import 'dart:async';

import 'package:logging/logging.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../audit/audit_log.dart';
import '../auth/auth_context.dart';
import '../db/database.dart';
import '../errors.dart';
import '../security/secret_cipher.dart';
import '../security/tokens.dart';
import '../sync/sync_service.dart';
import 'mail_transport.dart';
import 'oauth.dart';

final _log = Logger('email');

/// Longueur maximale du texte d'un email conservé dans une activité.
const _activityBodyMax = 5000;

/// Messagerie : comptes des utilisateurs (IMAP / SMTP, Gmail et
/// Microsoft via OAuth), boîte de réception, envoi, journalisation des
/// échanges avec les contacts (activités) et séquences d'emails.
///
/// Les messages restent privés (visibles par le propriétaire du compte) ;
/// seuls ceux échangés avec un contact du CRM sont journalisés en
/// activités partagées.
final class EmailService {
  EmailService({
    required this._db,
    required this._sync,
    required this._cipher,
    required this._transport,
    required this._oauth,
    this.publicUrl,
    this.oauthApps = const {},
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final Database _db;
  final SyncService _sync;
  final SecretCipher _cipher;
  final MailTransport _transport;
  final OAuthClient _oauth;
  final DateTime Function() _clock;

  /// Adresse publique du serveur (retour des connexions OAuth).
  final Uri? publicUrl;
  final Map<EmailProvider, OAuthApp> oauthApps;

  bool _syncing = false;

  String get _redirectUri =>
      publicUrl!.resolve('/api/v1/email/oauth/callback').toString();

  // ── Comptes ──────────────────────────────────────────────────────────

  /// Fournisseurs OAuth configurés sur ce serveur.
  List<EmailProvider> availableProviders() => [
    EmailProvider.imap,
    if (publicUrl != null) ...oauthApps.keys,
  ];

  Future<List<EmailAccountInfo>> listAccounts(AuthContext ctx) async {
    ctx.require(Permission.emailUse);
    final rows = await _db.run(
      (s) => s.queryAll(
        'SELECT * FROM email_accounts WHERE user_id = @u ORDER BY address',
        {'u': ctx.userId},
      ),
    );
    return [for (final r in rows) _toInfo(r)];
  }

  Future<EmailAccountInfo> createImapAccount(
    AuthContext ctx,
    CreateImapAccountRequest request,
  ) async {
    ctx.require(Permission.emailUse);
    final address = request.address.trim().toLowerCase();
    final issues = collectIssues([
      validateEmail('address', address),
      validateRequiredText(
        'imap_host',
        request.imapHost,
        label: 'Le serveur IMAP',
      ),
      validateRequiredText(
        'smtp_host',
        request.smtpHost,
        label: 'Le serveur SMTP',
      ),
      validateRequiredText(
        'username',
        request.username,
        label: "L'identifiant",
      ),
      validateRequiredText(
        'password',
        request.password,
        label: 'Le mot de passe',
      ),
    ]);
    if (issues.isNotEmpty) {
      throw ApiException.validation(issues);
    }
    final credentials = MailCredentials(
      address: address,
      displayName: request.displayName,
      username: request.username.trim(),
      secret: request.password,
      imapHost: request.imapHost.trim(),
      imapPort: request.imapPort,
      imapTls: request.imapTls,
      smtpHost: request.smtpHost.trim(),
      smtpPort: request.smtpPort,
      smtpSecurity: request.smtpSecurity,
    );
    try {
      await _transport.verify(credentials);
    } on MailException catch (e) {
      throw ApiException.badRequest(e.message);
    }
    return _saveAccount(
      userId: ctx.userId,
      provider: EmailProvider.imap,
      credentials: credentials,
      secret: request.password,
      audit: ctx,
    );
  }

  Future<EmailAccountInfo> _saveAccount({
    required String userId,
    required EmailProvider provider,
    required MailCredentials credentials,
    required String secret,
    OAuthTokens? tokens,
    AuthContext? audit,
  }) async {
    final secretEnc = await _cipher.encrypt(secret);
    final accessEnc = tokens == null
        ? null
        : await _cipher.encrypt(tokens.accessToken);
    return _db.tx((tx) async {
      final row = await tx.queryOne(
        'INSERT INTO email_accounts (id, user_id, provider, address, '
        'display_name, imap_host, imap_port, imap_tls, smtp_host, smtp_port, '
        'smtp_security, username, secret_enc, access_token_enc, '
        'access_expires_at) VALUES (@id, @u, @p, @a, @n, @ih, @ip, @it, @sh, '
        '@sp, @ss, @user, @sec, @acc, @exp) '
        'ON CONFLICT (user_id, address) DO UPDATE SET provider = @p, '
        'display_name = @n, imap_host = @ih, imap_port = @ip, imap_tls = @it, '
        'smtp_host = @sh, smtp_port = @sp, smtp_security = @ss, '
        'username = @user, secret_enc = @sec, access_token_enc = @acc, '
        'access_expires_at = @exp, enabled = true, last_error = NULL '
        'RETURNING *',
        {
          'id': newId(),
          'u': userId,
          'p': provider.name,
          'a': credentials.address,
          'n': credentials.displayName,
          'ih': credentials.imapHost,
          'ip': credentials.imapPort,
          'it': credentials.imapTls,
          'sh': credentials.smtpHost,
          'sp': credentials.smtpPort,
          'ss': credentials.smtpSecurity.name,
          'user': credentials.username,
          'sec': secretEnc,
          'acc': accessEnc,
          'exp': tokens?.expiresAt,
        },
      );
      await AuditLog.append(
        tx,
        AuditEvent(
          action: AuditActions.emailAccountConnected,
          actorUserId: userId,
          sessionId: audit?.sessionId,
          entity: 'email_accounts',
          entityId: row!['id'] as String,
          payload: {'provider': provider.name, 'address': credentials.address},
          ip: audit?.meta.ip,
        ),
      );
      return _toInfo(row);
    });
  }

  Future<void> deleteAccount(AuthContext ctx, String id) async {
    ctx.require(Permission.emailUse);
    await _db.tx((tx) async {
      final row = await tx.queryOne(
        'DELETE FROM email_accounts WHERE id = @id AND user_id = @u '
        'RETURNING address',
        {'id': id, 'u': ctx.userId},
      );
      if (row == null) {
        throw const ApiException.notFound('Compte introuvable.');
      }
      await AuditLog.append(
        tx,
        AuditEvent(
          action: AuditActions.emailAccountRemoved,
          actorUserId: ctx.userId,
          sessionId: ctx.sessionId,
          entity: 'email_accounts',
          entityId: id,
          payload: {'address': row['address']},
          ip: ctx.meta.ip,
        ),
      );
    });
  }

  // ── OAuth ────────────────────────────────────────────────────────────

  /// Adresse d'autorisation (à ouvrir dans le navigateur).
  Future<OAuthStartResponse> oauthStart(
    AuthContext ctx,
    String providerName,
  ) async {
    ctx.require(Permission.emailUse);
    final provider = EmailProvider.values
        .where((p) => p.name == providerName)
        .firstOrNull;
    final app = oauthApps[provider];
    if (app == null || publicUrl == null) {
      throw const ApiException.badRequest(
        'Ce fournisseur n’est pas configuré sur le serveur.',
      );
    }
    final state = randomToken();
    await _db.query(
      'DELETE FROM oauth_states WHERE created_at < now() - interval '
      "'15 minutes'",
    );
    await _db.query(
      'INSERT INTO oauth_states (state, user_id, provider) VALUES (@s, @u, @p)',
      {'s': state, 'u': ctx.userId, 'p': app.provider.name},
    );
    return OAuthStartResponse(
      url: app
          .authorizationUri(redirectUri: _redirectUri, state: state)
          .toString(),
    );
  }

  /// Retour du navigateur après autorisation ; retourne l'adresse
  /// connectée.
  Future<String> oauthCallback({
    required String? code,
    required String? state,
    String? error,
  }) async {
    if (error != null) throw MailException('Autorisation refusée ($error).');
    if (code == null || state == null) {
      throw const MailException('Réponse d’autorisation incomplète.');
    }
    final row = await _db.run(
      (s) => s.queryOne(
        'DELETE FROM oauth_states WHERE state = @s AND created_at > now() - '
        "interval '15 minutes' RETURNING user_id, provider",
        {'s': state},
      ),
    );
    if (row == null) {
      throw const MailException('Lien d’autorisation expiré : recommencez.');
    }
    final provider = EmailProvider.values.byName(row['provider'] as String);
    final app = oauthApps[provider]!;
    final tokens = await _oauth.exchangeCode(
      app,
      code: code,
      redirectUri: _redirectUri,
    );
    final address = tokens.email?.toLowerCase();
    if (address == null || tokens.refreshToken == null) {
      throw const MailException(
        'Le fournisseur n’a pas renvoyé l’adresse ou l’accès hors ligne.',
      );
    }
    final credentials = MailCredentials(
      address: address,
      displayName: tokens.name,
      username: address,
      secret: tokens.accessToken,
      oauth: true,
      imapHost: app.imapHost,
      imapPort: 993,
      imapTls: true,
      smtpHost: app.smtpHost,
      smtpPort: app.smtpPort,
      smtpSecurity: app.smtpSecurity,
    );
    await _saveAccount(
      userId: row['user_id'] as String,
      provider: provider,
      credentials: credentials,
      secret: tokens.refreshToken!,
      tokens: tokens,
    );
    return address;
  }

  /// Paramètres de connexion d'un compte (jeton OAuth renouvelé si
  /// nécessaire).
  Future<MailCredentials> _credentials(Map<String, dynamic> row) async {
    final provider = EmailProvider.values.byName(row['provider'] as String);
    var secret = await _cipher.decrypt(row['secret_enc'] as String);
    final oauth = provider != EmailProvider.imap;
    if (oauth) {
      final expires = row['access_expires_at'] as DateTime?;
      final cached = row['access_token_enc'] as String?;
      if (cached != null &&
          expires != null &&
          expires.isAfter(_clock().toUtc().add(const Duration(minutes: 2)))) {
        secret = await _cipher.decrypt(cached);
      } else {
        final app = oauthApps[provider];
        if (app == null) {
          throw const MailException('Fournisseur OAuth non configuré.');
        }
        final tokens = await _oauth.refresh(app, secret);
        await _db.query(
          'UPDATE email_accounts SET access_token_enc = @a, '
          'access_expires_at = @e, secret_enc = coalesce(@r, secret_enc) '
          'WHERE id = @id',
          {
            'a': await _cipher.encrypt(tokens.accessToken),
            'e': tokens.expiresAt,
            'r': tokens.refreshToken == null
                ? null
                : await _cipher.encrypt(tokens.refreshToken!),
            'id': row['id'],
          },
        );
        secret = tokens.accessToken;
      }
    }
    return MailCredentials(
      address: row['address'] as String,
      displayName: row['display_name'] as String?,
      username: row['username'] as String,
      secret: secret,
      oauth: oauth,
      imapHost: row['imap_host'] as String,
      imapPort: row['imap_port'] as int,
      imapTls: row['imap_tls'] as bool,
      smtpHost: row['smtp_host'] as String,
      smtpPort: row['smtp_port'] as int,
      smtpSecurity: SmtpSecurity.values.byName(row['smtp_security'] as String),
    );
  }

  Future<Map<String, dynamic>> _ownAccount(AuthContext ctx, String id) async {
    final row = await _db.run(
      (s) => s.queryOne(
        'SELECT * FROM email_accounts WHERE id = @id AND user_id = @u',
        {'id': id, 'u': ctx.userId},
      ),
    );
    return row ?? (throw const ApiException.notFound('Compte introuvable.'));
  }

  // ── Réception ────────────────────────────────────────────────────────

  /// Synchronise un compte de l'utilisateur.
  Future<EmailAccountInfo> syncAccount(AuthContext ctx, String id) async {
    ctx.require(Permission.emailUse);
    await _syncRow(await _ownAccount(ctx, id));
    return _toInfo(await _ownAccount(ctx, id));
  }

  /// Synchronise tous les comptes actifs (tâche périodique).
  Future<void> syncAll() async {
    if (_syncing) return;
    _syncing = true;
    try {
      final rows = await _db.run(
        (s) => s.queryAll('SELECT * FROM email_accounts WHERE enabled = true'),
      );
      for (final row in rows) {
        await _syncRow(row);
      }
    } finally {
      _syncing = false;
    }
  }

  Future<void> _syncRow(Map<String, dynamic> account) async {
    final accountId = account['id'] as String;
    final userId = account['user_id'] as String;
    try {
      final batch = await _transport.fetchInbox(
        await _credentials(account),
        uidValidity: account['uid_validity'] as int?,
        lastUid: account['uid_validity'] == null
            ? 0
            : account['last_uid'] as int,
        since: _clock().toUtc().subtract(const Duration(days: 30)),
      );
      var lastUid = account['uid_validity'] == batch.uidValidity
          ? account['last_uid'] as int
          : 0;
      for (final mail in batch.messages..sort((a, b) => a.uid - b.uid)) {
        await _storeInbound(
          accountId,
          userId,
          account['address'] as String,
          mail,
        );
        if (mail.uid > lastUid) lastUid = mail.uid;
      }
      await _db.query(
        'UPDATE email_accounts SET uid_validity = @v, last_uid = @l, '
        'last_sync_at = now(), last_error = NULL WHERE id = @id',
        {'v': batch.uidValidity, 'l': lastUid, 'id': accountId},
      );
    } on MailException catch (e) {
      _log.warning('Synchronisation de ${account['address']} : $e');
      await _db.query(
        'UPDATE email_accounts SET last_error = @e, last_sync_at = now() '
        'WHERE id = @id',
        {'e': e.message, 'id': accountId},
      );
    }
  }

  Future<void> _storeInbound(
    String accountId,
    String userId,
    String ownAddress,
    FetchedMail mail,
  ) async {
    // Messages envoyés par soi-même (copie, alias) : pas de contact entrant.
    final counterpart = mail.from.address == ownAddress
        ? mail.to.firstOrNull?.address
        : mail.from.address;
    final contact = counterpart == null
        ? null
        : await _contactByEmail(counterpart);
    final id = newId();
    final inserted = await _db.run(
      (s) => s.queryOne(
        'INSERT INTO email_messages (id, account_id, direction, uid, '
        'message_id, in_reply_to, from_address, from_name, to_addresses, '
        'cc_addresses, subject, body_text, sent_at, contact_id, '
        "organisation_id) VALUES (@id, @a, 'in', @uid, @mid, @irt, @fa, @fn, "
        '@to:jsonb, @cc:jsonb, @s, @b, @at, @c, @o) '
        'ON CONFLICT (account_id, uid) WHERE uid IS NOT NULL DO NOTHING '
        'RETURNING id',
        {
          'id': id,
          'a': accountId,
          'uid': mail.uid,
          'mid': mail.messageId,
          'irt': mail.inReplyTo,
          'fa': mail.from.address,
          'fn': mail.from.name,
          'to': [for (final a in mail.to) a.toJson()],
          'cc': [for (final a in mail.cc) a.toJson()],
          's': mail.subject,
          'b': mail.text,
          'at': mail.date,
          'c': contact?.id,
          'o': contact?.organisationId,
        },
      ),
    );
    if (inserted == null || contact == null) return;
    await _logActivity(
      messageId: id,
      userId: userId,
      subject: mail.subject,
      body: mail.text,
      at: mail.date,
      contactId: contact.id,
      organisationId: contact.organisationId,
    );
    if (mail.from.address != ownAddress) {
      await _stopEnrollmentsOnReply(contact.id, mail.date);
    }
  }

  Future<({String id, String? organisationId})?> _contactByEmail(
    String address,
  ) async {
    final row = await _db.run(
      (s) => s.queryOne(
        'SELECT id, organisation_id FROM contacts WHERE lower(email) = '
        'lower(@e) AND deleted_at IS NULL ORDER BY created_at LIMIT 1',
        {'e': address},
      ),
    );
    return row == null
        ? null
        : (
            id: row['id'] as String,
            organisationId: row['organisation_id'] as String?,
          );
  }

  Future<void> _logActivity({
    required String messageId,
    required String userId,
    required String subject,
    required String body,
    required DateTime at,
    required String contactId,
    String? organisationId,
  }) async {
    try {
      final activityId = await _sync.writeSystem(SyncEntities.activities, {
        'kind': ActivityKind.email.key,
        'subject': subject.trim().isEmpty ? '(sans objet)' : subject.trim(),
        'body': body.length > _activityBodyMax
            ? '${body.substring(0, _activityBodyMax)}…'
            : body,
        'contact_id': contactId,
        'organisation_id': organisationId,
        'starts_at': at.toUtc().toIso8601String(),
        'done_at': at.toUtc().toIso8601String(),
        'owner_id': userId,
      }, userId: userId);
      await _db.query(
        'UPDATE email_messages SET activity_id = @a WHERE id = @id',
        {'a': activityId, 'id': messageId},
      );
    } on SystemWriteException catch (e) {
      _log.warning('Activité email non créée : $e');
    }
  }

  // ── Lecture ──────────────────────────────────────────────────────────

  Future<List<EmailMessage>> listMessages(
    AuthContext ctx, {
    String? accountId,
    String? contactId,
    DateTime? before,
    int limit = 50,
  }) async {
    ctx.require(Permission.emailUse);
    final rows = await _db.run(
      (s) => s.queryAll(
        'SELECT m.* FROM email_messages m JOIN email_accounts a '
        'ON a.id = m.account_id WHERE a.user_id = @u '
        'AND (@acc::uuid IS NULL OR m.account_id = @acc::uuid) '
        'AND (@c::uuid IS NULL OR m.contact_id = @c::uuid) '
        'AND (@b::timestamptz IS NULL OR m.sent_at < @b::timestamptz) '
        'ORDER BY m.sent_at DESC LIMIT @n',
        {
          'u': ctx.userId,
          'acc': accountId,
          'c': contactId,
          'b': before,
          'n': limit.clamp(1, 200),
        },
      ),
    );
    return [for (final r in rows) _toMessage(r, withBody: false)];
  }

  Future<EmailMessage> getMessage(AuthContext ctx, String id) async {
    ctx.require(Permission.emailUse);
    final row = await _db.run(
      (s) => s.queryOne(
        'UPDATE email_messages m SET read = true FROM email_accounts a '
        'WHERE m.id = @id AND a.id = m.account_id AND a.user_id = @u '
        'RETURNING m.*',
        {'id': id, 'u': ctx.userId},
      ),
    );
    if (row == null) throw const ApiException.notFound('Message introuvable.');
    return _toMessage(row, withBody: true);
  }

  // ── Envoi ────────────────────────────────────────────────────────────

  Future<EmailMessage> send(AuthContext ctx, SendEmailRequest request) async {
    ctx.require(Permission.emailUse);
    final recipients = [
      for (final a in [...request.to, ...request.cc]) a.trim().toLowerCase(),
    ];
    final issues = collectIssues([
      if (request.to.isEmpty)
        const ValidationIssue(
          field: 'to',
          code: ValidationCodes.required,
          message: 'Indiquez au moins un destinataire.',
        ),
      for (final a in recipients) validateEmail('to', a),
      validateRequiredText('subject', request.subject, label: "L'objet"),
    ]);
    if (issues.isNotEmpty) throw ApiException.validation(issues);
    final account = await _ownAccount(ctx, request.accountId);
    final message = await _sendFrom(
      account,
      OutgoingMail(
        to: [for (final a in request.to) a.trim().toLowerCase()],
        cc: [for (final a in request.cc) a.trim().toLowerCase()],
        subject: request.subject.trim(),
        body: request.body,
        inReplyTo: request.inReplyTo,
      ),
      contactId: request.contactId,
      organisationId: request.organisationId,
    );
    return message;
  }

  /// Envoie depuis [account], enregistre le message et journalise
  /// l'échange si un contact est concerné.
  Future<EmailMessage> _sendFrom(
    Map<String, dynamic> account,
    OutgoingMail mail, {
    String? contactId,
    String? organisationId,
  }) async {
    final String messageId;
    try {
      messageId = await _transport.send(await _credentials(account), mail);
    } on MailException catch (e) {
      throw ApiException.badRequest(e.message);
    }
    var contact = contactId;
    var organisation = organisationId;
    if (contact == null) {
      final found = await _contactByEmail(mail.to.first);
      contact = found?.id;
      organisation ??= found?.organisationId;
    }
    final id = newId();
    final now = _clock().toUtc();
    final row = await _db.run(
      (s) => s.queryOne(
        'INSERT INTO email_messages (id, account_id, direction, message_id, '
        'in_reply_to, from_address, from_name, to_addresses, cc_addresses, '
        'subject, body_text, sent_at, read, contact_id, organisation_id) '
        "VALUES (@id, @a, 'out', @mid, @irt, @fa, @fn, @to:jsonb, @cc:jsonb, "
        '@s, @b, @at, true, @c, @o) RETURNING *',
        {
          'id': id,
          'a': account['id'],
          'mid': messageId,
          'irt': mail.inReplyTo,
          'fa': account['address'],
          'fn': account['display_name'],
          'to': [for (final a in mail.to) EmailAddress(address: a).toJson()],
          'cc': [for (final a in mail.cc) EmailAddress(address: a).toJson()],
          's': mail.subject,
          'b': mail.body,
          'at': now,
          'c': contact,
          'o': organisation,
        },
      ),
    );
    if (contact != null) {
      await _logActivity(
        messageId: id,
        userId: account['user_id'] as String,
        subject: mail.subject,
        body: mail.body,
        at: now,
        contactId: contact,
        organisationId: organisation,
      );
    }
    return _toMessage(
      (await _db.run(
            (s) => s.queryOne('SELECT * FROM email_messages WHERE id = @id', {
              'id': id,
            }),
          )) ??
          row!,
      withBody: true,
    );
  }

  // ── Séquences ────────────────────────────────────────────────────────

  Future<void> _stopEnrollmentsOnReply(String contactId, DateTime at) async {
    final rows = await _db.run(
      (s) => s.queryAll(
        'SELECT id FROM sequence_enrollments WHERE contact_id = @c AND '
        "status = 'active' AND deleted_at IS NULL AND created_at < @at",
        {'c': contactId, 'at': at},
      ),
    );
    for (final r in rows) {
      await _sync.writeSystem(SyncEntities.sequenceEnrollments, {
        'status': EnrollmentStatus.replied.key,
        'next_send_at': null,
      }, id: r['id'] as String);
    }
  }

  /// Envoie les étapes de séquence arrivées à échéance (tâche
  /// périodique). Retourne le nombre d'emails envoyés.
  Future<int> processSequences({int limit = 50}) async {
    final due = await _db.run(
      (s) => s.queryAll(
        "SELECT * FROM sequence_enrollments WHERE status = 'active' AND "
        'deleted_at IS NULL AND next_send_at <= @now '
        'ORDER BY next_send_at LIMIT @n',
        {'now': _clock().toUtc(), 'n': limit},
      ),
    );
    var sent = 0;
    for (final enrollment in due) {
      final id = enrollment['id'] as String;
      try {
        if (await _sendStep(enrollment)) sent++;
      } on Object catch (e) {
        final message = e is ApiException
            ? e.message
            : e is MailException
            ? e.message
            : 'Erreur interne.';
        if (e is! ApiException && e is! MailException) {
          _log.severe('Séquence $id', e);
        }
        await _sync.writeSystem(SyncEntities.sequenceEnrollments, {
          'status': EnrollmentStatus.failed.key,
          'last_error': message,
          'next_send_at': null,
        }, id: id);
      }
    }
    return sent;
  }

  Future<bool> _sendStep(Map<String, dynamic> enrollment) async {
    final id = enrollment['id'] as String;
    final step = enrollment['step'] as int;
    Future<void> finish(EnrollmentStatus status, [String? error]) =>
        _sync.writeSystem(SyncEntities.sequenceEnrollments, {
          'status': status.key,
          'next_send_at': null,
          'last_error': error,
        }, id: id);

    final data = await _db.run((s) async {
      final sequence = await s.queryOne(
        'SELECT * FROM email_sequences WHERE id = @id AND deleted_at IS NULL',
        {'id': enrollment['sequence_id']},
      );
      final contact = await s.queryOne(
        'SELECT * FROM contacts WHERE id = @id AND deleted_at IS NULL',
        {'id': enrollment['contact_id']},
      );
      final organisation = contact?['organisation_id'] == null
          ? null
          : await s.queryOne(
              'SELECT name, city FROM organisations WHERE id = @id',
              {'id': contact!['organisation_id']},
            );
      final owner = await s.queryOne(
        'SELECT display_name FROM users WHERE id = @id',
        {'id': enrollment['owner_id']},
      );
      final account = await s.queryOne(
        'SELECT * FROM email_accounts WHERE user_id = @u AND enabled = true '
        'ORDER BY created_at LIMIT 1',
        {'u': enrollment['owner_id']},
      );
      return (
        sequence: sequence,
        contact: contact,
        organisation: organisation,
        owner: owner,
        account: account,
      );
    });

    final sequence = data.sequence;
    final contact = data.contact;
    if (sequence == null || sequence['active'] == false) {
      await finish(EnrollmentStatus.stopped, 'Séquence désactivée.');
      return false;
    }
    if (contact == null || contact['do_not_contact'] == true) {
      await finish(EnrollmentStatus.stopped, 'Contact supprimé ou opposé.');
      return false;
    }
    final email = contact['email'] as String?;
    if (email == null || email.isEmpty) {
      await finish(EnrollmentStatus.failed, 'Le contact n’a pas d’email.');
      return false;
    }
    if (data.account == null) {
      await finish(
        EnrollmentStatus.failed,
        'L’expéditeur n’a pas de compte email connecté.',
      );
      return false;
    }
    final steps = (sequence['steps'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
    if (step >= steps.length) {
      await finish(EnrollmentStatus.completed);
      return false;
    }
    final template = await _db.run(
      (s) => s.queryOne(
        'SELECT * FROM email_templates WHERE id = @id AND deleted_at IS NULL',
        {'id': steps[step]['template_id']},
      ),
    );
    if (template == null) {
      await finish(EnrollmentStatus.failed, 'Modèle supprimé.');
      return false;
    }
    final values = {
      'contact.civility': contact['civility'] as String?,
      'contact.first_name': contact['first_name'] as String?,
      'contact.last_name': contact['last_name'] as String?,
      'contact.job_title': contact['job_title'] as String?,
      'organisation.name': data.organisation?['name'] as String?,
      'organisation.city': data.organisation?['city'] as String?,
      'user.name': data.owner?['display_name'] as String?,
    };
    await _sendFrom(
      data.account!,
      OutgoingMail(
        to: [email],
        subject: renderTemplate(template['subject'] as String, values),
        body: renderTemplate(template['body'] as String, values),
      ),
      contactId: contact['id'] as String,
      organisationId: contact['organisation_id'] as String?,
    );
    final next = step + 1;
    await _sync.writeSystem(SyncEntities.sequenceEnrollments, {
      'step': next,
      'last_error': null,
      if (next >= steps.length) ...{
        'status': EnrollmentStatus.completed.key,
        'next_send_at': null,
      } else
        'next_send_at': _clock()
            .toUtc()
            .add(Duration(days: steps[next]['delay_days'] as int))
            .toIso8601String(),
    }, id: id);
    return true;
  }

  // ── Conversion ───────────────────────────────────────────────────────

  static EmailAccountInfo _toInfo(Map<String, dynamic> r) => EmailAccountInfo(
    id: r['id'] as String,
    provider: EmailProvider.values.byName(r['provider'] as String),
    address: r['address'] as String,
    displayName: r['display_name'] as String?,
    enabled: r['enabled'] as bool,
    lastSyncAt: (r['last_sync_at'] as DateTime?)?.toUtc(),
    lastError: r['last_error'] as String?,
  );

  static List<EmailAddress> _addresses(Object? json) => [
    for (final a in (json as List<dynamic>?) ?? const [])
      EmailAddress.fromJson((a as Map).cast<String, dynamic>()),
  ];

  static EmailMessage _toMessage(
    Map<String, dynamic> r, {
    required bool withBody,
  }) {
    final body = r['body_text'] as String;
    final snippet = body.replaceAll(RegExp(r'\s+'), ' ').trim();
    return EmailMessage(
      id: r['id'] as String,
      accountId: r['account_id'] as String,
      direction: r['direction'] as String,
      from: EmailAddress(
        address: r['from_address'] as String,
        name: r['from_name'] as String?,
      ),
      to: _addresses(r['to_addresses']),
      cc: _addresses(r['cc_addresses']),
      subject: r['subject'] as String,
      snippet: snippet.length > 160 ? '${snippet.substring(0, 160)}…' : snippet,
      bodyText: withBody ? body : null,
      sentAt: (r['sent_at'] as DateTime).toUtc(),
      read: r['read'] as bool,
      messageId: r['message_id'] as String?,
      contactId: r['contact_id'] as String?,
      organisationId: r['organisation_id'] as String?,
      activityId: r['activity_id'] as String?,
    );
  }
}
