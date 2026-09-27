import 'package:voyaj_shared/voyaj_shared.dart';

import '../auth/auth_context.dart';
import '../auth/auth_service.dart';
import '../db/database.dart';
import '../errors.dart';
import '../security/tokens.dart';

/// Abonnement d'agenda : flux ICS personnel (rendez-vous, appels et
/// tâches de l'utilisateur), lisible par Outlook, Google Agenda, etc.
/// L'URL contient un jeton révocable (seule son empreinte est stockée).
final class CalendarService {
  CalendarService({required this._db, required this._publicUrl});

  final Database _db;
  final Uri? _publicUrl;

  /// Nouvelle URL d'abonnement (remplace la précédente).
  Future<String> createFeed(AuthContext ctx) async {
    ctx.require(Permission.activityRead);
    final token = randomToken();
    await _db.query(
      'INSERT INTO calendar_tokens (user_id, token_hash) VALUES (@u, @h) '
      'ON CONFLICT (user_id) DO UPDATE SET token_hash = EXCLUDED.token_hash, '
      'created_at = now()',
      {'u': ctx.userId, 'h': hashToken(token)},
    );
    final path = '/api/v1/calendar/$token.ics';
    return _publicUrl?.resolve(path).toString() ?? path;
  }

  Future<void> revokeFeed(AuthContext ctx) => _db.query(
    'DELETE FROM calendar_tokens WHERE user_id = @u',
    {'u': ctx.userId},
  );

  /// L'utilisateur a-t-il un abonnement actif ?
  Future<bool> hasFeed(AuthContext ctx) async =>
      (await _db.run(
        (s) => s.queryOne('SELECT 1 FROM calendar_tokens WHERE user_id = @u', {
          'u': ctx.userId,
        }),
      )) !=
      null;

  /// Flux ICS du jeton [token] : 90 jours passés, 1 an à venir.
  Future<String> feed(String token) async {
    final user = await _db.run(
      (s) => s.queryOne(
        'SELECT u.id, u.display_name FROM calendar_tokens t '
        "JOIN users u ON u.id = t.user_id AND u.status = 'active' "
        'WHERE t.token_hash = @h',
        {'h': hashToken(token)},
      ),
    );
    if (user == null) {
      throw const ApiException.notFound('Agenda introuvable.');
    }
    final userId = user['id'] as String;
    final permissions = await _db.run((s) => permissionsOf(s, userId));
    if (!permissions.contains(Permission.activityRead.key)) {
      throw const ApiException.forbidden();
    }
    final now = DateTime.now().toUtc();
    final rows = await _db.run(
      (s) => s.queryAll(
        'SELECT a.id, a.kind, a.subject, a.body, a.starts_at, a.ends_at, '
        'a.due_at, a.done_at, a.updated_at, o.name AS organisation, '
        "concat_ws(' ', c.first_name, c.last_name) AS contact "
        'FROM activities a '
        'LEFT JOIN organisations o ON o.id = a.organisation_id '
        'LEFT JOIN contacts c ON c.id = a.contact_id '
        'WHERE a.deleted_at IS NULL '
        'AND COALESCE(a.assignee_id, a.owner_id, a.created_by) = @u '
        'AND COALESCE(a.starts_at, a.due_at) BETWEEN @from AND @to '
        'ORDER BY COALESCE(a.starts_at, a.due_at) LIMIT 2000',
        {
          'u': userId,
          'from': now.subtract(const Duration(days: 90)),
          'to': now.add(const Duration(days: 366)),
        },
      ),
    );
    return buildIcs(
      name: 'Voyaj — ${user['display_name']}',
      events: [
        for (final r in rows)
          if (r['starts_at'] ?? r['due_at'] case final DateTime start)
            IcsEvent(
              uid: '${r['id']}@voyaj',
              start: start,
              end:
                  r['ends_at'] as DateTime? ??
                  start.add(const Duration(minutes: 30)),
              summary: [
                if (r['kind'] != ActivityKind.meeting.key)
                  enumByKey(ActivityKind.values, r['kind'] as String)?.label,
                r['subject'],
              ].whereType<String>().join(' : '),
              description: [
                r['organisation'],
                if ((r['contact'] as String?)?.trim().isNotEmpty ?? false)
                  r['contact'],
                r['body'],
              ].whereType<String>().join('\n'),
              updatedAt: r['updated_at'] as DateTime?,
              completed: r['done_at'] != null,
            ),
      ],
    );
  }
}
