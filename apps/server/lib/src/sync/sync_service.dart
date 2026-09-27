import 'dart:async';

import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:postgres/postgres.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../audit/audit_log.dart';
import '../auth/auth_context.dart';
import '../db/database.dart';
import '../errors.dart';

final _log = Logger('sync');

/// Enregistrement fourni par une source externe (données publiques).
@immutable
final class SourceRecord {
  const SourceRecord({
    required this.ref,
    required this.fields,
    this.matchField,
    this.parent,
    this.defaults = const {},
  });

  /// Identifiant dans la source (`source_ref`).
  final String ref;

  /// Champs maintenus par la source (format réseau).
  final Map<String, Object?> fields;

  /// Champs posés uniquement à la création (ex. statut commercial).
  final Map<String, Object?> defaults;

  /// Champ de rapprochement avec une fiche existante de même type
  /// (`kind`), ex. `insee_code`.
  final String? matchField;

  /// Parent : fiche dont le champ vaut la valeur, parmi ces types.
  final (String field, String value, Set<String> kinds)? parent;
}

/// Écriture système refusée par les règles de validation.
final class SystemWriteException implements Exception {
  const SystemWriteException(this.issues);

  final List<ValidationIssue> issues;

  @override
  String toString() => issues.map((i) => i.message).join(' ');
}

/// Bilan d'un import depuis une source.
final class SourceUpsertStats {
  int created = 0;
  int updated = 0;
  int unchanged = 0;

  /// Refusés par les règles de validation : référence → message.
  final Map<String, String> rejected = {};
}

/// Moteur de synchronisation côté serveur.
///
/// - **push** : chaque opération est fusionnée champ par champ
///   (last-write-wins sur HLC), dans sa propre transaction ; les conflits
///   sont journalisés.
/// - **pull** : renvoie les enregistrements modifiés depuis un curseur
///   (numéro de séquence global).
///
/// Les écritures sont sérialisées par un verrou transactionnel : les numéros
/// de séquence sont donc validés dans l'ordre, et un client qui a lu le
/// curseur N ne peut jamais manquer un changement < N validé plus tard.
final class SyncService {
  SyncService({required this._db, DateTime Function()? clock})
    : _clock = clock ?? DateTime.now,
      _hlc = HybridClock('server');

  final Database _db;
  final DateTime Function() _clock;
  final HybridClock _hlc;
  final _changes = StreamController<int>.broadcast();

  /// Émet le nouveau curseur après chaque changement validé.
  Stream<int> get changes => _changes.stream;

  static const _writeLockKey = 7428120003;

  Future<void> close() => _changes.close();

  /// Dernier numéro de séquence attribué.
  Future<int> currentCursor() async {
    final row = await _db.run(
      (s) => s.queryOne('SELECT coalesce(max(seq), 0) AS seq FROM change_log'),
    );
    return row!['seq'] as int;
  }

  // ── Push ─────────────────────────────────────────────────────────────

  Future<PushResponse> push(AuthContext ctx, PushRequest request) async {
    if (request.operations.length > maxPushBatchSize) {
      throw const ApiException.badRequest(
        'Lot trop volumineux (max $maxPushBatchSize opérations).',
      );
    }
    if (request.deviceId != ctx.deviceId) {
      throw const ApiException.badRequest(
        'Le poste ne correspond pas à la session.',
      );
    }
    final results = <OpResult>[];
    var lastSeq = 0;
    for (final op in request.operations) {
      final (result, seq) = await _applyOperation(ctx, op);
      results.add(result);
      if (seq > lastSeq) lastSeq = seq;
    }
    if (lastSeq > 0) _changes.add(lastSeq);
    return PushResponse(results: results);
  }

