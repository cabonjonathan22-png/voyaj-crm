@Tags(['integration'])
library;

import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'support/test_server.dart';

/// Abonnement d'agenda (flux ICS personnel).
void main() {
  if (integrationSkip != null) {
    test('intégration', () {}, skip: integrationSkip);
    return;
  }
  late TestServer server;

  setUpAll(
    () async => server = await TestServer.start(
      extraConfig: {'VOYAJ_PUBLIC_URL': 'https://crm.voyaj.test'},
    ),
  );
  tearDownAll(() => server.close());

  test('flux ICS : activités de l’utilisateur, jeton révocable', () async {
    final admin = await server.admin();
    final me = (await admin.get('/api/v1/auth/me')).json['id'] as String;
    final other = await server.userWithRoles('autre@voyaj.test', [
      'commercial',
    ]);
    final otherId = (await other.get('/api/v1/auth/me')).json['id'] as String;
    final orgId = newId();
    final soon = DateTime.now().toUtc().add(const Duration(days: 2));
    await admin.push([
      admin.op(orgId, {
        'name': 'Mairie de Rodez',
        'kind': 'commune',
        'status': 'client',
      }, entity: 'organisations'),
      admin.op(newId(), {
        'kind': 'meeting',
        'subject': 'Présentation, navettes',
        'organisation_id': orgId,
        'owner_id': me,
        'starts_at': soon.toIso8601String(),
        'ends_at': soon.add(const Duration(hours: 1)).toIso8601String(),
      }, entity: 'activities'),
      admin.op(newId(), {
        'kind': 'task',
        'subject': 'Tâche de quelqu’un d’autre',
        'assignee_id': otherId,
        'owner_id': me,
        'due_at': soon.toIso8601String(),
      }, entity: 'activities'),
    ]);

    expect((await admin.get('/api/v1/calendar/feed')).json['active'], isFalse);
    final url =
        (await admin.post('/api/v1/calendar/feed')).json['url'] as String;
    expect(url, startsWith('https://crm.voyaj.test/api/v1/calendar/'));
    expect((await admin.get('/api/v1/calendar/feed')).json['active'], isTrue);

    final path = Uri.parse(url).path;
    final response = await http.get(server.baseUri.resolve(path));
    expect(response.statusCode, 200);
    expect(response.headers['content-type'], startsWith('text/calendar'));
    expect(response.body, contains(r'SUMMARY:Présentation\, navettes'));
    expect(response.body, contains('DESCRIPTION:Mairie de Rodez'));
    expect(response.body, isNot(contains('quelqu’un d’autre')));

    // Nouveau jeton : l'ancienne URL ne fonctionne plus.
    await admin.post('/api/v1/calendar/feed');
    expect((await http.get(server.baseUri.resolve(path))).statusCode, 404);
    await admin.delete('/api/v1/calendar/feed');
    expect((await admin.get('/api/v1/calendar/feed')).json['active'], isFalse);
  });
}
