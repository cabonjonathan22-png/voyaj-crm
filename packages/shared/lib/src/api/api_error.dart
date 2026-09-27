import 'package:freezed_annotation/freezed_annotation.dart';

import '../validation/validation.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

/// Corps JSON de toute réponse d'erreur de l'API.
@freezed
abstract class ApiError with _$ApiError {
  const factory ApiError({
    required String code,
    required String message,
    @Default([]) List<ValidationIssue> issues,
  }) = _ApiError;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);
}

/// Codes d'erreur stables de l'API.
abstract final class ApiErrorCodes {
  static const badRequest = 'bad_request';
  static const validation = 'validation_failed';
  static const unauthenticated = 'unauthenticated';
  static const invalidCredentials = 'invalid_credentials';
  static const invalidMfaCode = 'invalid_mfa_code';
  static const mfaRequired = 'mfa_required';
  static const tokenExpired = 'token_expired';
  static const sessionRevoked = 'session_revoked';
  static const accountDisabled = 'account_disabled';
  static const tooManyAttempts = 'too_many_attempts';
  static const forbidden = 'forbidden';
  static const notFound = 'not_found';
  static const conflict = 'conflict';
  static const unsupportedProtocol = 'unsupported_protocol';
  static const internal = 'internal_error';
}