  Future<(OpResult, int)> _applyOperation(
    AuthContext ctx,
    SyncOperation op,
  ) async {
    final schema = SyncEntities.byName(op.entity);
    if (schema == null) {
      return (_invalid(op, 'entity', 'Entité inconnue : ${op.entity}.'), 0);
    }
    if (!ctx.can(schema.writePermission)) {
      return (OpResult(opId: op.opId, status: OpStatus.forbidden), 0);
    }
    if (!isValidId(op.opId) || !isValidId(op.entityId)) {
      return (_invalid(op, 'id', 'Identifiant invalide.'), 0);
    }
    final fieldIssues = schema.checkFields(op.fields);
    if (fieldIssues.isNotEmpty) {
      return (
        OpResult(opId: op.opId, status: OpStatus.invalid, issues: fieldIssues),
        0,
      );
    }
    final Hlc hlc;
    try {
      hlc = Hlc.parse(op.hlc);
      _hlc.observe(hlc);
    } on FormatException {
      return (_invalid(op, 'hlc', 'Horodatage invalide.'), 0);
    } on ClockDriftException {
      return (
        _invalid(
          op,
          'hlc',
          "L'horloge du poste est en avance : vérifiez la date et l'heure.",
        ),
        0,
      );
    }

    try {
      return await _db.tx((tx) async {
        await tx.query('SELECT pg_advisory_xact_lock(@k)', {
          'k': _writeLockKey,
        });

        final isNew = await tx.queryOne(
          'INSERT INTO sync_ops (op_id, device_id, user_id, entity, entity_id, '
          "status) VALUES (@op, @d, @u, @e, @id, 'processing') "
          'ON CONFLICT (op_id) DO NOTHING RETURNING op_id',
          {
            'op': op.opId,
            'd': ctx.deviceId,
            'u': ctx.userId,
            'e': op.entity,
            'id': op.entityId,
          },
        );
        if (isNew == null) {
          final record = await _loadRecord(tx, schema, op.entityId);
          return (
            OpResult(opId: op.opId, status: OpStatus.duplicate, record: record),
            0,
          );
        }

        final row = await tx.queryOne(
          'SELECT * FROM ${schema.name} WHERE id = @id FOR UPDATE',
          {'id': op.entityId},
        );
        final currentVersion = row?['version'] as int? ?? 0;
        final current = <String, Object?>{
          if (row != null)
            for (final field in schema.fields.keys)
              field: _toWire(row[field], schema.fields[field]!.type),
        };
        final merge = mergeFields(
          current: current,
          stamps: decodeFieldMeta(
            (row?['field_meta'] as Map?)?.cast<String, dynamic>(),
          ),
          incoming: op.fields,
          hlc: hlc,
          baseVersion: op.baseVersion,
          nextVersion: currentVersion + 1,
          userId: ctx.userId,
        );

        final merged = {...current, ...merge.applied};
        final issues = merge.changed
            ? schema.validate(merged)
            : const <ValidationIssue>[];
        if (issues.isNotEmpty) {
          await tx.rollback();
          return (
            OpResult(opId: op.opId, status: OpStatus.invalid, issues: issues),
            0,
          );
        }

        var seq = 0;
        if (merge.changed) {
          seq = await _write(
            tx,
            schema,
            ctx,
            op,
            row == null,
            currentVersion + 1,
            merge,
          );
        }
        for (final conflict in merge.conflicts) {
          await _recordConflict(tx, op, conflict);
        }

        final status = merge.rejectedFields.isEmpty
            ? OpStatus.applied
            : merge.changed
            ? OpStatus.partial
            : OpStatus.superseded;
        await tx.query('UPDATE sync_ops SET status = @s WHERE op_id = @op', {
          's': status.name,
          'op': op.opId,
        });
        return (
          OpResult(
            opId: op.opId,
            status: status,
            record: await _loadRecord(tx, schema, op.entityId),
            conflicts: merge.conflicts.length,
          ),
          seq,
        );
      });
    } on ServerException catch (e, stack) {
      _log.warning('Opération ${op.opId} refusée par la base', e, stack);
      return (_invalid(op, 'record', 'Enregistrement refusé par la base.'), 0);
    }
  }

  /// Écrit l'enregistrement fusionné et journalise le changement (push
  /// d'un client : entrée d'audit par enregistrement).
  Future<int> _write(
    TxSession tx,
    EntitySchema schema,
    AuthContext ctx,
    SyncOperation op,
    bool isInsert,
    int version,
    MergeResult merge,
  ) async {
    final seq = await _persist(
      tx,
      schema,
      entityId: op.entityId,
      isInsert: isInsert,
      version: version,
      merge: merge,
      hlc: op.hlc,
      opId: op.opId,
      deviceId: ctx.deviceId,
      userId: ctx.userId,
    );
    final deleted = merge.applied[SyncColumns.deletedAt];
    await AuditLog.append(
      tx,
      AuditEvent(
        action: isInsert
            ? AuditActions.recordCreated
            : deleted != null
            ? AuditActions.recordDeleted
            : AuditActions.recordUpdated,
        actorUserId: ctx.userId,
        sessionId: ctx.sessionId,
        entity: schema.name,
        entityId: op.entityId,
        payload: {'version': version, 'fields': merge.applied.keys.toList()},
        ip: ctx.meta.ip,
      ),
    );
    return seq;
  }

