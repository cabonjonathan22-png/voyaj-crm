import 'package:collection/collection.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../local/database.dart';
import '../sync/local_clock.dart';
import '../sync/local_entities.dart';
import '../sync/sync_engine.dart';

/// Écritures locales des entités synchronisées : validation par les règles
/// partagées, écriture dans la base locale et opération dans l'outbox (même
/// transaction). Les valeurs sont au format réseau (dates ISO 8601 UTC,
/// dates calendaires `AAAA-MM-JJ`, JSON en `Map`/`List`).
final class RecordStore {
  RecordStore({
    required this.db,
    required this.clock,
    required this.currentUserId,
    required this.onChanged,
  });

  final AppDatabase db;
  final LocalClock clock;
  final String? currentUserId;

  /// Appelé après chaque écriture (déclenche la synchronisation).
  final void Function() onChanged;

  /// Enregistrement local au format réseau, ou `null`.
  Future<Map<String, Object?>?> read(EntitySchema schema, String id) =>
      _entity(schema).read(db, id);

  /// Problèmes de l'enregistrement complet [record] (types et règles).
  List<ValidationIssue> validate(
    EntitySchema schema,
    Map<String, Object?> record,
  ) {
    final fields = {
      for (final MapEntry(:key, :value) in record.entries)
        if (schema.fields.containsKey(key)) key: value,
    };
    return [...schema.checkFields(fields), ...schema.validate(record)];
  }

  /// Exécute [body] dans une transaction (plusieurs écritures atomiques),
  /// puis déclenche la synchronisation.
  Future<T> write<T>(Future<T> Function(RecordWriter writer) body) async {
    final result = await db.transaction(() => body(RecordWriter._(this)));
    onChanged();
    return result;
  }

  Future<String> create(
    EntitySchema schema,
    Map<String, Object?> fields, {
    String? id,
  }) => write((w) => w.create(schema, fields, id: id));

  /// Enregistre les champs de [changes] réellement modifiés.
  Future<void> update(
    EntitySchema schema,
    String id,
    Map<String, Object?> changes,
  ) => write((w) => w.update(schema, id, changes));

  /// Suppression logique (synchronisée).
  Future<void> delete(EntitySchema schema, Iterable<String> ids) =>
      write((w) async {
        for (final id in ids) {
          await w.delete(schema, id);
        }
      });

  static LocalEntity _entity(EntitySchema schema) =>
      localEntityFor(schema.name)!;
}

/// Écritures au sein d'une transaction de [RecordStore.write].
final class RecordWriter {
  RecordWriter._(this._store);

  final RecordStore _store;

  AppDatabase get _db => _store.db;

  Future<String> create(
    EntitySchema schema,
    Map<String, Object?> fields, {
    String? id,
  }) async {
    final recordId = id ?? newId();
    final values = normalizeFields(schema, fields);
    final issues = _store.validate(schema, {
      for (final field in schema.fields.keys) field: null,
      ...values,
      SyncColumns.id: recordId,
    });
    if (issues.isNotEmpty) throw RecordValidationException(issues);
    final now = DateTime.now().toUtc().toIso8601String();
    await RecordStore._entity(schema).upsert(_db, recordId, {
      ...values,
      SyncColumns.version: 0,
      SyncColumns.createdAt: now,
      SyncColumns.createdBy: _store.currentUserId,
      SyncColumns.updatedAt: now,
      SyncColumns.updatedBy: _store.currentUserId,
    });
    await enqueueOperation(
      _db,
      entity: schema.name,
      entityId: recordId,
      baseVersion: 0,
      hlc: await _store.clock.tick(),
      fields: values,
    );
    return recordId;
  }

  /// Retourne `false` si rien n'a changé.
  Future<bool> update(
    EntitySchema schema,
    String id,
    Map<String, Object?> changes,
  ) async {
    final entity = RecordStore._entity(schema);
    final current = await entity.read(_db, id);
    if (current == null) {
      throw StateError('Enregistrement introuvable : ${schema.name}/$id');
    }
    final values = normalizeFields(schema, changes);
    final changed = {
      for (final MapEntry(:key, :value) in values.entries)
        if (!_sameValue(current[key], value)) key: value,
    };
    if (changed.isEmpty) return false;
    final issues = _store.validate(schema, {...current, ...changed});
    if (issues.isNotEmpty) throw RecordValidationException(issues);
    await entity.updateColumns(_db, id, {
      ...changed,
      SyncColumns.updatedAt: DateTime.now().toUtc().toIso8601String(),
      SyncColumns.updatedBy: _store.currentUserId,
    });
    await enqueueOperation(
      _db,
      entity: schema.name,
      entityId: id,
      baseVersion: current[SyncColumns.version]! as int,
      hlc: await _store.clock.tick(),
      fields: changed,
    );
    return true;
  }

  Future<void> delete(EntitySchema schema, String id) async {
    final current = await RecordStore._entity(schema).read(_db, id);
    if (current == null || current[SyncColumns.deletedAt] != null) return;
    await update(schema, id, {
      SyncColumns.deletedAt: DateTime.now().toUtc().toIso8601String(),
    });
  }
}

/// Nettoie les valeurs saisies : textes sans espaces superflus, texte vide
/// = `null` ; seuls les champs du schéma sont conservés.
Map<String, Object?> normalizeFields(
  EntitySchema schema,
  Map<String, Object?> fields,
) => {
  for (final MapEntry(:key, :value) in fields.entries)
    if (schema.fields.containsKey(key))
      key: switch (value) {
        final String text when schema.fields[key]!.type == FieldType.text =>
          text.trim().isEmpty
              ? (schema.fields[key]!.nullable ? null : '')
              : text.trim(),
        _ => value,
      },
};

bool _sameValue(Object? a, Object? b) {
  if (a is num && b is num) return a == b;
  if (a is Map || a is List || b is Map || b is List) {
    return const DeepCollectionEquality().equals(a, b);
  }
  if (a is String && b is String) {
    final da = DateTime.tryParse(a);
    final db = DateTime.tryParse(b);
    if (da != null && db != null && a.contains('T') && b.contains('T')) {
      return da.isAtSameMomentAs(db);
    }
  }
  return a == b;
}

/// Saisie refusée par les règles de validation.
final class RecordValidationException implements Exception {
  const RecordValidationException(this.issues);

  final List<ValidationIssue> issues;

  /// Message par champ (formulaires).
  Map<String, String> get byField => {
    for (final i in issues) i.field: i.message,
  };

  @override
  String toString() => issues.map((i) => i.message).join(' ');
}
