// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_stamp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FieldStamp _$FieldStampFromJson(Map<String, dynamic> json) => _FieldStamp(
  hlc: json['h'] as String,
  version: (json['v'] as num).toInt(),
  userId: json['u'] as String?,
);

Map<String, dynamic> _$FieldStampToJson(_FieldStamp instance) =>
    <String, dynamic>{
      'h': instance.hlc,
      'v': instance.version,
      'u': instance.userId,
    };
