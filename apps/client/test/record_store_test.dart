import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voyaj_client/data/local/database.dart';
import 'package:voyaj_client/data/records/record_store.dart';
import 'package:voyaj_client/data/sync/local_clock.dart';
import 'package:voyaj_client/data/sync/local_entities.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

void main() {
  late AppDatabase db;
  late RecordStore store;
  var changes = 0;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    changes = 0;
    store = RecordStore(
      db: db,
      clock: await LocalClock.load(db),
      currentUserId: 'u1',
      onChanged: () => changes++,
    );
  });

  tearDown(() => db.close());

  Future<List<Map<String, dynamic>>> outbox() async => [
    for (final op in await db.pendingOperations())
      jsonDecode(op.fields) as Map<String, dynamic>,
  ];

  test('création : valeurs nettoyées, types conservés, outbox', () async {
    final id = await store.create(SyncEntities.organisations, {
      'name': '  Mairie de Rodez ',
      'kind': 'commune',
      'status': 'a_prospecter',
      'siren': '',
      'population': 24000,
      'latitude': 44.35,
      'custom_fields': {'budget': 1200},
      'collected_at': '2026-09-01T10:00:00.000Z',
    });
    final row = (await store.read(SyncEntities.organisations, id))!;
    expect(row['name'], 'Mairie de Rodez');
    expect(row['siren'], isNull);
    expect(row['population'], 24000);
    expect(row['latitude'], 44.35);
    expect(row['custom_fields'], {'budget': 1200});
    expect(row['collected_at'], '2026-09-01T10:00:00.000Z');
    expect(row['version'], 0);
    expect((await outbox()).single['name'], 'Mairie de Rodez');
    expect(changes, 1);

    final typed = await (db.select(
      db.organisations,
    )..where((t) => t.id.equals(id))).getSingle();
    expect(typed.collectedAt, DateTime.utc(2026, 9, 1, 10));
    expect(typed.createdBy, 'u1');
  });

  test('mise à jour : seuls les champs modifiés partent', () async {
    final id = await store.create(SyncEntities.contacts, {
      'last_name': 'Durand',
      'first_name': 'Anne',
      'do_not_contact': false,
    });
    await store.update(SyncEntities.contacts, id, {
      'last_name': 'Durand',
      'first_name': 'Anne-Marie',
      'do_not_contact': false,
    });
    expect((await outbox()).last, {'first_name': 'Anne-Marie'});

    await store.update(SyncEntities.contacts, id, {'first_name': 'Anne-Marie'});
    expect(await outbox(), hasLength(2));
  });

  test('règles partagées appliquées avant écriture', () async {
    await expectLater(
      store.create(SyncEntities.positions, {
        'contact_id': newId(),
        'organisation_id': newId(),
        'is_elected': true,
        'start_date': '2026-02-30',
      }),
      throwsA(
        isA<RecordValidationException>().having(
          (e) => e.byField.keys,
          'champs',
          containsAll(['start_date', 'mandate_role']),
        ),
      ),
    );
    expect(await outbox(), isEmpty);
  });

  test('suppression logique', () async {
    final id = await store.create(SyncEntities.pipelines, {
      'name': 'Festivals',
      'kind': 'festivals',
    });
    await store.delete(SyncEntities.pipelines, [id]);
    final row = await (db.select(
      db.pipelines,
    )..where((t) => t.id.equals(id))).getSingle();
    expect(row.deletedAt, isNotNull);
    expect((await outbox()).last.keys, ['deleted_at']);
  });

  test('état serveur appliqué avec les saisies en attente', () async {
    final entity = localEntityFor('deals')!;
    final id = newId();
    await entity.applyServerRecord(
      db,
      SyncRecord(
        entity: 'deals',
        id: id,
        version: 3,
        seq: 10,
        data: {
          'title': 'Navettes',
          'pipeline_id': newId(),
          'stage_id': newId(),
          'status': 'open',
          'expected_close_date': '2026-12-15',
          'created_at': '2026-09-01T10:00:00.000Z',
          'updated_at': '2026-09-02T10:00:00.000Z',
        },
        fieldMeta: const {},
      ),
      {'title': 'Navettes estivales'},
    );
    final row = await (db.select(
      db.deals,
    )..where((t) => t.id.equals(id))).getSingle();
    expect(row.title, 'Navettes estivales');
    expect(row.version, 3);
    expect(row.expectedCloseDate, '2026-12-15');
    expect(row.updatedAt, DateTime.utc(2026, 9, 2, 10));
  });

  test('migration v1 → v2 : tables du CRM créées, tags conservés', () async {
    driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
    final dir = Directory.systemTemp.createTempSync('voyaj-migration');
    addTearDown(() => dir.deleteSync(recursive: true));
    final file = File('${dir.path}/voyaj.db');

    // Base v1 : uniquement tags, outbox, sync_errors, key_values.
    final v1 = AppDatabase(NativeDatabase(file));
    await v1.writeSetting(SettingKeys.syncCursor, 42);
    await v1.customStatement(
      'INSERT INTO tags (id, name, color, created_at, updated_at) '
      "VALUES ('t1', 'Prioritaire', '#EF4444', '2026-01-01T00:00:00Z', "
      "'2026-01-01T00:00:00Z')",
    );
    for (final table in v1.syncedTables.skip(1)) {
      await v1.customStatement('DROP TABLE "${table.actualTableName}"');
    }
    await v1.customStatement('PRAGMA user_version = 1');
    await v1.close();

    final v2 = AppDatabase(NativeDatabase(file));
    addTearDown(v2.close);
    expect(await v2.select(v2.tags).get(), hasLength(1));
    expect(await v2.select(v2.organisations).get(), isEmpty);
    expect(await v2.readSetting<int>(SettingKeys.syncCursor), isNull);
    final indexes = await v2
        .customSelect(
          "SELECT name FROM sqlite_master WHERE type = 'index' "
          "AND name = 'contacts_organisation'",
        )
        .get();
    expect(indexes, hasLength(1));
  });
}
