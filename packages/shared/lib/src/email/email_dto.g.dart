// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EmailAccountInfo _$EmailAccountInfoFromJson(Map<String, dynamic> json) =>
    _EmailAccountInfo(
      id: json['id'] as String,
      provider: $enumDecode(_$EmailProviderEnumMap, json['provider']),
      address: json['address'] as String,
      displayName: json['display_name'] as String?,
      enabled: json['enabled'] as bool,
      lastSyncAt: json['last_sync_at'] == null
          ? null
          : DateTime.parse(json['last_sync_at'] as String),
      lastError: json['last_error'] as String?,
    );

Map<String, dynamic> _$EmailAccountInfoToJson(_EmailAccountInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'provider': _$EmailProviderEnumMap[instance.provider]!,
      'address': instance.address,
      'display_name': instance.displayName,
      'enabled': instance.enabled,
      'last_sync_at': instance.lastSyncAt?.toIso8601String(),
      'last_error': instance.lastError,
    };

const _$EmailProviderEnumMap = {
  EmailProvider.imap: 'imap',
  EmailProvider.google: 'google',
  EmailProvider.microsoft: 'microsoft',
};

_CreateImapAccountRequest _$CreateImapAccountRequestFromJson(
  Map<String, dynamic> json,
) => _CreateImapAccountRequest(
  address: json['address'] as String,
  displayName: json['display_name'] as String?,
  imapHost: json['imap_host'] as String,
  imapPort: (json['imap_port'] as num?)?.toInt() ?? 993,
  imapTls: json['imap_tls'] as bool? ?? true,
  smtpHost: json['smtp_host'] as String,
  smtpPort: (json['smtp_port'] as num?)?.toInt() ?? 465,
  smtpSecurity:
      $enumDecodeNullable(_$SmtpSecurityEnumMap, json['smtp_security']) ??
      SmtpSecurity.tls,
  username: json['username'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$CreateImapAccountRequestToJson(
  _CreateImapAccountRequest instance,
) => <String, dynamic>{
  'address': instance.address,
  'display_name': instance.displayName,
  'imap_host': instance.imapHost,
  'imap_port': instance.imapPort,
  'imap_tls': instance.imapTls,
  'smtp_host': instance.smtpHost,
  'smtp_port': instance.smtpPort,
  'smtp_security': _$SmtpSecurityEnumMap[instance.smtpSecurity]!,
  'username': instance.username,
  'password': instance.password,
};

const _$SmtpSecurityEnumMap = {
  SmtpSecurity.tls: 'tls',
  SmtpSecurity.starttls: 'starttls',
  SmtpSecurity.none: 'none',
};

_OAuthStartResponse _$OAuthStartResponseFromJson(Map<String, dynamic> json) =>
    _OAuthStartResponse(url: json['url'] as String);

Map<String, dynamic> _$OAuthStartResponseToJson(_OAuthStartResponse instance) =>
    <String, dynamic>{'url': instance.url};

_EmailAddress _$EmailAddressFromJson(Map<String, dynamic> json) =>
    _EmailAddress(
      address: json['address'] as String,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$EmailAddressToJson(_EmailAddress instance) =>
    <String, dynamic>{'address': instance.address, 'name': instance.name};

_EmailMessage _$EmailMessageFromJson(Map<String, dynamic> json) =>
    _EmailMessage(
      id: json['id'] as String,
      accountId: json['account_id'] as String,
      direction: json['direction'] as String,
      from: EmailAddress.fromJson(json['from'] as Map<String, dynamic>),
      to: (json['to'] as List<dynamic>)
          .map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
          .toList(),
      cc:
          (json['cc'] as List<dynamic>?)
              ?.map((e) => EmailAddress.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      subject: json['subject'] as String,
      snippet: json['snippet'] as String,
      bodyText: json['body_text'] as String?,
      sentAt: DateTime.parse(json['sent_at'] as String),
      read: json['read'] as bool,
      messageId: json['message_id'] as String?,
      contactId: json['contact_id'] as String?,
      organisationId: json['organisation_id'] as String?,
      activityId: json['activity_id'] as String?,
    );

Map<String, dynamic> _$EmailMessageToJson(_EmailMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'account_id': instance.accountId,
      'direction': instance.direction,
      'from': instance.from.toJson(),
      'to': instance.to.map((e) => e.toJson()).toList(),
      'cc': instance.cc.map((e) => e.toJson()).toList(),
      'subject': instance.subject,
      'snippet': instance.snippet,
      'body_text': instance.bodyText,
      'sent_at': instance.sentAt.toIso8601String(),
      'read': instance.read,
      'message_id': instance.messageId,
      'contact_id': instance.contactId,
      'organisation_id': instance.organisationId,
      'activity_id': instance.activityId,
    };

_SendEmailRequest _$SendEmailRequestFromJson(Map<String, dynamic> json) =>
    _SendEmailRequest(
      accountId: json['account_id'] as String,
      to: (json['to'] as List<dynamic>).map((e) => e as String).toList(),
      cc:
          (json['cc'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      subject: json['subject'] as String,
      body: json['body'] as String,
      contactId: json['contact_id'] as String?,
      organisationId: json['organisation_id'] as String?,
      inReplyTo: json['in_reply_to'] as String?,
    );

Map<String, dynamic> _$SendEmailRequestToJson(_SendEmailRequest instance) =>
    <String, dynamic>{
      'account_id': instance.accountId,
      'to': instance.to,
      'cc': instance.cc,
      'subject': instance.subject,
      'body': instance.body,
      'contact_id': instance.contactId,
      'organisation_id': instance.organisationId,
      'in_reply_to': instance.inReplyTo,
    };
