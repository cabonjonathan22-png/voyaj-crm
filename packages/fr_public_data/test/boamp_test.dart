import 'dart:convert';
import 'dart:io';

import 'package:fr_public_data/fr_public_data.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  final fixture = File('test/fixtures/boamp.json').readAsStringSync();

  test('avis du BOAMP : champs et variantes', () {
    final notices = parseBoamp(jsonDecode(fixture));
    expect(notices, hasLength(2));
    final first = notices.first;
    expect(first.ref, '26-104512');
    expect(first.buyer, 'Communauté de communes du Lévézou');
    expect(first.publishedOn, '2026-09-21');
    expect(first.deadline, DateTime.utc(2026, 10, 20, 10));
    expect(first.departements, ['12']);
    expect(first.nature, 'SERVICES');
    expect(first.descriptors, contains('Tourisme'));
    final second = notices.last;
    expect(second.departements, ['12']);
    expect(second.url, contains('26-103877'));
  });

  test('requête : mots-clés, départements, date', () async {
    late Uri seen;
    final client = BoampClient(
      httpClient: MockClient((request) async {
        seen = request.url;
        return http.Response.bytes(utf8.encode(fixture), 200);
      }),
    );
    final notices = await client.search(
      keywords: ['transport', 'navette'],
      departements: ['12', '81'],
      since: DateTime(2026, 9),
    );
    expect(notices, hasLength(2));
    expect(
      seen.queryParameters['where'],
      "dateparution >= date'2026-09-01' AND "
      '(search("transport") OR search("navette")) AND '
      'code_departement IN ("12", "81")',
    );
    expect(seen.queryParameters['order_by'], 'dateparution DESC');
  });
}
