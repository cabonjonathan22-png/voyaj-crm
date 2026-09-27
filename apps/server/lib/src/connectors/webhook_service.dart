import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:connectors/connectors.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../audit/audit_log.dart';
import '../auth/auth_context.dart';
import '../db/database.dart';
import '../errors.dart';
import '../security/secret_cipher.dart';
import '../sync/sync_service.dart';

final _log = Logger('webhooks');

/// Webhooks sortants : les changements des entités choisies sont envoyés
/// en POST JSON signé (HMAC-SHA256), au moins une fois et dans l'ordre.
/// En cas d'échec, nouvel essai avec un délai croissant (jusqu'à 1 h).
final class WebhookService {
  WebhookService({
    required this._db,
    required this._sync,
    required this._cipher,
    http.Client? httpClient,
    DateTime Function()? clock,
  }) : _http = httpClient ?? http.Client(),
       _clock = clock ?? DateTime.now;

  final Database _db;
  final SyncService _sync;
  final SecretCipher _cipher;
  final http.Client _http;
  final DateTime Function() _clock;

  StreamSubscription<int>? _changes;
  Timer? _debounce;
  Timer? _retry;
  Future<void> _delivering = Future.value();

  static const _batchSize = 100;
  static const _timeout = Duration(seconds: 15);

  /// Démarre les livraisons (changements + nouvel essai chaque minute).
  void start() {
    _changes = _sync.changes.listen((_) {
      _debounce?.cancel();
      _debounce = Timer(const Duration(seconds: 2), deliverAll);
    });
    _retry = Timer.periodic(const Duration(minutes: 1), (_) => deliverAll());
  }

  Future<void> close() async {
    _debounce?.cancel();
    _retry?.cancel();
    await _changes?.cancel();
    await _delivering;
  }

  // ── Configuration ─────────────────────────────────────────────────────

  Future<List<WebhookInfo>> list(AuthContext ctx) async {
    ctx.require(Permission.connectorManage);
    final rows = await _db.run(
      (s) => s.queryAll('SELECT * FROM webhooks ORDER BY lower(name)'),
    );
    return [for (final row in rows) _info(row)];
  }

  static WebhookInfo _info(Map<String, dynamic> row) => WebhookInfo(
    id: row['id'] as String,
    name: row['name'] as String,
    url: row['url'] as String,
    entities: [for (final e in row['entities'] as List) '$e'],
    enabled: row['enabled'] as bool,
    hasSecret: row['secret_enc'] != null,
    lastSeq: row['last_seq'] as int,
    lastDeliveryAt: row['last_delivery_at'] as DateTime?,
    lastStatus: row['last_status'] as int?,
    lastError: row['last_error'] as String?,
    failures: row['failures'] as int,
  );

  List<ValidationIssue> _check(WebhookInput input) {
    final uri = Uri.tryParse(input.url.trim());
    return collectIssues([
      validateRequiredText('name', input.name, label: 'Le nom', max: 120),
      if (uri == null ||
          !(uri.scheme == 'https' || uri.scheme == 'http') ||
          uri.host.isEmpty)
        const ValidationIssue(
          field: 'url',
          code: ValidationCodes.invalidFormat,
          message: 'URL http(s) invalide.',
        ),
      if (input.entities.isEmpty ||
          input.entities.any((e) => SyncEntities.byName(e) == null))
        const ValidationIssue(
          field: 'entities',
          code: ValidationCodes.invalidFormat,
          message: 'Choisissez au moins une entité.',
        ),
    ]);
  }

  Future<WebhookInfo> create(AuthContext ctx, WebhookInput input) async {
    ctx.require(Permission.connectorManage);
    final issues = _check(input);
    if (issues.isNotEmpty) throw ApiException.validation(issues);
    final id = newId();
    final secret = input.secret;
    // Seuls les changements postérieurs à la création sont envoyés.
    final cursor = await _sync.currentCursor();
    final row = await _db.tx((tx) async {
      final row = await tx.queryOne(
        'INSERT INTO webhooks (id, name, url, entities, secret_enc, enabled, '
        'last_seq, created_by) VALUES (@id, @n, @url, @e:_text, @s, @en, @c, '
        '@u) RETURNING *',
        {
          'id': id,
          'n': input.name.trim(),
          'url': input.url.trim(),
          'e': input.entities,
          's': secret == null || secret.isEmpty
              ? null
              : await _cipher.encrypt(secret),
          'en': input.enabled,
          'c': cursor,
          'u': ctx.userId,
        },
      );
      await AuditLog.append(tx, _event(ctx, AuditActions.webhookSaved, id));
      return row!;
    });
    return _info(row);
  }

  Future<WebhookInfo> update(
    AuthContext ctx,
    String id,
    WebhookInput input,
  ) async {
    ctx.require(Permission.connectorManage);
    final issues = _check(input);
    if (issues.isNotEmpty) throw ApiException.validation(issues);
    final secret = input.secret;
    final row = await _db.tx((tx) async {
      final row = await tx.queryOne(
        'UPDATE webhooks SET name = @n, url = @url, entities = @e:_text, '
        'enabled = @en, failures = 0, next_attempt_at = NULL'
        '${secret == null ? '' : ', secret_enc = @s'} WHERE id = @id '
        'RETURNING *',
        {
          'id': id,
          'n': input.name.trim(),
          'url': input.url.trim(),
          'e': input.entities,
          'en': input.enabled,
          if (secret != null)
            's': secret.isEmpty ? null : await _cipher.encrypt(secret),
        },
      );
      if (row == null) {
        throw const ApiException.notFound('Webhook introuvable.');
      }
      await AuditLog.append(tx, _event(ctx, AuditActions.webhookSaved, id));
      return row;
    });
    return _info(row);
  }

