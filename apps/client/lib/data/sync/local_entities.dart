import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../local/database.dart';

/// Pont entre une entité synchronisée et sa table Drift locale.
///
/// Générique : les colonnes locales portent les noms des champs du
/// [EntitySchema] (snake_case), la conversion dépend du [FieldType].
/// Ajouter une entité synchronisée côté client = sa table Drift (avec
/// [SyncedColumns]) déclarée dans [AppDatabase.syncedTables].
final class LocalEntity {
  LocalEntity(this.schema);

  final EntitySchema schema;

  String get name => schema.name;

  TableInfo<Table, Object?> table(AppDatabase db) =>
      db.syncedTables.firstWhere((t) => t.actualTableName == name);

  /// Écrit l'état serveur [record] ; [pending] (champs locaux pas encore
  /// envoyés) est réappliqué par-dessus pour ne pas perdre de saisie.
  Future<void> applyServerRecord(
    AppDatabase db,
    SyncRecord record,
    Map<String, Object?> pending,
  ) {
    final data = {...record.data, ...pending};
    final now = DateTime.now().toUtc().toIso8601String();
    return upsert(db, record.id, {
      for (final field in schema.fields.keys) field: data[field],
      SyncColumns.version: record.version,
      SyncColumns.fieldMeta: encodeFieldMeta(record.fieldMeta),
      SyncColumns.createdAt: data[SyncColumns.createdAt] ?? now,
      SyncColumns.createdBy: data[SyncColumns.createdBy],
      SyncColumns.updatedAt: data[SyncColumns.updatedAt] ?? now,
      SyncColumns.updatedBy: data[SyncColumns.updatedBy],
    });
  }

  /// Insère ou remplace les colonnes [values] (valeurs au format réseau)
  /// de l'enregistrement [id].
  Future<void> upsert(
    AppDatabase db,
    String id,
    Map<String, Object?> values,
  ) async {
    final columns = values.keys.toList();
    final placeholders = List.filled(columns.length + 1, '?').join(', ');
    final assignments = [
      for (final c in columns) '"$c" = excluded."$c"',
    ].join(', ');
    await db.customInsert(
      'INSERT INTO "$name" ("id", ${columns.map((c) => '"$c"').join(', ')}) '
      'VALUES ($placeholders) '
      'ON CONFLICT ("id") DO UPDATE SET $assignments',
      variables: [
        Variable<String>(id),
        for (final c in columns) _variable(c, values[c]),
      ],
      updates: {table(db)},
    );
  }

  /// Met à jour les colonnes [values] (format réseau) de [id].
  Future<void> updateColumns(
    AppDatabase db,
    String id,
    Map<String, Object?> values,
  ) async {
    final columns = values.keys.toList();
    await db.customUpdate(
      'UPDATE "$name" SET ${columns.map((c) => '"$c" = ?').join(', ')} '
      'WHERE "id" = ?',
      variables: [
        for (final c in columns) _variable(c, values[c]),
        Variable<String>(id),
      ],
      updates: {table(db)},
      updateKind: UpdateKind.update,
    );
  }

  /// Enregistrement local au format réseau (champs du schéma + colonnes
  /// techniques), ou `null`.
  Future<Map<String, Object?>?> read(AppDatabase db, String id) async {
    final row = await db
        .customSelect(
          'SELECT * FROM "$name" WHERE "id" = ?',
          variables: [Variable<String>(id)],
          readsFrom: {table(db)},
        )
        .getSingleOrNull();
    if (row == null) return null;
    return {
      SyncColumns.id: id,
      SyncColumns.version: row.read<int>(SyncColumns.version),
      for (final MapEntry(key: field, value: spec) in schema.fields.entries)
        field: _readField(row, field, spec.type),
    };
  }

  /// Version serveur connue localement (0 si jamais synchronisé, `null` si
  /// inconnu).
  Future<int?> localVersion(AppDatabase db, String id) async {
    final row = await db
        .customSelect(
          'SELECT "version" FROM "$name" WHERE "id" = ?',
          variables: [Variable<String>(id)],
          readsFrom: {table(db)},
        )
        .getSingleOrNull();
    return row?.read<int>(SyncColumns.version);
  }

  Future<void> deleteLocal(AppDatabase db, String id) => db.customUpdate(
    'DELETE FROM "$name" WHERE "id" = ?',
    variables: [Variable<String>(id)],
    updates: {table(db)},
    updateKind: UpdateKind.delete,
  );

  Variable<Object> _variable(String column, Object? value) {
    final type = switch (column) {
      SyncColumns.version => FieldType.integer,
      SyncColumns.fieldMeta => FieldType.json,
      SyncColumns.createdAt || SyncColumns.updatedAt => FieldType.dateTime,
      SyncColumns.createdBy || SyncColumns.updatedBy => FieldType.text,
      _ => schema.fields[column]!.type,
    };
    return switch (type) {
      FieldType.text || FieldType.date => Variable<String>(value as String?),
      FieldType.integer => Variable<int>((value as num?)?.toInt()),
      FieldType.decimal => Variable<double>((value as num?)?.toDouble()),
      FieldType.boolean => Variable<bool>(value as bool?),
      FieldType.dateTime => Variable<DateTime>(
        value is String ? DateTime.parse(value).toUtc() : null,
      ),
      FieldType.json => Variable<String>(
        value == null ? null : jsonEncode(value),
      ),
    };
  }

  static Object? _readField(QueryRow row, String column, FieldType type) =>
      switch (type) {
        FieldType.text || FieldType.date => row.readNullable<String>(column),
        FieldType.integer => row.readNullable<int>(column),
        FieldType.decimal => row.readNullable<double>(column),
        FieldType.boolean => row.readNullable<bool>(column),
        FieldType.dateTime =>
          row.readNullable<DateTime>(column)?.toUtc().toIso8601String(),
        FieldType.json => switch (row.readNullable<String>(column)) {
          final String text => jsonDecode(text),
          null => null,
        },
      };
}

/// Ligne Drift → enregistrement au format réseau (champs du schéma,
/// `id` et `version`).
Map<String, Object?> rowToWire(EntitySchema schema, Insertable<Object?> row) {
  final columns = row.toColumns(false);
  Object? value(String column) => switch (columns[column]) {
    final Variable<Object> v => v.value,
    _ => null,
  };
  return {
    SyncColumns.id: value(SyncColumns.id),
    SyncColumns.version: value(SyncColumns.version),
    for (final MapEntry(key: field, value: spec) in schema.fields.entries)
      field: switch (value(field)) {
        final DateTime d => d.toUtc().toIso8601String(),
        final String text when spec.type == FieldType.json => jsonDecode(text),
        final other => other,
      },
  };
}

final Map<String, LocalEntity> _byName = {
  for (final schema in SyncEntities.all) schema.name: LocalEntity(schema),
};

/// Pont local de l'entité [name] (entités connues du protocole).
LocalEntity? localEntityFor(String name) => _byName[name];
