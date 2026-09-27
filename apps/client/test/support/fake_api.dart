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
  final connectors = [
    ConnectorInfo(
      id: newId(),
      name: 'Référentiel des communes (Supabase)',
      kind: ConnectorKind.supabase.key,
      config: const {'url': 'https://abcd.supabase.co', 'table': 'communes'},
      mapping: const ConnectorMapping(
        refPath: 'code_insee',
        matchField: 'insee_code',
        fields: [
          FieldMapping(target: 'name', source: 'nom'),
          FieldMapping(target: 'insee_code', source: 'code_insee'),
        ],
      ),
      scheduleMinutes: 1440,
      hasSecret: true,
      lastRun: ConnectorRun(
        id: newId(),
        connectorId: 'c1',
        trigger: 'schedule',
        status: 'succeeded',
        startedAt: now.subtract(const Duration(hours: 3)),
        finishedAt: now.subtract(const Duration(hours: 3)),
        fetched: 285,
        created: 4,
        updated: 12,
        unchanged: 267,
        rejected: 2,
      ),
    ),
    ConnectorInfo(
      id: newId(),
      name: 'Formulaire du site',
      kind: ConnectorKind.webhook.key,
      mapping: const ConnectorMapping(entity: 'contacts', refPath: 'email'),
      hasWebhookToken: true,
    ),
  ];
  final webhooks = [
    WebhookInfo(
      id: newId(),
      name: 'Entrepôt de données',
      url: 'https://hooks.exemple.fr/voyaj',
      entities: const ['organisations', 'deals'],
      hasSecret: true,
      lastSeq: 1200,
      lastDeliveryAt: now.subtract(const Duration(minutes: 8)),
      lastStatus: 200,
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
        '/api/v1/connectors' => [for (final c in connectors) c.toJson()],
        '/api/v1/webhooks' => [for (final w in webhooks) w.toJson()],
        '/api/v1/admin/backups' => BackupStatus(
          directory: '/var/lib/voyaj/backups',
          hour: 2,
          keepDays: 14,
          backups: [
            BackupInfo(
              name: 'voyaj-20260927-020000',
              createdAt: now.subtract(const Duration(hours: 8)),
              trigger: 'schedule',
              databaseBytes: 18400000,
              newFiles: 3,
              totalFiles: 412,
              schemaVersion: 8,
            ),
          ],
        ).toJson(),
        '/api/v1/auth/api-tokens' => [
          ApiTokenInfo(
            id: newId(),
            name: 'Synchronisation ERP',
            permissions: const ['organisation.read', 'invoice.read'],
            createdAt: now.subtract(const Duration(days: 40)),
            lastUsedAt: now.subtract(const Duration(hours: 2)),
            expiresAt: now.add(const Duration(days: 325)),
          ).toJson(),
        ],
        '/api/v1/billing/settings' => const BillingSettings(
          legalName: 'Voyaj SAS',
          siren: '123456782',
          city: 'Rodez',
          chorusEnabled: true,
          chorusLogin: 'TECH_voyaj@cpro.fr',
          pisteClientId: 'client-piste',
          chorusConfigured: true,
        ).toJson(),
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
