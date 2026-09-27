// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BackupInfo _$BackupInfoFromJson(Map<String, dynamic> json) => _BackupInfo(
  name: json['name'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  trigger: json['trigger'] as String,
  databaseBytes: (json['database_bytes'] as num).toInt(),
  newFiles: (json['new_files'] as num?)?.toInt() ?? 0,
  totalFiles: (json['total_files'] as num?)?.toInt() ?? 0,
  schemaVersion: (json['schema_version'] as num).toInt(),
);

Map<String, dynamic> _$BackupInfoToJson(_BackupInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'trigger': instance.trigger,
      'database_bytes': instance.databaseBytes,
      'new_files': instance.newFiles,
      'total_files': instance.totalFiles,
      'schema_version': instance.schemaVersion,
    };

_BackupStatus _$BackupStatusFromJson(Map<String, dynamic> json) =>
    _BackupStatus(
      directory: json['directory'] as String,
      hour: (json['hour'] as num?)?.toInt(),
      keepDays: (json['keep_days'] as num).toInt(),
      backups:
          (json['backups'] as List<dynamic>?)
              ?.map((e) => BackupInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastError: json['last_error'] as String?,
    );

Map<String, dynamic> _$BackupStatusToJson(_BackupStatus instance) =>
    <String, dynamic>{
      'directory': instance.directory,
      'hour': instance.hour,
      'keep_days': instance.keepDays,
      'backups': instance.backups.map((e) => e.toJson()).toList(),
      'last_error': instance.lastError,
    };
