import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:postgres/postgres.dart';

import 'database.dart';
import 'migrations/m0001_initial.dart';
import 'migrations/m0002_crm.dart';
import 'migrations/m0003_public_data.dart';
import 'migrations/m0004_email.dart';
import 'migrations/m0005_billing.dart';

/// Migration SQL versionnée. Une migration appliquée ne doit plus jamais
/// être modifiée : on en ajoute une nouvelle (le checksum est vérifié).
@immutable
final class Migration {
  const Migration(this.version, this.name, this.sql);

  final int version;
  final String name;
  final String sql;

  String get checksum => sha256.convert(utf8.encode(sql)).toString();
}

/// Liste ordonnée des migrations. Ajouter une migration : créer
/// `migrations/mNNNN_nom.dart` et l'ajouter ici.
const List<Migration> migrations = [
  m0001Initial,
  m0002Crm,
  m0003PublicData,
  m0004Email,
  m0005Billing,
];

final _log = Logger('migrations');

/// Clé du verrou consultatif empêchant deux migrations simultanées.
const _migrationLockKey = 7428120001;

/// Applique les migrations manquantes, chacune dans sa transaction.
///
/// Retourne les versions appliquées.
Future<List<int>> migrate(Database db, {List<Migration>? list}) async {
  final pending = list ?? migrations;
  return db.withConnection((session) async {
    await session.query('SELECT pg_advisory_lock(@k)', {
      'k': _migrationLockKey,
    });
    try {
      await session.execute('''
        CREATE TABLE IF NOT EXISTS schema_migrations (
          version integer PRIMARY KEY,
          name text NOT NULL,
          checksum text NOT NULL,
          applied_at timestamptz NOT NULL DEFAULT now()
        )''');
      final applied = {
        for (final row in await session.queryAll(
          'SELECT version, checksum FROM schema_migrations',
        ))
          row['version'] as int: row['checksum'] as String,
      };

      final done = <int>[];
      for (final migration in pending) {
        final checksum = applied[migration.version];
        if (checksum != null) {
          if (checksum != migration.checksum) {
            throw StateError(
              'La migration ${migration.version} (${migration.name}) a été '
              'modifiée après application.',
            );
          }
          continue;
        }
        _log.info('Migration ${migration.version} : ${migration.name}');
        await session.runTx((tx) async {
          await tx.execute(migration.sql, queryMode: QueryMode.simple);
          await tx.query(
            'INSERT INTO schema_migrations (version, name, checksum) '
            'VALUES (@v, @n, @c)',
            {
              'v': migration.version,
              'n': migration.name,
              'c': migration.checksum,
            },
          );
        });
        done.add(migration.version);
      }
      return done;
    } finally {
      await session.query('SELECT pg_advisory_unlock(@k)', {
        'k': _migrationLockKey,
      });
    }
  });
}
