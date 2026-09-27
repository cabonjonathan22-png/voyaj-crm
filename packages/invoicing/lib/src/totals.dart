import 'package:meta/meta.dart';

/// Ligne de document (JSON `lines` des devis, factures et avoirs).
@immutable
final class DocumentLine {
  const DocumentLine({
    required this.description,
    required this.quantity,
    required this.unitPriceCents,
    required this.vatRate,
    this.discountPercent = 0,
    this.unit,
    this.accountCode,
  });

  factory DocumentLine.fromJson(Map<String, Object?> json) => DocumentLine(
    description: json['description']! as String,
    quantity: json['quantity']! as num,
    unitPriceCents: json['unit_price_cents']! as int,
    vatRate: json['vat_rate']! as int,
    discountPercent: (json['discount_percent'] as num?) ?? 0,
    unit: json['unit'] as String?,
    accountCode: json['account_code'] as String?,
  );

  final String description;
  final num quantity;

  /// Prix unitaire hors taxes, en centimes.
  final int unitPriceCents;

  /// Taux de TVA en points de base (2000 = 20 %).
  final int vatRate;
  final num discountPercent;
  final String? unit;

  /// Compte de produit (FEC), `706000` par défaut.
  final String? accountCode;

  /// Prix unitaire net (après remise), en centimes, non arrondi.
  double get netUnitPriceCents => unitPriceCents * (1 - discountPercent / 100);

  /// Total hors taxes de la ligne, arrondi au centime.
  int get totalCents => (quantity * netUnitPriceCents).round();

  Map<String, Object?> toJson() => {
    'description': description,
    'quantity': quantity,
    'unit_price_cents': unitPriceCents,
    'vat_rate': vatRate,
    if (discountPercent != 0) 'discount_percent': discountPercent,
    'unit': ?unit,
    'account_code': ?accountCode,
  };
}

/// Base et montant de TVA d'un taux.
typedef VatLine = ({int baseCents, int vatCents});

/// Totaux d'un document. La TVA est calculée par taux sur la somme des
/// lignes hors taxes (arrondie au centime), comme l'exige la norme
/// EN 16931.
@immutable
final class DocumentTotals {
  const DocumentTotals({
    required this.htCents,
    required this.vatCents,
    required this.breakdown,
  });

  final int htCents;
  final int vatCents;

  /// Par taux (points de base), dans l'ordre décroissant des taux.
  final Map<int, VatLine> breakdown;

  int get ttcCents => htCents + vatCents;

  /// Répartition au format JSON (`vat_breakdown`).
  List<Map<String, int>> toJson() => [
    for (final MapEntry(key: rate, value: line) in breakdown.entries)
      {'rate': rate, 'base_cents': line.baseCents, 'vat_cents': line.vatCents},
  ];
}

/// Arrondi « au plus proche, demi vers le haut » (centimes).
int _roundHalfUp(num value) =>
    value >= 0 ? (value + 0.5).floor() : -((-value) + 0.5).floor();

DocumentTotals computeTotals(Iterable<DocumentLine> lines) {
  final bases = <int, int>{};
  for (final line in lines) {
    bases.update(
      line.vatRate,
      (b) => b + line.totalCents,
      ifAbsent: () => line.totalCents,
    );
  }
  final rates = bases.keys.toList()..sort((a, b) => b.compareTo(a));
  final breakdown = {
    for (final rate in rates)
      rate: (
        baseCents: bases[rate]!,
        vatCents: _roundHalfUp(bases[rate]! * rate / 10000),
      ),
  };
  return DocumentTotals(
    htCents: breakdown.values.fold(0, (s, l) => s + l.baseCents),
    vatCents: breakdown.values.fold(0, (s, l) => s + l.vatCents),
    breakdown: breakdown,
  );
}

/// Lignes d'un document (JSON).
List<DocumentLine> linesFromJson(Object? json) => [
  for (final line in (json as List<Object?>?) ?? const [])
    DocumentLine.fromJson((line! as Map).cast<String, Object?>()),
];

/// Numéro de document : préfixe, année, séquence sur 5 chiffres
/// (`F2026-00001`). Séquence continue et sans trou par type et par année.
String formatDocumentNumber(String prefix, int year, int sequence) =>
    '$prefix$year-${sequence.toString().padLeft(5, '0')}';

/// Montant « 1234,56 » (centimes → euros, virgule décimale).
String formatCentsFr(int cents) {
  final negative = cents < 0;
  final abs = cents.abs();
  return '${negative ? '-' : ''}${abs ~/ 100},'
      '${(abs % 100).toString().padLeft(2, '0')}';
}

/// Montant « 1234.56 » (XML).
String formatCentsDot(int cents) => formatCentsFr(cents).replaceAll(',', '.');
