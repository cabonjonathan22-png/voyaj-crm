@Tags(['integration'])
library;

import 'dart:convert';

import 'package:connectors/connectors.dart' show signPayload;
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'support/test_server.dart';

/// Signature électronique des devis (Yousign simulé).
void main() {
  if (integrationSkip != null) {
    test('intégration', () {}, skip: integrationSkip);
    return;
  }
  final calls = <String>[];
  late TestServer server;

  setUpAll(
    () async => server = await TestServer.start(
      yousignHttp: MockClient((request) async {
        calls.add('${request.method} ${request.url.path}');
        final path = request.url.path;
        if (path.endsWith('/documents/download')) {
          return http.Response.bytes(utf8.encode('%PDF-1.7 devis signé'), 200);
        }
        final body = switch (path) {
          '/v3/signature_requests' => {'id': 'sr-1', 'status': 'draft'},
          '/v3/signature_requests/sr-1' => {'id': 'sr-1', 'status': 'ongoing'},
          _ => {'id': 'x', 'status': 'ongoing'},
        };
        return http.Response(jsonEncode(body), 201);
      }),
      extraConfig: {
        'VOYAJ_YOUSIGN_API_KEY': 'cle-yousign',
        'VOYAJ_YOUSIGN_WEBHOOK_SECRET': 'secret-webhook',
      },
    ),
  );
  tearDownAll(() => server.close());

  test('devis envoyé, signé (webhook), accepté et PDF joint', () async {
    final admin = await server.admin();
    await admin.put(
      '/api/v1/billing/settings',
      const BillingSettings(
        legalName: 'Voyaj SAS',
        siren: '123456782',
      ).toJson(),
    );
    final orgId = newId();
    final contactId = newId();
    final quoteId = newId();
    await admin.push([
      admin.op(orgId, {
        'name': 'Mairie de Rodez',
        'kind': 'commune',
        'status': 'client',
      }, entity: 'organisations'),
      admin.op(contactId, {
        'last_name': 'Durand',
        'first_name': 'Anne',
        'email': 'anne.durand@rodez.fr',
        'organisation_id': orgId,
      }, entity: 'contacts'),
      admin.op(quoteId, {
        'kind': 'quote',
        'status': 'draft',
        'organisation_id': orgId,
        'lines': [
          {
            'description': 'Navette',
            'quantity': 1,
            'unit_price_cents': 10000,
            'vat_rate': 1000,
          },
        ],
      }, entity: 'invoices'),
    ]);
    expect(
      (await admin.post('/api/v1/billing/documents/$quoteId/issue')).status,
      200,
    );

    final sent = await admin.post(
      '/api/v1/billing/documents/$quoteId/signatures',
      SendSignatureRequest(contactId: contactId).toJson(),
    );
    expect(sent.status, 201, reason: '${sent.body}');
    final signature = SignatureInfo.fromJson(sent.json);
    expect(signature.status, 'ongoing');
    expect(signature.signerEmail, 'anne.durand@rodez.fr');
    expect(calls, [
      'POST /v3/signature_requests',
      'POST /v3/signature_requests/sr-1/documents',
      'POST /v3/signature_requests/sr-1/signers',
      'POST /v3/signature_requests/sr-1/activate',
    ]);

    final event = utf8.encode(
      jsonEncode({
        'event_name': 'signature_request.done',
        'data': {
          'signature_request': {'id': 'sr-1', 'status': 'done'},
        },
      }),
    );
    Future<http.Response> hook(String signature) => http.post(
      server.baseUri.resolve('/api/v1/signatures/webhook'),
      headers: {
        'content-type': 'application/json',
        'x-yousign-signature-256': signature,
      },
      body: event,
    );
    expect((await hook(signPayload('faux', event))).statusCode, 401);
    expect((await hook(signPayload('secret-webhook', event))).statusCode, 204);

    final list = (await admin.get(
      '/api/v1/billing/documents/$quoteId/signatures',
    )).list;
    final done = SignatureInfo.fromJson(list.single as Map<String, dynamic>);
    expect(done.status, 'done');
    expect(done.signedFileId, isNotNull);

    final records = (await admin.pull(0)).records;
    expect(
      records.lastWhere((r) => r.id == quoteId).data['status'],
      DocumentStatus.accepted.key,
    );
    final attachment = records.lastWhere((r) => r.entity == 'attachments').data;
    expect(attachment['file_name'], endsWith('-signé.pdf'));
    expect(attachment['organisation_id'], orgId);
  });
}
