import 'package:drift/drift.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../data/records/record_store.dart';
import '../../../data/sync/local_entities.dart';

/// Références vers une organisation ou un contact (entité, colonne).
const _references = {
  'organisations': [
    ('contacts', 'organisation_id'),
    ('positions', 'organisation_id'),
    ('deals', 'organisation_id'),
    ('activities', 'organisation_id'),
    ('attachments', 'organisation_id'),
    ('organisations', 'parent_id'),
  ],
  'contacts': [
    ('positions', 'contact_id'),
    ('deals', 'contact_id'),
    ('activities', 'contact_id'),
    ('attachments', 'contact_id'),
  ],
};

/// Fusionne [otherIds] dans [masterId] : champs vides du master complétés,
/// références (contacts, postes, affaires, activités, fichiers, tags,
/// organisation parente) reportées sur le master, doublons supprimés.
/// Toutes les écritures sont synchronisées (une transaction).
Future<void> mergeRecords(
  RecordStore store, {
  required EntitySchema schema,
  required String masterId,
  required List<String> otherIds,
}) => store.write((w) async {
  final master = (await store.read(schema, masterId))!;
  final others = [for (final id in otherIds) (await store.read(schema, id))!];
  final changes = mergeDuplicateFields(master, others, [
    for (final f in schema.fields.keys)
      if (f != SyncColumns.deletedAt) f,
  ]);
  if (changes.isNotEmpty) await w.update(schema, masterId, changes);

  Future<List<String>> ids(
    String table,
    String where,
    List<String> values,
  ) async {
    final rows = await store.db
        .customSelect(
          'SELECT "id" FROM "$table" WHERE $where AND "deleted_at" IS NULL',
          variables: [for (final v in values) Variable<String>(v)],
        )
        .get();
    return [for (final r in rows) r.read<String>('id')];
  }

  final placeholders = List.filled(otherIds.length, '?').join(', ');
  for (final (table, column) in _references[schema.name]!) {
    final target = SyncEntities.byName(table)!;
    for (final id in await ids(
      table,
      '"$column" IN ($placeholders)',
      otherIds,
    )) {
      if (id == masterId) continue;
      await w.update(target, id, {column: masterId});
    }
  }

  // Tags : reportés sur le master, sans créer de doublon d'étiquette.
  final masterTags = {
    for (final row
        in await store.db
            .customSelect(
              'SELECT "tag_id" FROM "taggings" WHERE "record_id" = ? '
              'AND "deleted_at" IS NULL',
              variables: [Variable<String>(masterId)],
            )
            .get())
      row.read<String>('tag_id'),
  };
  final otherTaggings = await store.db
      .customSelect(
        'SELECT "id", "tag_id" FROM "taggings" WHERE "record_id" IN '
        '($placeholders) AND "deleted_at" IS NULL',
        variables: [for (final v in otherIds) Variable<String>(v)],
      )
      .get();
  for (final row in otherTaggings) {
    final tagId = row.read<String>('tag_id');
    final id = row.read<String>('id');
    if (masterTags.add(tagId)) {
      await w.update(SyncEntities.taggings, id, {'record_id': masterId});
    } else {
      await w.delete(SyncEntities.taggings, id);
    }
  }

  for (final id in otherIds) {
    await w.delete(schema, id);
  }
});

/// Nombre de champs renseignés (choix du master par défaut).
int filledFieldCount(Map<String, Object?> record) => record.values
    .where((v) => v != null && (v is! String || v.isNotEmpty))
    .length;

/// Enregistrement au format réseau depuis une ligne Drift.
Map<String, Object?> wireOf(EntitySchema schema, Insertable<Object?> row) =>
    rowToWire(schema, row);
