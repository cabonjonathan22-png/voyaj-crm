import 'dart:convert';

import 'package:invoicing/invoicing.dart';
import 'package:invoicing/invoicing_pdf.dart';
import 'package:test/test.dart';
import 'package:voyaj_shared/voyaj_shared.dart';
import 'package:xml/xml.dart';

const seller = Party(
  name: 'Voyaj SAS',
  address: '12 rue de la Mobilité',
  postalCode: '12000',
  city: 'Rodez',
  siren: '912345678',
  siret: '91234567800012',
  vatNumber: 'FR12912345678',
  legalForm: 'SAS',
  capital: '10 000 €',
  rcs: 'Rodez',
  email: 'facturation@voyaj.fr',
);

const buyer = Party(
  name: 'Commune de Millau',
  address: 'Hôtel de ville\n17 avenue de la République',
  postalCode: '12100',
  city: 'Millau',
  siret: '21120145900014',
);

IssuedDocument invoice({
  DocumentKind kind = DocumentKind.invoice,
  String number = 'F2026-00001',
  List<DocumentLine>? lines,
}) => IssuedDocument(
  kind: kind,
  number: number,
  issueDate: DateTime(2026, 9, 27),
  dueDate: DateTime(2026, 10, 27),
  seller: seller,
  buyer: buyer,
  subject: 'Navettes estivales « Grands Causses » & festival',
  buyerReference: 'EJ-2026-0042',
  paymentTerms: 'Paiement à 30 jours',
  latePenalties:
      'Pénalités de retard : 3 fois le taux d’intérêt légal. '
      'Indemnité forfaitaire pour frais de recouvrement : 40 €.',
  iban: 'FR76 3000 6000 0112 3456 7890 189',
  originalNumber: kind == DocumentKind.creditNote ? 'F2026-00001' : null,
  lines:
      lines ??
      const [
        DocumentLine(
          description: 'Service de navettes (juillet-août)',
          quantity: 2,
          unitPriceCents: 1250000,
          vatRate: 1000,
        ),
        DocumentLine(
          description: 'Application de réservation',
          quantity: 1,
          unitPriceCents: 99900,
          vatRate: 2000,
          discountPercent: 10,
        ),
        DocumentLine(
          description: 'Frais de dossier',
          quantity: 3,
          unitPriceCents: 333,
          vatRate: 2000,
        ),
      ],
);

