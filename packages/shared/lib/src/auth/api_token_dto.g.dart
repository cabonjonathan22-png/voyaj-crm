// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_token_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApiTokenInfo _$ApiTokenInfoFromJson(Map<String, dynamic> json) =>
    _ApiTokenInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      lastUsedAt: json['last_used_at'] == null
          ? null
          : DateTime.parse(json['last_used_at'] as String),
      expiresAt: json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
    );

Map<String, dynamic> _$ApiTokenInfoToJson(_ApiTokenInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'permissions': instance.permissions,
      'created_at': instance.createdAt.toIso8601String(),
      'last_used_at': instance.lastUsedAt?.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
    };

_CreateApiTokenRequest _$CreateApiTokenRequestFromJson(
  Map<String, dynamic> json,
) => _CreateApiTokenRequest(
  name: json['name'] as String,
  permissions: (json['permissions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  expiresInDays: (json['expires_in_days'] as num?)?.toInt(),
);

Map<String, dynamic> _$CreateApiTokenRequestToJson(
  _CreateApiTokenRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'permissions': instance.permissions,
  'expires_in_days': instance.expiresInDays,
};

_CreatedApiToken _$CreatedApiTokenFromJson(Map<String, dynamic> json) =>
    _CreatedApiToken(
      info: ApiTokenInfo.fromJson(json['info'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$CreatedApiTokenToJson(_CreatedApiToken instance) =>
    <String, dynamic>{'info': instance.info.toJson(), 'token': instance.token};
