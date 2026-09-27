import 'package:voyaj_shared/voyaj_shared.dart';

import '../../data/local/database.dart';
import '../../data/records/record_store.dart';

/// Applique [tagId] aux enregistrements qui ne l'ont pas encore.
Future<int> applyTag(
  RecordStore store, {
  required CrmEntity entity,
  required Iterable<String> recordIds,
  required String tagId,
  required List<TaggingRow> taggings,
}) async {
  final already = {
    for (final t in taggings)
      if (t.tagId == tagId) t.recordId,
  };
  final targets = [
    for (final id in recordIds)
      if (!already.contains(id)) id,
  ];
  if (targets.isEmpty) return 0;
  await store.write((w) async {
    for (final id in targets) {
      await w.create(SyncEntities.taggings, {
        'tag_id': tagId,
        'entity': entity.key,
        'record_id': id,
      });
    }
  });
  return targets.length;
}

/// Retire [tagId] de [recordId].
Future<void> removeTag(
  RecordStore store, {
  required String recordId,
  required String tagId,
  required List<TaggingRow> taggings,
}) => store.delete(SyncEntities.taggings, [
  for (final t in taggings)
    if (t.recordId == recordId && t.tagId == tagId) t.id,
]);
