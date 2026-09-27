import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voyaj_client/data/local/database.dart';
import 'package:voyaj_client/data/records/record_store.dart';
import 'package:voyaj_client/data/sync/local_clock.dart';
import 'package:voyaj_client/features/crm/activities/reminders.dart';
import 'package:voyaj_client/features/crm/deals/default_pipelines.dart';
import 'package:voyaj_client/features/crm/duplicates/merge.dart';
import 'package:voyaj_client/features/crm/import/import_mapping.dart';
import 'package:voyaj_client/features/crm/import/import_runner.dart';
import 'package:voyaj_client/features/settings/custom_fields_section.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

void main() {
  late AppDatabase db;
  late RecordStore store;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    store = RecordStore(
      db: db,
      clock: await LocalClock.load(db),
      currentUserId: 'u1',
      onChanged: () {},
    );
  });

  tearDown(() => db.close());

  group('Import CSV : correspondance et conversion', () {
    test('en-têtes reconnus sans accents ni casse', () {
      expect(guessTarget('Raison sociale', organisationTargets), 'name');
      expect(guessTarget('Code Postal', organisationTargets), 'postal_code');
      expect(guessTarget('Téléphone', organisationTargets), 'phone');
      expect(guessTarget('Prénom', contactTargets), 'first_name');
      expect(guessTarget('Portable', contactTargets), 'mobile');
      expect(guessTarget('Collectivité', contactTargets), importOrganisation);
      expect(guessTarget('Colonne inconnue', contactTargets), isNull);
    });

    test('valeurs converties au format réseau', () {
      final row = convertRow(
        CrmEntity.organisations,
        [
          'Communauté de communes du Réquistanais',
          'Communauté de communes',
          'Client',
          '1 234',
          '2400',
          'www.cc-requistanais.fr',
          '44,03',
          'Occitanie',
          'Prioritaire, Aveyron',
          '12 000',
        ],
        {
          0: 'name',
          1: 'kind',
          2: 'status',
          3: 'population',
          4: 'postal_code',
          5: 'website',
          6: 'latitude',
          7: 'region_code',
          8: importTags,
          9: 'custom.budget',
        },
        line: 2,
        customTypes: {'budget': 'number'},
      );
      expect(row.fields, {
        'name': 'Communauté de communes du Réquistanais',
        'kind': 'epci',
        'status': 'client',
        'population': 1234,
        'postal_code': '02400',
        'website': 'https://www.cc-requistanais.fr',
        'latitude': 44.03,
        'region_code': '76',
        'custom_fields': {'budget': 12000},
      });
      expect(row.tags, ['Prioritaire', 'Aveyron']);
      expect(row.problems, isEmpty);
    });

    test('valeurs non reconnues signalées', () {
      final row = convertRow(
        CrmEntity.organisations,
        ['X', 'Planète', 'beaucoup'],
        {0: 'name', 1: 'kind', 2: 'population'},
        line: 7,
      );
      expect(row.problems.map((p) => p.$1), [
        ImportProblem.kind,
        ImportProblem.population,
      ]);
      expect(row.fields.containsKey('kind'), isFalse);
    });

    test('décodage UTF-8 puis Latin-1 (exports Excel)', () {
      expect(decodeText(utf8.encode('Élus')), 'Élus');
      expect(decodeText(latin1.encode('Élus')), 'Élus');
    });
  });

  group('Import CSV : écriture', () {
    ImportContext emptyContext() => ImportContext(
      existingKeys: {},
      tagsByName: {},
      organisationsByName: {},
    );

    test('organisations : doublons ignorés, tags créés, provenance', () async {
      final existing = await store.create(SyncEntities.organisations, {
        'name': 'Mairie de Rodez',
        'kind': 'commune',
        'status': 'client',
        'insee_code': '12202',
      });
      final context = emptyContext();
      context.existingKeys.addAll(
        organisationDuplicateKeys(
          (await store.read(SyncEntities.organisations, existing))!,
        ),
      );
      final rows = [
        convertRow(
          CrmEntity.organisations,
          ['Rodez', '12202', 'Aveyron'],
          {0: 'name', 1: 'insee_code', 2: importTags},
          line: 2,
        ),
        convertRow(
          CrmEntity.organisations,
          ['Millau', '12145', 'Aveyron'],
          {0: 'name', 1: 'insee_code', 2: importTags},
          line: 3,
        ),
        convertRow(
          CrmEntity.organisations,
          ['Millau', '12145', ''],
          {0: 'name', 1: 'insee_code', 2: importTags},
          line: 4,
        ),
        convertRow(
          CrmEntity.organisations,
          ['', '12001', ''],
          {0: 'name', 1: 'insee_code', 2: importTags},
          line: 5,
        ),
      ];
      final report = await runImport(
        store,
        entity: CrmEntity.organisations,
        rows: rows,
        options: const ImportOptions(source: 'Import CSV test.csv'),
        context: context,
      );
      expect(report.created, 1);
      expect(report.duplicates, 2);
      expect(report.tagsCreated, 1);
      expect(report.rejected.single.$1, 5);

      final millau = (await db.select(db.organisations).get()).firstWhere(
        (o) => o.name == 'Millau',
      );
      expect(millau.kind, 'commune');
      expect(millau.source, 'Import CSV test.csv');
      expect(millau.sourceRef, 'ligne 3');
      expect(millau.collectedAt, isNotNull);
      final taggings = await db.select(db.taggings).get();
      expect(taggings.single.recordId, millau.id);
    });

    test('contacts : organisation retrouvée ou créée', () async {
      final orgId = await store.create(SyncEntities.organisations, {
        'name': 'Mairie de Saint-Affrique',
        'kind': 'commune',
        'status': 'contacte',
      });
      final context = emptyContext();
      context.organisationsByName[normalizeName('Mairie de Saint-Affrique')] =
          orgId;
      final mapping = {0: 'last_name', 1: 'email', 2: importOrganisation};
      final report = await runImport(
        store,
        entity: CrmEntity.contacts,
        rows: [
          convertRow(
            CrmEntity.contacts,
            ['Durand', 'a@x.fr', 'Commune de St Affrique'],
            mapping,
            line: 2,
          ),
          convertRow(
            CrmEntity.contacts,
            ['Martin', 'p@y.fr', 'Festival Nouveau'],
            mapping,
            line: 3,
          ),
          convertRow(
            CrmEntity.contacts,
            ['Durand bis', 'A@X.FR', ''],
            mapping,
            line: 4,
          ),
        ],
        options: const ImportOptions(source: 'Import'),
        context: context,
      );
      expect(report.created, 2);
      expect(report.duplicates, 1);
      expect(report.organisationsCreated, 1);
      final contacts = await db.select(db.contacts).get();
      expect(
        contacts.firstWhere((c) => c.lastName == 'Durand').organisationId,
        orgId,
      );
    });
  });

  test('fusion : références et tags reportés, doublon supprimé', () async {
    final master = await store.create(SyncEntities.organisations, {
      'name': 'Mairie de Millau',
      'kind': 'commune',
      'status': 'client',
    });
    final duplicate = await store.create(SyncEntities.organisations, {
      'name': 'Commune de Millau',
      'kind': 'commune',
      'status': 'a_prospecter',
      'phone': '05 65 59 50 00',
    });
    final contact = await store.create(SyncEntities.contacts, {
      'last_name': 'Petit',
      'organisation_id': duplicate,
    });
    final tag = await store.create(SyncEntities.tags, {
      'name': 'Aveyron',
      'color': '#10B981',
    });
    for (final id in [master, duplicate]) {
      await store.create(SyncEntities.taggings, {
        'tag_id': tag,
        'entity': 'organisations',
        'record_id': id,
      });
    }

    await mergeRecords(
      store,
      schema: SyncEntities.organisations,
      masterId: master,
      otherIds: [duplicate],
    );

    final kept = (await store.read(SyncEntities.organisations, master))!;
    expect(kept['phone'], '05 65 59 50 00');
    expect(kept['status'], 'client');
    final removed = (await store.read(SyncEntities.organisations, duplicate))!;
    expect(removed['deleted_at'], isNotNull);
    expect(
      (await store.read(SyncEntities.contacts, contact))!['organisation_id'],
      master,
    );
    final activeTaggings = (await db.select(db.taggings).get())
        .where((t) => t.deletedAt == null)
        .toList();
    expect(activeTaggings.single.recordId, master);
  });

  test('pipelines par défaut : Collectivités et Festivals', () async {
    final first = await createDefaultPipelines(store);
    final pipelines = await db.select(db.pipelines).get();
    final stages = await db.select(db.pipelineStages).get();
    expect(
      pipelines.map((p) => p.name),
      containsAll(['Collectivités', 'Festivals']),
    );
    expect(pipelines.firstWhere((p) => p.id == first).name, 'Collectivités');
    expect(stages.where((s) => s.pipelineId == first), hasLength(7));
    expect(stages.where((s) => s.outcome == 'won'), hasLength(2));
  });

  test('identifiant de champ personnalisé dérivé du libellé', () {
    expect(customFieldKey('Budget mobilité 2026'), 'budget_mobilite_2026');
    expect(customFieldKey('2e contact'), 'champ_2e_contact');
    expect(
      validateCustomFieldRecord({
        'key': customFieldKey('Très très long libellé de champ personnalisé !'),
        'label': 'x',
        'type': 'text',
      }),
      isEmpty,
    );
  });

  test('rappels : échus, non terminés, signalés une seule fois', () {
    final now = DateTime.utc(2026, 9, 27, 10);
    ActivityRow activity(String id, {DateTime? remind, DateTime? done}) =>
        ActivityRow(
          id: id,
          kind: 'task',
          subject: id,
          remindAt: remind,
          doneAt: done,
          version: 1,
          fieldMeta: '{}',
          createdAt: now,
          updatedAt: now,
        );
    final due = dueReminders(
      [
        activity('futur', remind: now.add(const Duration(minutes: 5))),
        activity('b', remind: now.subtract(const Duration(minutes: 1))),
        activity('a', remind: now.subtract(const Duration(hours: 1))),
        activity('fait', remind: now, done: now),
        activity('deja', remind: now),
        activity('sans'),
      ],
      {'deja'},
      now,
    );
    expect(due.map((a) => a.id), ['a', 'b']);
  });
}
