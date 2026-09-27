import 'package:flutter/foundation.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

/// État d'authentification de l'application.
@immutable
sealed class AuthState {
  const AuthState();
}

/// Aucun serveur configuré (premier lancement).
final class AuthNeedsServer extends AuthState {
  const AuthNeedsServer();
}

/// Déconnecté ; [message] explique pourquoi le cas échéant.
final class AuthSignedOut extends AuthState {
  const AuthSignedOut({this.message});

  final String? message;
}

/// Mot de passe accepté, code de double authentification attendu.
final class AuthMfaRequired extends AuthState {
  const AuthMfaRequired({required this.mfaToken, required this.email});

  final String mfaToken;
  final String email;
}

/// Connecté (éventuellement hors ligne, avec l'utilisateur en cache).
final class AuthSignedIn extends AuthState {
  const AuthSignedIn(this.user);

  final CurrentUser user;

  bool can(Permission permission) => user.permissions.contains(permission.key);
}
