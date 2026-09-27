import 'dart:convert';

import 'package:cryptography/cryptography.dart';

/// Chiffrement des secrets au repos (AES-256-GCM, clé maître de config).
///
/// Format : `v1:` + base64(nonce 12 octets ‖ texte chiffré ‖ MAC 16 octets).
final class SecretCipher {
  SecretCipher(List<int> masterKey)
    : assert(masterKey.length == 32),
      _key = SecretKey(masterKey);

  final SecretKey _key;
  final _algorithm = AesGcm.with256bits();

  static const _prefix = 'v1:';

  Future<String> encrypt(String plaintext) async {
    final box = await _algorithm.encrypt(
      utf8.encode(plaintext),
      secretKey: _key,
    );
    return '$_prefix${base64.encode(box.concatenation())}';
  }

  /// Lève [SecretBoxAuthenticationError] si la donnée a été altérée ou si
  /// la clé maître ne correspond pas.
  Future<String> decrypt(String encoded) async {
    if (!encoded.startsWith(_prefix)) {
      throw const FormatException('Format de secret chiffré inconnu');
    }
    final box = SecretBox.fromConcatenation(
      base64.decode(encoded.substring(_prefix.length)),
      nonceLength: _algorithm.nonceLength,
      macLength: _algorithm.macAlgorithm.macLength,
    );
    final clear = await _algorithm.decrypt(box, secretKey: _key);
    return utf8.decode(clear);
  }
}
