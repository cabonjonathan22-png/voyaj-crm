import 'dart:convert';

import 'package:connectors/connectors.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

http.Response _json(Object body, {int status = 200}) =>
    http.Response.bytes(utf8.encode(jsonEncode(body)), status);

void main() {
  group('Mappage', () {
    const mapping = ConnectorMapping(
      entity: 'organisations',
      refPath: 'uid',
      fields: [
        FieldMapping(target: 'name', source: 'nom', transform: 'trim'),
        FieldMapping(target: 'siren', source: 'ids.siren', transform: 'digits'),
        FieldMapping(target: 'population', source: 'pop'),
        FieldMapping(target: 'kind', constant: 'commune'),
        FieldMapping(target: 'status', constant: 'a_prospecter'),
        FieldMapping(target: 'collected_at', source: 'date', transform: 'date'),
      ],
    );

    test('chemins, transformations et types', () {
      final mapped = mapRecord(
        {
          'uid': 42,
          'nom': '  Mairie de Rodez ',
          'ids': {'siren': '212 202 023'},
          'pop': '24 000',
        },
        mapping.copyWith(fields: mapping.fields.take(5).toList()),
        SyncEntities.organisations,
      );
      expect(mapped.problems, isEmpty);
      expect(mapped.ref, '42');
      expect(mapped.fields, {
        'name': 'Mairie de Rodez',
        'siren': '212202023',
        'population': 24000,
        'kind': 'commune',
        'status': 'a_prospecter',
      });
    });

    test('problèmes : identifiant absent, champ protégé, valeur refusée', () {
      final mapped = mapRecord(
        {'nom': 'X', 'pop': 'beaucoup'},
        mapping.copyWith(
          fields: [
            ...mapping.fields,
            const FieldMapping(target: 'kind', constant: 'planete'),
          ],
        ),
        SyncEntities.organisations,
      );
      expect(mapped.ref, isNull);
      expect(
        mapped.problems,
        containsAll([
          'Identifiant absent (uid).',
          'Champ inconnu : collected_at.',
          'population : nombre attendu (« beaucoup »).',
          'kind : valeur « planete » refusée.',
        ]),
      );
    });

    test('transformations', () {
      expect(transformValue('12/03/2026', 'date'), '2026-03-12');
      expect(transformValue(1767225600, 'date'), '2026-01-01');
      expect(transformValue('1 234,50 €', 'cents'), 123450);
      expect(transformValue('Oui', 'boolean'), isTrue);
      expect(transformValue('  ', 'upper'), isNull);
      expect(
        () => transformValue('peut-être', 'boolean'),
        throwsFormatException,
      );
    });

    test('chemins disponibles', () {
      expect(
        recordPaths([
          {
            'id': 1,
            'adresse': {'ville': 'Rodez', 'cp': '12000'},
            'contacts': [
              {'email': 'a@b.fr'},
            ],
          },
        ]),
        ['adresse.cp', 'adresse.ville', 'contacts', 'contacts.0.email', 'id'],
      );
      expect(
        readPath({
          'a': [1, 2],
        }, 'a.1'),
        2,
      );
      expect(
        readPath({
          'a': [1, 2],
        }, 'a.5'),
        isNull,
      );
    });
  });

  group('Sources HTTP', () {
    test(
      'REST : liste imbriquée, pagination par numéro, en-tête secret',
      () async {
        final requests = <http.Request>[];
        final source = RestSource(
          {
            'url': 'https://api.exemple.fr/v1/communes?dep=12',
            'records_path': 'data.items',
            'page_param': 'page',
            'auth_header': 'x-api-key',
          },
          secret: 'cle',
          client: MockClient((request) async {
            requests.add(request);
            final page = int.parse(request.url.queryParameters['page']!);
            return _json({
              'data': {
                'items': [
                  if (page < 3) {'id': page, 'nom': 'Commune $page'},
                ],
              },
            });
          }),
        );
        final records = await source.fetch();
        expect(records.map((r) => r['id']), [1, 2]);
        expect(requests.first.headers['x-api-key'], 'cle');
        expect(requests.first.url.queryParameters['dep'], '12');
        expect(requests, hasLength(3));
      },
    );

    test('REST : lien vers la page suivante et erreurs', () async {
      final source = RestSource(
        {'url': 'https://api.exemple.fr/items', 'next_path': 'next'},
        client: MockClient(
          (request) async => request.url.path == '/items'
              ? _json({
                  'next': '/items2',
                  'results': [
                    {'id': 'a'},
                  ],
                })
              : _json({
                  'next': null,
                  'results': [
                    {'id': 'b'},
                  ],
                }),
        ),
      );
      await expectLater(source.fetch(), throwsA(isA<ConnectorException>()));
      final ok = RestSource(
        {
          'url': 'https://api.exemple.fr/items',
          'next_path': 'next',
          'records_path': 'results',
        },
        client: MockClient(
          (request) async => request.url.path == '/items'
              ? _json({
                  'next': '/items2',
                  'results': [
                    {'id': 'a'},
                  ],
                })
              : _json({
                  'results': [
                    {'id': 'b'},
                  ],
                }),
        ),
      );
      expect((await ok.fetch()).map((r) => r['id']), ['a', 'b']);
      final denied = RestSource({
        'url': 'https://api.exemple.fr/items',
      }, client: MockClient((_) async => _json({}, status: 401)));
      await expectLater(
        denied.fetch(),
        throwsA(
          isA<ConnectorException>().having(
            (e) => e.message,
            'message',
            contains('accès refusé'),
          ),
        ),
      );
    });

    test('Supabase : PostgREST, filtres et clé', () async {
      late http.Request seen;
      final source = SupabaseSource(
        {
          'url': 'https://abcd.supabase.co',
          'table': 'mairies',
          'filter': 'departement=eq.12',
        },
        secret: 'anon',
        client: MockClient((request) async {
          seen = request;
          return _json([
            {'id': 1, 'nom': 'Rodez'},
          ]);
        }),
      );
      final records = await source.fetch();
      expect(records.single['nom'], 'Rodez');
      expect(seen.url.path, '/rest/v1/mairies');
      expect(seen.url.queryParameters['departement'], 'eq.12');
      expect(seen.headers['apikey'], 'anon');
      expect(seen.headers['authorization'], 'Bearer anon');
    });

    test('Firestore : documents typés et pages', () async {
      final source = FirestoreSource(
        {'project_id': 'voyaj-demo', 'collection': 'festivals'},
        secret: 'cle-web',
        client: MockClient((request) async {
          expect(request.url.queryParameters['key'], 'cle-web');
          final second = request.url.queryParameters['pageToken'] == 't2';
          return _json({
            'documents': [
              {
                'name':
                    'projects/p/databases/(default)/documents/festivals/'
                    '${second ? 'f2' : 'f1'}',
                'fields': {
                  'nom': {'stringValue': 'Festival ${second ? 2 : 1}'},
                  'jauge': {'integerValue': '1500'},
                  'gratuit': {'booleanValue': true},
                  'lieu': {
                    'mapValue': {
                      'fields': {
                        'ville': {'stringValue': 'Millau'},
                      },
                    },
                  },
                  'tags': {
                    'arrayValue': {
                      'values': [
                        {'stringValue': 'musique'},
                      ],
                    },
                  },
                },
              },
            ],
            if (!second) 'nextPageToken': 't2',
          });
        }),
      );
      final records = await source.fetch();
      expect(records, hasLength(2));
      expect(records.first, {
        'id': 'f1',
        'nom': 'Festival 1',
        'jauge': 1500,
        'gratuit': true,
        'lieu': {'ville': 'Millau'},
        'tags': ['musique'],
      });
    });
  });

  group('Bases de données', () {
    test('MySQL : requête SELECT unique exigée', () async {
      final source = MysqlSource({
        'host': 'localhost',
        'user': 'lecture',
        'query': 'DELETE FROM clients',
      });
      await expectLater(
        source.fetch(),
        throwsA(
          isA<ConnectorException>().having(
            (e) => e.message,
            'message',
            contains('SELECT'),
          ),
        ),
      );
    });

    test('MongoDB : chaîne de connexion et filtre vérifiés', () async {
      await expectLater(
        MongoSource({'collection': 'clients'}).fetch(),
        throwsA(isA<ConnectorException>()),
      );
      await expectLater(
        MongoSource({
          'collection': 'clients',
          'filter': '{pas du json',
        }, connectionString: 'mongodb://localhost/crm').fetch(),
        throwsA(
          isA<ConnectorException>().having(
            (e) => e.message,
            'message',
            contains('filtre'),
          ),
        ),
      );
    });
  });

  test('signature des webhooks', () {
    final body = utf8.encode('{"a":1}');
    final signature = signPayload('secret', body);
    expect(signature, startsWith('sha256='));
    expect(verifySignature('secret', body, signature), isTrue);
    expect(verifySignature('autre', body, signature), isFalse);
    expect(verifySignature('secret', body, null), isFalse);
  });
}
