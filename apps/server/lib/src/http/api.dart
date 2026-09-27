import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../admin/backup_service.dart';
import '../admin/gdpr_service.dart';
import '../audit/audit_log.dart';
import '../auth/auth_context.dart';
import '../auth/auth_service.dart';
import '../auth/users_service.dart';
import '../billing/billing_service.dart';
import '../calendar/calendar_service.dart';
import '../connectors/connector_service.dart';
import '../connectors/webhook_service.dart';
import '../db/database.dart';
import '../email/email_service.dart';
import '../email/mail_transport.dart';
import '../errors.dart';
import '../files/file_store.dart';
import '../public_data/public_data_service.dart';
import '../realtime/realtime_hub.dart';
import '../sync/sync_service.dart';
import 'http_utils.dart';

/// Version de l'application serveur (exposée par /health).
const serverVersion = '0.1.0';

/// Construit le handler HTTP complet (API REST v1 + WebSocket + santé).
Handler buildHandler({
  required Database db,
  required AuthService auth,
  required UsersService users,
  required SyncService sync,
  required RealtimeHub hub,
  required FileStore files,
  required PublicDataService publicData,
  required EmailService email,
  required BillingService billing,
  required ConnectorService connectors,
  required WebhookService webhooks,
  required CalendarService calendar,
  required GdprService gdpr,
  required BackupService backups,
  required bool trustProxy,
  required bool hsts,
}) {
  RequestMeta meta(Request r) => requestMeta(r, trustProxy: trustProxy);

  // Jetons d'API personnels : API publique (`/records`) et `/auth/me`
  // seulement.
  Future<AuthContext> authed(Request r) async {
    final ctx = (await auth.authenticate(bearerToken(r))).withMeta(meta(r));
    if (ctx.viaApiToken &&
        !r.url.path.startsWith('records/') &&
        r.url.path != 'records' &&
        r.url.path != 'auth/me') {
      throw const ApiException.forbidden(
        'Point d’accès non disponible avec un jeton d’API.',
      );
    }
    return ctx;
  }

  EntitySchema entityOf(String name) =>
      SyncEntities.byName(name) ??
      (throw const ApiException.notFound('Entité inconnue.'));

  Response writeResult(OpResult result, {int status = 200}) =>
      switch (result.status) {
        OpStatus.forbidden => throw const ApiException.forbidden(),
        OpStatus.invalid => throw ApiException.validation(result.issues),
        _ => jsonResponse(result.record?.toJson(), status: status),
      };

  final api = Router()
    // ── Authentification ──
    ..post('/auth/login', (Request r) async {
      final body = await readJson(r, LoginRequest.fromJson);
      return jsonResponse((await auth.login(body, meta(r))).toJson());
    })
    ..post('/auth/mfa', (Request r) async {
      final body = await readJson(r, MfaVerifyRequest.fromJson);
      return jsonResponse((await auth.verifyMfa(body, meta(r))).toJson());
    })
    ..post('/auth/refresh', (Request r) async {
      final body = await readJson(r, RefreshRequest.fromJson);
      return jsonResponse((await auth.refresh(body, meta(r))).toJson());
    })
    ..post('/auth/logout', (Request r) async {
      await auth.logout(await authed(r));
      return noContent();
    })
    ..get('/auth/me', (Request r) async {
      return jsonResponse((await auth.currentUser(await authed(r))).toJson());
    })
    ..post('/auth/password', (Request r) async {
      final ctx = await authed(r);
      await auth.changePassword(
        ctx,
        await readJson(r, ChangePasswordRequest.fromJson),
      );
      return noContent();
    })
    ..get('/auth/sessions', (Request r) async {
      final sessions = await auth.listSessions(await authed(r));
      return jsonResponse([for (final s in sessions) s.toJson()]);
    })
    ..delete('/auth/sessions/<id>', (Request r, String id) async {
      final ctx = await authed(r);
      await auth.revokeSessions(ctx, [id], reason: 'revoked_by_user');
      return noContent();
    })
    ..post('/auth/totp/setup', (Request r) async {
      return jsonResponse((await auth.totpSetup(await authed(r))).toJson());
    })
    ..post('/auth/totp/confirm', (Request r) async {
      final ctx = await authed(r);
      final body = await readJson(r, CodeRequest.fromJson);
      return jsonResponse((await auth.totpConfirm(ctx, body)).toJson());
    })
    ..post('/auth/totp/disable', (Request r) async {
      final ctx = await authed(r);
      await auth.totpDisable(ctx, await readJson(r, CodeRequest.fromJson));
      return noContent();
    })
    ..post('/auth/totp/recovery-codes', (Request r) async {
      final ctx = await authed(r);
      final body = await readJson(r, CodeRequest.fromJson);
      return jsonResponse(
        (await auth.regenerateRecoveryCodes(ctx, body)).toJson(),
      );
    })
    // ── Utilisateurs et rôles ──
    ..get('/users', (Request r) async {
      final list = await users.listUsers(await authed(r));
      return jsonResponse([for (final u in list) u.toJson()]);
    })
    ..post('/users', (Request r) async {
      final ctx = await authed(r);
      final body = await readJson(r, CreateUserRequest.fromJson);
      return jsonResponse(
        (await users.createUser(ctx, body)).toJson(),
        status: 201,
      );
    })
    ..patch('/users/<id>', (Request r, String id) async {
      final ctx = await authed(r);
      final body = await readJson(r, UpdateUserRequest.fromJson);
      return jsonResponse((await users.updateUser(ctx, id, body)).toJson());
    })
    ..post('/users/<id>/revoke-sessions', (Request r, String id) async {
      await users.revokeUserSessions(await authed(r), id);
      return noContent();
    })
    ..get('/roles', (Request r) async {
      final list = await users.listRoles(await authed(r));
      return jsonResponse([for (final role in list) role.toJson()]);
    })
    ..post('/roles', (Request r) async {
      final ctx = await authed(r);
      final body = await readJson(r, SaveRoleRequest.fromJson);
      return jsonResponse(
        (await users.createRole(ctx, body)).toJson(),
        status: 201,
      );
    })
    ..put('/roles/<id>', (Request r, String id) async {
      final ctx = await authed(r);
      final body = await readJson(r, SaveRoleRequest.fromJson);
      return jsonResponse((await users.updateRole(ctx, id, body)).toJson());
    })
    ..delete('/roles/<id>', (Request r, String id) async {
      await users.deleteRole(await authed(r), id);
      return noContent();
    })
    // ── Synchronisation ──
    ..post('/sync/push', (Request r) async {
      final ctx = await authed(r);
      final body = await readJson(r, PushRequest.fromJson);
      return jsonResponse((await sync.push(ctx, body)).toJson());
    })
    ..get('/sync/pull', (Request r) async {
      final ctx = await authed(r);
      final response = await sync.pull(
        ctx,
        intParam(r, 'cursor') ?? 0,
        limit: intParam(r, 'limit'),
      );
      return jsonResponse(response.toJson());
    })
    ..get('/sync/conflicts', (Request r) async {
      final ctx = await authed(r);
      final list = await sync.listConflicts(
        ctx,
        unreviewedOnly: r.url.queryParameters['unreviewed'] == 'true',
        limit: intParam(r, 'limit') ?? 200,
      );
      return jsonResponse([for (final c in list) c.toJson()]);
    })
    ..post('/sync/conflicts/<id>/review', (Request r, String id) async {
      await sync.markConflictReviewed(await authed(r), id);
      return noContent();
    })
    // ── Fichiers joints ──
    ..post('/files', (Request r) async {
      final ctx = await authed(r);
      final length = r.contentLength;
      if (length != null && length > maxFileBytes) {
        throw const ApiException(
          413,
          'payload_too_large',
          'Fichier trop volumineux (25 Mo maximum).',
        );
      }
      final stored = await files.upload(ctx, r.read(), mimeType: r.mimeType);
      return jsonResponse({'id': stored.id, 'size': stored.size}, status: 201);
    })
    ..get('/files/<id>', (Request r, String id) async {
      final found = await files.open(await authed(r), id);
      return Response.ok(
        found.file.openRead(),
        headers: {
          HttpHeaders.contentTypeHeader:
              found.mimeType ?? 'application/octet-stream',
          HttpHeaders.contentLengthHeader: '${found.file.lengthSync()}',
          'content-disposition': 'attachment',
        },
      );
    })
    // ── Messagerie ──
    ..get('/email/providers', (Request r) async {
      (await authed(r)).require(Permission.emailUse);
      return jsonResponse([for (final p in email.availableProviders()) p.name]);
    })
    ..get('/email/accounts', (Request r) async {
      final list = await email.listAccounts(await authed(r));
      return jsonResponse([for (final a in list) a.toJson()]);
    })
    ..post('/email/accounts', (Request r) async {
      final ctx = await authed(r);
      final body = await readJson(r, CreateImapAccountRequest.fromJson);
      return jsonResponse(
        (await email.createImapAccount(ctx, body)).toJson(),
        status: 201,
      );
    })
    ..delete('/email/accounts/<id>', (Request r, String id) async {
      await email.deleteAccount(await authed(r), id);
      return noContent();
    })
    ..post('/email/accounts/<id>/sync', (Request r, String id) async {
      return jsonResponse(
        (await email.syncAccount(await authed(r), id)).toJson(),
      );
    })
    ..get('/email/oauth/callback', (Request r) async {
      final q = r.url.queryParameters;
      try {
        final address = await email.oauthCallback(
          code: q['code'],
          state: q['state'],
          error: q['error'],
        );
        return htmlPage(
          'Compte connecté',
          'Le compte $address est connecté à Voyaj CRM. Vous pouvez fermer '
              'cette fenêtre et revenir à l’application.',
        );
      } on MailException catch (e) {
        return htmlPage('Connexion impossible', e.message, status: 400);
      }
    })
    ..get('/email/oauth/<provider>/start', (Request r, String provider) async {
      return jsonResponse(
        (await email.oauthStart(await authed(r), provider)).toJson(),
      );
    })
    ..get('/email/messages', (Request r) async {
      final q = r.url.queryParameters;
      final list = await email.listMessages(
        await authed(r),
        accountId: q['account'],
        contactId: q['contact'],
        before: q['before'] == null ? null : DateTime.tryParse(q['before']!),
        limit: intParam(r, 'limit') ?? 50,
      );
      return jsonResponse([for (final m in list) m.toJson()]);
    })
    ..get('/email/messages/<id>', (Request r, String id) async {
      return jsonResponse(
        (await email.getMessage(await authed(r), id)).toJson(),
      );
    })
    ..post('/email/send', (Request r) async {
      final ctx = await authed(r);
      final body = await readJson(r, SendEmailRequest.fromJson);
      return jsonResponse((await email.send(ctx, body)).toJson(), status: 201);
    })
    // ── Données publiques ──
    ..get('/public-data', (Request r) async {
      final list = await publicData.status(await authed(r));
      return jsonResponse([for (final s in list) s.toJson()]);
    })
    ..get('/public-data/runs', (Request r) async {
      final list = await publicData.runs(
        await authed(r),
        source: r.url.queryParameters['source'],
        limit: intParam(r, 'limit') ?? 50,
      );
      return jsonResponse([for (final run in list) run.toJson()]);
    })
    ..put('/public-data/<source>', (Request r, String source) async {
      final ctx = await authed(r);
      final body = await readJson(r, ConfigurePublicSourceRequest.fromJson);
      return jsonResponse(
        (await publicData.configure(ctx, source, body)).toJson(),
      );
    })
    ..post('/public-data/<source>/run', (Request r, String source) async {
      final run = await publicData.start(await authed(r), source);
      return jsonResponse(run.toJson(), status: 202);
    })
    // ── Facturation ──
    ..get('/billing/settings', (Request r) async {
      return jsonResponse((await billing.settings(await authed(r))).toJson());
    })
    ..put('/billing/settings', (Request r) async {
      final ctx = await authed(r);
      final body = await readJson(r, BillingSettings.fromJson);
      return jsonResponse((await billing.updateSettings(ctx, body)).toJson());
    })
    ..post('/billing/documents/<id>/issue', (Request r, String id) async {
      final number = await billing.issue(await authed(r), id);
      return jsonResponse({'number': number});
    })
    ..get('/billing/documents/<id>/pdf', (Request r, String id) async {
      final found = await billing.pdf(await authed(r), id);
      return Response.ok(
        found.file.openRead(),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/pdf',
          HttpHeaders.contentLengthHeader: '${found.file.lengthSync()}',
          'content-disposition': 'attachment; filename="${found.fileName}"',
        },
      );
    })
    ..post('/billing/documents/<id>/chorus', (Request r, String id) async {
      final flux = await billing.depositToChorus(await authed(r), id);
      return jsonResponse({'flux': flux});
    })
    ..get('/billing/fec', (Request r) async {
      final year = intParam(r, 'year');
      if (year == null || year < 2000 || year > 2100) {
        throw const ApiException.badRequest('Année invalide.');
      }
      final fec = await billing.fec(await authed(r), year);
      return Response.ok(
        fec.content,
        headers: {
          HttpHeaders.contentTypeHeader: 'text/plain; charset=utf-8',
          'content-disposition': 'attachment; filename="${fec.fileName}"',
        },
      );
    })
    ..get('/billing/vat', (Request r) async {
      final from = DateTime.tryParse(r.url.queryParameters['from'] ?? '');
      final to = DateTime.tryParse(r.url.queryParameters['to'] ?? '');
      if (from == null || to == null) {
        throw const ApiException.badRequest('Période invalide.');
      }
      final report = await billing.vatReport(await authed(r), from, to);
      return jsonResponse(report.toJson());
    })
    // ── Connecteurs ──
    ..get('/connectors', (Request r) async {
      final list = await connectors.list(await authed(r));
      return jsonResponse([for (final c in list) c.toJson()]);
    })
    ..post('/connectors', (Request r) async {
      final ctx = await authed(r);
      final body = await readJson(r, ConnectorInput.fromJson);
      return jsonResponse(
        (await connectors.create(ctx, body)).toJson(),
        status: 201,
      );
    })
    ..post('/connectors/preview', (Request r) async {
      final ctx = await authed(r);
      final body = await readJson(r, ConnectorInput.fromJson);
      final preview = await connectors.preview(
        ctx,
        body,
        id: r.url.queryParameters['id'],
      );
      return jsonResponse(preview.toJson());
    })
    ..get('/connectors/<id>', (Request r, String id) async {
      return jsonResponse((await connectors.get(await authed(r), id)).toJson());
    })
    ..put('/connectors/<id>', (Request r, String id) async {
      final ctx = await authed(r);
      final body = await readJson(r, ConnectorInput.fromJson);
      return jsonResponse((await connectors.update(ctx, id, body)).toJson());
    })
    ..delete('/connectors/<id>', (Request r, String id) async {
      await connectors.delete(await authed(r), id);
      return noContent();
    })
    ..post('/connectors/<id>/run', (Request r, String id) async {
      final run = await connectors.start(await authed(r), id);
      return jsonResponse(run.toJson(), status: 202);
    })
    ..get('/connectors/<id>/runs', (Request r, String id) async {
      final list = await connectors.runs(await authed(r), id);
      return jsonResponse([for (final run in list) run.toJson()]);
    })
    ..post('/connectors/<id>/webhook-token', (Request r, String id) async {
      final token = await connectors.createWebhookToken(await authed(r), id);
      return jsonResponse(token.toJson());
    })
    // Webhook entrant : authentifié par le jeton du connecteur.
    ..post('/hooks/<id>', (Request r, String id) async {
      final length = r.contentLength;
      if (length != null && length > maxHookBytes) {
        throw const ApiException(
          413,
          'payload_too_large',
          'Corps trop volumineux (5 Mo maximum).',
        );
      }
      final authorization = r.headers['authorization'];
      final token =
          r.headers['x-voyaj-token'] ??
          (authorization != null && authorization.startsWith('Bearer ')
              ? authorization.substring(7)
              : null);
      final body = await _readLimited(r, maxHookBytes);
      final run = await connectors.receive(id, token, body);
      return jsonResponse(run.toJson());
    })
    // ── Webhooks sortants ──
    ..get('/webhooks', (Request r) async {
      final list = await webhooks.list(await authed(r));
      return jsonResponse([for (final w in list) w.toJson()]);
    })
    ..post('/webhooks', (Request r) async {
      final ctx = await authed(r);
      final body = await readJson(r, WebhookInput.fromJson);
      return jsonResponse(
        (await webhooks.create(ctx, body)).toJson(),
        status: 201,
      );
    })
    ..put('/webhooks/<id>', (Request r, String id) async {
      final ctx = await authed(r);
      final body = await readJson(r, WebhookInput.fromJson);
      return jsonResponse((await webhooks.update(ctx, id, body)).toJson());
    })
    ..delete('/webhooks/<id>', (Request r, String id) async {
      await webhooks.delete(await authed(r), id);
      return noContent();
    })
    ..post('/webhooks/<id>/ping', (Request r, String id) async {
      final status = await webhooks.ping(await authed(r), id);
      return jsonResponse({'status': status});
    })
    // ── Agenda ──
    ..get('/calendar/feed', (Request r) async {
      return jsonResponse({'active': await calendar.hasFeed(await authed(r))});
    })
    ..post('/calendar/feed', (Request r) async {
      return jsonResponse({'url': await calendar.createFeed(await authed(r))});
    })
    ..delete('/calendar/feed', (Request r) async {
      await calendar.revokeFeed(await authed(r));
      return noContent();
    })
    // Flux ICS : authentifié par le jeton de l'URL (abonnement d'agenda).
    ..get('/calendar/<file>', (Request r, String file) async {
      if (!file.endsWith('.ics')) {
        throw const ApiException.notFound('Agenda introuvable.');
      }
      final ics = await calendar.feed(file.substring(0, file.length - 4));
      return Response.ok(
        ics,
        headers: {
          HttpHeaders.contentTypeHeader: 'text/calendar; charset=utf-8',
          HttpHeaders.cacheControlHeader: 'private, max-age=300',
        },
      );
    })
    // ── Jetons d'API personnels ──
    ..get('/auth/api-tokens', (Request r) async {
      final list = await auth.listApiTokens(await authed(r));
      return jsonResponse([for (final t in list) t.toJson()]);
    })
    ..post('/auth/api-tokens', (Request r) async {
      final ctx = await authed(r);
      final body = await readJson(r, CreateApiTokenRequest.fromJson);
      return jsonResponse(
        (await auth.createApiToken(ctx, body)).toJson(),
        status: 201,
      );
    })
    ..delete('/auth/api-tokens/<id>', (Request r, String id) async {
      await auth.revokeApiToken(await authed(r), id);
      return noContent();
    })
    // ── API publique : enregistrements ──
    ..get('/records/<entity>', (Request r, String entity) async {
      final page = await sync.listRecords(
        await authed(r),
        entityOf(entity),
        cursor: intParam(r, 'cursor') ?? 0,
        limit: intParam(r, 'limit') ?? 100,
      );
      return jsonResponse({
        'records': [for (final rec in page.records) rec.toJson()],
        'cursor': page.cursor,
        'has_more': page.hasMore,
      });
    })
    ..get('/records/<entity>/<id>', (
      Request r,
      String entity,
      String id,
    ) async {
      final record = await sync.getRecord(
        await authed(r),
        entityOf(entity),
        id,
      );
      return jsonResponse(record.toJson());
    })
    ..post('/records/<entity>', (Request r, String entity) async {
      final ctx = await authed(r);
      final fields = await readJson(r, (json) => json);
      final id = switch (fields.remove('id')) {
        final String given when isValidId(given) => given,
        null => newId(),
        _ => throw const ApiException.badRequest('Identifiant invalide.'),
      };
      final result = await sync.writeRecord(ctx, entityOf(entity), id, fields);
      return writeResult(result, status: 201);
    })
    ..patch('/records/<entity>/<id>', (
      Request r,
      String entity,
      String id,
    ) async {
      final ctx = await authed(r);
      final schema = entityOf(entity);
      await sync.getRecord(ctx, schema, id);
      final fields = await readJson(r, (json) => json);
      return writeResult(await sync.writeRecord(ctx, schema, id, fields));
    })
    ..delete('/records/<entity>/<id>', (
      Request r,
      String entity,
      String id,
    ) async {
      final ctx = await authed(r);
      final schema = entityOf(entity);
      await sync.getRecord(ctx, schema, id);
      writeResult(
        await sync.writeRecord(ctx, schema, id, {
          SyncColumns.deletedAt: DateTime.now().toUtc().toIso8601String(),
        }),
      );
      return noContent();
    })
    // ── RGPD ──
    ..get('/gdpr/contacts/<id>/export', (Request r, String id) async {
      final data = await gdpr.exportContact(await authed(r), id);
      return Response.ok(
        const JsonEncoder.withIndent('  ').convert(data),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
          'content-disposition': 'attachment; filename="rgpd-contact-$id.json"',
        },
      );
    })
    ..post('/gdpr/contacts/<id>/erase', (Request r, String id) async {
      await gdpr.eraseContact(await authed(r), id);
      return noContent();
    })
    // ── Sauvegardes ──
    ..get('/admin/backups', (Request r) async {
      return jsonResponse((await backups.status(await authed(r))).toJson());
    })
    ..post('/admin/backups', (Request r) async {
      final info = await backups.start(await authed(r));
      return jsonResponse(info.toJson(), status: 201);
    })
    // ── Audit ──
    ..get('/audit', (Request r) async {
      (await authed(r)).require(Permission.auditRead);
      final entries = await AuditLog.list(
        db,
        limit: intParam(r, 'limit') ?? 100,
        beforeId: intParam(r, 'before'),
      );
      return jsonResponse([for (final e in entries) e.toJson()]);
    })
    ..all('/<ignored|.*>', (Request r) {
      throw const ApiException.notFound('Point d’accès inconnu.');
    });

  final root = Router()
    ..get('/health', (Request r) async {
      await db.query('SELECT 1');
      return jsonResponse({
        'status': 'ok',
        'version': serverVersion,
        'protocol': syncProtocolVersion,
      });
    })
    ..get(
      '/ws',
      webSocketHandler(
        (channel, _) => hub.handle(channel),
        pingInterval: const Duration(seconds: 25),
      ),
    )
    ..mount('/api/v1/', api.call);

  return const Pipeline()
      .addMiddleware(logMiddleware())
      .addMiddleware(securityHeadersMiddleware(hsts: hsts))
      .addMiddleware(errorMiddleware())
      .addHandler(root.call);
}

/// Taille maximale d'un appel de webhook entrant.
const maxHookBytes = 5 * 1024 * 1024;

/// Corps de la requête, refusé au-delà de [limit] octets.
Future<List<int>> _readLimited(Request request, int limit) async {
  final bytes = <int>[];
  await for (final chunk in request.read()) {
    bytes.addAll(chunk);
    if (bytes.length > limit) {
      throw const ApiException(
        413,
        'payload_too_large',
        'Corps trop volumineux (5 Mo maximum).',
      );
    }
  }
  return bytes;
}
