import 'dart:async';

import 'package:fr_public_data/fr_public_data.dart';
import 'package:logging/logging.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../audit/audit_log.dart';
import '../auth/auth_context.dart';
import '../db/database.dart';
import '../errors.dart';
import '../sync/sync_service.dart';

final _log = Logger('public_data');

/// Imports des données publiques (régions, départements, EPCI, communes,
/// AOM, festivals) en organisations : à la demande ou chaque jour.
///
/// Les imports s'exécutent l'un après l'autre, en arrière-plan ; leur
/// état est conservé dans `public_data_runs`.
final class PublicDataService {
  PublicDataService({
    required this._db,
    required this._sync,
    required this._client,
    this.scheduleHour = 3,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final Database _db;
  final SyncService _sync;
  final PublicDataClient _client;
  final DateTime Function() _clock;

  /// Heure locale de l'import quotidien (`null` : pas d'import planifié).
  final int? scheduleHour;

  Future<void> _queue = Future.value();

  /// Source actuellement en file ou en cours (une seule fois chacune).
  final Set<PublicSource> _pending = {};

  /// Attend la fin des imports en file (tests, arrêt du serveur).
  Future<void> idle() => _queue;

  // ── Configuration ────────────────────────────────────────────────────

  Future<List<PublicSourceStatus>> status(AuthContext ctx) async {
    ctx.require(Permission.publicDataManage);
    return _db.run((s) async {
      final configs = {
        for (final r in await s.queryAll('SELECT * FROM public_data_sources'))
          r['source'] as String: r,
      };
      final lastRuns = {
        for (final r in await s.queryAll(
          'SELECT DISTINCT ON (source) * FROM public_data_runs '
          'ORDER BY source, started_at DESC',
        ))
          r['source'] as String: _toRun(r),
      };
      return [
        for (final source in PublicSource.values)
          PublicSourceStatus(
            source: source.key,
            enabled: configs[source.key]?['enabled'] as bool? ?? false,
            departements: [
              for (final d
                  in configs[source.key]?['departements'] as List<dynamic>? ??
                      const [])
                '$d',
            ],
            lastRun: lastRuns[source.key],
          ),
      ];
    });
  }

  Future<PublicSourceStatus> configure(
    AuthContext ctx,
    String key,
    ConfigurePublicSourceRequest request,
  ) async {
    ctx.require(Permission.publicDataManage);
    final source = _source(key);
    final departements = {
      for (final d in request.departements)
        if (RegExp(r'^(\d{2,3}|2[AB])$').hasMatch(d.trim())) d.trim(),
    }.toList()..sort();
    await _db.tx((tx) async {
      await tx.query(
        'INSERT INTO public_data_sources (source, enabled, departements, '
        'updated_at, updated_by) VALUES (@s, @e, @d:jsonb, now(), @u) '
        'ON CONFLICT (source) DO UPDATE SET enabled = @e, '
        'departements = @d:jsonb, updated_at = now(), updated_by = @u',
        {
          's': source.key,
          'e': request.enabled,
          'd': departements,
          'u': ctx.userId,
        },
      );
      await AuditLog.append(
        tx,
        AuditEvent(
          action: AuditActions.publicDataConfigured,
          actorUserId: ctx.userId,
          sessionId: ctx.sessionId,
          entity: 'public_data_sources',
          entityId: source.key,
          payload: {'enabled': request.enabled, 'departements': departements},
          ip: ctx.meta.ip,
        ),
      );
    });
    return (await status(ctx)).firstWhere((s) => s.source == source.key);
  }

  Future<List<PublicDataRun>> runs(
    AuthContext ctx, {
    String? source,
    int limit = 50,
  }) async {
    ctx.require(Permission.publicDataManage);
    final rows = await _db.run(
      (s) => s.queryAll(
        'SELECT * FROM public_data_runs WHERE (@s::text IS NULL OR source = @s) '
        'ORDER BY started_at DESC LIMIT @n',
        {'s': source, 'n': limit.clamp(1, 500)},
      ),
    );
    return [for (final r in rows) _toRun(r)];
  }

  // ── Exécution ────────────────────────────────────────────────────────

  /// Lance l'import de [key] (en arrière-plan) ; retourne l'exécution
  /// créée.
  Future<PublicDataRun> start(AuthContext ctx, String key) async {
    ctx.require(Permission.publicDataManage);
    final source = _source(key);
    if (_pending.contains(source)) {
      throw const ApiException.conflict(
        'Un import de cette source est déjà en cours.',
      );
    }
    return _enqueue(source, PublicRunTrigger.manual, ctx.userId);
  }

  /// Import quotidien : à l'heure prévue, une fois par jour, toutes les
  /// sources activées (dans l'ordre parents → enfants).
  Future<void> runScheduledIfDue() async {
    final hour = scheduleHour;
    final now = _clock();
    if (hour == null || now.hour != hour) return;
    final today = DateTime(now.year, now.month, now.day);
    final last = await _db.run(
      (s) => s.queryOne(
        'SELECT max(started_at) AS last FROM public_data_runs '
        "WHERE trigger = 'schedule'",
      ),
    );
    final lastRun = (last?['last'] as DateTime?)?.toLocal();
    if (lastRun != null && !lastRun.isBefore(today)) return;
    final enabled = await _db.run(
      (s) => s.queryAll(
        'SELECT source FROM public_data_sources WHERE enabled = true',
      ),
    );
    final keys = {for (final r in enabled) r['source'] as String};
    for (final source in PublicSource.values) {
      if (keys.contains(source.key) && !_pending.contains(source)) {
        await _enqueue(source, PublicRunTrigger.schedule, null);
      }
    }
  }

  /// Marque comme échoués les imports interrompus (redémarrage).
  Future<void> recoverInterrupted() => _db.query(
    "UPDATE public_data_runs SET status = 'failed', finished_at = now(), "
    "error = 'Interrompu par un redémarrage du serveur.' "
    "WHERE status = 'running'",
  );

  Future<PublicDataRun> _enqueue(
    PublicSource source,
    PublicRunTrigger trigger,
    String? userId,
  ) async {
    final id = newId();
    final startedAt = _clock().toUtc();
    await _db.query(
      'INSERT INTO public_data_runs (id, source, trigger, status, started_at, '
      'triggered_by) VALUES (@id, @s, @t, @st, @at, @u)',
      {
        'id': id,
        's': source.key,
        't': trigger.name,
        'st': PublicRunStatus.running.name,
        'at': startedAt,
        'u': userId,
      },
    );
    _pending.add(source);
    _queue = _queue
        .then((_) => _execute(id, source, userId))
        .whenComplete(() => _pending.remove(source));
    return PublicDataRun(
      id: id,
      source: source.key,
      trigger: trigger,
      status: PublicRunStatus.running,
      startedAt: startedAt,
    );
  }

  Future<void> _execute(
    String runId,
    PublicSource source,
    String? userId,
  ) async {
    var fetched = 0;
    SourceUpsertStats? stats;
    String? error;
    try {
      final config = await _db.run(
        (s) => s.queryOne(
          'SELECT departements FROM public_data_sources WHERE source = @s',
          {'s': source.key},
        ),
      );
      final departements = [
        for (final d in config?['departements'] as List<dynamic>? ?? const [])
          '$d',
      ];
      final records = await _client.fetch(source, departements: departements);
      fetched = records.length;
      if (records.isEmpty) {
        throw const PublicDataException(
          'La source n’a renvoyé aucune donnée (format modifié ?).',
        );
      }
      stats = await _sync.upsertFromSource(
        SyncEntities.organisations,
        source: source.sourceName,
        canAdopt: (current) =>
            current == null ||
            !PublicSource.values.any((s) => s.sourceName == current),
        records: [
          for (final r in records)
            SourceRecord(
              ref: r.ref,
              fields: r.fields,
              matchField: r.matchField,
              defaults: {'status': OrganisationStatus.aProspecter.key},
              parent: r.parent == null
                  ? null
                  : (r.parent!.field, r.parent!.value, r.parent!.kinds),
            ),
        ],
      );
      if (stats.rejected.isNotEmpty) {
        final sample = stats.rejected.entries
            .take(3)
            .map((e) => '${e.key} : ${e.value}')
            .join(' ; ');
        error = '${stats.rejected.length} fiche(s) refusée(s) : $sample';
      }
    } on PublicDataException catch (e) {
      error = e.message;
    } on Object catch (e, stack) {
      _log.severe('Import ${source.key}', e, stack);
      error = 'Erreur interne pendant l’import.';
    }
    final failed = stats == null;
    await _db.tx((tx) async {
      await tx.query(
        'UPDATE public_data_runs SET status = @st, finished_at = now(), '
        'fetched = @f, created = @c, updated = @up, unchanged = @un, '
        'rejected = @r, error = @e WHERE id = @id',
        {
          'st': (failed ? PublicRunStatus.failed : PublicRunStatus.succeeded)
              .name,
          'f': fetched,
          'c': stats?.created ?? 0,
          'up': stats?.updated ?? 0,
          'un': stats?.unchanged ?? 0,
          'r': stats?.rejected.length ?? 0,
          'e': error,
          'id': runId,
        },
      );
      await AuditLog.append(
        tx,
        AuditEvent(
          action: AuditActions.publicDataRun,
          actorUserId: userId,
          entity: 'public_data_runs',
          entityId: runId,
          payload: {
            'source': source.key,
            'status': failed ? 'failed' : 'succeeded',
            'fetched': fetched,
            'created': stats?.created ?? 0,
            'updated': stats?.updated ?? 0,
          },
        ),
      );
    });
    _log.info(
      'Import ${source.key} : ${failed ? 'échec' : 'terminé'} '
      '($fetched lus, ${stats?.created ?? 0} créés, '
      '${stats?.updated ?? 0} mis à jour)${error == null ? '' : ' — $error'}',
    );
  }

  static PublicSource _source(String key) =>
      enumByKey(PublicSource.values, key) ??
      (throw const ApiException.notFound('Source inconnue.'));

  static PublicDataRun _toRun(Map<String, dynamic> r) => PublicDataRun(
    id: r['id'] as String,
    source: r['source'] as String,
    trigger: PublicRunTrigger.values.byName(r['trigger'] as String),
    status: PublicRunStatus.values.byName(r['status'] as String),
    startedAt: (r['started_at'] as DateTime).toUtc(),
    finishedAt: (r['finished_at'] as DateTime?)?.toUtc(),
    fetched: r['fetched'] as int,
    created: r['created'] as int,
    updated: r['updated'] as int,
    unchanged: r['unchanged'] as int,
    rejected: r['rejected'] as int,
    error: r['error'] as String?,
  );
}
