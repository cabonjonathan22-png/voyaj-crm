import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fr_public_data/fr_public_data.dart';
import 'package:http/http.dart' as http;
import 'package:postgres/postgres.dart';
import 'package:voyaj_server/voyaj_server.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

/// URL de la base de test (jamais la base de développement : elle est
/// entièrement vidée). Lue dans `TEST_DATABASE_URL` ou le fichier `.env`.
String? testDatabaseUrl() {
  final fromEnv = Platform.environment['TEST_DATABASE_URL'];
  if (fromEnv != null && fromEnv.isNotEmpty) return fromEnv;
  final dotEnv = File('.env');
  if (!dotEnv.existsSync()) return null;
  return parseDotEnv(dotEnv.readAsStringSync())['TEST_DATABASE_URL'];
}

/// Raison de sauter les tests d'intégration si aucune base n'est configurée.
String? get integrationSkip => testDatabaseUrl() == null
    ? 'TEST_DATABASE_URL non défini : tests d’intégration ignorés.'
    : null;

const adminEmail = 'admin@voyaj.test';
const adminPassword = 'mot de passe administrateur';

/// Serveur complet sur une base de test vierge.
final class TestServer {
  TestServer._(this.server, this.baseUri);

  final VoyajServer server;
  final Uri baseUri;

  static Future<TestServer> start({
    PublicDataClient? publicDataClient,
    MailTransport? mailTransport,
    OAuthClient? oauthClient,
    ChorusProClient? chorusClient,
    SourceOpener? sourceOpener,
    http.Client? webhookClient,
    Map<String, String> extraConfig = const {},
  }) async {
    final config = ServerConfig.fromMap({
      'DATABASE_URL': testDatabaseUrl()!,
      'VOYAJ_MASTER_KEY': base64.encode(List.filled(32, 42)),
      'VOYAJ_PORT': '1',
      'VOYAJ_ARGON2_MEMORY_KIB': '1024',
      'VOYAJ_ARGON2_ITERATIONS': '1',
      'VOYAJ_AUTO_MIGRATE': 'true',
      'VOYAJ_DATA_DIR': Directory.systemTemp.createTempSync('voyaj-data').path,
      ...extraConfig,
    });
    await _resetDatabase(config.database);
    final server = await VoyajServer.start(
      _withPort0(config),
      publicDataClient: publicDataClient,
      mailTransport: mailTransport,
      oauthClient: oauthClient,
      chorusClient: chorusClient,
      sourceOpener: sourceOpener,
      webhookClient: webhookClient,
    );
    await server.services.users.createAdmin(
      email: adminEmail,
      displayName: 'Admin',
      password: adminPassword,
    );
    return TestServer._(server, Uri.parse('http://127.0.0.1:${server.port}'));
  }

  static ServerConfig _withPort0(ServerConfig c) => ServerConfig(
    host: c.host,
    port: 0,
    database: c.database,
    masterKey: c.masterKey,
    dbPoolSize: 4,
    argon2MemoryKib: c.argon2MemoryKib,
    argon2Iterations: c.argon2Iterations,
    dataDir: c.dataDir,
    publicDataHour: null,
    publicUrl: c.publicUrl,
    googleClientId: c.googleClientId,
    googleClientSecret: c.googleClientSecret,
    microsoftClientId: c.microsoftClientId,
    microsoftClientSecret: c.microsoftClientSecret,
  );

