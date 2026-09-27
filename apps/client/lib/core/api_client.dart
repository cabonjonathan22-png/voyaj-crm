import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:voyaj_shared/voyaj_shared.dart';

/// Erreur d'appel à l'API (message lisible en français).
final class ApiFailure implements Exception {
  const ApiFailure({
    required this.status,
    required this.code,
    required this.message,
    this.issues = const [],
  });

  const ApiFailure.network([
    this.message = 'Serveur injoignable. Vérifiez la connexion.',
  ]) : status = 0,
       code = 'network',
       issues = const [];

  final int status;
  final String code;
  final String message;
  final List<ValidationIssue> issues;

  bool get isNetwork => status == 0;

  /// La session n'est plus valable : il faut se reconnecter.
  bool get isSessionLost =>
      status == 401 &&
      const {
        ApiErrorCodes.sessionRevoked,
        ApiErrorCodes.tokenExpired,
        ApiErrorCodes.unauthenticated,
      }.contains(code);

  String? issueFor(String field) =>
      issues.where((i) => i.field == field).map((i) => i.message).firstOrNull;

  @override
  String toString() => message;
}

/// Client HTTP de l'API Voyaj.
///
/// Ajoute le jeton d'accès, le renouvelle automatiquement à l'expiration
/// (un seul renouvellement à la fois) et rejoue la requête.
final class ApiClient {
  ApiClient({
    required this.baseUri,
    required this.loadTokens,
    required this.saveTokens,
    required this.onSessionLost,
    http.Client? httpClient,
  }) : _http = httpClient ?? http.Client();

  final Uri baseUri;
  final Future<AuthTokens?> Function() loadTokens;
  final Future<void> Function(AuthTokens tokens) saveTokens;
  final void Function(ApiFailure reason) onSessionLost;
  final http.Client _http;

  static const timeout = Duration(seconds: 20);

  Future<AuthTokens>? _refreshing;

  /// Normalise une URL saisie par l'utilisateur (`crm.exemple.fr` →
  /// `https://crm.exemple.fr`, `localhost:8080` → `http://…`).
  static Uri normalizeServerUrl(String input) {
    var text = input.trim();
    if (!text.contains('://')) {
      final local = RegExp(
        r'^(localhost|127\.|192\.168\.|10\.|\[::1\])',
      ).hasMatch(text);
      text = '${local ? 'http' : 'https'}://$text';
    }
    final uri = Uri.parse(text);
    if (!uri.hasAuthority || !{'http', 'https'}.contains(uri.scheme)) {
      throw const FormatException('Adresse de serveur invalide');
    }
    return uri.replace(path: '', query: null, fragment: null);
  }

  Uri get webSocketUri => baseUri.replace(
    scheme: baseUri.scheme == 'https' ? 'wss' : 'ws',
    path: '/ws',
  );

  /// Vérifie qu'un serveur Voyaj répond à [uri].
  static Future<Map<String, dynamic>> health(
    Uri uri, {
    http.Client? client,
  }) async {
    final c = client ?? http.Client();
    try {
      final response = await c
          .get(uri.resolve('/health'))
          .timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) {
        throw ApiFailure(
          status: response.statusCode,
          code: 'health',
          message: 'Ce serveur ne répond pas comme un serveur Voyaj.',
        );
      }
      final body = jsonDecode(response.body);
      if (body is! Map<String, dynamic> || body['status'] != 'ok') {
        throw const ApiFailure(
          status: 200,
          code: 'health',
          message: 'Ce serveur ne répond pas comme un serveur Voyaj.',
        );
      }
      return body;
    } on ApiFailure {
      rethrow;
    } on Object {
      throw const ApiFailure.network();
    } finally {
      if (client == null) c.close();
    }
  }

  Future<Object?> get(String path) => send('GET', path);
  Future<Object?> post(String path, [Object? body]) =>
      send('POST', path, body: body);
  Future<Object?> patch(String path, Object? body) =>
      send('PATCH', path, body: body);
  Future<Object?> put(String path, Object? body) =>
      send('PUT', path, body: body);
  Future<Object?> delete(String path) => send('DELETE', path);

  /// Requête sans authentification (connexion, 2FA).
  Future<Object?> sendAnonymous(String method, String path, {Object? body}) =>
      _raw(method, path, body: body, token: null);

  Future<Object?> send(String method, String path, {Object? body}) async {
    final tokens = await loadTokens();
    if (tokens == null) {
      const failure = ApiFailure(
        status: 401,
        code: ApiErrorCodes.unauthenticated,
        message: 'Session expirée. Reconnectez-vous.',
      );
      onSessionLost(failure);
      throw failure;
    }
    try {
      return await _raw(method, path, body: body, token: tokens.accessToken);
    } on ApiFailure catch (e) {
      if (e.status != 401 || e.code == ApiErrorCodes.sessionRevoked) {
        if (e.code == ApiErrorCodes.sessionRevoked) onSessionLost(e);
        rethrow;
      }
      final refreshed = await refreshTokens(tokens);
      return _raw(method, path, body: body, token: refreshed.accessToken);
    }
  }

  /// Renouvelle les jetons (une seule requête même si plusieurs appels
  /// échouent en même temps).
  Future<AuthTokens> refreshTokens(AuthTokens current) => _refreshing ??=
      _doRefresh(current).whenComplete(() => _refreshing = null);

  Future<AuthTokens> _doRefresh(AuthTokens current) async {
    // Un autre appel a peut-être déjà renouvelé les jetons.
    final latest = await loadTokens();
    if (latest != null && latest.refreshToken != current.refreshToken) {
      return latest;
    }
    try {
      final json = await _raw(
        'POST',
        '/api/v1/auth/refresh',
        body: RefreshRequest(refreshToken: current.refreshToken).toJson(),
        token: null,
      );
      final tokens = AuthTokens.fromJson(json! as Map<String, dynamic>);
      await saveTokens(tokens);
      return tokens;
    } on ApiFailure catch (e) {
      if (e.isSessionLost) onSessionLost(e);
      rethrow;
    }
  }

  Future<Object?> _raw(
    String method,
    String path, {
    required Object? body,
    required String? token,
  }) async {
    final request = http.Request(method, baseUri.resolve(path))
      ..headers[HttpHeaders.acceptHeader] = 'application/json';
    if (token != null) {
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }
    if (body != null) {
      request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      request.body = jsonEncode(body);
    }
    final http.Response response;
    try {
      response = await http.Response.fromStream(
        await _http.send(request).timeout(timeout),
      ).timeout(timeout);
    } on Object {
      throw const ApiFailure.network();
    }
    final text = utf8.decode(response.bodyBytes);
    final decoded = text.isEmpty ? null : _tryDecode(text);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    }
    if (decoded is Map<String, dynamic> && decoded['code'] is String) {
      final error = ApiError.fromJson(decoded);
      throw ApiFailure(
        status: response.statusCode,
        code: error.code,
        message: error.message,
        issues: error.issues,
      );
    }
    throw ApiFailure(
      status: response.statusCode,
      code: 'http_${response.statusCode}',
      message: 'Erreur du serveur (${response.statusCode}).',
    );
  }

  static Object? _tryDecode(String text) {
    try {
      return jsonDecode(text);
    } on FormatException {
      return null;
    }
  }

  void close() => _http.close();
}
