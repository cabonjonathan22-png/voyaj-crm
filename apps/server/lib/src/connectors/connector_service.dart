import 'dart:async';
import 'dart:convert';

import 'package:connectors/connectors.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../audit/audit_log.dart';
import '../auth/auth_context.dart';
import '../db/database.dart';
import '../errors.dart';
import '../security/secret_cipher.dart';
import '../security/tokens.dart';
import '../sync/sync_service.dart';

final _log = Logger('connectors');

/// Ouverture d'une source (remplaçable dans les tests).
typedef SourceOpener = RecordSource Function(
  ConnectorKind kind,
  Map<String, Object?> config,
  String? secret,
);

/// Connecteurs : sources externes importées en organisations ou contacts
/// (manuellement, périodiquement ou par webhook entrant).
final class ConnectorService {
  ConnectorService({
    required this._db,
    required this._sync,
    required this._cipher,
    required this._publicUrl,
    SourceOpener? sourceOpener,
    http.Client? httpClient,
    DateTime Function()? clock,
  }) : _open =
           sourceOpener ??
           ((kind, config, secret) => openSource(
             kind,
             config,
             secret: secret,
             httpClient: httpClient,
           )),
       _clock = clock ?? DateTime.now;

  final Database _db;
  final SyncService _sync;
  final SecretCipher _cipher;
  final Uri? _publicUrl;
  final SourceOpener _open;
  final DateTime Function() _clock;

  /// Connecteurs en cours d'import (un seul import à la fois chacun).
  final _running = <String>{};

  /// Nombre maximal d'enregistrements lus par import.
  static const maxRecords = 20000;

  /// Planification minimale (minutes).
  static const minSchedule = 15;

  // ── Configuration ─────────────────────────────────────────────────────

  Future<List<ConnectorInfo>> list(AuthContext ctx) async {
    ctx.require(Permission.connectorManage);
    final rows = await _db.run(
      (s) => s.queryAll('SELECT * FROM connectors ORDER BY lower(name)'),
    );
    return [for (final row in rows) await _info(row)];
  }

  Future<ConnectorInfo> _info(Map<String, dynamic> row) async {
    final last = await _db.run(
      (s) => s.queryOne(
        'SELECT * FROM connector_runs WHERE connector_id = @id '
        'ORDER BY started_at DESC LIMIT 1',
        {'id': row['id']},
      ),
    );
    return ConnectorInfo(
      id: row['id'] as String,
      name: row['name'] as String,
      kind: row['kind'] as String,
      config: (row['config'] as Map).cast<String, Object?>(),
      mapping: ConnectorMapping.fromJson(
        (row['mapping'] as Map).cast<String, dynamic>(),
      ),
      enabled: row['enabled'] as bool,
      scheduleMinutes: row['schedule_minutes'] as int?,
      hasSecret: row['secret_enc'] != null,
      hasWebhookToken: row['webhook_token_hash'] != null,
      lastRun: last == null ? null : _run(last),
    );
  }

  static ConnectorRun _run(Map<String, dynamic> row) => ConnectorRun(
    id: row['id'] as String,
    connectorId: row['connector_id'] as String,
    trigger: row['trigger'] as String,
    status: row['status'] as String,
    startedAt: row['started_at'] as DateTime,
    finishedAt: row['finished_at'] as DateTime?,
    fetched: row['fetched'] as int,
    created: row['created'] as int,
    updated: row['updated'] as int,
    unchanged: row['unchanged'] as int,
    rejected: row['rejected'] as int,
    problems: [for (final p in row['problems'] as List) '$p'],
    error: row['error'] as String?,
  );