  static Future<void> _resetDatabase(DatabaseConfig db) async {
    final conn = await Connection.open(
      Endpoint(
        host: db.host,
        port: db.port,
        database: db.database,
        username: db.username,
        password: db.password,
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
    try {
      await conn.execute(
        'DROP SCHEMA public CASCADE; CREATE SCHEMA public;',
        queryMode: QueryMode.simple,
      );
    } finally {
      await conn.close();
    }
  }

  Future<void> close() => server.close();

  Uri wsUri() => baseUri.replace(scheme: 'ws', path: '/ws');

  /// Client connecté (sans 2FA).
  Future<ApiClient> login(String email, String password) async {
    final client = ApiClient(baseUri);
    final response = await client.login(email, password);
    client.useTokens((response as LoginAuthenticated).tokens);
    return client;
  }

  Future<ApiClient> admin() => login(adminEmail, adminPassword);

  /// Crée un utilisateur avec [roles] et retourne un client connecté.
  Future<ApiClient> userWithRoles(String email, List<String> roles) async {
    final admin = await this.admin();
    await admin.post(
      '/api/v1/users',
      CreateUserRequest(
        email: email,
        displayName: email.split('@').first,
        password: adminPassword,
        roles: roles,
      ).toJson(),
    );
    return login(email, adminPassword);
  }
}

/// Réponse HTTP décodée.
final class ApiResponse {
  ApiResponse(this.status, this.body);

  final int status;
  final Object? body;

  Map<String, dynamic> get json => body! as Map<String, dynamic>;
  List<dynamic> get list => body! as List<dynamic>;
  String? get errorCode => (body as Map<String, dynamic>?)?['code'] as String?;
}

/// Client HTTP minimal pour les tests.
final class ApiClient {
  ApiClient(this.baseUri) : deviceId = newId();

  final Uri baseUri;
  final String deviceId;
  AuthTokens? tokens;

  void useTokens(AuthTokens value) => tokens = value;

  Future<LoginResponse> login(String email, String password) async {
    final response = await post(
      '/api/v1/auth/login',
      LoginRequest(
        email: email,
        password: password,
        device: DeviceInfo(
          id: deviceId,
          name: 'Poste de test',
          platform: 'test',
          appVersion: '0.0.0',
        ),
      ).toJson(),
    );
    if (response.status != 200) {
      throw StateError('Connexion refusée : ${response.body}');
    }
    return LoginResponse.fromJson(response.json);
  }

  Future<ApiResponse> get(String path) => _send('GET', path);
  Future<ApiResponse> post(String path, [Object? body]) =>
      _send('POST', path, body);
  Future<ApiResponse> patch(String path, Object? body) =>
      _send('PATCH', path, body);
  Future<ApiResponse> put(String path, Object? body) =>
      _send('PUT', path, body);
  Future<ApiResponse> delete(String path) => _send('DELETE', path);

  Future<ApiResponse> _send(String method, String path, [Object? body]) async {
    final request = http.Request(method, baseUri.resolve(path));
    if (tokens != null) {
      request.headers['authorization'] = 'Bearer ${tokens!.accessToken}';
    }
    if (body != null) {
      request.headers['content-type'] = 'application/json';
      request.body = jsonEncode(body);
    }
    final response = await http.Response.fromStream(await request.send());
    return ApiResponse(
      response.statusCode,
      response.body.isEmpty ? null : jsonDecode(response.body),
    );
  }

  /// Envoie un fichier brut (`POST /files`).
  Future<ApiResponse> upload(List<int> bytes, {String? mimeType}) async {
    final request = http.Request('POST', baseUri.resolve('/api/v1/files'))
      ..bodyBytes = bytes;
    if (tokens != null) {
      request.headers['authorization'] = 'Bearer ${tokens!.accessToken}';
    }
    if (mimeType != null) request.headers['content-type'] = mimeType;
    final response = await http.Response.fromStream(await request.send());
    return ApiResponse(
      response.statusCode,
      response.body.isEmpty ? null : jsonDecode(response.body),
    );
  }

  /// Télécharge un fichier (`GET /files/{id}`).
  Future<http.Response> download(String id) => http.get(
    baseUri.resolve('/api/v1/files/$id'),
    headers: {
      if (tokens != null) 'authorization': 'Bearer ${tokens!.accessToken}',
    },
  );

  // ── Synchronisation ──

  late final HybridClock _clock = HybridClock(deviceId);

  SyncOperation op(
    String entityId,
    Map<String, Object?> fields, {
    int baseVersion = 0,
    Hlc? hlc,
    String entity = 'tags',
  }) => SyncOperation(
    opId: newId(),
    entity: entity,
    entityId: entityId,
    baseVersion: baseVersion,
    hlc: (hlc ?? _clock.now()).toString(),
    fields: fields,
  );

  Future<PushResponse> push(List<SyncOperation> operations) async {
    final response = await post(
      '/api/v1/sync/push',
      PushRequest(deviceId: deviceId, operations: operations).toJson(),
    );
    if (response.status != 200) {
      throw StateError('Push refusé : ${response.body}');
    }
    return PushResponse.fromJson(response.json);
  }

  Future<PullResponse> pull(int cursor, {int? limit}) async {
    final response = await get(
      '/api/v1/sync/pull?cursor=$cursor${limit == null ? '' : '&limit=$limit'}',
    );
    return PullResponse.fromJson(response.json);
  }
}
