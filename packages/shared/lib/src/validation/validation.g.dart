// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ValidationIssue _$ValidationIssueFromJson(Map<String, dynamic> json) =>
    _ValidationIssue(
      field: json['field'] as String,
      code: json['code'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ValidationIssueToJson(_ValidationIssue instance) =>
    <String, dynamic>{
      'field': instance.field,
      'code': instance.code,
      'message': instance.message,
    };
