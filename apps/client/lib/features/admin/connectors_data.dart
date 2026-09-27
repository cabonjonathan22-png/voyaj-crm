import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/providers.dart';
import '../../core/api_client.dart';

/// Accès à l'API des connecteurs et webhooks (connexion requise).
final class ConnectorsApi {
  const ConnectorsApi(this._api);

  final ApiClient _api;

  Future<List<ConnectorInfo>> list() async => [
    for (final c in (await _api.get('/api/v1/connectors'))! as List)
      ConnectorInfo.fromJson(c as Map<String, dynamic>),
  ];

  Future<ConnectorInfo> save(String? id, ConnectorInput input) async =>
      ConnectorInfo.fromJson(
        (id == null
                ? await _api.post('/api/v1/connectors', input.toJson())
                : await _api.put('/api/v1/connectors/$id', input.toJson()))!
            as Map<String, dynamic>,
      );

  Future<void> delete(String id) => _api.delete('/api/v1/connectors/$id');

  Future<ConnectorPreview> preview(ConnectorInput input, {String? id}) async =>
      ConnectorPreview.fromJson(
        (await _api.post(
              '/api/v1/connectors/preview${id == null ? '' : '?id=$id'}',
              input.toJson(),
            ))!
            as Map<String, dynamic>,
      );

  Future<ConnectorRun> run(String id) async => ConnectorRun.fromJson(
    (await _api.post('/api/v1/connectors/$id/run'))! as Map<String, dynamic>,
  );

  Future<List<ConnectorRun>> runs(String id) async => [
    for (final r in (await _api.get('/api/v1/connectors/$id/runs'))! as List)
      ConnectorRun.fromJson(r as Map<String, dynamic>),
  ];

  Future<WebhookToken> webhookToken(String id) async => WebhookToken.fromJson(
    (await _api.post('/api/v1/connectors/$id/webhook-token'))!
        as Map<String, dynamic>,
  );

  Future<List<WebhookInfo>> webhooks() async => [
    for (final w in (await _api.get('/api/v1/webhooks'))! as List)
      WebhookInfo.fromJson(w as Map<String, dynamic>),
  ];

  Future<WebhookInfo> saveWebhook(String? id, WebhookInput input) async =>
      WebhookInfo.fromJson(
        (id == null
                ? await _api.post('/api/v1/webhooks', input.toJson())
                : await _api.put('/api/v1/webhooks/$id', input.toJson()))!
            as Map<String, dynamic>,
      );

  Future<void> deleteWebhook(String id) => _api.delete('/api/v1/webhooks/$id');

  Future<int> ping(String id) async =>
      ((await _api.post('/api/v1/webhooks/$id/ping'))!
              as Map<String, dynamic>)['status']
          as int;
}

final connectorsApiProvider = Provider<ConnectorsApi?>((ref) {
  final api = ref.watch(apiClientProvider);
  return api == null ? null : ConnectorsApi(api);
});

final connectorsProvider = FutureProvider.autoDispose<List<ConnectorInfo>>(
  (ref) => ref.watch(connectorsApiProvider)!.list(),
);

final webhooksProvider = FutureProvider.autoDispose<List<WebhookInfo>>(
  (ref) => ref.watch(connectorsApiProvider)!.webhooks(),
);

/// Champs jamais alimentés par un connecteur (provenance et propriété).
const _protectedFields = {'source', 'source_ref', 'collected_at', 'owner_id'};

/// Champs Voyaj alimentables d'une entité.
List<String> mappableFields(String entity) => [
  for (final field in SyncEntities.byName(entity)?.fields.keys ?? <String>[])
    if (!_protectedFields.contains(field)) field,
];
