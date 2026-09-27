// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signature_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignatureInfo _$SignatureInfoFromJson(Map<String, dynamic> json) =>
    _SignatureInfo(
      id: json['id'] as String,
      invoiceId: json['invoice_id'] as String,
      signerName: json['signer_name'] as String,
      signerEmail: json['signer_email'] as String,
      status: json['status'] as String,
      signedFileId: json['signed_file_id'] as String?,
      error: json['error'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SignatureInfoToJson(_SignatureInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'invoice_id': instance.invoiceId,
      'signer_name': instance.signerName,
      'signer_email': instance.signerEmail,
      'status': instance.status,
      'signed_file_id': instance.signedFileId,
      'error': instance.error,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

_SendSignatureRequest _$SendSignatureRequestFromJson(
  Map<String, dynamic> json,
) => _SendSignatureRequest(contactId: json['contact_id'] as String);

Map<String, dynamic> _$SendSignatureRequestToJson(
  _SendSignatureRequest instance,
) => <String, dynamic>{'contact_id': instance.contactId};