void main() {
  group('Totaux', () {
    test('TVA par taux sur la somme des lignes, arrondie', () {
      final totals = invoice().totals;
      // 2 × 12 500 € ; 999 € − 10 % = 899,10 € ; 3 × 3,33 € = 9,99 €.
      expect(totals.breakdown[1000], (baseCents: 2500000, vatCents: 250000));
      expect(totals.breakdown[2000], (baseCents: 90909, vatCents: 18182));
      expect(totals.htCents, 2590909);
      expect(totals.vatCents, 268182);
      expect(totals.ttcCents, 2859091);
      expect(totals.breakdown.keys, [2000, 1000]);
    });

    test('quantités décimales et arrondi au demi-centime supérieur', () {
      const line = DocumentLine(
        description: 'x',
        quantity: 1.5,
        unitPriceCents: 333,
        vatRate: 550,
      );
      expect(line.totalCents, 500); // 499,5 → 500
      expect(computeTotals([line]).vatCents, 28); // 27,5 → 28
    });

    test('lignes JSON et numérotation', () {
      final lines = linesFromJson([
        {
          'description': 'A',
          'quantity': 1,
          'unit_price_cents': 100,
          'vat_rate': 2000,
        },
      ]);
      expect(lines.single.toJson()['vat_rate'], 2000);
      expect(formatDocumentNumber('F', 2026, 42), 'F2026-00042');
      expect(formatCentsFr(-123456), '-1234,56');
      expect(formatCentsDot(5), '0.05');
    });
  });

  group('Factur-X', () {
    test('XML CII EN 16931 : en-tête, parties, lignes, totaux', () {
      final xml = XmlDocument.parse(buildFacturxXml(invoice()));
      String text(String name) => xml.findAllElements(name).first.innerText;
      expect(text('ram:ID'), facturxProfile);
      expect(xml.findAllElements('ram:TypeCode').first.innerText, '380');
      expect(text('udt:DateTimeString'), '20260927');
      expect(
        xml.findAllElements('ram:IncludedSupplyChainTradeLineItem'),
        hasLength(3),
      );
      expect(text('ram:BuyerReference'), 'EJ-2026-0042');
      expect(text('ram:GrandTotalAmount'), '28590.91');
      expect(text('ram:TaxTotalAmount'), '2681.82');
      expect(
        xml.findAllElements('ram:SpecifiedLegalOrganization').first.innerText,
        '91234567800012',
      );
      expect(text('ram:IBANID'), 'FR7630006000011234567890189');
      final taxes = xml
          .findAllElements('ram:ApplicableHeaderTradeSettlement')
          .first
          .findElements('ram:ApplicableTradeTax');
      expect(taxes, hasLength(2));
      // Échappement XML des caractères spéciaux.
      expect(buildFacturxXml(invoice()), contains('&amp; festival'));
      // Somme des lignes = total HT (règle BR-CO-10).
      final lineTotals = xml
          .findAllElements('ram:LineTotalAmount')
          .take(3)
          .map((e) => double.parse(e.innerText))
          .fold<double>(0, (a, b) => a + b);
      expect(lineTotals.toStringAsFixed(2), '25909.09');
    });

    test('avoir : type 381 et facture d’origine', () {
      final xml = XmlDocument.parse(
        buildFacturxXml(
          invoice(kind: DocumentKind.creditNote, number: 'A2026-00001'),
        ),
      );
      expect(xml.findAllElements('ram:TypeCode').first.innerText, '381');
      expect(
        xml.findAllElements('ram:InvoiceReferencedDocument').single.innerText,
        'F2026-00001',
      );
    });

    test('taux 0 % : catégorie E et motif d’exonération', () {
      final doc = IssuedDocument(
        kind: DocumentKind.invoice,
        number: 'F2026-00002',
        issueDate: DateTime(2026, 1, 5),
        seller: seller,
        buyer: buyer,
        vatExemptionReason: 'TVA non applicable, art. 293 B du CGI',
        lines: const [
          DocumentLine(
            description: 'Formation',
            quantity: 1,
            unitPriceCents: 50000,
            vatRate: 0,
          ),
        ],
      );
      final xml = buildFacturxXml(doc);
      expect(xml, contains('<ram:CategoryCode>E</ram:CategoryCode>'));
      expect(xml, contains('art. 293 B du CGI'));
    });

    test('un devis n’a pas de XML', () {
      expect(
        () => buildFacturxXml(invoice(kind: DocumentKind.quote)),
        throwsArgumentError,
      );
    });
  });

  group('PDF', () {
    test('facture : PDF/A-3 avec factur-x.xml embarqué', () async {
      final bytes = await renderDocumentPdf(invoice());
      final text = latin1.decode(bytes);
      expect(text, startsWith('%PDF-'));
      expect(text, contains('factur-x.xml'));
      expect(text, contains('/AFRelationship'));
      expect(text, contains('pdfaid:part'));
      expect(text, contains('EN 16931'));
      expect(bytes.length, greaterThan(10000));
    });

    test('devis et avoir', () async {
      final quote = await renderDocumentPdf(
        invoice(kind: DocumentKind.quote, number: 'D2026-00001'),
      );
      expect(latin1.decode(quote), isNot(contains('factur-x.xml')));
      final credit = await renderDocumentPdf(
        invoice(kind: DocumentKind.creditNote, number: 'A2026-00001'),
      );
      expect(latin1.decode(credit), contains('factur-x.xml'));
    });
  });

  group('FEC et TVA', () {
    LedgerDocument ledger(
      String number,
      DocumentKind kind,
      List<DocumentLine> lines,
    ) => LedgerDocument(
      kind: kind,
      number: number,
      date: DateTime(2026, 3, 1),
      customerCode: 'CMILLAU',
      customerName: 'Commune de Millau',
      lines: lines,
    );

    const lines = [
      DocumentLine(
        description: 'Navettes',
        quantity: 1,
        unitPriceCents: 100000,
        vatRate: 1000,
      ),
      DocumentLine(
        description: 'Licence',
        quantity: 1,
        unitPriceCents: 50000,
        vatRate: 2000,
        accountCode: '706100',
      ),
    ];

    test('écritures équilibrées, format réglementaire', () {
      final fec = buildFec(
        documents: [
          ledger('F2026-00001', DocumentKind.invoice, lines),
          ledger('A2026-00001', DocumentKind.creditNote, [lines.first]),
        ],
        payments: [
          LedgerPayment(
            date: DateTime(2026, 4, 2),
            amountCents: 170000,
            documentNumber: 'F2026-00001',
            customerCode: 'CMILLAU',
            customerName: 'Commune de Millau',
          ),
        ],
      );
      expect(fec, endsWith('\r\n'));
      final rows = fec
          .substring(0, fec.length - 2)
          .split('\r\n')
          .map((r) => r.split('\t'))
          .toList();
      expect(rows.first, fecHeaders);
      expect(rows.skip(1).every((r) => r.length == 18), isTrue);

      int cents(String v) => int.parse(v.replaceAll(',', ''));
      final byEntry = <String, int>{};
      for (final r in rows.skip(1)) {
        byEntry.update(
          r[2],
          (v) => v + cents(r[11]) - cents(r[12]),
          ifAbsent: () => cents(r[11]) - cents(r[12]),
        );
      }
      expect(
        byEntry.values,
        everyElement(0),
        reason: 'chaque écriture équilibrée',
      );

      final invoiceRows = rows
          .where((r) => r[0] == 'VE' && r[8] == 'F2026-00001')
          .toList();
      expect(invoiceRows.first[4], '411000');
      expect(invoiceRows.first[11], '1700,00');
      expect(invoiceRows.first[6], 'CMILLAU');
      expect(
        invoiceRows.map((r) => r[4]),
        containsAll(['706000', '706100', '445712', '445711']),
      );
      final credit = rows.firstWhere((r) => r[8] == 'A2026-00001');
      expect(credit[12], '1100,00'); // client au crédit
      expect(rows.last[0], 'BQ');
      expect(rows[1][3], '20260301');
      expect(
        fecFileName('912 345 678', DateTime(2026, 12, 31)),
        '912345678FEC20261231.txt',
      );
    });

    test('TVA sur les débits et sur les encaissements', () {
      final doc = ledger('F2026-00001', DocumentKind.invoice, lines);
      final debits = vatOnDebits([
        doc,
        ledger('A2026-00001', DocumentKind.creditNote, [lines.first]),
      ]);
      expect(debits.map((l) => (l.rate, l.baseCents, l.vatCents)), [
        (2000, 50000, 10000),
        (1000, 0, 0),
      ]);
      // Moitié de la facture encaissée.
      final receipts = vatOnReceipts([(document: doc, amountCents: 85000)]);
      expect(receipts.map((l) => (l.rate, l.vatCents)), [
        (2000, 5000),
        (1000, 5000),
      ]);
    });

    test('plan de comptes : lecture JSON', () {
      final accounts = AccountingAccounts.fromJson({
        'customer': '411100',
        'vat': {'2000': '4457101'},
      });
      expect(accounts.customer, '411100');
      expect(accounts.vat, {2000: '4457101'});
      expect(AccountingAccounts.fromJson(const {}).vat[1000], '445712');
    });
  });
}
