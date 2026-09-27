import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// Erreur du prestataire de signature (message en français).
final class SignatureException implements Exception {
  const SignatureException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// API Yousign v3 (signature électronique simple, eIDAS).
final class YousignClient {
  YousignClient({
    required this.apiKey,
    required this.sandbox,
    http.Client? httpClient,
  }) : _http = httpClient ?? http.Client();

  final String apiKey;

  /// Environnement de test (signatures sans valeur légale).
  final bool sandbox;
  final http.Client _http;

  static const _timeout = Duration(seconds: 60);

  String get baseUrl => sandbox
      ? 'https://api-sandbox.yousign.app/v3'
      : 'https://api.yousign.app/v3';

  Map<String, String> get _auth => {'authorization': 'Bearer $apiKey'};

  Future<http.Response> _send(http.BaseRequest request) async {
    request.headers.addAll(_auth);
    final http.Response response;
    try {
      response = await http.Response.fromStream(
        await _http.send(request).timeout(_timeout),
      ).timeout(_timeout);
    } on Object {
      throw const SignatureException('Yousign injoignable.');
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      var detail = '';
      try {
        final json = jsonDecode(response.body);
        if (json is Map) detail = ' : ${json['detail'] ?? json['title'] ?? ''}';
      } on FormatException {
        // Corps non JSON.
      }
      throw SignatureException(
        'Yousign a refusé la demande (${response.statusCode})$detail',
      );
    }
    return response;
  }

  Future<Map<String, Object?>> _json(
    String method,
    String path, [
    Object? body,
  ]) async {
    final request = http.Request(method, Uri.parse('$baseUrl$path'));
    if (body != null) {
      request
        ..headers['content-type'] = 'application/json'
        ..body = jsonEncode(body);
    }
    final response = await _send(request);
    if (response.body.isEmpty) return const {};
    return (jsonDecode(response.body) as Map).cast<String, Object?>();
  }

  /// Crée une demande, y joint [pdf] (ancres de signature analysées),
  /// ajoute le signataire et l'active. Retourne l'identifiant Yousign.
  Future<String> send({
    required String name,
    required List<int> pdf,
    required String fileName,
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    final created = await _json('POST', '/signature_requests', {
      'name': name,
      'delivery_mode': 'email',
      'timezone': 'Europe/Paris',
    });
    final id = '${created['id']}';
    final upload =
        http.MultipartRequest(
            'POST',
            Uri.parse('$baseUrl/signature_requests/$id/documents'),
          )
          ..fields['nature'] = 'signable_document'
          ..fields['parse_anchors'] = 'true'
          ..files.add(
            http.MultipartFile.fromBytes('file', pdf, filename: fileName),
          );
    await _send(upload);
    await _json('POST', '/signature_requests/$id/signers', {
      'info': {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'locale': 'fr',
      },
      'signature_level': 'electronic_signature',
      'signature_authentication_mode': 'otp_email',
    });
    await _json('POST', '/signature_requests/$id/activate');
    return id;
  }

  /// État de la demande (`ongoing`, `done`, `declined`, `expired`…).
  Future<String> status(String id) async =>
      '${(await _json('GET', '/signature_requests/$id'))['status']}';

  /// Document signé (PDF).
  Future<List<int>> downloadSigned(String id) async => (await _send(
    http.Request(
      'GET',
      Uri.parse('$baseUrl/signature_requests/$id/documents/download'),
    ),
  )).bodyBytes;
}
