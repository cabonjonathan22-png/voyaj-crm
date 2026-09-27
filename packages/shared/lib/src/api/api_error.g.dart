// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiError _$ApiErrorFromJson(Map<String, dynamic> json) => _ApiError(
  code: json['code'] as String,
  message: json['message'] as String,
  issues:
      (json['issues'] as List<dynamic>?)
          ?.map((e) => ValidationIssue.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ApiErrorToJson(_ApiError instance) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'issues': instance.issues.map((e) => e.toJson()).toList(),
};
