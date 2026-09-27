// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    _LoginRequest(
      email: json['email'] as String,
      password: json['password'] as String,
      device: DeviceInfo.fromJson(json['device'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginRequestToJson(_LoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'device': instance.device.toJson(),
    };

_DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => _DeviceInfo(
  id: json['id'] as String,
  name: json['name'] as String,
  platform: json['platform'] as String,
  appVersion: json['app_version'] as String,
);

Map<String, dynamic> _$DeviceInfoToJson(_DeviceInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'platform': instance.platform,
      'app_version': instance.appVersion,
    };

LoginAuthenticated _$LoginAuthenticatedFromJson(Map<String, dynamic> json) =>
    LoginAuthenticated(
      tokens: AuthTokens.fromJson(json['tokens'] as Map<String, dynamic>),
      user: CurrentUser.fromJson(json['user'] as Map<String, dynamic>),
      $type: json['status'] as String?,
    );

Map<String, dynamic> _$LoginAuthenticatedToJson(LoginAuthenticated instance) =>
    <String, dynamic>{
      'tokens': instance.tokens.toJson(),
      'user': instance.user.toJson(),
      'status': instance.$type,
    };

LoginMfaRequired _$LoginMfaRequiredFromJson(Map<String, dynamic> json) =>
    LoginMfaRequired(
      mfaToken: json['mfa_token'] as String,
      $type: json['status'] as String?,
    );

Map<String, dynamic> _$LoginMfaRequiredToJson(LoginMfaRequired instance) =>
    <String, dynamic>{'mfa_token': instance.mfaToken, 'status': instance.$type};

_MfaVerifyRequest _$MfaVerifyRequestFromJson(Map<String, dynamic> json) =>
    _MfaVerifyRequest(
      mfaToken: json['mfa_token'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$MfaVerifyRequestToJson(_MfaVerifyRequest instance) =>
    <String, dynamic>{'mfa_token': instance.mfaToken, 'code': instance.code};

_AuthTokens _$AuthTokensFromJson(Map<String, dynamic> json) => _AuthTokens(
  sessionId: json['session_id'] as String,
  accessToken: json['access_token'] as String,
  accessExpiresAt: DateTime.parse(json['access_expires_at'] as String),
  refreshToken: json['refresh_token'] as String,
  refreshExpiresAt: DateTime.parse(json['refresh_expires_at'] as String),
);

Map<String, dynamic> _$AuthTokensToJson(_AuthTokens instance) =>
    <String, dynamic>{
      'session_id': instance.sessionId,
      'access_token': instance.accessToken,
      'access_expires_at': instance.accessExpiresAt.toIso8601String(),
      'refresh_token': instance.refreshToken,
      'refresh_expires_at': instance.refreshExpiresAt.toIso8601String(),
    };

_RefreshRequest _$RefreshRequestFromJson(Map<String, dynamic> json) =>
    _RefreshRequest(refreshToken: json['refresh_token'] as String);

Map<String, dynamic> _$RefreshRequestToJson(_RefreshRequest instance) =>
    <String, dynamic>{'refresh_token': instance.refreshToken};

_CurrentUser _$CurrentUserFromJson(Map<String, dynamic> json) => _CurrentUser(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['display_name'] as String,
  totpEnabled: json['totp_enabled'] as bool,
  roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
  permissions: (json['permissions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$CurrentUserToJson(_CurrentUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'display_name': instance.displayName,
      'totp_enabled': instance.totpEnabled,
      'roles': instance.roles,
      'permissions': instance.permissions,
    };

_SessionInfo _$SessionInfoFromJson(Map<String, dynamic> json) => _SessionInfo(
  id: json['id'] as String,
  deviceName: json['device_name'] as String,
  platform: json['platform'] as String,
  ip: json['ip'] as String?,
  userAgent: json['user_agent'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  lastSeenAt: DateTime.parse(json['last_seen_at'] as String),
  current: json['current'] as bool,
);

Map<String, dynamic> _$SessionInfoToJson(_SessionInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'device_name': instance.deviceName,
      'platform': instance.platform,
      'ip': instance.ip,
      'user_agent': instance.userAgent,
      'created_at': instance.createdAt.toIso8601String(),
      'last_seen_at': instance.lastSeenAt.toIso8601String(),
      'current': instance.current,
    };

_TotpSetupResponse _$TotpSetupResponseFromJson(Map<String, dynamic> json) =>
    _TotpSetupResponse(
      secret: json['secret'] as String,
      otpauthUri: json['otpauth_uri'] as String,
    );

Map<String, dynamic> _$TotpSetupResponseToJson(_TotpSetupResponse instance) =>
    <String, dynamic>{
      'secret': instance.secret,
      'otpauth_uri': instance.otpauthUri,
    };

_CodeRequest _$CodeRequestFromJson(Map<String, dynamic> json) =>
    _CodeRequest(code: json['code'] as String);

Map<String, dynamic> _$CodeRequestToJson(_CodeRequest instance) =>
    <String, dynamic>{'code': instance.code};

_RecoveryCodesResponse _$RecoveryCodesResponseFromJson(
  Map<String, dynamic> json,
) => _RecoveryCodesResponse(
  codes: (json['codes'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$RecoveryCodesResponseToJson(
  _RecoveryCodesResponse instance,
) => <String, dynamic>{'codes': instance.codes};

_ChangePasswordRequest _$ChangePasswordRequestFromJson(
  Map<String, dynamic> json,
) => _ChangePasswordRequest(
  currentPassword: json['current_password'] as String,
  newPassword: json['new_password'] as String,
);

Map<String, dynamic> _$ChangePasswordRequestToJson(
  _ChangePasswordRequest instance,
) => <String, dynamic>{
  'current_password': instance.currentPassword,
  'new_password': instance.newPassword,
};

_UserSummary _$UserSummaryFromJson(Map<String, dynamic> json) => _UserSummary(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['display_name'] as String,
  status: $enumDecode(_$UserStatusEnumMap, json['status']),
  roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
  totpEnabled: json['totp_enabled'] as bool,
  lastLoginAt: json['last_login_at'] == null
      ? null
      : DateTime.parse(json['last_login_at'] as String),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$UserSummaryToJson(_UserSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'display_name': instance.displayName,
      'status': _$UserStatusEnumMap[instance.status]!,
      'roles': instance.roles,
      'totp_enabled': instance.totpEnabled,
      'last_login_at': instance.lastLoginAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$UserStatusEnumMap = {
  UserStatus.active: 'active',
  UserStatus.disabled: 'disabled',
};

_CreateUserRequest _$CreateUserRequestFromJson(Map<String, dynamic> json) =>
    _CreateUserRequest(
      email: json['email'] as String,
      displayName: json['display_name'] as String,
      password: json['password'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CreateUserRequestToJson(_CreateUserRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'display_name': instance.displayName,
      'password': instance.password,
      'roles': instance.roles,
    };

_UpdateUserRequest _$UpdateUserRequestFromJson(Map<String, dynamic> json) =>
    _UpdateUserRequest(
      displayName: json['display_name'] as String?,
      status: $enumDecodeNullable(_$UserStatusEnumMap, json['status']),
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UpdateUserRequestToJson(_UpdateUserRequest instance) =>
    <String, dynamic>{
      'display_name': instance.displayName,
      'status': _$UserStatusEnumMap[instance.status],
      'roles': instance.roles,
    };

_RoleInfo _$RoleInfoFromJson(Map<String, dynamic> json) => _RoleInfo(
  id: json['id'] as String,
  key: json['key'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  isSystem: json['is_system'] as bool,
  permissions: (json['permissions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$RoleInfoToJson(_RoleInfo instance) => <String, dynamic>{
  'id': instance.id,
  'key': instance.key,
  'name': instance.name,
  'description': instance.description,
  'is_system': instance.isSystem,
  'permissions': instance.permissions,
};