  Future<void> delete(AuthContext ctx, String id) async {
    ctx.require(Permission.connectorManage);
    await _db.tx((tx) async {
      final row = await tx.queryOne(
        'DELETE FROM webhooks WHERE id = @id RETURNING id',
        {'id': id},
      );
      if (row == null) {
        throw const ApiException.notFound('Webhook introuvable.');
      }
      await AuditLog.append(tx, _event(ctx, AuditActions.webhookDeleted, id));
    });
  }

  AuditEvent _event(AuthContext ctx, String action, String id) => AuditEvent(
    action: action,
    actorUserId: ctx.userId,
    sessionId: ctx.sessionId,
    entity: 'webhooks',
    entityId: id,
    ip: ctx.meta.ip,
  );

  /// Envoie un événement de test ; retourne le code HTTP reçu.
  Future<int> ping(AuthContext ctx, String id) async {
    ctx.require(Permission.connectorManage);
    final row = await _db.run(
      (s) => s.queryOne('SELECT * FROM webhooks WHERE id = @id', {'id': id}),
    );
    if (row == null) throw const ApiException.notFound('Webhook introuvable.');
    final (status, error) = await _post(row, {
      'event': 'ping',
      'webhook_id': id,
      'sent_at': _clock().toUtc().toIso8601String(),
    });
    if (error != null) {
      throw ApiException(502, ApiErrorCodes.badRequest, error);
    }
    return status!;
  }

  // ── Livraison ─────────────────────────────────────────────────────────

  /// Livre les changements en attente de tous les webhooks actifs (appels
  /// sérialisés).
  Future<void> deliverAll() => _delivering = _delivering.then((_) async {
    try {
      final due = await _db.run(
        (s) => s.queryAll(
          'SELECT * FROM webhooks WHERE enabled AND (next_attempt_at IS NULL '
          'OR next_attempt_at <= @now)',
          {'now': _clock().toUtc()},
        ),
      );
      for (final row in due) {
        await _deliver(row);
      }
    } on Object catch (e, stack) {
      _log.warning('Livraison des webhooks', e, stack);
    }
  });

  Future<void> _deliver(Map<String, dynamic> row) async {
    final schemas = [
      for (final name in row['entities'] as List) ?SyncEntities.byName('$name'),
    ];
    var cursor = row['last_seq'] as int;
    // Plusieurs lots si besoin, tant que les envois réussissent.
    for (var i = 0; i < 20; i++) {
      final records = await _sync.changesSince(
        schemas,
        cursor,
        limit: _batchSize,
      );
      if (records.isEmpty) return;
      final (status, error) = await _post(row, {
        'event': 'records.changed',
        'webhook_id': row['id'],
        'sent_at': _clock().toUtc().toIso8601String(),
        'records': [
          for (final r in records)
            {
              'entity': r.entity,
              'id': r.id,
              'version': r.version,
              'seq': r.seq,
              'deleted': r.data[SyncColumns.deletedAt] != null,
              'data': r.data,
            },
        ],
      });
      if (error != null) {
        final failures = (row['failures'] as int) + 1;
        await _db.query(
          'UPDATE webhooks SET failures = @f, last_status = @st, '
          'last_error = @e, next_attempt_at = @next WHERE id = @id',
          {
            'id': row['id'],
            'f': failures,
            'st': status,
            'e': error,
            'next': _clock().toUtc().add(
              Duration(minutes: min(60, pow(2, failures - 1).toInt())),
            ),
          },
        );
        return;
      }
      cursor = records.last.seq;
      await _db.query(
        'UPDATE webhooks SET last_seq = @c, failures = 0, last_status = @st, '
        'last_error = NULL, next_attempt_at = NULL, last_delivery_at = now() '
        'WHERE id = @id',
        {'id': row['id'], 'c': cursor, 'st': status},
      );
      row = {...row, 'failures': 0};
      if (records.length < _batchSize) return;
    }
  }

  /// Envoie [payload] ; retourne le code HTTP et l'erreur éventuelle.
  Future<(int?, String?)> _post(
    Map<String, dynamic> row,
    Map<String, Object?> payload,
  ) async {
    final body = utf8.encode(jsonEncode(payload));
    final secretEnc = row['secret_enc'] as String?;
    final headers = {
      'content-type': 'application/json; charset=utf-8',
      'user-agent': 'Voyaj-CRM-Webhook/1',
      'x-voyaj-event': '${payload['event']}',
      if (secretEnc != null)
        signatureHeader: signPayload(await _cipher.decrypt(secretEnc), body),
    };
    try {
      final response = await _http
          .post(Uri.parse(row['url'] as String), headers: headers, body: body)
          .timeout(_timeout);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return (response.statusCode, null);
      }
      return (
        response.statusCode,
        'Réponse ${response.statusCode} du destinataire.',
      );
    } on TimeoutException {
      return (null, 'Délai dépassé.');
    } on Object {
      return (null, 'Destinataire injoignable.');
    }
  }
}