  /// Insère ou met à jour l'enregistrement et l'ajoute au journal des
  /// changements. Retourne le numéro de séquence attribué.
  Future<int> _persist(
    TxSession tx,
    EntitySchema schema, {
    required String entityId,
    required bool isInsert,
    required int version,
    required MergeResult merge,
    required String hlc,
    String? opId,
    String? deviceId,
    String? userId,
  }) async {
    final seqRow = await tx.queryOne("SELECT nextval('sync_seq') AS seq");
    final seq = seqRow!['seq'] as int;
    final now = _clock().toUtc();
    final params = <String, Object?>{
      'id': entityId,
      'version': version,
      'seq': seq,
      'meta': encodeFieldMeta(merge.stamps),
      'now': now,
      'user': userId,
    };
    final fieldColumns = merge.applied.keys.toList();
    for (final (i, field) in fieldColumns.indexed) {
      params['f$i'] = _fromWire(
        schema.fields[field]!.type,
        merge.applied[field],
      );
    }

    if (isInsert) {
      final columns = [
        'id',
        'version',
        'seq',
        'field_meta',
        'created_at',
        'created_by',
        'updated_at',
        'updated_by',
        ...fieldColumns,
      ];
      final values = [
        '@id',
        '@version',
        '@seq',
        '@meta:jsonb',
        '@now',
        '@user',
        '@now',
        '@user',
        for (final (i, field) in fieldColumns.indexed)
          _param(i, schema.fields[field]!.type),
      ];
      await tx.query(
        'INSERT INTO ${schema.name} (${columns.join(', ')}) '
        'VALUES (${values.join(', ')})',
        params,
      );
    } else {
      final assignments = [
        'version = @version',
        'seq = @seq',
        'field_meta = @meta:jsonb',
        'updated_at = @now',
        'updated_by = @user',
        for (final (i, field) in fieldColumns.indexed)
          '$field = ${_param(i, schema.fields[field]!.type)}',
      ];
      await tx.query(
        'UPDATE ${schema.name} SET ${assignments.join(', ')} WHERE id = @id',
        params,
      );
    }

    await tx.query(
      'INSERT INTO change_log (seq, entity, entity_id, version, fields, hlc, '
      'op_id, device_id, user_id, committed_at) VALUES (@seq, @e, @id, @v, '
      '@fields:jsonb, @hlc, @op, @d, @u, @now)',
      {
        'seq': seq,
        'e': schema.name,
        'id': entityId,
        'v': version,
        'fields': merge.applied,
        'hlc': hlc,
        'op': opId,
        'd': deviceId,
        'u': userId,
        'now': now,
      },
    );
    return seq;
  }

  Future<void> _recordConflict(
    TxSession tx,
    SyncOperation op,
    FieldConflict conflict,
  ) => tx.query(
    'INSERT INTO sync_conflicts (id, entity, entity_id, field, winning_value, '
    'losing_value, winning_hlc, losing_hlc, winner_user_id, loser_user_id, '
    'op_id) VALUES (@id, @e, @eid, @f, @wv:jsonb, @lv:jsonb, @wh, @lh, '
    '@wu, @lu, @op)',
    {
      'id': newId(),
      'e': op.entity,
      'eid': op.entityId,
      'f': conflict.field,
      // Enveloppe : conserve la distinction entre `null` JSON et absence.
      'wv': {'v': conflict.winningValue},
      'lv': {'v': conflict.losingValue},
      'wh': conflict.winningHlc,
      'lh': conflict.losingHlc,
      'wu': conflict.winnerUserId,
      'lu': conflict.loserUserId,
      'op': op.opId,
    },
  );

  // ── Écritures du serveur ─────────────────────────────────────────────

