// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connector_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FieldMapping _$FieldMappingFromJson(Map<String, dynamic> json) =>
    _FieldMapping(
      target: json['target'] as String,
      source: json['source'] as String?,
      transform: json['transform'] as String? ?? 'none',
      constant: json['constant'],
    );

Map<String, dynamic> _$FieldMappingToJson(_FieldMapping instance) =>
    <String, dynamic>{
      'target': instance.target,
      'source': instance.source,
      'transform': instance.transform,
      'constant': instance.constant,
    };

_OrganisationLookup _$OrganisationLookupFromJson(Map<String, dynamic> json) =>
    _OrganisationLookup(
      source: json['source'] as String,
      field: json['field'] as String? ?? 'siren',
    );

Map<String, dynamic> _$OrganisationLookupToJson(_OrganisationLookup instance) =>
    <String, dynamic>{'source': instance.source, 'field': instance.field};

_ConnectorMapping _$ConnectorMappingFromJson(Map<String, dynamic> json) =>
    _ConnectorMapping(
      entity: json['entity'] as String? ?? 'organisations',
      refPath: json['ref_path'] as String? ?? 'id',
      fields:
          (json['fields'] as List<dynamic>?)
              ?.map((e) => FieldMapping.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      defaults: json['defaults'] as Map<String, dynamic>? ?? const {},
      matchField: json['match_field'] as String?,
      organisationLookup: json['organisation_lookup'] == null
          ? null
          : OrganisationLookup.fromJson(
              json['organisation_lookup'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ConnectorMappingToJson(_ConnectorMapping instance) =>
    <String, dynamic>{
      'entity': instance.entity,
      'ref_path': instance.refPath,
      'fields': instance.fields.map((e) => e.toJson()).toList(),
      'defaults': instance.defaults,
      'match_field': instance.matchField,
      'organisation_lookup': instance.organisationLookup?.toJson(),
    };

_ConnectorRun _$ConnectorRunFromJson(Map<String, dynamic> json) =>
    _ConnectorRun(
      id: json['id'] as String,
      connectorId: json['connector_id'] as String,
      trigger: json['trigger'] as String,
      status: json['status'] as String,
      startedAt: DateTime.parse(json['started_at'] as String),
      finishedAt: json['finished_at'] == null
          ? null
          : DateTime.parse(json['finished_at'] as String),
      fetched: (json['fetched'] as num?)?.toInt() ?? 0,
      created: (json['created'] as num?)?.toInt() ?? 0,
      updated: (json['updated'] as num?)?.toInt() ?? 0,
      unchanged: (json['unchanged'] as num?)?.toInt() ?? 0,
      rejected: (json['rejected'] as num?)?.toInt() ?? 0,
      problems:
          (json['problems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      error: json['error'] as String?,
    );

Map<String, dynamic> _$ConnectorRunToJson(_ConnectorRun instance) =>
    <String, dynamic>{
      'id': instance.id,
      'connector_id': instance.connectorId,
      'trigger': instance.trigger,
      'status': instance.status,
      'started_at': instance.startedAt.toIso8601String(),
      'finished_at': instance.finishedAt?.toIso8601String(),
      'fetched': instance.fetched,
      'created': instance.created,
      'updated': instance.updated,
      'unchanged': instance.unchanged,
      'rejected': instance.rejected,
      'problems': instance.problems,
      'error': instance.error,
    };

_ConnectorInfo _$ConnectorInfoFromJson(Map<String, dynamic> json) =>
    _ConnectorInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      kind: json['kind'] as String,
      config: json['config'] as Map<String, dynamic>? ?? const {},
      mapping: json['mapping'] == null
          ? const ConnectorMapping()
          : ConnectorMapping.fromJson(json['mapping'] as Map<String, dynamic>),
      enabled: json['enabled'] as bool? ?? true,
      scheduleMinutes: (json['schedule_minutes'] as num?)?.toInt(),
      hasSecret: json['has_secret'] as bool? ?? false,
      hasWebhookToken: json['has_webhook_token'] as bool? ?? false,
      lastRun: json['last_run'] == null
          ? null
          : ConnectorRun.fromJson(json['last_run'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConnectorInfoToJson(_ConnectorInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'kind': instance.kind,
      'config': instance.config,
      'mapping': instance.mapping.toJson(),
      'enabled': instance.enabled,
      'schedule_minutes': instance.scheduleMinutes,
      'has_secret': instance.hasSecret,
      'has_webhook_token': instance.hasWebhookToken,
      'last_run': instance.lastRun?.toJson(),
    };

_ConnectorInput _$ConnectorInputFromJson(Map<String, dynamic> json) =>
    _ConnectorInput(
      name: json['name'] as String,
      kind: json['kind'] as String,
      config: json['config'] as Map<String, dynamic>? ?? const {},
      mapping: json['mapping'] == null
          ? const ConnectorMapping()
          : ConnectorMapping.fromJson(json['mapping'] as Map<String, dynamic>),
      enabled: json['enabled'] as bool? ?? true,
      scheduleMinutes: (json['schedule_minutes'] as num?)?.toInt(),
      secret: json['secret'] as String?,
    );

Map<String, dynamic> _$ConnectorInputToJson(_ConnectorInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'kind': instance.kind,
      'config': instance.config,
      'mapping': instance.mapping.toJson(),
      'enabled': instance.enabled,
      'schedule_minutes': instance.scheduleMinutes,
      'secret': instance.secret,
    };

_MappedRecord _$MappedRecordFromJson(Map<String, dynamic> json) =>
    _MappedRecord(
      ref: json['ref'] as String?,
      fields: json['fields'] as Map<String, dynamic>? ?? const {},
      problems:
          (json['problems'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MappedRecordToJson(_MappedRecord instance) =>
    <String, dynamic>{
      'ref': instance.ref,
      'fields': instance.fields,
      'problems': instance.problems,
    };

_ConnectorPreview _$ConnectorPreviewFromJson(Map<String, dynamic> json) =>
    _ConnectorPreview(
      paths:
          (json['paths'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      raw:
          (json['raw'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
      mapped:
          (json['mapped'] as List<dynamic>?)
              ?.map((e) => MappedRecord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ConnectorPreviewToJson(_ConnectorPreview instance) =>
    <String, dynamic>{
      'paths': instance.paths,
      'raw': instance.raw,
      'mapped': instance.mapped.map((e) => e.toJson()).toList(),
    };

_WebhookToken _$WebhookTokenFromJson(Map<String, dynamic> json) =>
    _WebhookToken(url: json['url'] as String, token: json['token'] as String);

Map<String, dynamic> _$WebhookTokenToJson(_WebhookToken instance) =>
    <String, dynamic>{'url': instance.url, 'token': instance.token};

_WebhookInfo _$WebhookInfoFromJson(Map<String, dynamic> json) => _WebhookInfo(
  id: json['id'] as String,
  name: json['name'] as String,
  url: json['url'] as String,
  entities:
      (json['entities'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  enabled: json['enabled'] as bool? ?? true,
  hasSecret: json['has_secret'] as bool? ?? false,
  lastSeq: (json['last_seq'] as num?)?.toInt() ?? 0,
  lastDeliveryAt: json['last_delivery_at'] == null
      ? null
      : DateTime.parse(json['last_delivery_at'] as String),
  lastStatus: (json['last_status'] as num?)?.toInt(),
  lastError: json['last_error'] as String?,
  failures: (json['failures'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$WebhookInfoToJson(_WebhookInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'entities': instance.entities,
      'enabled': instance.enabled,
      'has_secret': instance.hasSecret,
      'last_seq': instance.lastSeq,
      'last_delivery_at': instance.lastDeliveryAt?.toIso8601String(),
      'last_status': instance.lastStatus,
      'last_error': instance.lastError,
      'failures': instance.failures,
    };

_WebhookInput _$WebhookInputFromJson(Map<String, dynamic> json) =>
    _WebhookInput(
      name: json['name'] as String,
      url: json['url'] as String,
      entities:
          (json['entities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      enabled: json['enabled'] as bool? ?? true,
      secret: json['secret'] as String?,
    );

Map<String, dynamic> _$WebhookInputToJson(_WebhookInput instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
      'entities': instance.entities,
      'enabled': instance.enabled,
      'secret': instance.secret,
    };
