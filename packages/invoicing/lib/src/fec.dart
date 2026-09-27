import 'package:meta/meta.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import 'totals.dart';

/// Plan de comptes utilisé pour le FEC (paramètres de facturation).
@immutable
final class AccountingAccounts {
  const AccountingAccounts({
    this.customer = '411000',
    this.sales = '706000',
    this.bank = '512000',
    this.vat = const {
      2000: '445711',
      1000: '445712',
      550: '445713',
      210: '445714',
      0: '445710',
    },
    this.salesJournal = 'VE',
    this.bankJournal = 'BQ',
  });

  factory AccountingAccounts.fromJson(Map<String, Object?> json) =>
      AccountingAccounts(
        customer: json['customer'] as String? ?? '411000',
        sales: json['sales'] as String? ?? '706000',
        bank: json['bank'] as String? ?? '512000',
        vat: switch (json['vat']) {
          final Map<Object?, Object?> map when map.isNotEmpty => {
            for (final MapEntry(:key, :value) in map.entries)
              int.parse('$key'): '$value',
          },
          _ => const AccountingAccounts().vat,
        },
        salesJournal: json['sales_journal'] as String? ?? 'VE',
        bankJournal: json['bank_journal'] as String? ?? 'BQ',
      );

  final String customer;
  final String sales;
  final String bank;

  /// TVA collectée par taux (points de base).
  final Map<int, String> vat;
  final String salesJournal;
  final String bankJournal;

  Map<String, Object?> toJson() => {
    'customer': customer,
    'sales': sales,
    'bank': bank,
    'vat': {for (final e in vat.entries) '${e.key}': e.value},
    'sales_journal': salesJournal,
    'bank_journal': bankJournal,
  };
}

/// Facture ou avoir émis, pour la comptabilité.
@immutable
final class LedgerDocument {
  const LedgerDocument({
    required this.kind,
    required this.number,
    required this.date,
    required this.customerCode,
    required this.customerName,
    required this.lines,
  });

  final DocumentKind kind;
  final String number;
  final DateTime date;

  /// Compte auxiliaire client (`CompAuxNum`).
  final String customerCode;
  final String customerName;
  final List<DocumentLine> lines;
}

/// Encaissement (ou remboursement d'un avoir).
@immutable
final class LedgerPayment {
  const LedgerPayment({
    required this.date,
    required this.amountCents,
    required this.documentNumber,
    required this.customerCode,
    required this.customerName,
    this.refund = false,
    this.reference,
  });

  final DateTime date;
  final int amountCents;
  final String documentNumber;
  final String customerCode;
  final String customerName;

  /// Remboursement (avoir) : sens inversé.
  final bool refund;
  final String? reference;
}

/// En-têtes du FEC (article A47 A-1 du LPF).
const fecHeaders = [
  'JournalCode',
  'JournalLib',
  'EcritureNum',
  'EcritureDate',
  'CompteNum',
  'CompteLib',
  'CompAuxNum',
  'CompAuxLib',
  'PieceRef',
  'PieceDate',
  'EcritureLib',
  'Debit',
  'Credit',
  'EcritureLet',
  'DateLet',
  'ValidDate',
  'Montantdevise',
  'Idevise',
];

String _date(DateTime d) =>
    '${d.year}${d.month.toString().padLeft(2, '0')}'
    '${d.day.toString().padLeft(2, '0')}';

String _clean(String text) => text.replaceAll(RegExp(r'[\t\r\n|]'), ' ').trim();

/// Nom réglementaire du fichier : `<SIREN>FEC<AAAAMMJJ>.txt` (date de
/// clôture de l'exercice).
String fecFileName(String siren, DateTime closing) =>
    '${siren.replaceAll(' ', '')}FEC${_date(closing)}.txt';

