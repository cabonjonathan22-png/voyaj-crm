import 'dart:convert';

import 'package:crypto/crypto.dart';

/// En-tête de signature des webhooks (`sha256=<hex>`).
const signatureHeader = 'x-voyaj-signature';

/// Signature HMAC-SHA256 de [body] par [secret] (`sha256=<hex>`).
String signPayload(String secret, List<int> body) =>
    'sha256=${Hmac(sha256, utf8.encode(secret)).convert(body)}';

/// Vérifie une signature en temps constant.
bool verifySignature(String secret, List<int> body, String? signature) {
  if (signature == null) return false;
  final expected = signPayload(secret, body);
  if (expected.length != signature.length) return false;
  var diff = 0;
  for (var i = 0; i < expected.length; i++) {
    diff |= expected.codeUnitAt(i) ^ signature.codeUnitAt(i);
  }
  return diff == 0;
}
