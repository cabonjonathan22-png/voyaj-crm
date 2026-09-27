// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protocol.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyncOperation _$SyncOperationFromJson(Map<String, dynamic> json) =>
    _SyncOperation(
      opId: json['op_id'] as String,
      entity: json['entity'] as String,
      entityId: json['entity_id'] as String,
      baseVersion: (json['base_version'] as num).toInt(),
      hlc: json['hlc'] as String,
      fields: json['fields'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$SyncOperationToJson(_SyncOperation instance) =>
    <String, dynamic>{
      'op_id': instance.opId,
      'entity': instance.entity,
      'entity_id': instance.entityId,
      'base_version': instance.baseVersion,
      'hlc': instance.hlc,
      'fields': instance.fields,
    };

_PushRequest _$PushRequestFromJson(Map<String, dynamic> json) => _PushRequest(
  deviceId: json['device_id'] as String,
  operations: (json['operations'] as List<dynamic>)
      .map((e) => SyncOperation.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PushRequestToJson(_PushRequest instance) =>
    <String, dynamic>{
      'device_id': instance.deviceId,
      'operations': instance.operations.map((e) => e.toJson()).toList(),
    };

_OpResult _$OpResultFromJson(Map<String, dynamic> json) => _OpResult(
  opId: json['op_id'] as String,
  status: $enumDecode(_$OpStatusEnumMap, json['status']),
  record: json['record'] == null
      ? null
      : SyncRecord.fromJson(json['record'] as Map<String, dynamic>),
  conflicts: (json['conflicts'] as num?)?.toInt() ?? 0,
  issues:
      (json['issues'] as List<dynamic>?)
          ?.map((e) => ValidationIssue.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$OpResultToJson(_OpResult instance) => <String, dynamic>{
  'op_id': instance.opId,
  'status': _$OpStatusEnumMap[instance.status]!,
  'record': instance.record?.toJson(),
  'conflicts': instance.conflicts,
  'issues': instance.issues.map((e) => e.toJson()).toList(),
};

const _$OpStatusEnumMap = {
  OpStatus.applied: 'applied',
  OpStatus.partial: 'partial',
  OpStatus.superseded: 'superseded',
  OpStatus.duplicate: 'duplicate',
  OpStatus.invalid: 'invalid',
  OpStatus.forbidden: 'forbidden',
};

_PushResponse _$PushResponseFromJson(Map<String, dynamic> json) =>
    _PushResponse(
      results: (json['results'] as List<dynamic>)
          .map((e) => OpResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PushResponseToJson(_PushResponse instance) =>
    <String, dynamic>{
      'results': instance.results.map((e) => e.toJson()).toList(),
    };

_SyncRecord _$SyncRecordFromJson(Map<String, dynamic> json) => _SyncRecord(
  entity: json['entity'] as String,
  id: json['id'] as String,
  version: (json['version'] as num).toInt(),
  seq: (json['seq'] as num).toInt(),
  data: json['data'] as Map<String, dynamic>,
  fieldMeta: (json['field_meta'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, FieldStamp.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$SyncRecordToJson(_SyncRecord instance) =>
    <String, dynamic>{
      'entity': instance.entity,
      'id': instance.id,
      'version': instance.version,
      'seq': instance.seq,
      'data': instance.data,
      'field_meta': instance.fieldMeta.map((k, e) => MapEntry(k, e.toJson())),
    };

_PullResponse _$PullResponseFromJson(Map<String, dynamic> json) =>
    _PullResponse(
      records: (json['records'] as List<dynamic>)
          .map((e) => SyncRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      cursor: (json['cursor'] as num).toInt(),
      hasMore: json['has_more'] as bool,
    );

Map<String, dynamic> _$PullResponseToJson(_PullResponse instance) =>
    <String, dynamic>{
      'records': instance.records.map((e) => e.toJson()).toList(),
      'cursor': instance.cursor,
      'has_more': instance.hasMore,
    };

_SyncConflict _$SyncConflictFromJson(Map<String, dynamic> json) =>
    _SyncConflict(
      id: json['id'] as String,
      entity: json['entity'] as String,
      entityId: json['entity_id'] as String,
      field: json['field'] as String,
      winningValue: json['winning_value'],
      losingValue: json['losing_value'],
      winningHlc: json['winning_hlc'] as String,
      losingHlc: json['losing_hlc'] as String,
      winnerUserId: json['winner_user_id'] as String?,
      winnerName: json['winner_name'] as String?,
      loserUserId: json['loser_user_id'] as String?,
      loserName: json['loser_name'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      reviewedAt: json['reviewed_at'] == null
          ? null
          : DateTime.parse(json['reviewed_at'] as String),
      reviewedBy: json['reviewed_by'] as String?,
    );

Map<String, dynamic> _$SyncConflictToJson(_SyncConflict instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entity': instance.entity,
      'entity_id': instance.entityId,
      'field': instance.field,
      'winning_value': instance.winningValue,
      'losing_value': instance.losingValue,
      'winning_hlc': instance.winningHlc,
      'losing_hlc': instance.losingHlc,
      'winner_user_id': instance.winnerUserId,
      'winner_name': instance.winnerName,
      'loser_user_id': instance.loserUserId,
      'loser_name': instance.loserName,
      'created_at': instance.createdAt.toIso8601String(),
      'reviewed_at': instance.reviewedAt?.toIso8601String(),
      'reviewed_by': instance.reviewedBy,
    };

ClientAuth _$ClientAuthFromJson(Map<String, dynamic> json) => ClientAuth(
  accessToken: json['access_token'] as String,
  protocolVersion: (json['protocol_version'] as num).toInt(),
);

Map<String, dynamic> _$ClientAuthToJson(ClientAuth instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'protocol_version': instance.protocolVersion,
    };

ServerReady _$ServerReadyFromJson(Map<String, dynamic> json) => ServerReady(
  cursor: (json['cursor'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ServerReadyToJson(ServerReady instance) =>
    <String, dynamic>{'cursor': instance.cursor, 'type': instance.$type};

ServerChanges _$ServerChangesFromJson(Map<String, dynamic> json) =>
    ServerChanges(
      cursor: (json['cursor'] as num).toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ServerChangesToJson(ServerChanges instance) =>
    <String, dynamic>{'cursor': instance.cursor, 'type': instance.$type};

ServerSessionRevoked _$ServerSessionRevokedFromJson(
  Map<String, dynamic> json,
) => ServerSessionRevoked($type: json['type'] as String?);

Map<String, dynamic> _$ServerSessionRevokedToJson(
  ServerSessionRevoked instance,
) => <String, dynamic>{'type': instance.$type};

ServerError _$ServerErrorFromJson(Map<String, dynamic> json) => ServerError(
  code: json['code'] as String,
  message: json['message'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ServerErrorToJson(ServerError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'type': instance.$type,
    };
