import 'package:freezed_annotation/freezed_annotation.dart';

part 'email_dto.freezed.dart';
part 'email_dto.g.dart';

/// Fournisseur d'un compte email.
enum EmailProvider { imap, google, microsoft }

/// Sécurité de la connexion SMTP.
enum SmtpSecurity { tls, starttls, none }

/// Compte email connecté (sans secret).
@freezed
abstract class EmailAccountInfo with _$EmailAccountInfo {
  const factory EmailAccountInfo({
    required String id,
    required EmailProvider provider,
    required String address,
    String? displayName,
    required bool enabled,
    DateTime? lastSyncAt,
    String? lastError,
  }) = _EmailAccountInfo;

  factory EmailAccountInfo.fromJson(Map<String, dynamic> json) =>
      _$EmailAccountInfoFromJson(json);
}

/// Ajout d'un compte IMAP / SMTP (mot de passe ou mot de passe
/// d'application).
@freezed
abstract class CreateImapAccountRequest with _$CreateImapAccountRequest {
  const factory CreateImapAccountRequest({
    required String address,
    String? displayName,
    required String imapHost,
    @Default(993) int imapPort,
    @Default(true) bool imapTls,
    required String smtpHost,
    @Default(465) int smtpPort,
    @Default(SmtpSecurity.tls) SmtpSecurity smtpSecurity,
    required String username,
    required String password,
  }) = _CreateImapAccountRequest;

  factory CreateImapAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateImapAccountRequestFromJson(json);
}

/// Adresse de connexion OAuth (à ouvrir dans le navigateur).
@freezed
abstract class OAuthStartResponse with _$OAuthStartResponse {
  const factory OAuthStartResponse({required String url}) = _OAuthStartResponse;

  factory OAuthStartResponse.fromJson(Map<String, dynamic> json) =>
      _$OAuthStartResponseFromJson(json);
}

/// Adresse email et nom affiché.
@freezed
abstract class EmailAddress with _$EmailAddress {
  const factory EmailAddress({required String address, String? name}) =
      _EmailAddress;

  factory EmailAddress.fromJson(Map<String, dynamic> json) =>
      _$EmailAddressFromJson(json);
}

/// Email reçu ou envoyé (boîte de réception).
@freezed
abstract class EmailMessage with _$EmailMessage {
  const factory EmailMessage({
    required String id,
    required String accountId,

    /// `in` (reçu) ou `out` (envoyé depuis Voyaj).
    required String direction,
    required EmailAddress from,
    required List<EmailAddress> to,
    @Default([]) List<EmailAddress> cc,
    required String subject,
    required String snippet,

    /// Corps texte (renseigné pour le détail d'un message).
    String? bodyText,
    required DateTime sentAt,
    required bool read,
    String? messageId,
    String? contactId,
    String? organisationId,
    String? activityId,
  }) = _EmailMessage;

  factory EmailMessage.fromJson(Map<String, dynamic> json) =>
      _$EmailMessageFromJson(json);
}

/// Envoi d'un email.
@freezed
abstract class SendEmailRequest with _$SendEmailRequest {
  const factory SendEmailRequest({
    required String accountId,
    required List<String> to,
    @Default([]) List<String> cc,
    required String subject,
    required String body,
    String? contactId,
    String? organisationId,

    /// Message auquel on répond (`Message-ID`).
    String? inReplyTo,
  }) = _SendEmailRequest;

  factory SendEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$SendEmailRequestFromJson(json);
}
