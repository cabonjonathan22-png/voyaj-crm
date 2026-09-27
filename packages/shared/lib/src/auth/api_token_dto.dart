import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_token_dto.freezed.dart';
part 'api_token_dto.g.dart';

/// Préfixe des jetons d'API personnels.
const apiTokenPrefix = 'vpat_';

/// Jeton d'API personnel (la valeur n'est affichée qu'à la création).
@freezed
abstract class ApiTokenInfo with _$ApiTokenInfo {
  const factory ApiTokenInfo({
    required String id,
    required String name,

    /// Permissions accordées (limitées à celles de l'utilisateur au moment
    /// de chaque appel).
    required List<String> permissions,
    required DateTime createdAt,
    DateTime? lastUsedAt,
    DateTime? expiresAt,
  }) = _ApiTokenInfo;

  factory ApiTokenInfo.fromJson(Map<String, dynamic> json) =>
      _$ApiTokenInfoFromJson(json);
}

@freezed
abstract class CreateApiTokenRequest with _$CreateApiTokenRequest {
  const factory CreateApiTokenRequest({
    required String name,
    required List<String> permissions,

    /// Durée de validité (jours) ; `null` : sans expiration.
    int? expiresInDays,
  }) = _CreateApiTokenRequest;

  factory CreateApiTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateApiTokenRequestFromJson(json);
}

@freezed
abstract class CreatedApiToken with _$CreatedApiToken {
  const factory CreatedApiToken({
    required ApiTokenInfo info,

    /// Valeur du jeton (`vpat_…`), affichée une seule fois.
    required String token,
  }) = _CreatedApiToken;

  factory CreatedApiToken.fromJson(Map<String, dynamic> json) =>
      _$CreatedApiTokenFromJson(json);
}
