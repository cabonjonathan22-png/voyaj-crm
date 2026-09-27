@Tags(['integration'])
library;

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'support/test_server.dart';

/// Assistant IA (API Claude simulée).
void main() {
  if (integrationSkip != null) {
    test('intégration', () {}, skip: integrationSkip);
    return;
  }
  final requests = <Map<String, dynamic>>[];
  final headers = <Map<String, String>>[];
  var refuse = false;
  late TestServer server;

  setUpAll(
    () async => server = await TestServer.start(
      aiHttp: MockClient((request) async {
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        requests.add(body);
        headers.add(request.headers);
        final structured = (body['output_config'] as Map).containsKey('format');
        return http.Response.bytes(
          utf8.encode(
            jsonEncode({
              'type': 'message',
              'role': 'assistant',
              'stop_reason': refuse ? 'refusal' : 'end_turn',
              'content': [
                {'type': 'thinking', 'thinking': '', 'signature': 'x'},
                if (!refuse)
                  {
                    'type': 'text',
                    'text': structured
                        ? jsonEncode({
                            'subject': 'Navettes estivales 2027',
                            'body': 'Madame Durand,\n\nSuite à…',
                          })
                        : '- Client depuis 2026.\n- Relancer le devis.',
                  },
              ],
            }),
          ),
          200,
        );
      }),
      extraConfig: {'ANTHROPIC_API_KEY': 'cle-test'},
    ),
  );
  tearDownAll(() => server.close());

  test('synthèse, brouillon d’email, refus et droits', () async {
    final admin = await server.admin();
    expect((await admin.get('/api/v1/ai/status')).json['enabled'], isTrue);
    final orgId = newId();
    final contactId = newId();
    await admin.push([
      admin.op(orgId, {
        'name': 'Mairie de Rodez',
        'kind': 'commune',
        'status': 'client',
      }, entity: 'organisations'),
      admin.op(contactId, {
        'last_name': 'Durand',
        'first_name': 'Anne',
        'organisation_id': orgId,
      }, entity: 'contacts'),
      admin.op(newId(), {
        'kind': 'call',
        'subject': 'Budget navettes',
        'organisation_id': orgId,
        'contact_id': contactId,
      }, entity: 'activities'),
    ]);

    final summary = await admin.post('/api/v1/ai/organisations/$orgId/summary');
    expect(summary.status, 200, reason: '${summary.body}');
    expect(summary.json['text'], contains('Relancer'));
    final sent = requests.last;
    expect(sent['model'], 'claude-opus-5');
    expect(sent['thinking'], {'type': 'adaptive'});
    expect(sent['fallbacks'], 'default');
    expect(headers.last['x-api-key'], 'cle-test');
    expect(headers.last['anthropic-beta'], 'server-side-fallback-2026-07-01');
    final prompt = ((sent['messages'] as List).single as Map)['content'];
    expect(prompt, contains('Budget navettes'));

    final draft = await admin.post(
      '/api/v1/ai/email-draft',
      DraftEmailRequest(
        contactId: contactId,
        instructions: 'proposer un rendez-vous',
      ).toJson(),
    );
    expect(draft.status, 200, reason: '${draft.body}');
    expect(EmailDraft.fromJson(draft.json).subject, 'Navettes estivales 2027');
    expect(
      ((requests.last['output_config'] as Map)['format'] as Map)['type'],
      'json_schema',
    );

    refuse = true;
    final refused = await admin.post('/api/v1/ai/organisations/$orgId/summary');
    expect(refused.status, 502);
    refuse = false;

    final reader = await server.userWithRoles('ia@voyaj.test', ['lecture']);
    expect(
      (await reader.post('/api/v1/ai/organisations/$orgId/summary')).status,
      403,
    );
  });
}
