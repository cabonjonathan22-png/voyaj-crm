import 'package:freezed_annotation/freezed_annotation.dart';

part 'billing_dto.freezed.dart';
part 'billing_dto.g.dart';

/// Mention par défaut des pénalités de retard (articles L441-10 et D441-5
/// du Code de commerce).
const defaultLatePenalties =
    'En cas de retard de paiement, pénalités au taux de trois fois le taux '
    'd’intérêt légal et indemnité forfaitaire pour frais de recouvrement de '
    '40 €. Pas d’escompte pour paiement anticipé.';

/// Paramètres de facturation : identité du vendeur, mentions, comptes,
/// Chorus Pro. Les secrets ne sont jamais renvoyés par le serveur.
@freezed
abstract class BillingSettings with _$BillingSettings {
  const factory BillingSettings({
    @Default('') String legalName,
    String? address,
    String? postalCode,
    String? city,
    String? siren,
    String? siret,
    String? vatNumber,
    String? legalForm,
    String? capital,
    String? rcs,
    String? email,
    String? phone,
    String? iban,
    String? bic,
    @Default('Paiement à 30 jours par virement') String paymentTerms,
    @Default(30) int paymentDays,
    @Default(30) int quoteValidityDays,
    @Default(defaultLatePenalties) String latePenalties,
    String? vatExemptionReason,
    String? footer,

    /// Plan de comptes (FEC) : `customer`, `sales`, `bank`, `vat`…
    @Default({}) Map<String, Object?> accounts,
    @Default(false) bool chorusEnabled,
    @Default(true) bool chorusSandbox,
    String? chorusLogin,
    String? pisteClientId,

    /// Écriture seule : nouveau mot de passe du compte technique Chorus
    /// Pro (`null` : inchangé).
    String? chorusPassword,

    /// Écriture seule : secret de l'application PISTE (`null` : inchangé).
    String? pisteClientSecret,

    /// Lecture seule : identifiants Chorus Pro complets.
    @Default(false) bool chorusConfigured,
  }) = _BillingSettings;

  factory BillingSettings.fromJson(Map<String, dynamic> json) =>
      _$BillingSettingsFromJson(json);
}

/// Ligne du rapport de TVA.
@freezed
abstract class VatReportRow with _$VatReportRow {
  const factory VatReportRow({
    required int rate,
    required int baseCents,
    required int vatCents,
  }) = _VatReportRow;

  factory VatReportRow.fromJson(Map<String, dynamic> json) =>
      _$VatReportRowFromJson(json);
}

/// TVA collectée d'une période : sur les débits (documents émis) et sur
/// les encaissements (paiements reçus).
@freezed
abstract class VatReport with _$VatReport {
  const factory VatReport({
    required DateTime from,
    required DateTime to,
    required List<VatReportRow> debits,
    required List<VatReportRow> receipts,
  }) = _VatReport;

  factory VatReport.fromJson(Map<String, dynamic> json) =>
      _$VatReportFromJson(json);
}
