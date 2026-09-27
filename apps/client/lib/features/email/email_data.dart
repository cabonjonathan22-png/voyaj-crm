import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../data/local/database.dart';

final emailTemplatesProvider = StreamProvider<List<EmailTemplateRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.emailTemplates)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([(t) => OrderingTerm.asc(t.name.lower())]))
      .watch();
});

final emailSequencesProvider = StreamProvider<List<EmailSequenceRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.emailSequences)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([(t) => OrderingTerm.asc(t.name.lower())]))
      .watch();
});

final enrollmentsProvider = StreamProvider<List<EnrollmentRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.sequenceEnrollments)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
      .watch();
});

/// Étape d'une séquence.
typedef SequenceStep = ({int delayDays, String templateId});

/// Étapes d'une séquence (JSON stocké).
List<SequenceStep> sequenceSteps(String json) => [
  for (final s in jsonDecode(json) as List<dynamic>)
    (
      delayDays: (s as Map<String, dynamic>)['delay_days'] as int,
      templateId: s['template_id'] as String,
    ),
];

/// Accès à l'API de messagerie (connexion au serveur requise).
final class EmailApi {
  const EmailApi(this._api);

  final ApiClient _api;

  Future<List<String>> providers() async => [
    for (final p in (await _api.get('/api/v1/email/providers'))! as List) '$p',
  ];

  Future<List<EmailAccountInfo>> accounts() async => [
    for (final a in (await _api.get('/api/v1/email/accounts'))! as List)
      EmailAccountInfo.fromJson(a as Map<String, dynamic>),
  ];

  Future<EmailAccountInfo> createImap(CreateImapAccountRequest request) async =>
      EmailAccountInfo.fromJson(
        (await _api.post('/api/v1/email/accounts', request.toJson()))!
            as Map<String, dynamic>,
      );

  Future<void> deleteAccount(String id) =>
      _api.delete('/api/v1/email/accounts/$id');

  Future<EmailAccountInfo> sync(String id) async => EmailAccountInfo.fromJson(
    (await _api.post('/api/v1/email/accounts/$id/sync'))!
        as Map<String, dynamic>,
  );

  Future<Uri> oauthStart(String provider) async => Uri.parse(
    OAuthStartResponse.fromJson(
      (await _api.get('/api/v1/email/oauth/$provider/start'))!
          as Map<String, dynamic>,
    ).url,
  );

  Future<List<EmailMessage>> messages({
    String? accountId,
    String? contactId,
    DateTime? before,
    int limit = 50,
  }) async {
    final query = {
      'account': ?accountId,
      'contact': ?contactId,
      if (before != null) 'before': before.toUtc().toIso8601String(),
      'limit': '$limit',
    };
    final path = Uri(path: '/api/v1/email/messages', queryParameters: query);
    return [
      for (final m in (await _api.get(path.toString()))! as List)
        EmailMessage.fromJson(m as Map<String, dynamic>),
    ];
  }

  Future<EmailMessage> message(String id) async => EmailMessage.fromJson(
    (await _api.get('/api/v1/email/messages/$id'))! as Map<String, dynamic>,
  );

  Future<EmailMessage> send(SendEmailRequest request) async =>
      EmailMessage.fromJson(
        (await _api.post('/api/v1/email/send', request.toJson()))!
            as Map<String, dynamic>,
      );
}

final emailApiProvider = Provider<EmailApi?>((ref) {
  final api = ref.watch(apiClientProvider);
  return api == null ? null : EmailApi(api);
});

/// Comptes email de l'utilisateur (rechargés par `ref.invalidate`).
final emailAccountsProvider =
    FutureProvider.autoDispose<List<EmailAccountInfo>>(
      (ref) => ref.watch(emailApiProvider)!.accounts(),
    );
