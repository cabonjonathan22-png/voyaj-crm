import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_dto.freezed.dart';
part 'ai_dto.g.dart';

/// Texte produit par l'assistant (synthèse d'une fiche).
@freezed
abstract class AiText with _$AiText {
  const factory AiText({required String text}) = _AiText;

  factory AiText.fromJson(Map<String, dynamic> json) => _$AiTextFromJson(json);
}

@freezed
abstract class DraftEmailRequest with _$DraftEmailRequest {
  const factory DraftEmailRequest({
    required String contactId,

    /// Intention de l'email (« relancer sur le devis », « proposer un
    /// rendez-vous »…).
    required String instructions,
  }) = _DraftEmailRequest;

  factory DraftEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$DraftEmailRequestFromJson(json);
}

@freezed
abstract class EmailDraft with _$EmailDraft {
  const factory EmailDraft({required String subject, required String body}) =
      _EmailDraft;

  factory EmailDraft.fromJson(Map<String, dynamic> json) =>
      _$EmailDraftFromJson(json);
}
