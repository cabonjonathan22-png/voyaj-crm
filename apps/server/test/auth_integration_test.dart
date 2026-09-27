@Tags(['integration'])
library;

import 'package:test/test.dart';
import 'package:voyaj_server/src/security/totp.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'support/test_server.dart';

void main() {
  if (integrationSkip != null) {
    test('intégration', () {}, skip: integrationSkip);
    return;
  }
  late TestServer server;

  setUpAll(() async => server = await TestServer.start());
  tearDownAll(() => server.close());

  group('Connexion', () {
    test('identifiants valides : jetons + utilisateur', () async {
      final client = ApiClient(server.baseUri);
      final response = await client.login(adminEmail, adminPassword);
      expect(response, isA<LoginAuthenticated>());
      final user = (response as LoginAuthenticated).user;
      expect(user.email, adminEmail);
      expect(user.roles, ['admin']);
      expect(user.permissions, contains('user.manage'));
    });

    test('mot de passe incorrect ou compte inconnu : même erreur', () async {
      final client = ApiClient(server.baseUri);
      for (final email in [adminEmail, 'inconnu@voyaj.test']) {
        final response = await client.post('/api/v1/auth/login', {
          'email': email,
          'password': 'mauvais mot de passe',
          'device': {
            'id': client.deviceId,
            'name': 'x',
            'platform': 'x',
            'app_version': '0',
          },
        });
        expect(response.status, 401);
        expect(response.errorCode, ApiErrorCodes.invalidCredentials);
      }
    });

    test('corps invalide : 400', () async {
      final response = await ApiClient(server.baseUri)
          .post('/api/v1/auth/login', {'email': 1});
      expect(response.status, 400);
    });

    test('sans jeton : 401', () async {
      final response = await ApiClient(server.baseUri).get('/api/v1/auth/me');
      expect(response.status, 401);
      expect(response.errorCode, ApiErrorCodes.unauthenticated);
    });
  });

  group('Jetons et sessions', () {
    test('rotation du jeton de rafraîchissement', () async {
      final client = await server.admin();
      final first = client.tokens!;
      final refreshed = await client.post('/api/v1/auth/refresh', {
        'refresh_token': first.refreshToken,
      });
      expect(refreshed.status, 200);
      final second = AuthTokens.fromJson(refreshed.json);
      expect(second.sessionId, first.sessionId);
      expect(second.refreshToken, isNot(first.refreshToken));

      // L'ancien jeton d'accès n'est plus valable, le nouveau oui.
      expect((await client.get('/api/v1/auth/me')).status, 401);
      client.useTokens(second);
      expect((await client.get('/api/v1/auth/me')).status, 200);
    });

    test('réutilisation immédiate de l’ancien jeton : tolérée sans '
        'révocation (requêtes concurrentes)', () async {
      final client = await server.admin();
      final old = client.tokens!.refreshToken;
      final ok = await client.post('/api/v1/auth/refresh', {
        'refresh_token': old,
      });
      client.useTokens(AuthTokens.fromJson(ok.json));
      final again = await client.post('/api/v1/auth/refresh', {
        'refresh_token': old,
      });
      expect(again.status, 401);
      expect(again.errorCode, ApiErrorCodes.tokenExpired);
      expect((await client.get('/api/v1/auth/me')).status, 200);
    });

    test('liste et révocation des sessions', () async {
      final a = await server.admin();
      final b = await server.admin();
      final sessions = (await a.get('/api/v1/auth/sessions')).list;
      expect(
        sessions.where((s) => (s as Map)['current'] == true),
        hasLength(1),
      );
      final revoke = await a.delete(
        '/api/v1/auth/sessions/${b.tokens!.sessionId}',
      );
      expect(revoke.status, 204);
      final denied = await b.get('/api/v1/auth/me');
      expect(denied.errorCode, ApiErrorCodes.sessionRevoked);
      final refresh = await b.post('/api/v1/auth/refresh', {
        'refresh_token': b.tokens!.refreshToken,
      });
      expect(refresh.errorCode, ApiErrorCodes.sessionRevoked);
    });

    test('déconnexion', () async {
      final client = await server.admin();
      expect((await client.post('/api/v1/auth/logout')).status, 204);
      expect((await client.get('/api/v1/auth/me')).status, 401);
    });
  });

  group('Double authentification', () {
    test(
      'activation, connexion avec code, code de secours, désactivation',
      () async {
        final client = await server.userWithRoles('totp@voyaj.test', [
          'commercial',
        ]);
        final setup = TotpSetupResponse.fromJson(
          (await client.post('/api/v1/auth/totp/setup')).json,
        );
        expect(setup.otpauthUri, contains('secret=${setup.secret}'));

        final wrong = await client.post('/api/v1/auth/totp/confirm', {
          'code': '000000',
        });
        expect(wrong.status, 422);

        final now = DateTime.now();
        final confirm = await client.post('/api/v1/auth/totp/confirm', {
          'code': Totp.codeAt(setup.secret, Totp.stepAt(now)),
        });
        expect(confirm.status, 200);
        final codes = RecoveryCodesResponse.fromJson(confirm.json).codes;
        expect(codes, hasLength(10));

        // Connexion : le mot de passe seul ne suffit plus.
        final other = ApiClient(server.baseUri);
        final step1 = await other.login('totp@voyaj.test', adminPassword);
        expect(step1, isA<LoginMfaRequired>());
        final mfaToken = (step1 as LoginMfaRequired).mfaToken;

        final bad = await other.post('/api/v1/auth/mfa', {
          'mfa_token': mfaToken,
          'code': '123456',
        });
        expect(bad.errorCode, ApiErrorCodes.invalidMfaCode);

        // Le code déjà utilisé pour la confirmation est refusé (anti-rejeu) :
        // on utilise un code de secours.
        final ok = await other.post('/api/v1/auth/mfa', {
          'mfa_token': mfaToken,
          'code': codes.first.toUpperCase(),
        });
        expect(ok.status, 200);
        expect(LoginResponse.fromJson(ok.json), isA<LoginAuthenticated>());

        // Un code de secours n'est utilisable qu'une fois.
        final step2 = await other.login('totp@voyaj.test', adminPassword);
        final reuse = await other.post('/api/v1/auth/mfa', {
          'mfa_token': (step2 as LoginMfaRequired).mfaToken,
          'code': codes.first,
        });
        expect(reuse.errorCode, ApiErrorCodes.invalidMfaCode);

        final disable = await client.post('/api/v1/auth/totp/disable', {
          'code': codes[1],
        });
        expect(disable.status, 204);
        expect(
          await ApiClient(server.baseUri)
              .login('totp@voyaj.test', adminPassword),
          isA<LoginAuthenticated>(),
        );
      },
    );
  });

  group('Mot de passe', () {
    test('changement : révoque les autres sessions', () async {
      final a = await server.userWithRoles('pwd@voyaj.test', ['lecture']);
      final b = await server.login('pwd@voyaj.test', adminPassword);
      final tooShort = await a.post('/api/v1/auth/password', {
        'current_password': adminPassword,
        'new_password': 'court',
      });
      expect(tooShort.status, 422);
      final changed = await a.post('/api/v1/auth/password', {
        'current_password': adminPassword,
        'new_password': 'nouvelle phrase de passe',
      });
      expect(changed.status, 204);
      expect((await a.get('/api/v1/auth/me')).status, 200);
      expect((await b.get('/api/v1/auth/me')).status, 401);
    });
  });

  group('Utilisateurs et rôles', () {
    test('un lecteur ne peut pas gérer les utilisateurs', () async {
      final reader = await server.userWithRoles('lecteur@voyaj.test', [
        'lecture',
      ]);
      expect((await reader.get('/api/v1/users')).status, 200);
      final create = await reader.post('/api/v1/users', {
        'email': 'x@voyaj.test',
        'display_name': 'X',
        'password': adminPassword,
        'roles': <String>[],
      });
      expect(create.status, 403);
    });

    test('email en double et rôle inconnu refusés', () async {
      final admin = await server.admin();
      final duplicate = await admin.post('/api/v1/users', {
        'email': adminEmail.toUpperCase(),
        'display_name': 'Doublon',
        'password': adminPassword,
        'roles': <String>[],
      });
      expect(duplicate.status, 409);
      final unknownRole = await admin.post('/api/v1/users', {
        'email': 'role@voyaj.test',
        'display_name': 'R',
        'password': adminPassword,
        'roles': ['inexistant'],
      });
      expect(unknownRole.status, 422);
    });

    test('désactivation : sessions révoquées, connexion refusée', () async {
      final user = await server.userWithRoles('off@voyaj.test', ['lecture']);
      final admin = await server.admin();
      final users = (await admin.get('/api/v1/users')).list;
      final id = (users.firstWhere(
        (u) => (u as Map)['email'] == 'off@voyaj.test',
      ) as Map)['id'];
      final update = await admin.patch('/api/v1/users/$id', {
        'status': 'disabled',
      });
      expect(update.status, 200);
      expect((await user.get('/api/v1/auth/me')).status, 401);
      final login = await ApiClient(server.baseUri).post('/api/v1/auth/login', {
        'email': 'off@voyaj.test',
        'password': adminPassword,
        'device': {
          'id': newId(),
          'name': 'x',
          'platform': 'x',
          'app_version': '0',
        },
      });
      expect(login.errorCode, ApiErrorCodes.accountDisabled);
    });

    test('le dernier administrateur ne peut pas perdre son rôle', () async {
      final admin = await server.admin();
      final me = CurrentUser.fromJson(
        (await admin.get('/api/v1/auth/me')).json,
      );
      final response = await admin.patch('/api/v1/users/${me.id}', {
        'roles': ['lecture'],
      });
      expect(response.status, 409);
    });

    test('rôles personnalisés', () async {
      final admin = await server.admin();
      final created = await admin.post('/api/v1/roles', {
        'key': 'stagiaire',
        'name': 'Stagiaire',
        'permissions': ['tag.read'],
      });
      expect(created.status, 201);
      final role = RoleInfo.fromJson(created.json);
      expect(role.isSystem, isFalse);

      final invalid = await admin.put('/api/v1/roles/${role.id}', {
        'name': 'Stagiaire',
        'permissions': ['pas.une.permission'],
      });
      expect(invalid.status, 422);

      final roles = (await admin.get('/api/v1/roles')).list
          .map((r) => RoleInfo.fromJson(r as Map<String, dynamic>))
          .toList();
      final system = roles.firstWhere((r) => r.key == 'admin');
      expect(system.permissions, hasLength(Permission.values.length));
      expect((await admin.delete('/api/v1/roles/${system.id}')).status, 409);
      expect((await admin.delete('/api/v1/roles/${role.id}')).status, 204);
    });
  });
}
