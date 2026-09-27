import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';

import '../auth/auth_context.dart';
import '../errors.dart';

final _log = Logger('http');

/// Taille maximale d'un corps de requête JSON.
const maxBodyBytes = 2 * 1024 * 1024;

const _jsonHeaders = {
  HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
};

Response jsonResponse(Object? body, {int status = 200}) =>
    Response(status, body: jsonEncode(body), headers: _jsonHeaders);

Response noContent() => Response(204);

/// Page HTML minimale (retour de navigateur, ex. connexion OAuth).
Response htmlPage(String title, String message, {int status = 200}) {
  const escape = HtmlEscape();
  return Response(
    status,
    body:
        '<!doctype html><html lang="fr"><head><meta charset="utf-8">'
        '<title>${escape.convert(title)}</title><style>body{font-family:'
        'system-ui,sans-serif;max-width:32rem;margin:15vh auto;padding:0 1rem;'
        'color:#18181b}h1{font-size:1.4rem}</style></head><body><h1>'
        '${escape.convert(title)}</h1><p>${escape.convert(message)}</p>'
        '</body></html>',
    headers: {HttpHeaders.contentTypeHeader: 'text/html; charset=utf-8'},
  );
}

/// Lit et décode le corps JSON de [request] avec [fromJson].
Future<T> readJson<T>(
  Request request,
  T Function(Map<String, dynamic> json) fromJson,
) async {
  final length = request.contentLength;
  if (length != null && length > maxBodyBytes) {
    throw const ApiException(413, 'payload_too_large', 'Requête trop lourde.');
  }
  final bytes = <int>[];
  await for (final chunk in request.read()) {
    bytes.addAll(chunk);
    if (bytes.length > maxBodyBytes) {
      throw const ApiException(
        413,
        'payload_too_large',
        'Requête trop lourde.',
      );
    }
  }
  try {
    final decoded = jsonDecode(utf8.decode(bytes));
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('objet JSON attendu');
    }
    return fromJson(decoded);
  } on FormatException {
    throw const ApiException.badRequest('Corps JSON invalide.');
  } on CheckedFromJsonException catch (e) {
    throw ApiException.badRequest('Champ invalide : ${e.key}.');
  } on TypeError {
    throw const ApiException.badRequest('Corps JSON invalide.');
  }
}

/// Adresse IP du client (derrière un proxy de confiance : X-Forwarded-For).
RequestMeta requestMeta(Request request, {required bool trustProxy}) {
  String? ip;
  if (trustProxy) {
    ip = request.headers['x-forwarded-for']?.split(',').first.trim();
  }
  if (ip == null || ip.isEmpty) {
    final info = request.context['shelf.io.connection_info'];
    if (info is HttpConnectionInfo) ip = info.remoteAddress.address;
  }
  return RequestMeta(ip: ip, userAgent: request.headers['user-agent']);
}

/// Extrait le jeton `Authorization: Bearer <jeton>`.
String bearerToken(Request request) {
  final header = request.headers[HttpHeaders.authorizationHeader];
  if (header == null || !header.startsWith('Bearer ')) {
    throw const ApiException.unauthenticated();
  }
  return header.substring(7).trim();
}

/// Paramètre entier de la query string.
int? intParam(Request request, String name) {
  final raw = request.url.queryParameters[name];
  if (raw == null) return null;
  return int.tryParse(raw) ??
      (throw ApiException.badRequest('Paramètre $name invalide.'));
}

/// Transforme les exceptions en réponses JSON ([ApiException] → code
/// HTTP ; autres → 500 sans détail technique).
Middleware errorMiddleware() =>
    (inner) => (request) async {
      try {
        return await inner(request);
      } on ApiException catch (e) {
        return jsonResponse(e.toApiError().toJson(), status: e.status);
      } on HijackException {
        rethrow;
      } catch (e, stack) {
        _log.severe('${request.method} /${request.url}', e, stack);
        return jsonResponse(
          const ApiException(
            500,
            'internal_error',
            'Erreur interne.',
          ).toApiError().toJson(),
          status: 500,
        );
      }
    };

/// Journalise méthode, chemin, statut et durée (jamais le corps).
Middleware logMiddleware() =>
    (inner) => (request) async {
      final watch = Stopwatch()..start();
      final response = await inner(request);
      _log.info(
        '${request.method} /${request.url.path} → ${response.statusCode} '
        '(${watch.elapsedMilliseconds} ms)',
      );
      return response;
    };

/// En-têtes de sécurité (API JSON, pas de contenu HTML).
Middleware securityHeadersMiddleware({required bool hsts}) =>
    (inner) => (request) async {
      final response = await inner(request);
      return response.change(
        headers: {
          'x-content-type-options': 'nosniff',
          'x-frame-options': 'DENY',
          'referrer-policy': 'no-referrer',
          'cache-control': 'no-store',
          if (hsts) 'strict-transport-security': 'max-age=31536000',
        },
      );
    };
