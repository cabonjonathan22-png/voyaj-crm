// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuditEntry _$AuditEntryFromJson(Map<String, dynamic> json) => _AuditEntry(
  id: (json['id'] as num).toInt(),
  occurredAt: DateTime.parse(json['occurred_at'] as String),
  actorUserId: json['actor_user_id'] as String?,
  actorName: json['actor_name'] as String?,
  action: json['action'] as String,
  entity: json['entity'] as String?,
  entityId: json['entity_id'] as String?,
  payload: json['payload'] as Map<String, dynamic>,
  ip: json['ip'] as String?,
);

Map<String, dynamic> _$AuditEntryToJson(_AuditEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'occurred_at': instance.occurredAt.toIso8601String(),
      'actor_user_id': instance.actorUserId,
      'actor_name': instance.actorName,
      'action': instance.action,
      'entity': instance.entity,
      'entity_id': instance.entityId,
      'payload': instance.payload,
      'ip': instance.ip,
    };
