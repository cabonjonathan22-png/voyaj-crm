import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/providers.dart';
import '../../data/local/database.dart';
import '../../data/records/record_store.dart';

/// Écritures locales des entités du CRM.
final recordStoreProvider = Provider<RecordStore>(
  (ref) => RecordStore(
    db: ref.watch(appDatabaseProvider),
    clock: ref.watch(localClockProvider),
    currentUserId: ref.watch(currentUserProvider.select((u) => u?.id)),
    onChanged: () => ref.read(syncEngineProvider)?.notifyLocalChange(),
  ),
);

// Lectures locales réactives (enregistrements non supprimés).

final organisationsProvider = StreamProvider<List<OrganisationRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.organisations)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([(t) => OrderingTerm.asc(t.name.lower())]))
      .watch();
});

final contactsProvider = StreamProvider<List<ContactRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.contacts)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([
          (t) => OrderingTerm.asc(t.lastName.lower()),
          (t) => OrderingTerm.asc(t.firstName.lower()),
        ]))
      .watch();
});

final positionsProvider = StreamProvider<List<PositionRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.positions)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([(t) => OrderingTerm.desc(t.startDate)]))
      .watch();
});

final pipelinesProvider = StreamProvider<List<PipelineRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.pipelines)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([
          (t) => OrderingTerm.asc(t.sortOrder),
          (t) => OrderingTerm.asc(t.name),
        ]))
      .watch();
});

final stagesProvider = StreamProvider<List<StageRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.pipelineStages)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
      .watch();
});

final dealsProvider = StreamProvider<List<DealRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.deals)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([
          (t) => OrderingTerm.asc(t.sortOrder),
          (t) => OrderingTerm.desc(t.createdAt),
        ]))
      .watch();
});

final activitiesProvider = StreamProvider<List<ActivityRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.activities)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .watch();
});

final attachmentsProvider = StreamProvider<List<AttachmentRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.attachments)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .watch();
});

final taggingsProvider = StreamProvider<List<TaggingRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.taggings)..where((t) => t.deletedAt.isNull())).watch();
});

final customFieldsProvider = StreamProvider<List<CustomFieldRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.customFields)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([
          (t) => OrderingTerm.asc(t.sortOrder),
          (t) => OrderingTerm.asc(t.label),
        ]))
      .watch();
});

final segmentsProvider = StreamProvider<List<SegmentRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.segments)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([(t) => OrderingTerm.asc(t.name.lower())]))
      .watch();
});

// Index dérivés.

final organisationByIdProvider = Provider<Map<String, OrganisationRow>>(
  (ref) => {
    for (final o
        in ref.watch(organisationsProvider).value ?? const <OrganisationRow>[])
      o.id: o,
  },
);

final contactByIdProvider = Provider<Map<String, ContactRow>>(
  (ref) => {
    for (final c in ref.watch(contactsProvider).value ?? const <ContactRow>[])
      c.id: c,
  },
);

final tagByIdProvider = Provider<Map<String, Tag>>(
  (ref) => {
    for (final t in ref.watch(tagsProvider).value ?? const <Tag>[]) t.id: t,
  },
);

/// Tags appliqués, par enregistrement (tags supprimés exclus).
final tagsByRecordProvider = Provider<Map<String, List<Tag>>>((ref) {
  final tags = ref.watch(tagByIdProvider);
  final result = <String, List<Tag>>{};
  for (final tagging
      in ref.watch(taggingsProvider).value ?? const <TaggingRow>[]) {
    final tag = tags[tagging.tagId];
    if (tag != null) result.putIfAbsent(tagging.recordId, () => []).add(tag);
  }
  for (final list in result.values) {
    list.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
  }
  return result;
});

/// Champs personnalisés définis pour [CrmEntity].
final customFieldsForProvider =
    Provider.family<List<CustomFieldRow>, CrmEntity>(
      (ref, entity) => [
        for (final f
            in ref.watch(customFieldsProvider).value ??
                const <CustomFieldRow>[])
          if (f.entity == entity.key) f,
      ],
    );
