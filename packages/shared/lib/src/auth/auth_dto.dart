import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_dto.freezed.dart';
part 'auth_dto.g.dart';

@freezed
abstract class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    required String email,
    required String password,
    required DeviceInfo device,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}

/// Poste client qui ouvre la session.
@freezed
abstract class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    /// Identifiant stable du poste (UUID généré à l'installation).
    required String id,
    required String name,
    required String platform,
    required String appVersion,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}

/// Réponse à une tentative de connexion.
@Freezed(unionKey: 'status', unionValueCase: FreezedUnionCase.snake)
sealed class LoginResponse with _$LoginResponse {
  /// Connexion réussie.
  const factory LoginResponse.authenticated({
    required AuthTokens tokens,
    required CurrentUser user,
  }) = LoginAuthenticated;

  /// Mot de passe correct, code 2FA requis.
  const factory LoginResponse.mfaRequired({
    /// Jeton temporaire (5 min) à renvoyer avec le code.
    required String mfaToken,
  }) = LoginMfaRequired;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
abstract class MfaVerifyRequest with _$MfaVerifyRequest {
  const factory MfaVerifyRequest({
    required String mfaToken,

    /// Code TOTP à 6 chiffres ou code de secours.
    required String code,
  }) = _MfaVerifyRequest;

  factory MfaVerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$MfaVerifyRequestFromJson(json);
}

@freezed
abstract class AuthTokens with _$AuthTokens {
  const factory AuthTokens({
    required String sessionId,
    required String accessToken,
    required DateTime accessExpiresAt,
    required String refreshToken,
    required DateTime refreshExpiresAt,
  }) = _AuthTokens;

  factory AuthTokens.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensFromJson(json);
}

@freezed
abstract class RefreshRequest with _$RefreshRequest {
  const factory RefreshRequest({required String refreshToken}) =
      _RefreshRequest;

  factory RefreshRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshRequestFromJson(json);
}

/// Utilisateur connecté, avec ses permissions effectives.
@freezed
abstract class CurrentUser with _$CurrentUser {
  const factory CurrentUser({
    required String id,
    required String email,
    required String displayName,
    required bool totpEnabled,
    required List<String> roles,
    required List<String> permissions,
  }) = _CurrentUser;

  factory CurrentUser.fromJson(Map<String, dynamic> json) =>
      _$CurrentUserFromJson(json);
}

/// Session ouverte (affichée dans « Sécurité > Sessions »).
@freezed
abstract class SessionInfo with _$SessionInfo {
  const factory SessionInfo({
    required String id,
    required String deviceName,
    required String platform,
    String? ip,
    String? userAgent,
    required DateTime createdAt,
    required DateTime lastSeenAt,
    required bool current,
  }) = _SessionInfo;

  factory SessionInfo.fromJson(Map<String, dynamic> json) =>
      _$SessionInfoFromJson(json);
}

@freezed
abstract class TotpSetupResponse with _$TotpSetupResponse {
  const factory TotpSetupResponse({
    /// Secret en base32 (saisie manuelle).
    required String secret,

    /// URI `otpauth://` à encoder en QR code.
    required String otpauthUri,
  }) = _TotpSetupResponse;

  factory TotpSetupResponse.fromJson(Map<String, dynamic> json) =>
      _$TotpSetupResponseFromJson(json);
}

@freezed
abstract class CodeRequest with _$CodeRequest {
  const factory CodeRequest({required String code}) = _CodeRequest;

  factory CodeRequest.fromJson(Map<String, dynamic> json) =>
      _$CodeRequestFromJson(json);
}

@freezed
abstract class RecoveryCodesResponse with _$RecoveryCodesResponse {
  const factory RecoveryCodesResponse({required List<String> codes}) =
      _RecoveryCodesResponse;

  factory RecoveryCodesResponse.fromJson(Map<String, dynamic> json) =>
      _$RecoveryCodesResponseFromJson(json);
}

@freezed
abstract class ChangePasswordRequest with _$ChangePasswordRequest {
  const factory ChangePasswordRequest({
    required String currentPassword,
    required String newPassword,
  }) = _ChangePasswordRequest;

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);
}

enum UserStatus { active, disabled }

/// Utilisateur vu par un administrateur.
@freezed
abstract class UserSummary with _$UserSummary {
  const factory UserSummary({
    required String id,
    required String email,
    required String displayName,
    required UserStatus status,
    required List<String> roles,
    required bool totpEnabled,
    DateTime? lastLoginAt,
    required DateTime createdAt,
  }) = _UserSummary;

  factory UserSummary.fromJson(Map<String, dynamic> json) =>
      _$UserSummaryFromJson(json);
}

@freezed
abstract class CreateUserRequest with _$CreateUserRequest {
  const factory CreateUserRequest({
    required String email,
    required String displayName,
    required String password,
    required List<String> roles,
  }) = _CreateUserRequest;

  factory CreateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestFromJson(json);
}

@freezed
abstract class UpdateUserRequest with _$UpdateUserRequest {
  const factory UpdateUserRequest({
    String? displayName,
    UserStatus? status,
    List<String>? roles,
  }) = _UpdateUserRequest;

  factory UpdateUserRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRequestFromJson(json);
}

@freezed
abstract class RoleInfo with _$RoleInfo {
  const factory RoleInfo({
    required String id,
    required String key,
    required String name,
    String? description,
    required bool isSystem,
    required List<String> permissions,
  }) = _RoleInfo;

  factory RoleInfo.fromJson(Map<String, dynamic> json) =>
      _$RoleInfoFromJson(json);
}
