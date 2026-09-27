import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../data/records/record_store.dart';
import 'import_mapping.dart';

/// Options d'un import.
final class ImportOptions {
  const ImportOptions({
    required this.source,
    this.skipDuplicates = true,
    this.defaultKind = 'commune',
    this.defaultStatus = 'a_prospecter',
    this.createMissingOrganisations = true,
    this.createMissingTags = true,
    this.ownerId,
  });

  /// Origine des données (RGPD), ex. « Import CSV maires-2026.csv ».
  final String source;
  final bool skipDuplicates;
  final String defaultKind;
  final String defaultStatus;
  final bool createMissingOrganisations;
  final bool createMissingTags;
  final String? ownerId;
}

/// Bilan d'un import.
final class ImportReport {
  int created = 0;
  int duplicates = 0;
  int organisationsCreated = 0;
  int tagsCreated = 0;

  /// Lignes refusées : numéro de ligne → message.
  final List<(int, String)> rejected = [];
}

/// Données existantes utiles à l'import.
final class ImportContext {
  ImportContext({
    required this.existingKeys,
    required this.tagsByName,
    required this.organisationsByName,
  });

  /// Clés de doublon des enregistrements existants.
  final Set<String> existingKeys;

  /// Tags existants (nom normalisé → identifiant).
  final Map<String, String> tagsByName;

  /// Organisations existantes (nom normalisé → identifiant).
  final Map<String, String> organisationsByName;
}

/// Taille des lots écrits dans une même transaction.
const importBatchSize = 200;

/// Écrit les lignes converties par lots. Les lignes invalides ou en
/// doublon sont ignorées et rapportées.
Future<ImportReport> runImport(
  RecordStore store, {
  required CrmEntity entity,
  required List<ImportedRow> rows,
  required ImportOptions options,
  required ImportContext context,
  void Function(int done)? onProgress,
}) async {
  final report = ImportReport();
  final seen = {...context.existingKeys};
  final collectedAt = DateTime.now().toUtc().toIso8601String();
  final schema = entity == CrmEntity.organisations
      ? SyncEntities.organisations
      : SyncEntities.contacts;
  final keysOf = entity == CrmEntity.organisations
      ? organisationDuplicateKeys
      : contactDuplicateKeys;

  for (var start = 0; start < rows.length; start += importBatchSize) {
    final batch = rows.skip(start).take(importBatchSize);
    await store.write((w) async {
      for (final row in batch) {
        final fields = <String, Object?>{
          if (entity == CrmEntity.organisations) ...{
            'kind': options.defaultKind,
            'status': options.defaultStatus,
          },
          ...row.fields,
          'owner_id': options.ownerId,
          'source': options.source,
          'source_ref': 'ligne ${row.line}',
          'collected_at': collectedAt,
        };
        if (entity == CrmEntity.contacts && row.organisationName != null) {
          final name = normalizeName(row.organisationName);
          var orgId = context.organisationsByName[name];
          if (orgId == null && options.createMissingOrganisations) {
            try {
              orgId = await w.create(SyncEntities.organisations, {
                'name': row.organisationName,
                'kind': OrganisationKind.autre.key,
                'status': options.defaultStatus,
                'owner_id': options.ownerId,
                'source': options.source,
                'collected_at': collectedAt,
              });
              context.organisationsByName[name] = orgId;
              report.organisationsCreated++;
            } on RecordValidationException catch (e) {
              report.rejected.add((row.line, e.toString()));
              continue;
            }
          }
          fields['organisation_id'] = orgId;
        }
        final keys = keysOf(fields);
        if (options.skipDuplicates && keys.any(seen.contains)) {
          report.duplicates++;
          continue;
        }
        final String id;
        try {
          id = await w.create(schema, fields);
        } on RecordValidationException catch (e) {
          report.rejected.add((row.line, e.toString()));
          continue;
        }
        seen.addAll(keys);
        report.created++;
        for (final tagName in row.tags) {
          final key = normalizeName(tagName).isEmpty
              ? searchText(tagName)
              : normalizeName(tagName);
          var tagId = context.tagsByName[key];
          if (tagId == null && options.createMissingTags) {
            tagId = await w.create(SyncEntities.tags, {
              'name': tagName.length > tagNameMaxLength
                  ? tagName.substring(0, tagNameMaxLength)
                  : tagName,
              'color':
                  tagPalette[context.tagsByName.length % tagPalette.length],
            });
            context.tagsByName[key] = tagId;
            report.tagsCreated++;
          }
          if (tagId == null) continue;
          await w.create(SyncEntities.taggings, {
            'tag_id': tagId,
            'entity': entity.key,
            'record_id': id,
          });
        }
      }
    });
    onProgress?.call((start + importBatchSize).clamp(0, rows.length));
  }
  return report;
}
