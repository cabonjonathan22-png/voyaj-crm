import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../audit/audit_log.dart';
import '../auth/auth_context.dart';
import '../auth/auth_service.dart';
import '../auth/users_service.dart';
import '../db/database.dart';
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
  required bool trustProxy,
  required bool hsts,
}) {
  RequestMeta meta(Request r) => requestMeta(r, trustProxy: trustProxy);

  Future<AuthContext> authed(Request r) async =>
      (await auth.authenticate(bearerToken(r))).withMeta(meta(r));

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
