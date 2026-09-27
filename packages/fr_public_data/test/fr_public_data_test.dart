import 'dart:convert';
import 'dart:io';

import 'package:fr_public_data/fr_public_data.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

Object? fixture(String name) =>
    jsonDecode(File('test/fixtures/$name.json').readAsStringSync());

void main() {
  group('geo.api.gouv.fr', () {
    test('régions et départements', () {
      final regions = parseRegions(fixture('regions'));
      expect(regions.first.fields, {
        'name': 'Occitanie',
        'kind': 'region',
        'region_code': '76',
      });
      expect(regions.first.matchField, 'region_code');

      final departements = parseDepartements(
        fixture('departements'),
        scope: {'12', '2A'},
      );
      expect(departements.map((d) => d.ref), ['12', '2A']);
      expect(departements.first.parent!.value, '76');
      expect(departements.first.parent!.kinds, {'region'});
    });

    test('EPCI : SIREN, métropole, centre, périmètre', () {
      final all = parseEpcis(fixture('epcis'));
      expect(all, hasLength(3));
      final lille = all.firstWhere((e) => e.ref == '200093201');
      expect(lille.kind, 'metropole');
      final rodez = all.first;
      expect(rodez.fields['siren'], '241200567');
      expect(rodez.fields['latitude'], 44.3572);
      expect(rodez.fields['longitude'], 2.5705);
      expect(rodez.fields['population'], 56011);
      expect(rodez.parent!.field, 'departement_code');
      expect(parseEpcis(fixture('epcis'), scope: {'12'}), hasLength(2));
    });

    test('communes rattachées à leur EPCI', () {
      final communes = parseCommunes(fixture('communes_12'));
      final rodez = communes.first;
      expect(rodez.fields, containsPair('insee_code', '12202'));
      expect(rodez.fields, containsPair('postal_code', '12000'));
      expect(rodez.fields, containsPair('city', 'Rodez'));
      expect(rodez.matchField, 'insee_code');
      expect(rodez.parent!.value, '241200567');
      expect(rodez.parent!.kinds, containsAll(['epci', 'metropole']));
    });

    test('les fiches produites respectent les règles des organisations', () {
      for (final record in [
        ...parseRegions(fixture('regions')),
        ...parseDepartements(fixture('departements')),
        ...parseEpcis(fixture('epcis')),
        ...parseCommunes(fixture('communes_12')),
        ...parseAoms(fixture('aoms')),
        ...parseFestivals(fixture('festivals')),
      ]) {
        final full = {...record.fields, 'status': 'a_prospecter'};
        expect(SyncEntities.organisations.checkFields(full), isEmpty);
        expect(
          validateOrganisationRecord(full),
          isEmpty,
          reason: '${record.ref} ${record.fields}',
        );
      }
    });
  });

  test('AOM : variantes de nommage et périmètre', () {
    final aoms = parseAoms(fixture('aoms'));
    expect(aoms.map((a) => a.fields['name']), [
      'Rodez Agglomération',
      'Région Occitanie',
      'SMT Artois-Gohelle',
    ]);
    expect(aoms.first.fields['kind'], 'aom');
    expect(aoms.first.matchField, 'siren');
    expect(aoms.last.fields['departement_code'], '62');
    // AOM sans département (régions) conservées quel que soit le périmètre.
    expect(parseAoms(fixture('aoms'), scope: {'12'}), hasLength(2));
    expect(
      () => parseAoms('pas du geojson'),
      throwsA(isA<PublicDataException>()),
    );
  });

  test('festivals : coordonnées, site, email invalide ignoré', () {
    final festivals = parseFestivals(fixture('festivals'));
    expect(festivals, hasLength(2));
    final millau = festivals.first;
    expect(millau.ref, 'FEST_12145_1');
    expect(millau.fields['website'], 'https://www.millaujazz.fr');
    expect(millau.fields['departement_code'], '12');
    expect(millau.fields['latitude'], 44.0986);
    expect(millau.fields['description'], contains('Musique'));
    expect(festivals.last.fields.containsKey('email'), isFalse);
    expect(parseFestivals(fixture('festivals'), scope: {'19'}), hasLength(1));
  });

  test('département d’un code postal ou INSEE', () {
    expect(departementOf('12100'), '12');
    expect(departementOf('97411'), '974');
    expect(departementOf('2A004'), '2A');
    expect(departementOf('x'), isNull);
  });

  group('client HTTP', () {
    test('communes : une requête par département du périmètre', () async {
      final requested = <Uri>[];
      final client = PublicDataClient(
        httpClient: MockClient((request) async {
          requested.add(request.url);
          return http.Response.bytes(
            utf8.encode(
              File('test/fixtures/communes_12.json').readAsStringSync(),
            ),
            200,
          );
        }),
      );
      final records = await client.fetch(
        PublicSource.communes,
        departements: ['12', '81'],
      );
      expect(records, hasLength(6));
      expect(requested.map((u) => u.path), [
        '/departements/12/communes',
        '/departements/81/communes',
      ]);
      expect(requested.first.queryParameters['fields'], contains('codeEpci'));
    });

    test('erreur HTTP : message lisible', () async {
      final client = PublicDataClient(
        httpClient: MockClient((_) async => http.Response('', 503)),
      );
      await expectLater(
        client.fetch(PublicSource.regions),
        throwsA(
          isA<PublicDataException>().having(
            (e) => e.message,
            'message',
            'geo.api.gouv.fr a répondu 503.',
          ),
        ),
      );
    });
  });
}