  /// Crée ([id] absent ou inconnu) ou modifie un enregistrement au nom du
  /// serveur (attribué à [userId] s'il est fourni), synchronisé comme une
  /// écriture de client. Retourne l'identifiant.
  Future<String> writeSystem(
    EntitySchema schema,
    Map<String, Object?> fields, {
    String? id,
    String? userId,
  }) async {
    final recordId = id ?? newId();
    final issues = schema.checkFields(fields);
    if (issues.isNotEmpty) throw SystemWriteException(issues);
    final seq = await _db.tx((tx) async {
      await tx.query('SELECT pg_advisory_xact_lock(@k)', {'k': _writeLockKey});
      final row = await tx.queryOne(
        'SELECT * FROM ${schema.name} WHERE id = @id FOR UPDATE',
        {'id': recordId},
      );
      final version = row?['version'] as int? ?? 0;
      final current = <String, Object?>{
        if (row != null)
          for (final field in schema.fields.keys)
            field: _toWire(row[field], schema.fields[field]!.type),
      };
      final hlc = _hlc.now();
      final merge = mergeFields(
        current: current,
        stamps: decodeFieldMeta(
          (row?['field_meta'] as Map?)?.cast<String, dynamic>(),
        ),
        incoming: fields,
        hlc: hlc,
        baseVersion: version,
        nextVersion: version + 1,
        userId: userId,
      );
      if (!merge.changed) return 0;
      final problems = schema.validate({
        ...current,
        ...merge.applied,
        'id': recordId,
      });
      if (problems.isNotEmpty) throw SystemWriteException(problems);
      return _persist(
        tx,
        schema,
        entityId: recordId,
        isInsert: row == null,
        version: version + 1,
        merge: merge,
        hlc: hlc.toString(),
        userId: userId,
      );
    });
    if (seq > 0) _changes.add(seq);
    return recordId;
  }

  // ── Import depuis une source externe ─────────────────────────────────

  /// Crée ou met à jour les enregistrements de [source] (champ `source`),
  /// retrouvés par `source_ref`, sinon rapprochés d'une fiche existante
  /// par [SourceRecord.matchField] (si [canAdopt] accepte sa source).
  ///
  /// Écritures « système » (sans utilisateur), synchronisées comme les
  /// autres. Un champ modifié par un utilisateur n'est jamais écrasé.
  Future<SourceUpsertStats> upsertFromSource(
    EntitySchema schema, {
    required String source,
    required List<SourceRecord> records,
    bool Function(String? currentSource)? canAdopt,
    int batchSize = 500,
  }) async {
    final stats = SourceUpsertStats();
    final parents = <String, String?>{};
    var lastSeq = 0;
    for (var start = 0; start < records.length; start += batchSize) {
      final batch = records.skip(start).take(batchSize).toList();
      final seq = await _db.tx((tx) async {
        await tx.query('SELECT pg_advisory_xact_lock(@k)', {
          'k': _writeLockKey,
        });
        var batchSeq = 0;
        for (final record in batch) {
          final seq = await _upsertSourceRecord(
            tx,
            schema,
            source,
            record,
            stats,
            parents,
            canAdopt ?? (current) => current == null,
          );
          if (seq > batchSeq) batchSeq = seq;
        }
        return batchSeq;
      });
      if (seq > 0) {
        lastSeq = seq;
        _changes.add(seq);
      }
    }
    if (lastSeq > 0) _log.info('Import $source : $lastSeq');
    return stats;
  }

