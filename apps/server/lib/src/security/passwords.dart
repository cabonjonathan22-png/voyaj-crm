import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';

/// Hachage des mots de passe en Argon2id (recommandation OWASP / ANSSI).
///
/// Format stocké (PHC) : `$argon2id$v=19$m=<kib>,t=<iter>,p=1$<sel>$<hash>`.
/// Les paramètres sont lus depuis le hash : on peut les renforcer sans
/// invalider les mots de passe existants ([needsRehash]).
final class PasswordHasher {
  PasswordHasher({required this.memoryKib, required this.iterations});

  final int memoryKib;
  final int iterations;

  static const _saltLength = 16;
  static const _hashLength = 32;
  static final _random = Random.secure();

  Future<String> hash(String password) async {
    final salt = List<int>.generate(_saltLength, (_) => _random.nextInt(256));
    final digest = await _derive(password, salt, memoryKib, iterations);
    return '\$argon2id\$v=19\$m=$memoryKib,t=$iterations,p=1'
        '\$${_b64(salt)}\$${_b64(digest)}';
  }

  /// Vérifie [password] contre [encoded] en temps constant.
  Future<bool> verify(String password, String encoded) async {
    final parsed = _Parsed.tryParse(encoded);
    if (parsed == null) return false;
    final digest = await _derive(
      password,
      parsed.salt,
      parsed.memoryKib,
      parsed.iterations,
    );
    return constantTimeEquals(digest, parsed.hash);
  }

  bool needsRehash(String encoded) {
    final parsed = _Parsed.tryParse(encoded);
    return parsed == null ||
        parsed.memoryKib < memoryKib ||
        parsed.iterations < iterations;
  }

  /// Hash factice : permet de consommer le même temps de calcul quand
  /// l'utilisateur n'existe pas (évite l'énumération des comptes).
  Future<void> burn(String password) => hash(password);

  static Future<List<int>> _derive(
    String password,
    List<int> salt,
    int memoryKib,
    int iterations,
  ) async {
    final algorithm = Argon2id(
      parallelism: 1,
      memory: memoryKib,
      iterations: iterations,
      hashLength: _hashLength,
    );
    final key = await algorithm.deriveKey(
      secretKey: SecretKey(utf8.encode(password)),
      nonce: salt,
    );
    return key.extractBytes();
  }

  static String _b64(List<int> bytes) =>
      base64.encode(bytes).replaceAll('=', '');
}

final class _Parsed {
  _Parsed(this.memoryKib, this.iterations, this.salt, this.hash);

  static final _pattern = RegExp(
    r'^\$argon2id\$v=19\$m=(\d+),t=(\d+),p=1\$([A-Za-z0-9+/]+)\$([A-Za-z0-9+/]+)$',
  );

  static _Parsed? tryParse(String encoded) {
    final match = _pattern.firstMatch(encoded);
    if (match == null) return null;
    try {
      return _Parsed(
        int.parse(match[1]!),
        int.parse(match[2]!),
        base64.decode(base64.normalize(match[3]!)),
        base64.decode(base64.normalize(match[4]!)),
      );
    } on FormatException {
      return null;
    }
  }

  final int memoryKib;
  final int iterations;
  final List<int> salt;
  final List<int> hash;
}

/// Comparaison en temps constant (évite les attaques temporelles).
bool constantTimeEquals(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  var diff = 0;
  for (var i = 0; i < a.length; i++) {
    diff |= a[i] ^ b[i];
  }
  return diff == 0;
}