  List<ValidationIssue> _check(ConnectorInput input) => collectIssues([
    validateRequiredText('name', input.name, label: 'Le nom', max: 120),
    if (enumByKey(ConnectorKind.values, input.kind) == null)
      _issue('kind', 'Type de connecteur inconnu.'),
    if (!connectorEntities.contains(input.mapping.entity))
      _issue('mapping', 'Entité non alimentable par un connecteur.'),
    if (input.mapping.refPath.trim().isEmpty)
      _issue('mapping', 'Indiquez le chemin de l’identifiant source.'),
    if (input.scheduleMinutes != null &&
        (input.scheduleMinutes! < minSchedule ||
            input.scheduleMinutes! > 7 * 24 * 60))
      _issue(
        'scheduleMinutes',
        'Planification de $minSchedule minutes à 7 jours.',
      ),
    if (input.scheduleMinutes != null && input.kind == 'webhook')
      _issue('scheduleMinutes', 'Un webhook entrant n’est pas planifié.'),
  ]);

  static ValidationIssue _issue(String field, String message) =>
      ValidationIssue(
        field: field,
        code: ValidationCodes.invalidFormat,
        message: message,
      );

  Future<ConnectorInfo> create(AuthContext ctx, ConnectorInput input) async {
    ctx.require(Permission.connectorManage);
    final issues = _check(input);
    if (issues.isNotEmpty) throw ApiException.validation(issues);
    final id = newId();
    final secret = input.secret;
    await _db.tx((tx) async {
      await tx.query(
        'INSERT INTO connectors (id, name, kind, config, mapping, secret_enc, '
        'enabled, schedule_minutes, created_by) VALUES (@id, @n, @k, '
        '@c:jsonb, @m:jsonb, @s, @e, @sch, @u)',
        {
          'id': id,
          'n': input.name.trim(),
          'k': input.kind,
          'c': input.config,
          'm': input.mapping.toJson(),
          's': secret == null || secret.isEmpty
              ? null
              : await _cipher.encrypt(secret),
          'e': input.enabled,
          'sch': input.scheduleMinutes,
          'u': ctx.userId,
        },
      );
      await AuditLog.append(tx, _event(ctx, AuditActions.connectorSaved, id));
    });
    return get(ctx, id);
  }

  Future<ConnectorInfo> get(AuthContext ctx, String id) async {
    ctx.require(Permission.connectorManage);
    return _info(await _row(id));
  }

  Future<Map<String, dynamic>> _row(String id) async {
    if (!isValidId(id)) {
      throw const ApiException.notFound('Connecteur introuvable.');
    }
    final row = await _db.run(
      (s) => s.queryOne('SELECT * FROM connectors WHERE id = @id', {'id': id}),
    );
    if (row == null) {
      throw const ApiException.notFound('Connecteur introuvable.');
    }
    return row;
  }

  Future<ConnectorInfo> update(
    AuthContext ctx,
    String id,
    ConnectorInput input,
  ) async {
    ctx.require(Permission.connectorManage);
    await _row(id);
    final issues = _check(input);
    if (issues.isNotEmpty) throw ApiException.validation(issues);
    final secret = input.secret;
    await _db.tx((tx) async {
      await tx.query(
        'UPDATE connectors SET name = @n, kind = @k, config = @c:jsonb, '
        'mapping = @m:jsonb, enabled = @e, schedule_minutes = @sch, '
        '${secret == null ? '' : 'secret_enc = @s, '}updated_at = now() '
        'WHERE id = @id',
        {
          'id': id,
          'n': input.name.trim(),
          'k': input.kind,
          'c': input.config,
          'm': input.mapping.toJson(),
          'e': input.enabled,
          'sch': input.scheduleMinutes,
          if (secret != null)
            's': secret.isEmpty ? null : await _cipher.encrypt(secret),
        },
      );
      await AuditLog.append(tx, _event(ctx, AuditActions.connectorSaved, id));
    });
    return get(ctx, id);
  }

  Future<void> delete(AuthContext ctx, String id) async {
    ctx.require(Permission.connectorManage);
    await _row(id);
    await _db.tx((tx) async {
      await tx.query('DELETE FROM connectors WHERE id = @id', {'id': id});
      await AuditLog.append(tx, _event(ctx, AuditActions.connectorDeleted, id));
    });
  }

