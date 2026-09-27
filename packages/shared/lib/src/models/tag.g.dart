// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Tag _$TagFromJson(Map<String, dynamic> json) => _Tag(
  id: json['id'] as String,
  name: json['name'] as String,
  color: json['color'] as String,
  description: json['description'] as String?,
  version: (json['version'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['created_at'] as String),
  createdBy: json['created_by'] as String?,
  updatedAt: DateTime.parse(json['updated_at'] as String),
  updatedBy: json['updated_by'] as String?,
  deletedAt: json['deleted_at'] == null
      ? null
      : DateTime.parse(json['deleted_at'] as String),
);

Map<String, dynamic> _$TagToJson(_Tag instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'color': instance.color,
  'description': instance.description,
  'version': instance.version,
  'created_at': instance.createdAt.toIso8601String(),
  'created_by': instance.createdBy,
  'updated_at': instance.updatedAt.toIso8601String(),
  'updated_by': instance.updatedBy,
  'deleted_at': instance.deletedAt?.toIso8601String(),
};
