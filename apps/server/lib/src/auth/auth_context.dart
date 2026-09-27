import 'package:meta/meta.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../errors.dart';

/// Métadonnées réseau d'une requête (journalisées).
@immutable
final class RequestMeta {
  const RequestMeta({this.ip, this.userAgent});

  final String? ip;
  final String? userAgent;
}

/// Identité authentifiée attachée à une requête.
@immutable
final class AuthContext {
  const AuthContext({
    required this.userId,
    required this.sessionId,
    required this.deviceId,
    required this.email,
    required this.displayName,
    required this.permissions,
    this.meta = const RequestMeta(),
    this.viaApiToken = false,
  });

  final String userId;
  final String sessionId;
  final String deviceId;
  final String email;
  final String displayName;
  final Set<String> permissions;
  final RequestMeta meta;

  /// Appel authentifié par un jeton d'API personnel ([sessionId] et
  /// [deviceId] valent alors l'identifiant du jeton).
  final bool viaApiToken;

  bool can(Permission permission) => permissions.contains(permission.key);

  /// Lève [ApiException.forbidden] si la permission manque.
  void require(Permission permission) {
    if (!can(permission)) {
      throw ApiException.forbidden(
        'Permission requise : ${permission.label} (${permission.key}).',
      );
    }
  }

  AuthContext withMeta(RequestMeta meta) => AuthContext(
    userId: userId,
    sessionId: sessionId,
    deviceId: deviceId,
    email: email,
    displayName: displayName,
    permissions: permissions,
    meta: meta,
    viaApiToken: viaApiToken,
  );
}