  /// Nouveau jeton du webhook entrant (l'ancien cesse de fonctionner).
  Future<WebhookToken> createWebhookToken(AuthContext ctx, String id) async {
    ctx.require(Permission.connectorManage);
    await _row(id);
    final token = randomToken();
    await _db.tx((tx) async {
      await tx.query(
        'UPDATE connectors SET webhook_token_hash = @h, updated_at = now() '
        'WHERE id = @id',
        {'id': id, 'h': hashToken(token)},
      );
      await AuditLog.append(
        tx,
        _event(ctx, AuditActions.connectorTokenCreated, id),
      );
    });
    final path = '/api/v1/hooks/$id';
    return WebhookToken(
      url: _publicUrl?.resolve(path).toString() ?? path,
      token: token,
    );
  }

  AuditEvent _event(AuthContext ctx, String action, String id) => AuditEvent(
    action: action,
    actorUserId: ctx.userId,
    sessionId: ctx.sessionId,
    entity: 'connectors',
    entityId: id,
    ip: ctx.meta.ip,
  );

  // ── Lecture ───────────────────────────────────────────────────────────

  Future<String?> _secretOf(Map<String, dynamic>? row) async {
    final enc = row?['secret_enc'] as String?;
    return enc == null ? null : _cipher.decrypt(enc);
  }

  Future<List<RawRecord>> _fetch(
    ConnectorKind kind,
    Map<String, Object?> config,
    String? secret, {
    required int limit,
  }) async {
    final source = _open(kind, config, secret);
    try {
      return await source.fetch(limit: limit);
    } on ConnectorException catch (e) {
      throw ApiException(502, ApiErrorCodes.badRequest, e.message);
    } finally {
      await source.close();
    }
  }

  /// Aperçu : premiers enregistrements lus et convertis selon [input]
  /// (secret enregistré de [id] si [ConnectorInput.secret] est `null`).
  Future<ConnectorPreview> preview(
    AuthContext ctx,
    ConnectorInput input, {
    String? id,
  }) async {
    ctx.require(Permission.connectorManage);
    final kind = enumByKey(ConnectorKind.values, input.kind);
    if (kind == null || kind == ConnectorKind.webhook) {
      throw const ApiException.badRequest(
        'Aperçu impossible pour ce type de connecteur.',
      );
    }
    final secret =
        input.secret ?? (id == null ? null : await _secretOf(await _row(id)));
    final raw = await _fetch(kind, input.config, secret, limit: 20);
    return ConnectorPreview(
      paths: recordPaths(raw),
      raw: raw,
      mapped: [
        for (final record in raw)
          mapRecord(record, input.mapping, _schemaOf(input.mapping)),
      ],
    );
  }

  static EntitySchema _schemaOf(ConnectorMapping mapping) =>
      SyncEntities.byName(mapping.entity)!;

  // ── Import ────────────────────────────────────────────────────────────

  /// Historique des imports d'un connecteur (plus récents d'abord).
  Future<List<ConnectorRun>> runs(AuthContext ctx, String id) async {
    ctx.require(Permission.connectorManage);
    final rows = await _db.run(
      (s) => s.queryAll(
        'SELECT * FROM connector_runs WHERE connector_id = @id '
        'ORDER BY started_at DESC LIMIT 30',
        {'id': id},
      ),
    );
    return [for (final row in rows) _run(row)];
  }

  /// Lance un import en arrière-plan.
  Future<ConnectorRun> start(AuthContext ctx, String id) async {
    ctx.require(Permission.connectorManage);
    final row = await _row(id);
    if (row['kind'] == ConnectorKind.webhook.key) {
      throw const ApiException.badRequest(
        'Un webhook entrant reçoit les données : rien à lancer.',
      );
    }
    return _startRun(row, 'manual');
  }

  Future<ConnectorRun> _startRun(
    Map<String, dynamic> row,
    String trigger,
  ) async {
    final id = row['id'] as String;
    if (!_running.add(id)) {
      throw const ApiException.conflict('Un import est déjà en cours.');
    }
    final run = await _openRun(id, trigger);
    unawaited(_execute(row, run.id).whenComplete(() => _running.remove(id)));
    return run;
  }

