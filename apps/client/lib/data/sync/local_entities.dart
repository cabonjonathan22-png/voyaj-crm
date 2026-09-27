import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../local/database.dart';

/// Pont entre une entité synchronisée et sa table Drift locale.
///
/// Ajouter une entité synchronisée côté client = une nouvelle classe ici et
/// son enregistrement dans [localEntities].
abstract interface class LocalEntity {
  String get name;

  /// Écrit l'état serveur [record] ; [pending] (champs locaux pas encore
  /// envoyés) est réappliqué par-dessus pour ne pas perdre de saisie.
  Future<void> applyServerRecord(
    AppDatabase db,
    SyncRecord record,
    Map<String, Object?> pending,
  );

  /// Version serveur connue localement (0 si jamais synchronisé, `null` si
  /// inconnu).
  Future<int?> localVersion(AppDatabase db, String id);

  Future<void> deleteLocal(AppDatabase db, String id);
}

final List<LocalEntity> localEntities = [TagsLocalEntity()];

LocalEntity? localEntityFor(String name) =>
    localEntities.where((e) => e.name == name).firstOrNull;

DateTime? _date(Object? value) =>
    value is String ? DateTime.parse(value).toUtc() : null;

final class TagsLocalEntity implements LocalEntity {
  @override
  String get name => SyncEntities.tags.name;

  @override
  Future<void> applyServerRecord(
    AppDatabase db,
    SyncRecord record,
    Map<String, Object?> pending,
  ) async {
    final data = {...record.data, ...pending};
    await db
        .into(db.tags)
        .insertOnConflictUpdate(
          TagsCompanion.insert(
            id: record.id,
            name: data['name'] as String? ?? '',
            color: data['color'] as String? ?? '#64748B',
            description: Value(data['description'] as String?),
            version: Value(record.version),
            fieldMeta: Value(jsonEncode(encodeFieldMeta(record.fieldMeta))),
            createdAt: _date(data['created_at']) ?? DateTime.now().toUtc(),
            createdBy: Value(data['created_by'] as String?),
            updatedAt: _date(data['updated_at']) ?? DateTime.now().toUtc(),
            updatedBy: Value(data['updated_by'] as String?),
            deletedAt: Value(_date(data['deleted_at'])),
          ),
        );
  }

  @override
  Future<int?> localVersion(AppDatabase db, String id) async {
    final row = await (db.select(
      db.tags,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row?.version;
  }

  @override
  Future<void> deleteLocal(AppDatabase db, String id) =>
      (db.delete(db.tags)..where((t) => t.id.equals(id))).go();
}
