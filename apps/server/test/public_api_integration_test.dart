@Tags(['integration'])
library;

import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'support/test_server.dart';

/// API publique : jetons d'API personnels et points d'accès `/records`.
void main() {
  if (integrationSkip != null) {
    test('intégration', () {}, skip: integrationSkip);
    return;
  }
  late TestServer server;

  setUpAll(() async => server = await TestServer.start());
  tearDownAll(() => server.close());

  ApiClient withToken(String token) => ApiClient(server.baseUri)
    ..useTokens(
      AuthTokens(
        sessionId: newId(),
        accessToken: token,
        accessExpiresAt: DateTime.now().add(const Duration(hours: 1)),
        refreshToken: 'x',
        refreshExpiresAt: DateTime.now().add(const Duration(hours: 1)),
      ),
    );

  test('jeton : permissions limitées, création, lecture, révocation', () async {
    final admin = await server.admin();
    final created = await admin.post(
      '/api/v1/auth/api-tokens',
      const CreateApiTokenRequest(
        name: 'Intégration ERP',
        permissions: ['organisation.read', 'organisation.write'],
        expiresInDays: 30,
      ).toJson(),
    );
    expect(created.status, 201, reason: '${created.body}');
    final token = CreatedApiToken.fromJson(created.json);
    expect(token.token, startsWith(apiTokenPrefix));
    expect(
      ((await admin.get('/api/v1/auth/api-tokens')).list.single
          as Map<String, dynamic>)['name'],
      'Intégration ERP',
    );

    final api = withToken(token.token);
    final me = await api.get('/api/v1/auth/me');
    expect(me.status, 200);

    // Création, lecture, modification, suppression.
    final org = await api.post('/api/v1/records/organisations', {
      'name': 'Mairie de Rodez',
      'kind': 'commune',
      'status': 'client',
    });
    expect(org.status, 201, reason: '${org.body}');
    final id = org.json['id'] as String;
    expect((org.json['data'] as Map)['name'], 'Mairie de Rodez');

    final invalid = await api.post('/api/v1/records/organisations', {
      'name': 'Sans type',
    });
    expect(invalid.status, 422);

    final patched = await api.patch('/api/v1/records/organisations/$id', {
      'city': 'Rodez',
    });
    expect(patched.status, 200, reason: '${patched.body}');
    expect(patched.json['version'], 2);

    final list = await api.get('/api/v1/records/organisations?limit=10');
    expect(list.json['has_more'], isFalse);
    expect(
      (list.json['records'] as List).map((r) => (r as Map)['id']),
      contains(id),
    );
    final cursor = list.json['cursor'] as int;
    expect(
      ((await api.get('/api/v1/records/organisations?cursor=$cursor'))
                  .json['records']
              as List)
          .isEmpty,
      isTrue,
    );

    expect((await api.delete('/api/v1/records/organisations/$id')).status, 204);
    final deleted = await api.get('/api/v1/records/organisations/$id');
    expect((deleted.json['data'] as Map)['deleted_at'], isNotNull);

    // Hors du périmètre du jeton.
    expect((await api.get('/api/v1/records/contacts')).status, 403);
    expect((await api.get('/api/v1/users')).status, 403);
    expect(
      (await api.post(
        '/api/v1/auth/api-tokens',
        const CreateApiTokenRequest(
          name: 'Rebond',
          permissions: ['organisation.read'],
        ).toJson(),
      )).status,
      403,
    );
    expect((await api.get('/api/v1/records/planetes')).status, 404);

    await admin.delete('/api/v1/auth/api-tokens/${token.info.id}');
    expect((await api.get('/api/v1/records/organisations')).status, 401);
  });

  test('un jeton ne donne pas plus que les droits de l’utilisateur', () async {
    final reader = await server.userWithRoles('lecteur-api@voyaj.test', [
      'lecture',
    ]);
    final refused = await reader.post(
      '/api/v1/auth/api-tokens',
      const CreateApiTokenRequest(
        name: 'Écriture',
        permissions: ['organisation.write'],
      ).toJson(),
    );
    expect(refused.status, 422);
  });
}