  Future<ConnectorRun> _openRun(String connectorId, String trigger) async {
    final run = ConnectorRun(
      id: newId(),
      connectorId: connectorId,
      trigger: trigger,
      status: 'running',
      startedAt: _clock().toUtc(),
    );
    await _db.query(
      'INSERT INTO connector_runs (id, connector_id, trigger, status, '
      'started_at) VALUES (@id, @c, @t, @s, @at)',
      {
        'id': run.id,
        'c': connectorId,
        't': trigger,
        's': run.status,
        'at': run.startedAt,
      },
    );
    await _db.query('UPDATE connectors SET last_run_at = @at WHERE id = @id', {
      'id': connectorId,
      'at': run.startedAt,
    });
    return run;
  }

  Future<void> _execute(Map<String, dynamic> row, String runId) async {
    try {
      final records = await _fetch(
        enumByKey(ConnectorKind.values, row['kind'] as String)!,
        (row['config'] as Map).cast<String, Object?>(),
        await _secretOf(row),
        limit: maxRecords,
      );
      await _import(row, runId, records);
    } on Object catch (e, stack) {
      final message = switch (e) {
        ApiException(:final message) => message,
        _ => 'Erreur inattendue : $e',
      };
      if (e is! ApiException) _log.warning('Import du connecteur', e, stack);
      await _finish(runId, error: message);
    }
  }

  /// Convertit et importe [records] ; bilan écrit dans le run [runId].
  Future<ConnectorRun> _import(
    Map<String, dynamic> row,
    String runId,
    List<RawRecord> records,
  ) async {
    final mapping = ConnectorMapping.fromJson(
      (row['mapping'] as Map).cast<String, dynamic>(),
    );
    final schema = _schemaOf(mapping);
    final problems = <String>[];
    final sourceRecords = <SourceRecord>[];
    final organisations = await _organisationIndex(mapping);
    for (final raw in records) {
      final mapped = mapRecord(raw, mapping, schema);
      if (mapped.problems.isNotEmpty) {
        problems.add('${mapped.ref ?? '?'} : ${mapped.problems.join(' ')}');
        continue;
      }
      final fields = {...mapped.fields};
      if (mapping.organisationLookup case final lookup?) {
        final value = readPath(raw, lookup.source);
        final orgId = value == null
            ? null
            : organisations[_lookupKey(lookup.field, value)];
        if (orgId != null) fields['organisation_id'] = orgId;
      }
      sourceRecords.add(
        SourceRecord(
          ref: mapped.ref!,
          fields: fields,
          matchField: mapping.matchField,
          defaults: {..._defaultsFor(mapping.entity), ...mapping.defaults},
        ),
      );
    }
    final source = 'connector:${row['id']}';
    final stats = await _sync.upsertFromSource(
      schema,
      source: source,
      records: sourceRecords,
      canAdopt: (current) => current == null || current == source,
    );
    for (final MapEntry(:key, :value) in stats.rejected.entries) {
      problems.add('$key : $value');
    }
    return _finish(
      runId,
      fetched: records.length,
      created: stats.created,
      updated: stats.updated,
      unchanged: stats.unchanged,
      problems: problems,
    );
  }

  /// Valeurs obligatoires posées à la création si le mappage ne les
  /// fournit pas.
  static Map<String, Object?> _defaultsFor(String entity) => switch (entity) {
    'organisations' => {
      'kind': OrganisationKind.autre.key,
      'status': OrganisationStatus.aProspecter.key,
    },
    _ => const {},
  };

  static String _lookupKey(String field, Object value) => field == 'name'
      ? searchText('$value')
      : '$value'.trim().toLowerCase().replaceAll(' ', '');

