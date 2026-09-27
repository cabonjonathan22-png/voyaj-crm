import 'package:postgres/postgres.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../audit/audit_log.dart';
import '../auth/auth_context.dart';
import '../db/database.dart';
import '../errors.dart';
import '../sync/sync_service.dart';

/// Droits des personnes (RGPD) : export de toutes les données d'un contact
/// (droit d'accès, portabilité) et anonymisation (droit à l'effacement).
final class GdprService {
  GdprService({required this._db, required this._sync});

  final Database _db;
  final SyncService _sync;

  /// Libellé posé à la place du nom d'un contact anonymisé.
  static const anonymizedName = 'Contact anonymisé';

  static Object? _json(Object? value) => switch (value) {
    final DateTime d => d.toUtc().toIso8601String(),
    final Map<Object?, Object?> m => {
      for (final MapEntry(:key, :value) in m.entries) '$key': _json(value),
    },
    final List<Object?> l => [for (final v in l) _json(v)],
    _ => value,
  };

  static List<Map<String, Object?>> _rows(List<Map<String, dynamic>> rows) => [
    for (final row in rows)
      {
        for (final MapEntry(:key, :value) in row.entries)
          if (key != 'field_meta') key: _json(value),
      },
  ];

  Future<Map<String, dynamic>> _contact(Session s, String id) async {
    final contact = isValidId(id)
        ? await s.queryOne('SELECT * FROM contacts WHERE id = @id', {'id': id})
        : null;
    if (contact == null) {
      throw const ApiException.notFound('Contact introuvable.');
    }
    return contact;
  }

  /// Export de toutes les données relatives au contact [id].
  Future<Map<String, Object?>> exportContact(AuthContext ctx, String id) async {
    ctx.require(Permission.gdprManage);
    final data = await _db.run((s) async {
      final contact = await _contact(s, id);
      Future<List<Map<String, Object?>>> all(String sql) async =>
          _rows(await s.queryAll(sql, {'id': id}));
      return <String, Object?>{
        'generated_at': DateTime.now().toUtc().toIso8601String(),
        'contact': _rows([contact]).single,
        'positions': await all(
          'SELECT * FROM positions WHERE contact_id = @id',
        ),
        'activities': await all(
          'SELECT * FROM activities WHERE contact_id = @id',
        ),
        'deals': await all('SELECT * FROM deals WHERE contact_id = @id'),
        'invoices': await all(
          'SELECT id, kind, number, issue_date, total_ttc_cents, status '
          'FROM invoices WHERE contact_id = @id',
        ),
        'attachments': await all(
          'SELECT id, file_name, size, mime_type, created_at FROM attachments '
          'WHERE contact_id = @id',
        ),
        'tags': await all(
          'SELECT t.name, tg.created_at FROM taggings tg '
          'JOIN tags t ON t.id = tg.tag_id '
          'WHERE tg.record_id = @id AND tg.deleted_at IS NULL',
        ),
        'emails': await all(
          'SELECT direction, from_address, to_addresses, subject, body_text, '
          'sent_at FROM email_messages WHERE contact_id = @id '
          'ORDER BY sent_at',
        ),
        'sequence_enrollments': await all(
          'SELECT * FROM sequence_enrollments WHERE contact_id = @id',
        ),
      };
    });
    await _audit(ctx, AuditActions.gdprExported, id);
    return data;
  }

  /// Anonymise le contact [id] : données personnelles effacées (fiche,
  /// historique des modifications, contenu des activités, emails),
  /// séquences arrêtées. La fiche reste (liens et statistiques) mais ne
  /// permet plus d'identifier la personne.
  Future<void> eraseContact(AuthContext ctx, String id) async {
    ctx.require(Permission.gdprManage);
    await _db.run((s) => _contact(s, id));
    final seqs = <int>[];
    await _db.tx((tx) async {
      await _sync.lockWrites(tx);
      Future<void> write(
        EntitySchema schema,
        String recordId,
        Map<String, Object?> fields,
      ) async {
        final (_, seq) = await _sync.writeSystemInTx(
          tx,
          schema,
          fields,
          id: recordId,
          userId: ctx.userId,
        );
        seqs.add(seq);
      }

      await write(SyncEntities.contacts, id, {
        'civility': null,
        'first_name': null,
        'last_name': anonymizedName,
        'email': null,
        'phone': null,
        'mobile': null,
        'job_title': null,
        'notes': null,
        'custom_fields': null,
        'do_not_contact': true,
        'source_ref': null,
      });
      final activities = await tx.queryAll(
        'SELECT id FROM activities WHERE contact_id = @id AND deleted_at IS NULL',
        {'id': id},
      );
      for (final a in activities) {
        await write(SyncEntities.activities, a['id'] as String, {
          'subject': 'Activité anonymisée',
          'body': null,
        });
      }
      final enrollments = await tx.queryAll(
        'SELECT id FROM sequence_enrollments WHERE contact_id = @id '
        "AND status = 'active' AND deleted_at IS NULL",
        {'id': id},
      );
      for (final e in enrollments) {
        await write(SyncEntities.sequenceEnrollments, e['id'] as String, {
          'status': EnrollmentStatus.stopped.key,
          'next_send_at': null,
        });
      }
      // Historique : anciennes valeurs effacées.
      await tx.query(
        "UPDATE change_log SET fields = '{}'::jsonb "
        "WHERE (entity = 'contacts' AND entity_id = @id) OR (entity = "
        "'activities' AND entity_id = ANY(@acts:_uuid))",
        {
          'id': id,
          'acts': [for (final a in activities) a['id'] as String],
        },
      );
      await tx.query('DELETE FROM sync_conflicts WHERE entity_id = @id', {
        'id': id,
      });
      await tx.query('DELETE FROM email_messages WHERE contact_id = @id', {
        'id': id,
      });
      await AuditLog.append(
        tx,
        AuditEvent(
          action: AuditActions.gdprErased,
          actorUserId: ctx.userId,
          sessionId: ctx.sessionId,
          entity: 'contacts',
          entityId: id,
          payload: {'activities': activities.length},
          ip: ctx.meta.ip,
        ),
      );
    });
    for (final seq in seqs) {
      _sync.notifyChange(seq);
    }
  }

  Future<void> _audit(AuthContext ctx, String action, String id) => _db.tx(
    (tx) => AuditLog.append(
      tx,
      AuditEvent(
        action: action,
        actorUserId: ctx.userId,
        sessionId: ctx.sessionId,
        entity: 'contacts',
        entityId: id,
        ip: ctx.meta.ip,
      ),
    ),
  );
}
