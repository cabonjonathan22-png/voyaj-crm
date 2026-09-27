@Tags(['integration'])
library;

import 'dart:convert';

import 'package:fr_public_data/fr_public_data.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'support/test_server.dart';

/// Veille des appels d'offres (BOAMP simulé).
void main() {
  if (integrationSkip != null) {
    test('intégration', () {}, skip: integrationSkip);
    return;
  }
  final queries = <Uri>[];
  late TestServer server;

  setUpAll(
    () async => server = await TestServer.start(
      boampClient: BoampClient(
        httpClient: MockClient((request) async {
          queries.add(request.url);
          return http.Response.bytes(
            utf8.encode(
              jsonEncode({
                'results': [
                  {
                    'idweb': '26-104512',
                    'objet': 'Navettes estivales vers les sites touristiques',
                    'nomacheteur': 'Communauté de communes du Lévézou',
                    'dateparution': '2026-09-21',
                    'datelimitereponse': '2026-10-20T12:00:00+02:00',
                    'code_departement': ['12'],
                    'type_marche': ['SERVICES'],
                  },
                ],
              }),
            ),
            200,
          );
        }),
      ),
    ),
  );
  tearDownAll(() => server.close());

  test('configuration, recherche sans doublon, suivi', () async {
    final admin = await server.admin();
    expect((await admin.post('/api/v1/tenders/run')).status, 400);
    final invalid = await admin.put(
      '/api/v1/tenders/watch',
      const TenderWatch(enabled: true).toJson(),
    );
    expect(invalid.status, 422);

    final watch = TenderWatch.fromJson(
      (await admin.put(
        '/api/v1/tenders/watch',
        const TenderWatch(
          enabled: true,
          keywords: ['transport', ' navette ', ''],
          departements: ['12', 'xx'],
        ).toJson(),
      )).json,
    );
    expect(watch.keywords, ['transport', 'navette']);
    expect(watch.departements, ['12']);

    expect((await admin.post('/api/v1/tenders/run')).json['added'], 1);
    expect((await admin.post('/api/v1/tenders/run')).json['added'], 0);
    expect(
      queries.last.queryParameters['where'],
      contains('search("navette")'),
    );

    final tender = TenderInfo.fromJson(
      (await admin.get('/api/v1/tenders')).list.single as Map<String, dynamic>,
    );
    expect(tender.buyer, 'Communauté de communes du Lévézou');
    expect(tender.status, 'new');

    final dealId = newId();
    final updated = await admin.patch(
      '/api/v1/tenders/${tender.id}',
      UpdateTenderRequest(status: 'followed', dealId: dealId).toJson(),
    );
    expect(updated.json['deal_id'], dealId);
    expect((await admin.get('/api/v1/tenders?status=new')).list, isEmpty);

    final reader = await server.userWithRoles('veille@voyaj.test', ['lecture']);
    expect((await reader.get('/api/v1/tenders')).status, 200);
    expect(
      (await reader.patch(
        '/api/v1/tenders/${tender.id}',
        const UpdateTenderRequest(status: 'ignored').toJson(),
      )).status,
      403,
    );
  });
}
