import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// Mots de passe à usage unique basés sur le temps (TOTP, RFC 6238).
///
/// SHA-1, 6 chiffres, période de 30 s : compatible avec toutes les
/// applications d'authentification (Google Authenticator, Aegis, 1Password…).
abstract final class Totp {
  static const digits = 6;
  static const period = 30;

  /// Tolérance de décalage d'horloge : ±1 période.
  static const window = 1;

  static final _random = Random.secure();

  /// Nouveau secret (160 bits) encodé en base32.
  static String generateSecret() => base32Encode(
    Uint8List.fromList(List.generate(20, (_) => _random.nextInt(256))),
  );

  static int stepAt(DateTime time) =>
      time.millisecondsSinceEpoch ~/ 1000 ~/ period;

  static String codeAt(String secret, int step) {
    final counter = ByteData(8)..setInt64(0, step);
    final mac = Hmac(
      sha1,
      base32Decode(secret),
    ).convert(counter.buffer.asUint8List()).bytes;
    final offset = mac.last & 0x0f;
    final binary =
        ((mac[offset] & 0x7f) << 24) |
        (mac[offset + 1] << 16) |
        (mac[offset + 2] << 8) |
        mac[offset + 3];
    return (binary % pow(10, digits)).toString().padLeft(digits, '0');
  }

  /// Vérifie [code] ; retourne le pas de temps reconnu, ou `null`.
  ///
  /// [lastUsedStep] : dernier pas accepté, refusé à nouveau (anti-rejeu).
  static int? verify(
    String secret,
    String code,
    DateTime now, {
    int? lastUsedStep,
  }) {
    final normalized = code.replaceAll(RegExp(r'\s'), '');
    if (!RegExp(r'^\d{6}$').hasMatch(normalized)) return null;
    final current = stepAt(now);
    for (var delta = -window; delta <= window; delta++) {
      final step = current + delta;
      if (lastUsedStep != null && step <= lastUsedStep) continue;
      if (_equals(codeAt(secret, step), normalized)) return step;
    }
    return null;
  }

  /// URI à encoder en QR code pour l'application d'authentification.
  static String otpauthUri({
    required String secret,
    required String account,
    String issuer = 'Voyaj CRM',
  }) {
    final label = Uri.encodeComponent('$issuer:$account');
    return 'otpauth://totp/$label?secret=$secret'
        '&issuer=${Uri.encodeComponent(issuer)}'
        '&algorithm=SHA1&digits=$digits&period=$period';
  }

  static bool _equals(String a, String b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return diff == 0;
  }
}

const _base32Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';

/// Encodage base32 (RFC 4648) sans remplissage.
String base32Encode(Uint8List bytes) {
  final out = StringBuffer();
  var buffer = 0;
  var bits = 0;
  for (final byte in bytes) {
    buffer = (buffer << 8) | byte;
    bits += 8;
    while (bits >= 5) {
      out.write(_base32Alphabet[(buffer >> (bits - 5)) & 31]);
      bits -= 5;
    }
  }
  if (bits > 0) out.write(_base32Alphabet[(buffer << (5 - bits)) & 31]);
  return out.toString();
}

/// Décodage base32 (RFC 4648), insensible à la casse, remplissage toléré.
Uint8List base32Decode(String input) {
  final clean = input.toUpperCase().replaceAll(RegExp(r'[\s=]'), '');
  final out = BytesBuilder();
  var buffer = 0;
  var bits = 0;
  for (final char in clean.split('')) {
    final value = _base32Alphabet.indexOf(char);
    if (value < 0) throw FormatException('Caractère base32 invalide', input);
    buffer = ((buffer << 5) | value) & 0xFFFF;
    bits += 5;
    if (bits >= 8) {
      out.addByte((buffer >> (bits - 8)) & 0xFF);
      bits -= 8;
    }
  }
  return out.toBytes();
}