  Future<int> _upsertSourceRecord(
    TxSession tx,
    EntitySchema schema,
    String source,
    SourceRecord record,
    SourceUpsertStats stats,
    Map<String, String?> parents,
    bool Function(String? currentSource) canAdopt,
  ) async {
    bool isField(String name) => schema.fields.containsKey(name);
    var row = await tx.queryOne(
      'SELECT * FROM ${schema.name} WHERE source = @s AND source_ref = @r '
      'ORDER BY deleted_at NULLS FIRST, created_at LIMIT 1',
      {'s': source, 'r': record.ref},
    );
    // Fiche supprimée par un utilisateur : elle n'est pas recréée.
    if (row != null && row['deleted_at'] != null) {
      stats.unchanged++;
      return 0;
    }
    final match = record.matchField;
    if (row == null && match != null && isField(match) && isField('kind')) {
      final value = record.fields[match];
      if (value != null) {
        final candidate = await tx.queryOne(
          'SELECT * FROM ${schema.name} WHERE kind = @k AND $match = @v '
          'AND deleted_at IS NULL ORDER BY created_at LIMIT 1',
          {'k': record.fields['kind'], 'v': value},
        );
        if (candidate != null && canAdopt(candidate['source'] as String?)) {
          row = candidate;
        }
      }
    }

    final incoming = <String, Object?>{
      ...record.fields,
      'source': source,
      'source_ref': record.ref,
    };
    if (record.parent case (final field, final value, final kinds)?
        when isField(field) && isField('kind')) {
      final key = '$field|$value|${(kinds.toList()..sort()).join(',')}';
      final parentId = parents.containsKey(key)
          ? parents[key]
          : parents[key] =
                (await tx.queryOne(
                      'SELECT id FROM ${schema.name} WHERE $field = @v '
                      'AND kind = ANY(@kinds:_text) AND deleted_at IS NULL '
                      'ORDER BY created_at LIMIT 1',
                      {'v': value, 'kinds': kinds.toList()},
                    ))?['id']
                    as String?;
      if (parentId != null) incoming['parent_id'] = parentId;
    }

    final id = row?['id'] as String? ?? newId();
    final version = row?['version'] as int? ?? 0;
    final current = <String, Object?>{
      if (row != null)
        for (final field in schema.fields.keys)
          field: _toWire(row[field], schema.fields[field]!.type),
    };
    final stamps = decodeFieldMeta(
      (row?['field_meta'] as Map?)?.cast<String, dynamic>(),
    );
    const equality = DeepCollectionEquality();
    final changes = <String, Object?>{
      if (row == null) ...record.defaults,
      for (final MapEntry(:key, :value) in incoming.entries)
        if (isField(key) &&
            !equality.equals(current[key], value) &&
            stamps[key]?.userId == null)
          key: value,
    };
    if (changes.isEmpty) {
      stats.unchanged++;
      return 0;
    }
    changes['collected_at'] = _clock().toUtc().toIso8601String();

    final hlc = _hlc.now();
    final merge = mergeFields(
      current: current,
      stamps: stamps,
      incoming: changes,
      hlc: hlc,
      baseVersion: version,
      nextVersion: version + 1,
      userId: null,
    );
    final issues = [
      ...schema.checkFields(changes),
      ...schema.validate({...current, ...merge.applied, 'id': id}),
    ];
    if (issues.isNotEmpty) {
      stats.rejected[record.ref] = issues.map((i) => i.message).join(' ');
      return 0;
    }
    if (row == null) {
      stats.created++;
    } else {
      stats.updated++;
    }
    return _persist(
      tx,
      schema,
      entityId: id,
      isInsert: row == null,
      version: version + 1,
      merge: merge,
      hlc: hlc.toString(),
    );
  }

  // ── Pull ─────────────────────────────────────────────────────────────

  /// Enregistrements modifiés après [cursor], par ordre de séquence.
  Future<PullResponse> pull(AuthContext ctx, int cursor, {int? limit}) async {
    final pageSize = (limit ?? maxPullPageSize).clamp(1, maxPullPageSize);
    final readable = [
      for (final schema in SyncEntities.all)
        if (ctx.can(schema.readPermission)) schema,
    ];
    return _db.run((session) async {
      final candidates = <SyncRecord>[];
      var truncated = false;
      for (final schema in readable) {
        final rows = await session.queryAll(
          'SELECT * FROM ${schema.name} WHERE seq > @c ORDER BY seq LIMIT @n',
          {'c': cursor, 'n': pageSize + 1},
        );
        if (rows.length > pageSize) truncated = true;
        candidates.addAll(rows.map((r) => _toRecord(schema, r)));
      }
      candidates.sort((a, b) => a.seq.compareTo(b.seq));
      final page = candidates.take(pageSize).toList();
      final hasMore = truncated || candidates.length > pageSize;
      final int nextCursor;
      if (page.isEmpty) {
        nextCursor = cursor;
      } else if (hasMore) {
        nextCursor = page.last.seq;
      } else {
        // Page complète : on avance jusqu'au dernier changement connu, y
        // compris ceux d'entités non lisibles par l'utilisateur.
        nextCursor = await currentCursor();
      }
      return PullResponse(
        records: page,
        cursor: nextCursor < cursor ? cursor : nextCursor,
        hasMore: hasMore,
      );
    });
  }

  // ── Conflits ─────────────────────────────────────────────────────────