  /// Organisations indexées par le champ de rattachement des contacts.
  Future<Map<String, String>> _organisationIndex(
    ConnectorMapping mapping,
  ) async {
    final lookup = mapping.organisationLookup;
    const allowed = {'siren', 'siret', 'insee_code', 'name', 'email'};
    if (lookup == null || !allowed.contains(lookup.field)) return const {};
    final rows = await _db.run(
      (s) => s.queryAll(
        'SELECT id, ${lookup.field} AS v FROM organisations '
        'WHERE deleted_at IS NULL AND ${lookup.field} IS NOT NULL '
        'ORDER BY created_at DESC',
      ),
    );
    return {
      for (final r in rows)
        _lookupKey(lookup.field, r['v'] as Object): r['id'] as String,
    };
  }

  Future<ConnectorRun> _finish(
    String runId, {
    int fetched = 0,
    int created = 0,
    int updated = 0,
    int unchanged = 0,
    List<String> problems = const [],
    String? error,
  }) async {
    final row = await _db.run(
      (s) => s.queryOne(
        'UPDATE connector_runs SET status = @s, finished_at = now(), '
        'fetched = @f, created = @c, updated = @u, unchanged = @n, '
        'rejected = @r, problems = @p:jsonb, error = @e WHERE id = @id '
        'RETURNING *',
        {
          'id': runId,
          's': error == null ? 'succeeded' : 'failed',
          'f': fetched,
          'c': created,
          'u': updated,
          'n': unchanged,
          'r': problems.length,
          'p': problems.take(50).toList(),
          'e': error,
        },
      ),
    );
    return _run(row!);
  }

  /// Imports planifiés échus.
  Future<void> runScheduledIfDue() async {
    final due = await _db.run(
      (s) => s.queryAll(
        "SELECT * FROM connectors WHERE enabled AND kind <> 'webhook' "
        'AND schedule_minutes IS NOT NULL AND (last_run_at IS NULL OR '
        "last_run_at + schedule_minutes * interval '1 minute' <= @now)",
        {'now': _clock().toUtc()},
      ),
    );
    for (final row in due) {
      if (_running.contains(row['id'])) continue;
      await _startRun(row, 'schedule');
    }
  }

  /// Imports interrompus par un arrêt du serveur.
  Future<void> recoverInterrupted() => _db.query(
    "UPDATE connector_runs SET status = 'failed', finished_at = now(), "
    "error = 'Interrompu par un redémarrage du serveur.' "
    "WHERE status = 'running'",
  );

  // ── Webhook entrant ───────────────────────────────────────────────────

  /// Reçoit des enregistrements poussés par un système externe
  /// ([token] : jeton du connecteur). Import immédiat.
  Future<ConnectorRun> receive(String id, String? token, List<int> body) async {
    if (!isValidId(id) || token == null || token.isEmpty) {
      throw const ApiException.unauthenticated('Jeton de webhook requis.');
    }
    final row = await _db.run(
      (s) => s.queryOne('SELECT * FROM connectors WHERE id = @id AND enabled', {
        'id': id,
      }),
    );
    final expected = row?['webhook_token_hash'] as String?;
    if (row == null ||
        expected == null ||
        !_sameHash(expected, hashToken(token))) {
      throw const ApiException.unauthenticated('Jeton de webhook invalide.');
    }
    final Object? json;
    try {
      json = jsonDecode(utf8.decode(body));
    } on FormatException {
      throw const ApiException.badRequest('Corps JSON invalide.');
    }
    final path = (row['config'] as Map)['records_path'] as String?;
    final list = switch (path == null || path.isEmpty
        ? json
        : readPath(json, path)) {
      final List<Object?> items => items,
      final Map<Object?, Object?> single => [single],
      _ => throw const ApiException.badRequest(
        'Objet ou liste d’objets JSON attendu.',
      ),
    };
    if (list.length > 5000) {
      throw const ApiException.badRequest('5 000 enregistrements maximum.');
    }
    if (!_running.add(id)) {
      throw const ApiException.conflict('Un import est déjà en cours.');
    }
    try {
      final run = await _openRun(id, 'webhook');
      return await _import(row, run.id, [
        for (final item in list)
          if (item is Map) item.cast<String, Object?>(),
      ]);
    } finally {
      _running.remove(id);
    }
  }

  static bool _sameHash(String a, String b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return diff == 0;
  }
}
