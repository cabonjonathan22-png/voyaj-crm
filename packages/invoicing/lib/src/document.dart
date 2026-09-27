import 'package:meta/meta.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'totals.dart';

/// Partie (vendeur ou acheteur) d'un document émis, figée à l'émission.
@immutable
final class Party {
  const Party({
    required this.name,
    this.address,
    this.postalCode,
    this.city,
    this.country = 'FR',
    this.siren,
    this.siret,
    this.vatNumber,
    this.email,
    this.phone,
    this.legalForm,
    this.capital,
    this.rcs,
  });

  factory Party.fromJson(Map<String, Object?> json) => Party(
    name: json['name'] as String? ?? '',
    address: json['address'] as String?,
    postalCode: json['postal_code'] as String?,
    city: json['city'] as String?,
    country: json['country'] as String? ?? 'FR',
    siren: json['siren'] as String?,
    siret: json['siret'] as String?,
    vatNumber: json['vat_number'] as String?,
    email: json['email'] as String?,
    phone: json['phone'] as String?,
    legalForm: json['legal_form'] as String?,
    capital: json['capital'] as String?,
    rcs: json['rcs'] as String?,
  );

  final String name;
  final String? address;
  final String? postalCode;
  final String? city;
  final String country;
  final String? siren;
  final String? siret;
  final String? vatNumber;
  final String? email;
  final String? phone;
  final String? legalForm;
  final String? capital;

  /// Ville d'immatriculation au RCS.
  final String? rcs;

  Map<String, Object?> toJson() => {
    'name': name,
    'address': ?address,
    'postal_code': ?postalCode,
    'city': ?city,
    'country': country,
    'siren': ?siren,
    'siret': ?siret,
    'vat_number': ?vatNumber,
    'email': ?email,
    'phone': ?phone,
    'legal_form': ?legalForm,
    'capital': ?capital,
    'rcs': ?rcs,
  };

  /// Lignes d'adresse (affichage).
  List<String> get addressLines => [
    if (address != null && address!.isNotEmpty) ...address!.split('\n'),
    [postalCode, city].whereType<String>().join(' '),
  ].where((l) => l.trim().isNotEmpty).toList();
}

/// Document émis (devis, facture, avoir), prêt pour le PDF, le XML
/// Factur-X et la comptabilité.
@immutable
final class IssuedDocument {
  const IssuedDocument({
    required this.kind,
    required this.number,
    required this.issueDate,
    required this.seller,
    required this.buyer,
    required this.lines,
    this.subject,
    this.serviceDate,
    this.dueDate,
    this.validUntil,
    this.notes,
    this.paymentTerms,
    this.latePenalties,
    this.buyerReference,
    this.serviceCode,
    this.originalNumber,
    this.iban,
    this.bic,
    this.vatExemptionReason,
    this.footer,
  });

  final DocumentKind kind;
  final String number;
  final DateTime issueDate;
  final DateTime? serviceDate;
  final DateTime? dueDate;
  final DateTime? validUntil;
  final Party seller;
  final Party buyer;
  final List<DocumentLine> lines;
  final String? subject;
  final String? notes;
  final String? paymentTerms;

  /// Mentions de pénalités de retard (obligatoires sur les factures B2B).
  final String? latePenalties;

  /// Numéro d'engagement / bon de commande de l'acheteur (Chorus Pro).
  final String? buyerReference;

  /// Code service de l'acheteur public (Chorus Pro).
  final String? serviceCode;

  /// Facture d'origine d'un avoir.
  final String? originalNumber;
  final String? iban;
  final String? bic;

  /// Mention d'exonération pour les lignes à 0 % (ex. « TVA non
  /// applicable, art. 293 B du CGI »).
  final String? vatExemptionReason;
  final String? footer;

  DocumentTotals get totals => computeTotals(lines);
}
