import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

/// Coffre sécurisé du système (Windows : DPAPI ; macOS : Trousseau ;
/// Linux : libsecret). Contient les jetons de session et la clé de la base
/// locale ; aucun mot de passe n'y est stocké.
final class SecureStore {
  SecureStore([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _tokensKey = 'voyaj.tokens';
  static const _dbKey = 'voyaj.db_key';

  Future<AuthTokens?> readTokens() async {
    final raw = await _storage.read(key: _tokensKey);
    if (raw == null) return null;
    try {
      return AuthTokens.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      await clearTokens();
      return null;
    }
  }

  Future<void> writeTokens(AuthTokens tokens) =>
      _storage.write(key: _tokensKey, value: jsonEncode(tokens.toJson()));

  Future<void> clearTokens() => _storage.delete(key: _tokensKey);

  /// Clé de chiffrement de la base locale (créée au premier lancement).
  /// Retourne `(clé, créée)`.
  Future<(String, bool)> databaseKey() async {
    final existing = await _storage.read(key: _dbKey);
    if (existing != null) return (existing, false);
    final random = Random.secure();
    final key = List.generate(
      32,
      (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
    await _storage.write(key: _dbKey, value: key);
    return (key, true);
  }
}