  Future<List<SyncConflict>> listConflicts(
    AuthContext ctx, {
    bool unreviewedOnly = false,
    int limit = 200,
  }) async {
    ctx.require(Permission.syncConflictRead);
    final rows = await _db.run(
      (s) => s.queryAll(
        'SELECT c.*, w.display_name AS winner_name, '
        'l.display_name AS loser_name FROM sync_conflicts c '
        'LEFT JOIN users w ON w.id = c.winner_user_id '
        'LEFT JOIN users l ON l.id = c.loser_user_id '
        'WHERE (@unreviewed = false OR c.reviewed_at IS NULL) '
        'ORDER BY c.created_at DESC LIMIT @n',
        {'unreviewed': unreviewedOnly, 'n': limit.clamp(1, 1000)},
      ),
    );
    return [
      for (final r in rows)
        SyncConflict(
          id: r['id'] as String,
          entity: r['entity'] as String,
          entityId: r['entity_id'] as String,
          field: r['field'] as String,
          winningValue: (r['winning_value'] as Map?)?['v'],
          losingValue: (r['losing_value'] as Map?)?['v'],
          winningHlc: r['winning_hlc'] as String,
          losingHlc: r['losing_hlc'] as String,
          winnerUserId: r['winner_user_id'] as String?,
          winnerName: r['winner_name'] as String?,
          loserUserId: r['loser_user_id'] as String?,
          loserName: r['loser_name'] as String?,
          createdAt: r['created_at'] as DateTime,
          reviewedAt: r['reviewed_at'] as DateTime?,
          reviewedBy: r['reviewed_by'] as String?,
        ),
    ];
  }

  Future<void> markConflictReviewed(AuthContext ctx, String id) async {
    ctx.require(Permission.syncConflictManage);
    await _db.tx((tx) async {
      final row = await tx.queryOne(
        'UPDATE sync_conflicts SET reviewed_at = now(), reviewed_by = @u '
        'WHERE id = @id AND reviewed_at IS NULL RETURNING entity, entity_id',
        {'u': ctx.userId, 'id': id},
      );
      if (row == null) {
        throw const ApiException.notFound('Conflit introuvable.');
      }
      await AuditLog.append(
        tx,
        AuditEvent(
          action: AuditActions.conflictReviewed,
          actorUserId: ctx.userId,
          sessionId: ctx.sessionId,
          entity: 'sync_conflicts',
          entityId: id,
          ip: ctx.meta.ip,
        ),
      );
    });
  }

  // ── Conversion ───────────────────────────────────────────────────────

  Future<SyncRecord?> _loadRecord(
    Session session,
    EntitySchema schema,
    String id,
  ) async {
    final row = await session.queryOne(
      'SELECT * FROM ${schema.name} WHERE id = @id',
      {'id': id},
    );
    return row == null ? null : _toRecord(schema, row);
  }

  SyncRecord _toRecord(EntitySchema schema, Map<String, dynamic> row) =>
      SyncRecord(
        entity: schema.name,
        id: row['id'] as String,
        version: row['version'] as int,
        seq: row['seq'] as int,
        data: {
          for (final column in [
            ...schema.fields.keys,
            SyncColumns.createdAt,
            SyncColumns.createdBy,
            SyncColumns.updatedAt,
            SyncColumns.updatedBy,
          ])
            column: _toWire(row[column], schema.fields[column]?.type),
        },
        fieldMeta: decodeFieldMeta(
          (row['field_meta'] as Map).cast<String, dynamic>(),
        ),
      );

  OpResult _invalid(SyncOperation op, String field, String message) => OpResult(
    opId: op.opId,
    status: OpStatus.invalid,
    issues: [
      ValidationIssue(
        field: field,
        code: ValidationCodes.invalidFormat,
        message: message,
      ),
    ],
  );
}

/// Valeur base → valeur réseau (horodatages en ISO 8601 UTC, dates
/// calendaires en AAAA-MM-JJ).
Object? _toWire(Object? value, [FieldType? type]) => switch (value) {
  final DateTime d when type == FieldType.date => formatDateOnly(d),
  final DateTime d => d.toUtc().toIso8601String(),
  _ => value,
};

/// Valeur réseau → paramètre SQL.
Object? _fromWire(FieldType type, Object? value) => switch (type) {
  FieldType.dateTime when value is String => DateTime.parse(value).toUtc(),
  FieldType.date when value is String => DateTime.parse('${value}T00:00:00Z'),
  _ => value,
};

String _param(int index, FieldType type) => switch (type) {
  FieldType.json => '@f$index:jsonb',
  FieldType.dateTime => '@f$index:timestamptz',
  FieldType.date => '@f$index:date',
  _ => '@f$index',
};
