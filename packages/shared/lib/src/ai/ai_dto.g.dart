// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiText _$AiTextFromJson(Map<String, dynamic> json) =>
    _AiText(text: json['text'] as String);

Map<String, dynamic> _$AiTextToJson(_AiText instance) => <String, dynamic>{
  'text': instance.text,
};

_DraftEmailRequest _$DraftEmailRequestFromJson(Map<String, dynamic> json) =>
    _DraftEmailRequest(
      contactId: json['contact_id'] as String,
      instructions: json['instructions'] as String,
    );

Map<String, dynamic> _$DraftEmailRequestToJson(_DraftEmailRequest instance) =>
    <String, dynamic>{
      'contact_id': instance.contactId,
      'instructions': instance.instructions,
    };

_EmailDraft _$EmailDraftFromJson(Map<String, dynamic> json) => _EmailDraft(
  subject: json['subject'] as String,
  body: json['body'] as String,
);

Map<String, dynamic> _$EmailDraftToJson(_EmailDraft instance) =>
    <String, dynamic>{'subject': instance.subject, 'body': instance.body};