/// Fichier des écritures comptables (ventes et encaissements), séparateur
/// tabulation, montants à virgule. Chaque écriture est équilibrée.
String buildFec({
  required List<LedgerDocument> documents,
  required List<LedgerPayment> payments,
  AccountingAccounts accounts = const AccountingAccounts(),
}) {
  final rows = <List<String>>[fecHeaders];
  var salesNumber = 0;
  var bankNumber = 0;

  void entry({
    required String journal,
    required String journalLabel,
    required int number,
    required DateTime date,
    required String account,
    required String accountLabel,
    required String piece,
    required String label,
    required int debit,
    required int credit,
    String aux = '',
    String auxLabel = '',
  }) => rows.add([
    journal,
    journalLabel,
    '$journal${number.toString().padLeft(6, '0')}',
    _date(date),
    account,
    _clean(accountLabel),
    aux,
    _clean(auxLabel),
    _clean(piece),
    _date(date),
    _clean(label),
    formatCentsFr(debit),
    formatCentsFr(credit),
    '',
    '',
    _date(date),
    '',
    '',
  ]);

  final sortedDocs = [...documents]
    ..sort((a, b) {
      final byDate = a.date.compareTo(b.date);
      return byDate != 0 ? byDate : a.number.compareTo(b.number);
    });
  for (final doc in sortedDocs) {
    salesNumber++;
    final credit = doc.kind == DocumentKind.creditNote;
    final totals = computeTotals(doc.lines);
    final label = '${doc.kind.label} ${doc.number} ${doc.customerName}';
    void post(
      String account,
      String accountLabel,
      int amount, {
      bool customer = false,
    }) {
      // Facture : client au débit, produits et TVA au crédit ; avoir :
      // l'inverse.
      final debitSide = customer != credit;
      entry(
        journal: accounts.salesJournal,
        journalLabel: 'Ventes',
        number: salesNumber,
        date: doc.date,
        account: account,
        accountLabel: accountLabel,
        piece: doc.number,
        label: label,
        debit: debitSide ? amount : 0,
        credit: debitSide ? 0 : amount,
        aux: customer ? doc.customerCode : '',
        auxLabel: customer ? doc.customerName : '',
      );
    }

    post(accounts.customer, 'Clients', totals.ttcCents, customer: true);
    final byAccount = <String, int>{};
    for (final line in doc.lines) {
      byAccount.update(
        line.accountCode ?? accounts.sales,
        (v) => v + line.totalCents,
        ifAbsent: () => line.totalCents,
      );
    }
    for (final MapEntry(key: account, value: amount) in byAccount.entries) {
      post(account, 'Prestations de services', amount);
    }
    for (final MapEntry(key: rate, value: vat) in totals.breakdown.entries) {
      if (vat.vatCents == 0) continue;
      post(
        accounts.vat[rate] ?? accounts.vat[2000]!,
        'TVA collectée ${vatRates[rate] ?? ''}',
        vat.vatCents,
      );
    }
  }

  final sortedPayments = [...payments]
    ..sort((a, b) => a.date.compareTo(b.date));
  for (final payment in sortedPayments) {
    bankNumber++;
    final label =
        '${payment.refund ? 'Remboursement' : 'Règlement'} '
        '${payment.documentNumber} ${payment.customerName}';
    for (final (account, accountLabel, isBank) in [
      (accounts.bank, 'Banque', true),
      (accounts.customer, 'Clients', false),
    ]) {
      final debitSide = isBank != payment.refund;
      entry(
        journal: accounts.bankJournal,
        journalLabel: 'Banque',
        number: bankNumber,
        date: payment.date,
        account: account,
        accountLabel: accountLabel,
        piece: payment.reference ?? payment.documentNumber,
        label: label,
        debit: debitSide ? payment.amountCents : 0,
        credit: debitSide ? 0 : payment.amountCents,
        aux: isBank ? '' : payment.customerCode,
        auxLabel: isBank ? '' : payment.customerName,
      );
    }
  }
  return '${rows.map((r) => r.join('\t')).join('\r\n')}\r\n';
}

/// Totaux de TVA d'une période.
@immutable
final class VatReportLine {
  const VatReportLine(this.rate, this.baseCents, this.vatCents);

  final int rate;
  final int baseCents;
  final int vatCents;
}

/// TVA collectée « sur les débits » : factures moins avoirs émis dans la
/// période, par taux.
List<VatReportLine> vatOnDebits(Iterable<LedgerDocument> documents) {
  final base = <int, int>{};
  final vat = <int, int>{};
  for (final doc in documents) {
    final sign = doc.kind == DocumentKind.creditNote ? -1 : 1;
    for (final MapEntry(key: rate, value: line) in computeTotals(
      doc.lines,
    ).breakdown.entries) {
      base.update(
        rate,
        (v) => v + sign * line.baseCents,
        ifAbsent: () => sign * line.baseCents,
      );
      vat.update(
        rate,
        (v) => v + sign * line.vatCents,
        ifAbsent: () => sign * line.vatCents,
      );
    }
  }
  final rates = base.keys.toList()..sort((a, b) => b.compareTo(a));
  return [for (final r in rates) VatReportLine(r, base[r]!, vat[r]!)];
}

/// TVA « sur les encaissements » (prestations de services) : chaque
/// encaissement est ventilé au prorata de la TVA de sa facture.
List<VatReportLine> vatOnReceipts(
  Iterable<({LedgerDocument document, int amountCents})> receipts,
) {
  final base = <int, double>{};
  final vat = <int, double>{};
  for (final (:document, :amountCents) in receipts) {
    final totals = computeTotals(document.lines);
    if (totals.ttcCents == 0) continue;
    final share = amountCents / totals.ttcCents;
    final sign = document.kind == DocumentKind.creditNote ? -1 : 1;
    for (final MapEntry(key: rate, value: line) in totals.breakdown.entries) {
      base.update(
        rate,
        (v) => v + sign * line.baseCents * share,
        ifAbsent: () => sign * line.baseCents * share,
      );
      vat.update(
        rate,
        (v) => v + sign * line.vatCents * share,
        ifAbsent: () => sign * line.vatCents * share,
      );
    }
  }
  final rates = base.keys.toList()..sort((a, b) => b.compareTo(a));
  return [
    for (final r in rates) VatReportLine(r, base[r]!.round(), vat[r]!.round()),
  ];
}
