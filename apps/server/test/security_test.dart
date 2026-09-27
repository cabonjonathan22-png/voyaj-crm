import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:test/test.dart';
import 'package:voyaj_server/src/audit/audit_log.dart';
import 'package:voyaj_server/src/config.dart';
import 'package:voyaj_server/src/security/passwords.dart';
import 'package:voyaj_server/src/security/rate_limiter.dart';
import 'package:voyaj_server/src/security/secret_cipher.dart';
import 'package:voyaj_server/src/security/tokens.dart';
import 'package:voyaj_server/src/security/totp.dart';

void main() {
  group('TOTP (RFC 6238)', () {
    // Secret de référence de la RFC : "12345678901234567890" (ASCII).
    final secret = base32Encode(
      Uint8List.fromList(utf8.encode('12345678901234567890')),
    );

    test('vecteurs de test SHA-1 (6 derniers chiffres)', () {
      const vectors = {
        59: '287082',
        1111111109: '081804',
        1111111111: '050471',
        1234567890: '005924',
        2000000000: '279037',
      };
      vectors.forEach((seconds, expected) {
        final step = Totp.stepAt(
          DateTime.fromMillisecondsSinceEpoch(seconds * 1000, isUtc: true),
        );
        expect(Totp.codeAt(secret, step), expected, reason: 't=$seconds');
      });
    });

    test('fenêtre de tolérance et anti-rejeu', () {
      final now = DateTime.utc(2026, 9, 27, 12);
      final step = Totp.stepAt(now);
      final previous = Totp.codeAt(secret, step - 1);
      expect(Totp.verify(secret, previous, now), step - 1);
      expect(
        Totp.verify(secret, previous, now, lastUsedStep: step - 1),
        isNull,
      );
      expect(Totp.verify(secret, Totp.codeAt(secret, step - 3), now), isNull);
      expect(Totp.verify(secret, 'abcdef', now), isNull);
    });

    test('base32 aller-retour', () {
      final bytes = Uint8List.fromList(List.generate(37, (i) => i * 7 % 256));
      expect(base32Decode(base32Encode(bytes)), bytes);
      expect(
        base32Encode(Uint8List.fromList(utf8.encode('foobar'))),
        'MZXW6YTBOI',
      );
    });

    test('URI otpauth', () {
      final uri = Totp.otpauthUri(secret: 'ABC', account: 'a@b.fr');
      expect(
        uri,
        startsWith('otpauth://totp/Voyaj%20CRM%3Aa%40b.fr?secret=ABC'),
      );
    });
  });

  group('Mots de passe', () {
    final hasher = PasswordHasher(memoryKib: 1024, iterations: 1);

    test('hash / vérification', () async {
      final hash = await hasher.hash('une phrase de passe');
      expect(hash, startsWith(r'$argon2id$v=19$m=1024,t=1,p=1$'));
      expect(await hasher.verify('une phrase de passe', hash), isTrue);
      expect(await hasher.verify('autre chose', hash), isFalse);
      expect(await hasher.verify('x', 'format inconnu'), isFalse);
    });

    test('sel aléatoire', () async {
      expect(await hasher.hash('a'), isNot(await hasher.hash('a')));
    });

    test('renforcement des paramètres', () async {
      final hash = await hasher.hash('a');
      expect(hasher.needsRehash(hash), isFalse);
      expect(
        PasswordHasher(memoryKib: 2048, iterations: 1).needsRehash(hash),
        isTrue,
      );
    });
  });

  group('Chiffrement des secrets', () {
    final cipher = SecretCipher(List.filled(32, 7));

    test('aller-retour', () async {
      final encrypted = await cipher.encrypt('secret TOTP');
      expect(encrypted, startsWith('v1:'));
      expect(encrypted, isNot(contains('secret')));
      expect(await cipher.decrypt(encrypted), 'secret TOTP');
    });

    test('altération détectée', () async {
      final encrypted = await cipher.encrypt('secret');
      final bytes = base64.decode(encrypted.substring(3));
      bytes[20] ^= 1;
      await expectLater(
        cipher.decrypt('v1:${base64.encode(bytes)}'),
        throwsA(isA<SecretBoxAuthenticationError>()),
      );
    });

    test('mauvaise clé détectée', () async {
      final encrypted = await cipher.encrypt('secret');
      await expectLater(
        SecretCipher(List.filled(32, 8)).decrypt(encrypted),
        throwsA(isA<SecretBoxAuthenticationError>()),
      );
    });
  });

  group('Jetons', () {
    test('aléatoires et hachés', () {
      final a = randomToken();
      expect(a, hasLength(43));
      expect(a, isNot(randomToken()));
      expect(hashToken(a), hasLength(64));
    });

    test('codes de secours normalisés', () {
      final code = recoveryCode();
      expect(code, matches(RegExp(r'^[a-z2-9]{4}-[a-z2-9]{4}-[a-z2-9]{4}$')));
      expect(
        normalizeRecoveryCode(' ${code.toUpperCase().replaceAll('-', ' ')} '),
        code,
      );
    });
  });

  group('Limiteur de tentatives', () {
    test('fenêtre glissante', () {
      var now = DateTime.utc(2026);
      final limiter = RateLimiter(
        maxAttempts: 2,
        window: const Duration(minutes: 1),
        clock: () => now,
      );
      expect(limiter.allow('k'), isTrue);
      limiter
        ..recordFailure('k')
        ..recordFailure('k');
      expect(limiter.allow('k'), isFalse);
      now = now.add(const Duration(minutes: 2));
      expect(limiter.allow('k'), isTrue);
      limiter
        ..recordFailure('k')
        ..reset('k');
      expect(limiter.allow('k'), isTrue);
    });
  });

  group('Configuration', () {
    final key = base64.encode(List.filled(32, 1));
    Map<String, String> base() => {
      'DATABASE_URL': 'postgres://u:p%40ss@db:5433/voyaj?sslmode=require',
      'VOYAJ_MASTER_KEY': key,
    };

    test('valeurs par défaut et URL de base', () {
      final config = ServerConfig.fromMap(base());
      expect(config.host, '127.0.0.1');
      expect(config.port, 8080);
      expect(config.database.host, 'db');
      expect(config.database.port, 5433);
      expect(config.database.password, 'p@ss');
      expect(config.database.requireSsl, isTrue);
    });

    test('TLS obligatoire hors localhost', () {
      expect(
        () => ServerConfig.fromMap({...base(), 'VOYAJ_HOST': '0.0.0.0'}),
        throwsA(isA<ConfigException>()),
      );
      expect(
        ServerConfig.fromMap({
          ...base(),
          'VOYAJ_HOST': '0.0.0.0',
          'VOYAJ_TRUST_PROXY': 'true',
        }).trustProxy,
        isTrue,
      );
    });

    test('secrets obligatoires et validés', () {
      expect(
        () => ServerConfig.fromMap({'DATABASE_URL': base()['DATABASE_URL']!}),
        throwsA(isA<ConfigException>()),
      );
      expect(
        () => ServerConfig.fromMap({...base(), 'VOYAJ_MASTER_KEY': 'court'}),
        throwsA(isA<ConfigException>()),
      );
    });

    test('fichier .env', () {
      final values = parseDotEnv('''
# commentaire
export A=1
B="valeur # pas un commentaire"
C=x # commentaire
''');
      expect(values, {'A': '1', 'B': 'valeur # pas un commentaire', 'C': 'x'});
    });
  });

  group('Audit', () {
    test('hash déterministe et sensible au contenu', () {
      String hash(Map<String, Object?> payload) => AuditLog.computeHash(
        prevHash: AuditLog.genesisHash,
        occurredAt: DateTime.utc(2026),
        actorUserId: 'u',
        sessionId: null,
        action: 'a',
        entity: null,
        entityId: null,
        payload: payload,
        ip: null,
      );
      expect(hash({'a': 1, 'b': 2}), hash({'b': 2, 'a': 1}));
      expect(hash({'a': 1}), isNot(hash({'a': 2})));
    });
  });
}
