import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

/// Erreur Chorus Pro (message en français).
final class ChorusException implements Exception {
  const ChorusException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Identifiants Chorus Pro : application PISTE (OAuth « client
/// credentials ») et compte technique Chorus Pro.
@immutable
final class ChorusCredentials {
  const ChorusCredentials({
    required this.clientId,
    required this.clientSecret,
    required this.login,
    required this.password,
    required this.sandbox,
  });

  final String clientId;
  final String clientSecret;
  final String login;
  final String password;

  /// Environnement de qualification (sandbox PISTE).
  final bool sandbox;

  String get oauthBase => sandbox
      ? 'https://sandbox-oauth.piste.gouv.fr'
      : 'https://oauth.piste.gouv.fr';

  String get apiBase => sandbox
      ? 'https://sandbox-api.piste.gouv.fr'
      : 'https://api.piste.gouv.fr';
}

/// Dépôt de factures Factur-X sur Chorus Pro (API PISTE).
final class ChorusProClient {
  ChorusProClient({http.Client? httpClient})
    : _http = httpClient ?? http.Client();

  final http.Client _http;

  static const _timeout = Duration(seconds: 60);

  Future<String> _token(ChorusCredentials c) async {
    final http.Response response;
    try {
      response = await _http
          .post(
            Uri.parse('${c.oauthBase}/api/oauth/token'),
            body: {
              'grant_type': 'client_credentials',
              'client_id': c.clientId,
              'client_secret': c.clientSecret,
              'scope': 'openid',
            },
          )
          .timeout(_timeout);
    } on Object {
      throw const ChorusException('PISTE injoignable.');
    }
    final json = _decode(response.body);
    final token = json['access_token'];
    if (response.statusCode != 200 || token is! String) {
      throw ChorusException(
        'Authentification PISTE refusée (${response.statusCode}) : '
        '${json['error_description'] ?? json['error'] ?? ''}',
      );
    }
    return token;
  }

  /// Dépose la facture ([pdf] Factur-X) ; retourne le numéro de flux.
  Future<String> depositFacturx(
    ChorusCredentials c, {
    required List<int> pdf,
    required String fileName,
  }) async {
    final token = await _token(c);
    final http.Response response;
    try {
      response = await _http
          .post(
            Uri.parse('${c.apiBase}/cpro/factures/v1/deposer/flux'),
            headers: {
              'authorization': 'Bearer $token',
              'cpro-account': base64.encode(
                utf8.encode('${c.login}:${c.password}'),
              ),
              'content-type': 'application/json;charset=utf-8',
              'accept': 'application/json',
            },
            body: jsonEncode({
              'fichierFlux': base64.encode(pdf),
              'nomFichier': fileName,
              'syntaxeFlux': 'IN_DP_E2_CII_FACTURX',
              'avecSignature': false,
            }),
          )
          .timeout(_timeout);
    } on Object {
      throw const ChorusException('Chorus Pro injoignable.');
    }
    final json = _decode(response.body);
    final flux = json['numeroFluxDepot'];
    if (response.statusCode != 200 || json['codeRetour'] != 0 || flux == null) {
      throw ChorusException(
        'Dépôt refusé par Chorus Pro (${response.statusCode}) : '
        '${json['libelle'] ?? response.body}',
      );
    }
    return '$flux';
  }

  static Map<String, Object?> _decode(String body) {
    try {
      final json = jsonDecode(body);
      return json is Map<String, Object?> ? json : const {};
    } on FormatException {
      return const {};
    }
  }

  void close() => _http.close();
}
