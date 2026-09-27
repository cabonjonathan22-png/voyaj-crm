import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../data/local/database.dart';
import 'auth_state.dart';

/// Version de l'application (transmise au serveur à la connexion).
const appVersion = '0.1.0';

/// Connexion, double authentification et déconnexion.
final class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    final boot = ref.read(bootstrapProvider);
    if (boot.serverUrl == null) return const AuthNeedsServer();
    if (boot.tokens != null && boot.cachedUser != null) {
      // Démarrage hors ligne possible : l'utilisateur en cache suffit ;
      // le profil est rafraîchi dès que le serveur répond.
      unawaited(Future.microtask(refreshUser));
      return AuthSignedIn(boot.cachedUser!);
    }
    return const AuthSignedOut();
  }

  AppDatabase get _db => ref.read(appDatabaseProvider);

  ApiClient get _api =>
      ref.read(apiClientProvider) ??
      (throw const ApiFailure.network('Aucun serveur configuré.'));

  /// Enregistre l'adresse du serveur (vérifiée au préalable).
  Future<void> setServer(Uri url) async {
    final previous = ref.read(serverUrlProvider);
    if (previous != null && previous != url) await _clearSession();
    await ref.read(serverUrlProvider.notifier).set(url);
    state = const AuthSignedOut();
  }

  /// Revient à l'écran de choix du serveur.
  Future<void> changeServer() async {
    await logout();
    state = const AuthNeedsServer();
  }

  Future<void> login(String email, String password) async {
    final response = LoginResponse.fromJson(
      (await _api.sendAnonymous(
            'POST',
            '/api/v1/auth/login',
            body: LoginRequest(
              email: email.trim(),
              password: password,
              device: _deviceInfo(),
            ).toJson(),
          ))!
          as Map<String, dynamic>,
    );
    switch (response) {
      case LoginMfaRequired(:final mfaToken):
        state = AuthMfaRequired(mfaToken: mfaToken, email: email.trim());
      case LoginAuthenticated(:final tokens, :final user):
        await _completeLogin(tokens, user);
    }
  }

  Future<void> verifyMfa(String code) async {
    final current = state;
    if (current is! AuthMfaRequired) return;
    try {
      final response = LoginResponse.fromJson(
        (await _api.sendAnonymous(
              'POST',
              '/api/v1/auth/mfa',
              body: MfaVerifyRequest(
                mfaToken: current.mfaToken,
                code: code.trim(),
              ).toJson(),
            ))!
            as Map<String, dynamic>,
      );
      if (response case LoginAuthenticated(:final tokens, :final user)) {
        await _completeLogin(tokens, user);
      }
    } on ApiFailure catch (e) {
      // Étape expirée ou trop d'essais : retour à la saisie du mot de passe.
      if (e.code != ApiErrorCodes.invalidMfaCode) {
        state = AuthSignedOut(message: e.message);
      }
      rethrow;
    }
  }

  void cancelMfa() => state = const AuthSignedOut();

  Future<void> _completeLogin(AuthTokens tokens, CurrentUser user) async {
    final lastUserId = await _db.readSetting<String>(SettingKeys.lastUserId);
    if (lastUserId != null && lastUserId != user.id) {
      // Autre utilisateur sur ce poste : les données locales (et les
      // modifications non envoyées) du précédent ne doivent pas lui être
      // visibles.
      await _db.wipeSyncedData();
    }
    await ref.read(tokenStoreProvider).save(tokens);
    await _db.writeSetting(SettingKeys.currentUser, user.toJson());
    await _db.writeSetting(SettingKeys.lastUserId, user.id);
    state = AuthSignedIn(user);
  }

  /// Rafraîchit le profil et les permissions (silencieux hors ligne).
  Future<void> refreshUser() async {
    if (state is! AuthSignedIn) return;
    try {
      final user = CurrentUser.fromJson(
        (await _api.get('/api/v1/auth/me'))! as Map<String, dynamic>,
      );
      await _db.writeSetting(SettingKeys.currentUser, user.toJson());
      if (state is AuthSignedIn) state = AuthSignedIn(user);
    } on ApiFailure {
      // Hors ligne ou session perdue (déjà gérée par onSessionLost).
    }
  }

  Future<void> logout() async {
    if (state is AuthSignedIn) {
      try {
        await _api.post('/api/v1/auth/logout');
      } on ApiFailure {
        // Hors ligne : la session expirera côté serveur.
      }
    }
    await _clearSession();
    state = const AuthSignedOut();
  }

  /// Session révoquée ou expirée côté serveur.
  void sessionLost(String message) {
    if (state is! AuthSignedIn) return;
    unawaited(_clearSession());
    state = AuthSignedOut(message: message);
  }

  Future<void> _clearSession() async {
    await ref.read(tokenStoreProvider).clear();
    await _db.deleteSetting(SettingKeys.currentUser);
  }

  DeviceInfo _deviceInfo() => DeviceInfo(
    id: ref.read(localClockProvider).deviceId,
    name: Platform.localHostname,
    platform: Platform.operatingSystem,
    appVersion: appVersion,
  );
}
