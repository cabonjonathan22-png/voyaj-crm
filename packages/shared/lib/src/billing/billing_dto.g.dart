// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billing_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BillingSettings _$BillingSettingsFromJson(Map<String, dynamic> json) =>
    _BillingSettings(
      legalName: json['legal_name'] as String? ?? '',
      address: json['address'] as String?,
      postalCode: json['postal_code'] as String?,
      city: json['city'] as String?,
      siren: json['siren'] as String?,
      siret: json['siret'] as String?,
      vatNumber: json['vat_number'] as String?,
      legalForm: json['legal_form'] as String?,
      capital: json['capital'] as String?,
      rcs: json['rcs'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      iban: json['iban'] as String?,
      bic: json['bic'] as String?,
      paymentTerms:
          json['payment_terms'] as String? ??
          'Paiement à 30 jours par virement',
      paymentDays: (json['payment_days'] as num?)?.toInt() ?? 30,
      quoteValidityDays: (json['quote_validity_days'] as num?)?.toInt() ?? 30,
      latePenalties: json['late_penalties'] as String? ?? defaultLatePenalties,
      vatExemptionReason: json['vat_exemption_reason'] as String?,
      footer: json['footer'] as String?,
      accounts: json['accounts'] as Map<String, dynamic>? ?? const {},
      chorusEnabled: json['chorus_enabled'] as bool? ?? false,
      chorusSandbox: json['chorus_sandbox'] as bool? ?? true,
      chorusLogin: json['chorus_login'] as String?,
      pisteClientId: json['piste_client_id'] as String?,
      chorusPassword: json['chorus_password'] as String?,
      pisteClientSecret: json['piste_client_secret'] as String?,
      chorusConfigured: json['chorus_configured'] as bool? ?? false,
    );

Map<String, dynamic> _$BillingSettingsToJson(_BillingSettings instance) =>
    <String, dynamic>{
      'legal_name': instance.legalName,
      'address': instance.address,
      'postal_code': instance.postalCode,
      'city': instance.city,
      'siren': instance.siren,
      'siret': instance.siret,
      'vat_number': instance.vatNumber,
      'legal_form': instance.legalForm,
      'capital': instance.capital,
      'rcs': instance.rcs,
      'email': instance.email,
      'phone': instance.phone,
      'iban': instance.iban,
      'bic': instance.bic,
      'payment_terms': instance.paymentTerms,
      'payment_days': instance.paymentDays,
      'quote_validity_days': instance.quoteValidityDays,
      'late_penalties': instance.latePenalties,
      'vat_exemption_reason': instance.vatExemptionReason,
      'footer': instance.footer,
      'accounts': instance.accounts,
      'chorus_enabled': instance.chorusEnabled,
      'chorus_sandbox': instance.chorusSandbox,
      'chorus_login': instance.chorusLogin,
      'piste_client_id': instance.pisteClientId,
      'chorus_password': instance.chorusPassword,
      'piste_client_secret': instance.pisteClientSecret,
      'chorus_configured': instance.chorusConfigured,
    };

_VatReportRow _$VatReportRowFromJson(Map<String, dynamic> json) =>
    _VatReportRow(
      rate: (json['rate'] as num).toInt(),
      baseCents: (json['base_cents'] as num).toInt(),
      vatCents: (json['vat_cents'] as num).toInt(),
    );

Map<String, dynamic> _$VatReportRowToJson(_VatReportRow instance) =>
    <String, dynamic>{
      'rate': instance.rate,
      'base_cents': instance.baseCents,
      'vat_cents': instance.vatCents,
    };

_VatReport _$VatReportFromJson(Map<String, dynamic> json) => _VatReport(
  from: DateTime.parse(json['from'] as String),
  to: DateTime.parse(json['to'] as String),
  debits: (json['debits'] as List<dynamic>)
      .map((e) => VatReportRow.fromJson(e as Map<String, dynamic>))
      .toList(),
  receipts: (json['receipts'] as List<dynamic>)
      .map((e) => VatReportRow.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VatReportToJson(_VatReport instance) =>
    <String, dynamic>{
      'from': instance.from.toIso8601String(),
      'to': instance.to.toIso8601String(),
      'debits': instance.debits.map((e) => e.toJson()).toList(),
      'receipts': instance.receipts.map((e) => e.toJson()).toList(),
    };
