// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PublicDataRun _$PublicDataRunFromJson(Map<String, dynamic> json) =>
    _PublicDataRun(
      id: json['id'] as String,
      source: json['source'] as String,
      trigger: $enumDecode(_$PublicRunTriggerEnumMap, json['trigger']),
      status: $enumDecode(_$PublicRunStatusEnumMap, json['status']),
      startedAt: DateTime.parse(json['started_at'] as String),
      finishedAt: json['finished_at'] == null
          ? null
          : DateTime.parse(json['finished_at'] as String),
      fetched: (json['fetched'] as num?)?.toInt() ?? 0,
      created: (json['created'] as num?)?.toInt() ?? 0,
      updated: (json['updated'] as num?)?.toInt() ?? 0,
      unchanged: (json['unchanged'] as num?)?.toInt() ?? 0,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$PublicDataRunToJson(_PublicDataRun instance) =>
    <String, dynamic>{
      'id': instance.id,
      'source': instance.source,
      'trigger': _$PublicRunTriggerEnumMap[instance.trigger]!,
      'status': _$PublicRunStatusEnumMap[instance.status]!,
      'started_at': instance.startedAt.toIso8601String(),
      'finished_at': instance.finishedAt?.toIso8601String(),
      'fetched': instance.fetched,
      'created': instance.created,
      'updated': instance.updated,
      'unchanged': instance.unchanged,
      'error': instance.error,
    };

const _$PublicRunTriggerEnumMap = {
  PublicRunTrigger.manual: 'manual',
  PublicRunTrigger.schedule: 'schedule',
};

const _$PublicRunStatusEnumMap = {
  PublicRunStatus.running: 'running',
  PublicRunStatus.succeeded: 'succeeded',
  PublicRunStatus.failed: 'failed',
};

_PublicSourceStatus _$PublicSourceStatusFromJson(Map<String, dynamic> json) =>
    _PublicSourceStatus(
      source: json['source'] as String,
      enabled: json['enabled'] as bool,
      departements: (json['departements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastRun: json['last_run'] == null
          ? null
          : PublicDataRun.fromJson(json['last_run'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PublicSourceStatusToJson(_PublicSourceStatus instance) =>
    <String, dynamic>{
      'source': instance.source,
      'enabled': instance.enabled,
      'departements': instance.departements,
      'last_run': instance.lastRun?.toJson(),
    };

_ConfigurePublicSourceRequest _$ConfigurePublicSourceRequestFromJson(
  Map<String, dynamic> json,
) => _ConfigurePublicSourceRequest(
  enabled: json['enabled'] as bool,
  departements: (json['departements'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ConfigurePublicSourceRequestToJson(
  _ConfigurePublicSourceRequest instance,
) => <String, dynamic>{
  'enabled': instance.enabled,
  'departements': instance.departements,
};
