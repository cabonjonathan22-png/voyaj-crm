import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:voyaj_client/app/bootstrap.dart';
import 'package:voyaj_client/core/api_client.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'crm_seed.dart';

/// API simulée pour les tests d'écrans (données publiques) ; les autres
/// appels échouent comme hors ligne.
ApiClient fakeApi(Bootstrap boot) {
  final now = DateTime.now().toUtc();
  PublicDataRun run(
    String source,
    PublicRunStatus status, {
    int hours = 5,
    String? error,
  }) => PublicDataRun(
    id: newId(),
    source: source,
    trigger: PublicRunTrigger.schedule,
    status: status,
    startedAt: now.subtract(Duration(hours: hours)),
    finishedAt: now.subtract(Duration(hours: hours, minutes: -2)),
    fetched: 285,
    created: 12,
    updated: 4,
    unchanged: 269,
    error: error,
  );
  final runs = [
    run('communes', PublicRunStatus.succeeded),
    run('epcis', PublicRunStatus.succeeded, hours: 6),
    run(
      'festivals',
      PublicRunStatus.failed,
      hours: 7,
      error: 'data.culture.gouv.fr a répondu 503.',
    ),
  ];
  final sources = [
    for (final source in PublicSource.values)
      PublicSourceStatus(
        source: source.key,
        enabled: source != PublicSource.aoms,
        departements: source == PublicSource.regions
            ? const []
            : const ['12', '81'],
        lastRun: runs.where((r) => r.source == source.key).firstOrNull,
      ),
  ];
  final accountId = newId();
  final accounts = [
    EmailAccountInfo(
      id: accountId,
      provider: EmailProvider.google,
      address: 'camille.martin@voyaj.fr',
      displayName: 'Camille Martin',
      enabled: true,
      lastSyncAt: now.subtract(const Duration(minutes: 3)),
    ),
  ];
  EmailMessage message(
    int i,
    String from,
    String subject, {
    String direction = 'in',
    bool read = true,
    String? contact,
  }) => EmailMessage(
    id: 'msg-$i',
    accountId: accountId,
    direction: direction,
    from: EmailAddress(address: from, name: from.split('@').first),
    to: const [EmailAddress(address: 'camille.martin@voyaj.fr')],
    subject: subject,
    snippet: 'Bonjour, suite à notre échange de la semaine dernière…',
    bodyText:
        'Bonjour,\n\nSuite à notre échange de la semaine dernière, '
        'voici les éléments demandés.\n\nCordialement,',
    sentAt: now.subtract(Duration(hours: i * 5)),
    read: read,
    contactId: contact,
  );
  final messages = [
    message(
      1,
      'a.durand@rodez.fr',
      'Budget navettes 2027',
      read: false,
      contact: sid('ct-1'),
    ),
    message(2, 'newsletter@mobilites.fr', 'Les mobilités en France'),
    message(
      3,
      'camille.martin@voyaj.fr',
      'Proposition — Mairie de Millau',
      direction: 'out',
      contact: sid('ct-3'),
    ),
  ];
  return ApiClient(
    baseUri: boot.serverUrl!,
    loadTokens: () async => boot.tokens,
    saveTokens: (_) async {},
    onSessionLost: (_) {},
    httpClient: MockClient((request) async {
      final body = switch (request.url.path) {
        '/api/v1/public-data' => [for (final s in sources) s.toJson()],
        '/api/v1/public-data/runs' => [for (final r in runs) r.toJson()],
        '/api/v1/email/providers' => ['imap', 'google', 'microsoft'],
        '/api/v1/email/accounts' => [for (final a in accounts) a.toJson()],
        '/api/v1/email/messages' => [for (final m in messages) m.toJson()],
        final path when path.startsWith('/api/v1/email/messages/') =>
          messages.first.toJson(),
        _ => null,
      };
      return body == null
          ? http.Response('', 503)
          : http.Response.bytes(
              utf8.encode(jsonEncode(body)),
              200,
              headers: {'content-type': 'application/json'},
            );
    }),
  );
}
