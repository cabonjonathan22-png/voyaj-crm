import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:meta/meta.dart';
import 'package:postgres/postgres.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../db/database.dart';

/// Actions journalisées (valeurs stables, utilisées pour filtrer).
abstract final class AuditActions {
  static const loginSucceeded = 'auth.login.succeeded';
  static const loginFailed = 'auth.login.failed';
  static const mfaFailed = 'auth.mfa.failed';
  static const logout = 'auth.logout';
  static const refreshReuse = 'auth.refresh.reuse_detected';
  static const sessionRevoked = 'auth.session.revoked';
  static const passwordChanged = 'auth.password.changed';
  static const totpEnabled = 'auth.totp.enabled';
  static const totpDisabled = 'auth.totp.disabled';
  static const recoveryCodesRegenerated = 'auth.recovery_codes.regenerated';
  static const recoveryCodeUsed = 'auth.recovery_code.used';
  static const userCreated = 'user.created';
  static const userUpdated = 'user.updated';
  static const roleCreated = 'role.created';
  static const roleUpdated = 'role.updated';
  static const roleDeleted = 'role.deleted';
  static const recordCreated = 'record.created';
  static const recordUpdated = 'record.updated';
  static const recordDeleted = 'record.deleted';
  static const conflictReviewed = 'sync.conflict.reviewed';
  static const publicDataConfigured = 'public_data.configured';
  static const publicDataRun = 'public_data.run';
  static const emailAccountConnected = 'email.account.connected';
  static const emailAccountRemoved = 'email.account.removed';
}

/// Événement à journaliser.
@immutable
final class AuditEvent {
  const AuditEvent({
    required this.action,
    this.actorUserId,
    this.sessionId,
    this.entity,
    this.entityId,
    this.payload = const {},
    this.ip,
  });

  final String action;
  final String? actorUserId;
  final String? sessionId;
  final String? entity;
  final String? entityId;
  final Map<String, Object?> payload;
  final String? ip;
}

/// Journal d'audit inaltérable.
///
/// Chaque entrée contient le hash SHA-256 de l'entrée précédente et de son
/// propre contenu : toute modification ou suppression a posteriori casse la
/// chaîne et est détectée par [verifyChain]. La table est de plus protégée
/// par des triggers qui refusent UPDATE, DELETE et TRUNCATE.
abstract final class AuditLog {
  static const genesisHash =
      '0000000000000000000000000000000000000000000000000000000000000000';

  /// Clé du verrou transactionnel qui sérialise les ajouts.
  static const _lockKey = 7428120002;

  /// Ajoute [event] au journal, dans la transaction [tx].
  static Future<void> append(TxSession tx, AuditEvent event) async {
    await tx.query('SELECT pg_advisory_xact_lock(@k)', {'k': _lockKey});
    final last = await tx.queryOne(
      'SELECT hash FROM audit_log ORDER BY id DESC LIMIT 1',
    );
    final prevHash = last?['hash'] as String? ?? genesisHash;
    final occurredAt = DateTime.now().toUtc();
    final hash = computeHash(
      prevHash: prevHash,
      occurredAt: occurredAt,
      actorUserId: event.actorUserId,
      sessionId: event.sessionId,
      action: event.action,
      entity: event.entity,
      entityId: event.entityId,
      payload: event.payload,
      ip: event.ip,
    );
    await tx.query(
      'INSERT INTO audit_log (occurred_at, actor_user_id, session_id, action, '
      'entity, entity_id, payload, ip, prev_hash, hash) VALUES (@at, '
      '@actor, @session, @action, @entity, @entityId, @payload:jsonb, @ip, '
      '@prev, @hash)',
      {
        'at': occurredAt,
        'actor': event.actorUserId,
        'session': event.sessionId,
        'action': event.action,
        'entity': event.entity,
        'entityId': event.entityId,
        'payload': canonicalize(event.payload),
        'ip': event.ip,
        'prev': prevHash,
        'hash': hash,
      },
    );
  }

  /// Calcule le hash d'une entrée.
  static String computeHash({
    required String prevHash,
    required DateTime occurredAt,
    required String? actorUserId,
    required String? sessionId,
    required String action,
    required String? entity,
    required String? entityId,
    required Map<String, Object?> payload,
    required String? ip,
  }) {
    final content = jsonEncode([
      occurredAt.toUtc().toIso8601String(),
      actorUserId,
      sessionId,
      action,
      entity,
      entityId,
      canonicalize(payload),
      ip,
    ]);
    return sha256.convert(utf8.encode('$prevHash\n$content')).toString();
  }

  /// Dernières entrées (plus récentes d'abord), paginées par [beforeId].
  static Future<List<AuditEntry>> list(
    Database db, {
    int limit = 100,
    int? beforeId,
  }) async {
    final rows = await db.run(
      (s) => s.queryAll(
        'SELECT a.*, u.display_name AS actor_name FROM audit_log a '
        'LEFT JOIN users u ON u.id = a.actor_user_id '
        'WHERE a.id < @before ORDER BY a.id DESC LIMIT @n',
        {'before': beforeId ?? 9223372036854775807, 'n': limit.clamp(1, 500)},
      ),
    );
    return [
      for (final r in rows)
        AuditEntry(
          id: r['id'] as int,
          occurredAt: r['occurred_at'] as DateTime,
          actorUserId: r['actor_user_id'] as String?,
          actorName: r['actor_name'] as String?,
          action: r['action'] as String,
          entity: r['entity'] as String?,
          entityId: r['entity_id'] as String?,
          payload: (r['payload'] as Map).cast<String, Object?>(),
          ip: r['ip'] as String?,
        ),
    ];
  }

  /// Vérifie toute la chaîne. Retourne l'id de la première entrée
  /// incohérente, ou `null` si la chaîne est intègre.
  static Future<int?> verifyChain(Database db) => db.run((session) async {
    var prevHash = genesisHash;
    var afterId = 0;
    while (true) {
      final rows = await session.queryAll(
        'SELECT * FROM audit_log WHERE id > @after ORDER BY id LIMIT 1000',
        {'after': afterId},
      );
      if (rows.isEmpty) return null;
      for (final row in rows) {
        final expected = computeHash(
          prevHash: prevHash,
          occurredAt: row['occurred_at'] as DateTime,
          actorUserId: row['actor_user_id'] as String?,
          sessionId: row['session_id'] as String?,
          action: row['action'] as String,
          entity: row['entity'] as String?,
          entityId: row['entity_id'] as String?,
          payload: (row['payload'] as Map).cast<String, Object?>(),
          ip: row['ip'] as String?,
        );
        if (row['prev_hash'] != prevHash || row['hash'] != expected) {
          return row['id'] as int;
        }
        prevHash = expected;
        afterId = row['id'] as int;
      }
    }
  });
}

/// Forme canonique d'une valeur JSON (clés triées récursivement).
Object? canonicalize(Object? value) => switch (value) {
  final Map<dynamic, dynamic> map => {
    for (final key in map.keys.map((k) => k.toString()).toList()..sort())
      key: canonicalize(map[key]),
  },
  final List<dynamic> list => [for (final item in list) canonicalize(item)],
  final DateTime date => date.toUtc().toIso8601String(),
  _ => value,
};
