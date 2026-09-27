import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

final _random = Random.secure();

/// Jeton aléatoire opaque (256 bits, base64url sans remplissage).
String randomToken([int bytes = 32]) => base64Url
    .encode(List<int>.generate(bytes, (_) => _random.nextInt(256)))
    .replaceAll('=', '');

/// Empreinte SHA-256 (hex) d'un jeton : seule l'empreinte est stockée.
String hashToken(String token) => sha256.convert(utf8.encode(token)).toString();

/// Code de secours lisible : `xxxx-xxxx-xxxx` (alphabet sans ambiguïté).
String recoveryCode() {
  const alphabet = 'abcdefghjkmnpqrstuvwxyz23456789';
  String group() => List.generate(
    4,
    (_) => alphabet[_random.nextInt(alphabet.length)],
  ).join();
  return '${group()}-${group()}-${group()}';
}

/// Normalise un code de secours saisi (casse, espaces, tirets).
String normalizeRecoveryCode(String input) {
  final compact = input.toLowerCase().replaceAll(RegExp('[^a-z0-9]'), '');
  if (compact.length != 12) return compact;
  return '${compact.substring(0, 4)}-${compact.substring(4, 8)}-'
      '${compact.substring(8)}';
}
