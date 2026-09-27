@Tags(['integration'])
library;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:voyaj_server/voyaj_server.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'support/test_server.dart';

/// Facturation (Phase 5) : émission atomique et numérotation continue,
/// verrouillage des documents émis, PDF, FEC, TVA et dépôt Chorus Pro.
void main() {
  if (integrationSkip != null) {
    test('intégration', () {}, skip: integrationSkip);
    return;
  }
  final chorusRequests = <http.Request>[];
  late TestServer server;
  late ApiClient admin;
  final year = DateTime.now().year;
  final orgId = newId();

  setUpAll(() async {
    server = await TestServer.start(
      chorusClient: ChorusProClient(
        httpClient: MockClient((request) async {
          chorusRequests.add(request);
          if (request.url.path.endsWith('/oauth/token')) {
            return http.Response(jsonEncode({'access_token': 'jeton'}), 200);
          }
          return http.Response(
            jsonEncode({'codeRetour': 0, 'numeroFluxDepot': 'FLUX-42'}),
            200,
          );
        }),
      ),
    );
    admin = await server.admin();
    final result = (await admin.push([
      admin.op(orgId, {
        'name': 'Communauté de communes du Lévézou',
        'kind': OrganisationKind.epci.key,
        'status': OrganisationStatus.client.key,
        'siren': '241200567',
        'siret': '24120056700016',
        'address': '1 place de la Mairie',
        'postal_code': '12290',
        'city': 'Pont-de-Salars',
      }, entity: 'organisations'),
    ])).results.single;
    expect(result.status, OpStatus.applied, reason: '${result.issues}');
  });
  tearDownAll(() => server.close());

  Map<String, Object?> line(String description, int cents, {int vat = 1000}) =>
      {
        'description': description,
        'quantity': 2,
        'unit_price_cents': cents,
        'vat_rate': vat,
      };

  Future<String> draft(
    String kind, {
    List<Map<String, Object?>>? lines,
    String? originalId,
  }) async {
    final id = newId();
    final result = (await admin.push([
      admin.op(id, {
        'kind': kind,
        'status': DocumentStatus.draft.key,
        'organisation_id': orgId,
        'subject': 'Transport scolaire',
        'lines': lines ?? [line('Navette', 10000)],
        'original_invoice_id': ?originalId,
      }, entity: 'invoices'),
    ])).results.single;
    expect(result.status, OpStatus.applied, reason: '${result.issues}');
    return id;
  }

  Future<Map<String, dynamic>> record(String id) async {
    final pulled = await admin.pull(0);
    return pulled.records.lastWhere((r) => r.id == id).data;
  }

  Future<ApiResponse> issue(String id, [ApiClient? client]) =>
      (client ?? admin).post('/api/v1/billing/documents/$id/issue');

  test('émission refusée sans identité du vendeur', () async {
    final id = await draft(DocumentKind.invoice.key);
    final response = await issue(id);
    expect(response.status, 422);
    expect(jsonEncode(response.body), contains('SIREN'));
  });

  test('paramètres : secrets chiffrés, jamais renvoyés', () async {
    final saved = await admin.put(
      '/api/v1/billing/settings',
      const BillingSettings(
        legalName: 'Voyaj SAS',
        address: '3 rue du Port',
        postalCode: '12000',
        city: 'Rodez',
        siren: '123456782',
        siret: '12345678200015',
        vatNumber: 'FR40123456782',
        iban: 'FR7630006000011234567890189',
        chorusEnabled: true,
        chorusLogin: 'TECH_voyaj@cpro.fr',
        pisteClientId: 'client-piste',
        chorusPassword: 'motdepasse',
        pisteClientSecret: 'secret-piste',
      ).toJson(),
    );
    expect(saved.status, 200, reason: '${saved.body}');
    final settings = BillingSettings.fromJson(
      (await admin.get('/api/v1/billing/settings')).json,
    );
    expect(settings.chorusConfigured, isTrue);
    expect(settings.chorusPassword, isNull);
    expect(settings.pisteClientSecret, isNull);

    // Secrets non renvoyés : conservés si laissés vides.
    await admin.put(
      '/api/v1/billing/settings',
      settings.copyWith(footer: 'Merci de votre confiance.').toJson(),
    );
    final again = BillingSettings.fromJson(
      (await admin.get('/api/v1/billing/settings')).json,
    );
    expect(again.chorusConfigured, isTrue);
    expect(again.footer, 'Merci de votre confiance.');
  });

  test('numérotation continue par type, instantanés et PDF', () async {
    final first = await draft(
      DocumentKind.invoice.key,
      lines: [line('Navette', 10000), line('Guide', 5000, vat: 2000)],
    );
    final second = await draft(DocumentKind.invoice.key);
    final quote = await draft(DocumentKind.quote.key);

    final numbers = <String>[];
    for (final id in [first, second, quote]) {
      final response = await issue(id);
      expect(response.status, 200, reason: '${response.body}');
      numbers.add(response.json['number'] as String);
    }
    expect(numbers, ['F$year-00001', 'F$year-00002', 'D$year-00001']);

    final data = await record(first);
    expect(data['status'], DocumentStatus.issued.key);
    expect(data['total_ht_cents'], 30000);
    expect(data['total_vat_cents'], 4000);
    expect(data['total_ttc_cents'], 34000);
    expect((data['seller'] as Map)['name'], 'Voyaj SAS');
    expect((data['buyer'] as Map)['siret'], '24120056700016');
    expect(data['issue_date'], isNotNull);
    expect(data['due_date'], isNotNull);
    expect(await record(quote), containsPair('status', 'sent'));

    expect((await issue(first)).status, 409);

    final pdf = await http.get(
      server.baseUri.resolve('/api/v1/billing/documents/$first/pdf'),
      headers: {'authorization': 'Bearer ${admin.tokens!.accessToken}'},
    );
    expect(pdf.statusCode, 200);
    expect(ascii.decode(pdf.bodyBytes.sublist(0, 5)), '%PDF-');
    expect(pdf.headers['content-disposition'], contains('F$year-00001.pdf'));
  });

  test('document émis verrouillé ; état toujours modifiable', () async {
    final id = await draft(DocumentKind.invoice.key);
    expect((await issue(id)).status, 200);
    final data = await record(id);
    final version = data['version'] as int? ?? 0;
    final results = (await admin.push([
      admin.op(
        id,
        {
          'lines': [line('Autre', 1)],
        },
        entity: 'invoices',
        baseVersion: version,
      ),
      admin.op(id, {'number': 'F1999-00001'}, entity: 'invoices'),
      admin.op(id, {'status': DocumentStatus.paid.key}, entity: 'invoices'),
    ])).results;
    expect(results.map((r) => r.status), [
      OpStatus.invalid,
      OpStatus.invalid,
      OpStatus.applied,
    ]);
    expect((await record(id))['status'], DocumentStatus.paid.key);
  });

  test('avoir, paiement, FEC et TVA', () async {
    final invoice = await draft(DocumentKind.invoice.key);
    final number = (await issue(invoice)).json['number'] as String;
    final credit = await draft(
      DocumentKind.creditNote.key,
      lines: [line('Navette annulée', 5000)],
      originalId: invoice,
    );
    final creditResponse = await issue(credit);
    expect(creditResponse.status, 200, reason: '${creditResponse.body}');
    expect(creditResponse.json['number'], 'A$year-00001');

    final today = DateTime.now().toIso8601String().substring(0, 10);
    final payment = (await admin.push([
      admin.op(newId(), {
        'invoice_id': invoice,
        'amount_cents': 22000,
        'paid_on': today,
        'method': PaymentMethod.treasury.key,
      }, entity: 'payments'),
    ])).results.single;
    expect(payment.status, OpStatus.applied, reason: '${payment.issues}');

    final fec = await http.get(
      server.baseUri.resolve('/api/v1/billing/fec?year=$year'),
      headers: {'authorization': 'Bearer ${admin.tokens!.accessToken}'},
    );
    expect(fec.statusCode, 200);
    expect(
      fec.headers['content-disposition'],
      contains('123456782FEC${year}1231.txt'),
    );
    final body = utf8.decode(fec.bodyBytes);
    expect(body, startsWith('JournalCode\t'));
    expect(body, contains(number));
    expect(body, contains('A$year-00001'));

    final vat = VatReport.fromJson(
      (await admin.get('/api/v1/billing/vat?from=$year-01-01&to=$year-12-31'))
          .json,
    );
    final debit10 = vat.debits.firstWhere((r) => r.rate == 1000);
    // 10 % : quatre factures à 20 000 HT émises, avoir de 10 000.
    expect(debit10.baseCents, 4 * 20000 - 10000);
    expect(debit10.vatCents, 4 * 2000 - 1000);
    expect(vat.receipts.single.rate, 1000);
    expect(vat.receipts.single.baseCents, 20000);
    expect(vat.receipts.single.vatCents, 2000);
  });

  test('dépôt Chorus Pro', () async {
    final id = await draft(DocumentKind.invoice.key);
    expect(
      (await admin.post('/api/v1/billing/documents/$id/chorus')).status,
      400,
    );
    expect((await issue(id)).status, 200);
    final response = await admin.post('/api/v1/billing/documents/$id/chorus');
    expect(response.status, 200, reason: '${response.body}');
    expect(response.json['flux'], 'FLUX-42');
    final deposit = chorusRequests.last;
    expect(deposit.url.path, '/cpro/factures/v1/deposer/flux');
    expect(
      utf8.decode(base64.decode(deposit.headers['cpro-account']!)),
      'TECH_voyaj@cpro.fr:motdepasse',
    );
    expect(
      (jsonDecode(deposit.body) as Map)['syntaxeFlux'],
      'IN_DP_E2_CII_FACTURX',
    );
    final data = await record(id);
    expect(data['chorus_flux'], 'FLUX-42');
    expect(data['chorus_status'], 'deposited');
    expect(
      (await admin.post('/api/v1/billing/documents/$id/chorus')).status,
      409,
    );
  });

  test('droits : lecture seule', () async {
    final reader = await server.userWithRoles('compta@voyaj.test', ['lecture']);
    final id = await draft(DocumentKind.invoice.key);
    expect((await issue(id, reader)).status, 403);
    expect((await reader.get('/api/v1/billing/settings')).status, 200);
    expect(
      (await reader.put(
        '/api/v1/billing/settings',
        const BillingSettings().toJson(),
      )).status,
      403,
    );
    expect((await reader.get('/api/v1/billing/fec?year=$year')).status, 403);
  });
}
