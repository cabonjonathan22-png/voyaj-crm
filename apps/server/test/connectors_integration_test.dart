@Tags(['integration'])
library;

import 'dart:convert';

import 'package:connectors/connectors.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'support/test_server.dart';

/// Source simulée : enregistrements en mémoire.
final class FakeSource implements RecordSource {
  FakeSource(this.records);

  final List<RawRecord> records;

  @override
  Future<List<RawRecord>> fetch({int limit = 10000}) async =>
      records.take(limit).toList();

  @override
  Future<void> close() async {}
}

/// Connecteurs (Phase 6) : aperçu, import planifiable, rapprochement,
/// webhooks entrants et sortants.
void main() {
  if (integrationSkip != null) {
    test('intégration', () {}, skip: integrationSkip);
    return;
  }
  var sourceRecords = <RawRecord>[];
  final delivered = <http.Request>[];
  var receiverStatus = 200;
  late TestServer server;
  late ApiClient admin;

  setUpAll(() async {
    server = await TestServer.start(
      sourceOpener: (kind, config, secret) {
        if (secret != 'cle-api') {
          throw const ConnectorException('API REST : accès refusé (401).');
        }
        return FakeSource(sourceRecords);
      },
      webhookClient: MockClient((request) async {
        delivered.add(request);
        return http.Response('', receiverStatus);
      }),
      extraConfig: {'VOYAJ_PUBLIC_URL': 'https://crm.voyaj.test'},
    );
    admin = await server.admin();
  });
  tearDownAll(() => server.close());

  const orgMapping = ConnectorMapping(
    entity: 'organisations',
    refPath: 'code',
    matchField: 'siren',
    fields: [
      FieldMapping(target: 'name', source: 'nom', transform: 'trim'),
      FieldMapping(target: 'siren', source: 'siren', transform: 'digits'),
      FieldMapping(target: 'city', source: 'adresse.ville'),
      FieldMapping(target: 'kind', constant: 'commune'),
    ],
  );

  Future<ConnectorRun> waitRun(String id) async {
    for (var i = 0; i < 100; i++) {
      final runs = (await admin.get('/api/v1/connectors/$id/runs')).list;
      final run = ConnectorRun.fromJson(runs.first as Map<String, dynamic>);
      if (run.status != 'running') return run;
      await Future<void>.delayed(const Duration(milliseconds: 50));
    }
    throw StateError('Import non terminé');
  }

  Future<List<SyncRecord>> organisations() async => [
    for (final r in (await admin.pull(0)).records)
      if (r.entity == 'organisations') r,
  ];

  test('aperçu, import, rapprochement et saisie préservée', () async {
    // Fiche existante (même SIREN) : adoptée plutôt que dupliquée.
    final existing = newId();
    await admin.push([
      admin.op(existing, {
        'name': 'Mairie de Rodez',
        'kind': 'commune',
        'status': 'client',
        'siren': '211202023',
      }, entity: 'organisations'),
    ]);
    sourceRecords = [
      {
        'code': 'R1',
        'nom': ' Ville de Rodez ',
        'siren': '211 202 023',
        'adresse': {'ville': 'Rodez'},
      },
      {
        'code': 'M1',
        'nom': 'Mairie de Millau',
        'siren': '211201454',
        'adresse': {'ville': 'Millau'},
      },
      {'code': 'X1', 'nom': 'SIREN faux', 'siren': '123'},
    ];
    const input = ConnectorInput(
      name: 'Référentiel communes',
      kind: 'rest',
      config: {'url': 'https://api.exemple.fr/communes'},
      mapping: orgMapping,
      secret: 'cle-api',
    );

    final preview = ConnectorPreview.fromJson(
      (await admin.post('/api/v1/connectors/preview', input.toJson())).json,
    );
    expect(preview.paths, containsAll(['adresse.ville', 'code', 'nom']));
    expect(preview.mapped.first.fields['name'], 'Ville de Rodez');

    final created = await admin.post('/api/v1/connectors', input.toJson());
    expect(created.status, 201, reason: '${created.body}');
    final connector = ConnectorInfo.fromJson(created.json);
    expect(connector.hasSecret, isTrue);
    expect(created.json.containsKey('secret'), isFalse);

    expect(
      (await admin.post('/api/v1/connectors/${connector.id}/run')).status,
      202,
    );
    final run = await waitRun(connector.id);
    expect(run.status, 'succeeded', reason: run.error);
    expect(run.fetched, 3);
    expect(run.created, 1);
    expect(run.updated, 1);
    expect(run.rejected, 1);
    expect(run.problems.single, startsWith('X1'));

    final orgs = await organisations();
    final rodez = orgs.lastWhere((r) => r.id == existing).data;
    expect(rodez['source'], 'connector:${connector.id}');
    expect(rodez['city'], 'Rodez');
    // Le nom saisi par un utilisateur n'est pas écrasé.
    expect(rodez['name'], 'Mairie de Rodez');
    final millau = orgs.lastWhere((r) => r.data['source_ref'] == 'M1').data;
    expect(millau['status'], 'a_prospecter');

    // Nouvel import : rien de changé.
    await admin.post('/api/v1/connectors/${connector.id}/run');
    final again = await waitRun(connector.id);
    expect(again.unchanged, 2);
    expect(again.created + again.updated, 0);
  });

  test('erreur de la source visible dans l’historique', () async {
    final created = await admin.post(
      '/api/v1/connectors',
      const ConnectorInput(
        name: 'Clé fausse',
        kind: 'rest',
        config: {'url': 'https://api.exemple.fr/x'},
        mapping: orgMapping,
        secret: 'mauvaise',
      ).toJson(),
    );
    final id = created.json['id'] as String;
    await admin.post('/api/v1/connectors/$id/run');
    final run = await waitRun(id);
    expect(run.status, 'failed');
    expect(run.error, contains('accès refusé'));
  });

  test('webhook entrant : contacts rattachés à leur organisation', () async {
    final created = await admin.post(
      '/api/v1/connectors',
      const ConnectorInput(
        name: 'Formulaire du site',
        kind: 'webhook',
        config: {'records_path': 'contacts'},
        mapping: ConnectorMapping(
          entity: 'contacts',
          refPath: 'email',
          matchField: 'email',
          organisationLookup: OrganisationLookup(source: 'siren'),
          fields: [
            FieldMapping(
              target: 'last_name',
              source: 'nom',
              transform: 'upper',
            ),
            FieldMapping(target: 'first_name', source: 'prenom'),
            FieldMapping(target: 'email', source: 'email', transform: 'lower'),
          ],
        ),
      ).toJson(),
    );
    expect(created.status, 201, reason: '${created.body}');
    final id = created.json['id'] as String;
    final token = WebhookToken.fromJson(
      (await admin.post('/api/v1/connectors/$id/webhook-token')).json,
    );
    expect(token.url, 'https://crm.voyaj.test/api/v1/hooks/$id');

    Future<http.Response> hook(String? bearer) => http.post(
      server.baseUri.resolve('/api/v1/hooks/$id'),
      headers: {
        'content-type': 'application/json',
        if (bearer != null) 'authorization': 'Bearer $bearer',
      },
      body: jsonEncode({
        'contacts': [
          {
            'nom': 'Durand',
            'prenom': 'Anne',
            'email': 'Anne.Durand@Rodez.fr',
            'siren': '211202023',
          },
        ],
      }),
    );
    expect((await hook(null)).statusCode, 401);
    expect((await hook('faux')).statusCode, 401);
    final response = await hook(token.token);
    expect(response.statusCode, 200, reason: response.body);
    final run = ConnectorRun.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
    expect(run.created, 1);

    final contact = (await admin.pull(0)).records
        .lastWhere((r) => r.entity == 'contacts')
        .data;
    expect(contact['last_name'], 'DURAND');
    expect(contact['email'], 'anne.durand@rodez.fr');
    final rodez = (await organisations()).firstWhere(
      (r) => r.data['siren'] == '211202023',
    );
    expect(contact['organisation_id'], rodez.id);
  });

  test('webhook sortant : envoi signé, nouvel essai après échec', () async {
    final created = await admin.post(
      '/api/v1/webhooks',
      const WebhookInput(
        name: 'Entrepôt de données',
        url: 'https://hooks.exemple.fr/voyaj',
        entities: ['organisations'],
        secret: 'signature',
      ).toJson(),
    );
    expect(created.status, 201, reason: '${created.body}');
    final webhook = WebhookInfo.fromJson(created.json);
    final hooks = server.server.services.webhooks;

    // Changements antérieurs à la création : non envoyés.
    delivered.clear();
    await hooks.deliverAll();
    expect(delivered, isEmpty);

    final orgId = newId();
    await admin.push([
      admin.op(orgId, {
        'name': 'Office de tourisme',
        'kind': 'autre',
        'status': 'contacte',
      }, entity: 'organisations'),
    ]);

    receiverStatus = 500;
    await hooks.deliverAll();
    expect(delivered, hasLength(1));
    var info = WebhookInfo.fromJson(
      ((await admin.get('/api/v1/webhooks')).list.single)
          as Map<String, dynamic>,
    );
    expect(info.failures, 1);
    expect(info.lastSeq, webhook.lastSeq);
    expect(info.lastError, contains('500'));

    // Nouvel essai (après modification, qui relance immédiatement).
    receiverStatus = 200;
    await admin.put(
      '/api/v1/webhooks/${webhook.id}',
      const WebhookInput(
        name: 'Entrepôt de données',
        url: 'https://hooks.exemple.fr/voyaj',
        entities: ['organisations'],
      ).toJson(),
    );
    delivered.clear();
    await hooks.deliverAll();
    final request = delivered.single;
    expect(
      verifySignature(
        'signature',
        request.bodyBytes,
        request.headers[signatureHeader],
      ),
      isTrue,
    );
    final payload = jsonDecode(request.body) as Map<String, dynamic>;
    expect(payload['event'], 'records.changed');
    final record = (payload['records'] as List).single as Map<String, dynamic>;
    expect(record['id'], orgId);
    expect((record['data'] as Map)['name'], 'Office de tourisme');
    info = WebhookInfo.fromJson(
      ((await admin.get('/api/v1/webhooks')).list.single)
          as Map<String, dynamic>,
    );
    expect(info.failures, 0);
    expect(info.lastSeq, greaterThan(webhook.lastSeq));

    expect((await admin.post('/api/v1/webhooks/${webhook.id}/ping')).json, {
      'status': 200,
    });
  });

  test('droits : réservé à la configuration des connecteurs', () async {
    final commercial = await server.userWithRoles('com@voyaj.test', [
      'commercial',
    ]);
    expect((await commercial.get('/api/v1/connectors')).status, 403);
    expect((await commercial.get('/api/v1/webhooks')).status, 403);
  });
}
