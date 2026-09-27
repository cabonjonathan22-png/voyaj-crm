import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:voyaj_client/app/bootstrap.dart';
import 'package:voyaj_client/core/api_client.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

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
  return ApiClient(
    baseUri: boot.serverUrl!,
    loadTokens: () async => boot.tokens,
    saveTokens: (_) async {},
    onSessionLost: (_) {},
    httpClient: MockClient((request) async {
      final body = switch (request.url.path) {
        '/api/v1/public-data' => [for (final s in sources) s.toJson()],
        '/api/v1/public-data/runs' => [for (final r in runs) r.toJson()],
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
