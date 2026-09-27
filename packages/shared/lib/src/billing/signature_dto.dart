import 'package:freezed_annotation/freezed_annotation.dart';

part 'signature_dto.freezed.dart';
part 'signature_dto.g.dart';

/// Demande de signature électronique d'un devis.
@freezed
abstract class SignatureInfo with _$SignatureInfo {
  const factory SignatureInfo({
    required String id,
    required String invoiceId,
    required String signerName,
    required String signerEmail,

    /// `ongoing`, `done`, `declined`, `expired`, `canceled` ou `failed`.
    required String status,

    /// Devis signé (fichier joint).
    String? signedFileId,
    String? error,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SignatureInfo;

  factory SignatureInfo.fromJson(Map<String, dynamic> json) =>
      _$SignatureInfoFromJson(json);
}

@freezed
abstract class SendSignatureRequest with _$SendSignatureRequest {
  const factory SendSignatureRequest({required String contactId}) =
      _SendSignatureRequest;

  factory SendSignatureRequest.fromJson(Map<String, dynamic> json) =>
      _$SendSignatureRequestFromJson(json);
}
