import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// Erreur de l'assistant IA (message en français).
final class AiException implements Exception {
  const AiException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// API Messages de Claude (Anthropic), en HTTP (pas de SDK Dart officiel).
///
/// Réflexion adaptative, effort moyen, et repli côté serveur (`fallbacks:
/// "default"`) : une demande déclinée par un classifieur de sécurité est
/// relancée sur le modèle recommandé par Anthropic.
final class ClaudeClient {
  ClaudeClient({
    required this.apiKey,
    this.model = 'claude-opus-5',
    http.Client? httpClient,
  }) : _http = httpClient ?? http.Client();

  final String apiKey;
  final String model;
  final http.Client _http;

  static final _endpoint = Uri.parse('https://api.anthropic.com/v1/messages');
  static const _timeout = Duration(minutes: 5);

  /// Réponse texte à [prompt] ; [schema] (JSON Schema) impose une sortie
  /// JSON structurée, renvoyée telle quelle.
  Future<String> complete({
    required String system,
    required String prompt,
    Map<String, Object?>? schema,
    int maxTokens = 16000,
  }) async {
    final http.Response response;
    try {
      response = await _http
          .post(
            _endpoint,
            headers: {
              'content-type': 'application/json',
              'x-api-key': apiKey,
              'anthropic-version': '2023-06-01',
              'anthropic-beta': 'server-side-fallback-2026-07-01',
            },
            body: jsonEncode({
              'model': model,
              'max_tokens': maxTokens,
              'thinking': {'type': 'adaptive'},
              'output_config': {
                'effort': 'medium',
                if (schema != null)
                  'format': {'type': 'json_schema', 'schema': schema},
              },
              'fallbacks': 'default',
              'system': system,
              'messages': [
                {'role': 'user', 'content': prompt},
              ],
            }),
          )
          .timeout(_timeout);
    } on TimeoutException {
      throw const AiException('L’assistant IA n’a pas répondu à temps.');
    } on Object {
      throw const AiException('Service d’IA injoignable.');
    }
    final Object? json;
    try {
      json = jsonDecode(utf8.decode(response.bodyBytes));
    } on FormatException {
      throw AiException(
        'Réponse illisible du service d’IA (${response.statusCode}).',
      );
    }
    if (response.statusCode != 200 || json is! Map) {
      final message = switch (json) {
        {'error': {'message': final String m}} => m,
        _ => '',
      };
      throw AiException(
        switch (response.statusCode) {
          401 || 403 => 'Clé d’API Anthropic refusée.',
          429 => 'Assistant IA saturé : réessayez dans un instant.',
          _ => 'Erreur du service d’IA (${response.statusCode}) $message',
        }.trim(),
      );
    }
    final stop = json['stop_reason'];
    if (stop == 'refusal') {
      throw const AiException('L’assistant a décliné cette demande.');
    }
    final text = [
      for (final block in json['content'] as List? ?? const [])
        if (block is Map && block['type'] == 'text') '${block['text']}',
    ].join();
    if (text.trim().isEmpty) {
      throw const AiException('L’assistant n’a produit aucune réponse.');
    }
    if (stop == 'max_tokens') {
      throw const AiException('Réponse de l’assistant tronquée.');
    }
    return text.trim();
  }
}
