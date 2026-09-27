@Tags(['integration'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:fr_public_data/fr_public_data.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:voyaj_server/voyaj_server.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'support/test_server.dart';

const _fixtures = '../../packages/fr_public_data/test/fixtures';

/// Fausses API publiques : jeux d'essai du package fr_public_data.
http.Client fakePublicApis({Set<String> failing = const {}}) =>
    MockClient((request) async {
      final path = request.url.path;
      final name = switch (path) {
        '/regions' => 'regions',
        '/departements' => 'departements',
        '/epcis' => 'epcis',
        '/departements/12/communes' => 'communes_12',
        '/api/aoms/geojson' => 'aoms',
        _ when path.contains('festivals') => 'festivals',
        _ => null,
      };
      if (name == null || failing.contains(name)) {
        return http.Response('indisponible', 503);
      }
      return http.Response.bytes(
        File('$_fixtures/$name.json').readAsBytesSync(),
        200,
        headers: {'content-type': 'application/json'},
      );
    });

void main() {
  if (integrationSkip != null) {
    test('intégration', () {}, skip: integrationSkip);
    return;
  }
  late TestServer server;
  final failing = <String>{};

  setUpAll(
    () async => server = await TestServer.start(
      publicDataClient: PublicDataClient(
        httpClient: fakePublicApis(failing: failing),
      ),
    ),
  );
  tearDownAll(() async {
    await server.server.services.publicData.idle();
    await server.close();
  });

  Future<List<SyncRecord>> organisations(ApiClient client) async => [
    for (final r in (await client.pull(0)).records)
      if (r.entity == 'organisations') r,
  ];

  Future<PublicDataRun> run(ApiClient admin, PublicSource source) async {
    final response = await admin.post('/api/v1/public-data/${source.key}/run');
    expect(response.status, 202, reason: '${response.body}');
    await server.server.services.publicData.idle();
    final runs = await admin.get(
      '/api/v1/public-data/runs?source=${source.key}&limit=1',
    );
    return PublicDataRun.fromJson(runs.list.single as Map<String, dynamic>);
  }

  test('configuration réservée à publicdata.manage', () async {
    final sales = await server.userWithRoles('pd-commercial@voyaj.test', [
      'commercial',
    ]);
    expect((await sales.get('/api/v1/public-data')).status, 403);
    expect((await sales.post('/api/v1/public-data/regions/run')).status, 403);
  });

  test('import complet : hiérarchie, rapprochement, idempotence', () async {
    final admin = await server.admin();

    // Une commune saisie à la main avant l'import sera rattachée.
    final manual = newId();
    await admin.push([
      admin.op(manual, {
        'name': 'Mairie de Millau',
        'kind': 'commune',
        'status': 'client',
        'insee_code': '12145',
      }, entity: 'organisations'),
    ]);

    final configured = await admin.put(
      '/api/v1/public-data/communes',
      const ConfigurePublicSourceRequest(
        enabled: true,
        departements: ['12', 'pas-un-code'],
      ).toJson(),
    );
    expect(configured.status, 200);
    expect(configured.json['departements'], ['12']);
    await admin.put(
      '/api/v1/public-data/epcis',
      const ConfigurePublicSourceRequest(
        enabled: true,
        departements: ['12'],
      ).toJson(),
    );

    for (final source in [
      PublicSource.regions,
      PublicSource.departements,
      PublicSource.epcis,
      PublicSource.communes,
    ]) {
      final result = await run(admin, source);
      expect(result.status, PublicRunStatus.succeeded, reason: result.error);
    }

    final orgs = await organisations(admin);
    Map<String, Object?> byName(String name) =>
        orgs.firstWhere((o) => o.data['name'] == name).data;
    SyncRecord recordNamed(String name) =>
        orgs.firstWhere((o) => o.data['name'] == name);

    expect(orgs.where((o) => o.data['kind'] == 'region'), hasLength(2));
    final aveyron = recordNamed('Aveyron');
    expect(aveyron.data['parent_id'], recordNamed('Occitanie').id);
    final agglo = recordNamed('CA Rodez Agglomération');
    expect(agglo.data['parent_id'], aveyron.id);
    expect(orgs.where((o) => o.data['kind'] == 'metropole'), isEmpty);

    final rodez = byName('Rodez');
    expect(rodez['kind'], 'commune');
    expect(rodez['status'], 'a_prospecter');
    expect(rodez['population'], 24989);
    expect(rodez['parent_id'], agglo.id);
    expect(rodez['source'], 'geo.api.gouv.fr/communes');
    expect(rodez['source_ref'], '12202');
    expect(rodez['collected_at'], isNotNull);

    // La fiche saisie à la main est reprise : ses champs saisis (nom,
    // statut) sont conservés, les autres complétés par la source.
    final millau = orgs.firstWhere((o) => o.id == manual).data;
    expect(millau['name'], 'Mairie de Millau');
    expect(millau['status'], 'client');
    expect(millau['source_ref'], '12145');
    expect(millau['population'], 22003);
    expect(orgs.where((o) => o.data['insee_code'] == '12145'), hasLength(1));

    // Deuxième import : rien ne change.
    final again = await run(admin, PublicSource.communes);
    expect(again.created, 0);
    expect(again.updated, 0);
    expect(again.unchanged, 3);
  });

  test('un champ modifié par un utilisateur n’est pas écrasé', () async {
    final admin = await server.admin();
    final rodez = (await organisations(admin))
        .firstWhere((o) => o.data['source_ref'] == '12202');
    final edited = (await admin.push([
      admin.op(
        rodez.id,
        {'name': 'Mairie de Rodez'},
        baseVersion: rodez.version,
        entity: 'organisations',
      ),
    ])).results.single;
    expect(edited.status, OpStatus.applied);

    final result = await run(admin, PublicSource.communes);
    expect(result.updated, 0);
    final after = (await organisations(admin))
        .firstWhere((o) => o.id == rodez.id);
    expect(after.data['name'], 'Mairie de Rodez');
  });

  test('une fiche supprimée n’est pas recréée', () async {
    final admin = await server.admin();
    final onet = (await organisations(admin))
        .firstWhere((o) => o.data['source_ref'] == '12176');
    await admin.push([
      admin.op(
        onet.id,
        {'deleted_at': DateTime.now().toUtc().toIso8601String()},
        baseVersion: onet.version,
        entity: 'organisations',
      ),
    ]);
    final result = await run(admin, PublicSource.communes);
    expect(result.created, 0);
    final orgs = await organisations(admin);
    expect(orgs.where((o) => o.data['source_ref'] == '12176'), hasLength(1));
  });

  test('AOM et festivals', () async {
    final admin = await server.admin();
    expect((await run(admin, PublicSource.aoms)).created, 3);
    final festivals = await run(admin, PublicSource.festivals);
    expect(festivals.created, 2);
    final orgs = await organisations(admin);
    final jazz = orgs.firstWhere(
      (o) => o.data['name'] == 'Millau Jazz Festival',
    );
    expect(jazz.data['kind'], 'festival');
    expect(jazz.data['latitude'], 44.0986);
    // L'AOM de Rodez partage le SIREN de l'agglomération mais pas son
    // type : fiche distincte.
    expect(
      orgs
          .where((o) => o.data['siren'] == '241200567')
          .map((o) => o.data['kind']),
      containsAll(['epci', 'aom']),
    );
  });

  test('source indisponible : échec enregistré, lisible', () async {
    final admin = await server.admin();
    failing.add('regions');
    addTearDown(failing.clear);
    final result = await run(admin, PublicSource.regions);
    expect(result.status, PublicRunStatus.failed);
    expect(result.error, 'geo.api.gouv.fr a répondu 503.');

    final status = await admin.get('/api/v1/public-data');
    final regions = status.list
        .cast<Map<String, dynamic>>()
        .map(PublicSourceStatus.fromJson)
        .firstWhere((s) => s.source == 'regions');
    expect(regions.lastRun!.status, PublicRunStatus.failed);
  });

  test('journal d’audit : un événement par import', () async {
    final admin = await server.admin();
    final audit = await admin.get('/api/v1/audit?limit=500');
    final runs = [
      for (final e in audit.list.cast<Map<String, dynamic>>())
        if (e['action'] == 'public_data.run') e,
    ];
    expect(runs.length, greaterThanOrEqualTo(6));
    expect(jsonEncode(runs.first['payload']), contains('source'));
  });

  test('planification : une fois par jour, à l’heure prévue', () async {
    final services = server.server.services;
    var now = DateTime(2030, 1, 15, 2, 50);
    final scheduler = PublicDataService(
      db: services.db,
      sync: services.sync,
      client: PublicDataClient(httpClient: fakePublicApis()),
      scheduleHour: 3,
      clock: () => now,
    );
    Future<int> scheduledRuns() async {
      final result = await services.db.query(
        "SELECT count(*) AS n FROM public_data_runs WHERE trigger = 'schedule'",
      );
      return result.first.toColumnMap()['n'] as int;
    }

    final before = await scheduledRuns();
    await scheduler.runScheduledIfDue();
    await scheduler.idle();
    expect(await scheduledRuns(), before, reason: 'avant l’heure');

    now = DateTime(2030, 1, 15, 3, 5);
    await scheduler.runScheduledIfDue();
    await scheduler.idle();
    // Sources activées plus haut : EPCI et communes.
    expect(await scheduledRuns(), before + 2);

    now = DateTime(2030, 1, 15, 3, 45);
    await scheduler.runScheduledIfDue();
    await scheduler.idle();
    expect(await scheduledRuns(), before + 2, reason: 'déjà fait ce jour');
  });
}
