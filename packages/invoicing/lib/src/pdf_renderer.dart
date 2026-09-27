import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:voyaj_shared/voyaj_shared.dart';

import 'document.dart';
import 'facturx.dart';
import 'pdf_assets.g.dart';
import 'totals.dart';

Uint8List _unpack(String gzBase64) =>
    Uint8List.fromList(gzip.decode(base64.decode(gzBase64)));

final _regular = pw.Font.ttf(ByteData.sublistView(_unpack(regularFontGz)));
final _bold = pw.Font.ttf(ByteData.sublistView(_unpack(boldFontGz)));
final _icc = _unpack(srgbIccGz);

String _day(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/'
    '${d.year}';

/// « 1 234,56 € ».
String _euros(int cents) {
  final text = formatCentsFr(cents);
  final negative = text.startsWith('-');
  final digits = negative ? text.substring(1) : text;
  final parts = digits.split(',');
  final grouped = parts.first.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ' ',
  );
  return '${negative ? '-' : ''}$grouped,${parts.last} €';
}

String _quantity(num q) => q == q.roundToDouble()
    ? q.toInt().toString()
    : q.toString().replaceAll('.', ',');

const _accent = PdfColor.fromInt(0xFF4545BF);
const _muted = PdfColor.fromInt(0xFF52525B);
const _line = PdfColor.fromInt(0xFFE4E4E7);
const _band = PdfColor.fromInt(0xFFF4F4F5);

/// PDF d'un document émis. Factures et avoirs : PDF/A-3b avec le XML
/// Factur-X (EN 16931) embarqué ; devis : PDF/A-3b simple.
Future<Uint8List> renderDocumentPdf(IssuedDocument doc) async {
  final isInvoice = doc.kind != DocumentKind.quote;
  final pdf = pw.Document(
    theme: pw.ThemeData.withFont(base: _regular, bold: _bold),
    title: '${doc.kind.label} ${doc.number}',
    author: doc.seller.name,
    creator: 'Voyaj CRM',
    producer: 'Voyaj CRM',
    metadata: PdfaRdf(
      title: '${doc.kind.label} ${doc.number}',
      author: doc.seller.name,
      creator: 'Voyaj CRM',
      producer: 'Voyaj CRM',
      subject: doc.subject ?? '',
      keywords: doc.kind.label,
      creationDate: doc.issueDate,
      invoiceRdf: isInvoice
          ? PdfaFacturxRdf().create(
              namespace: 'urn:factur-x:pdfa:CrossIndustryDocument:invoice:1p0#',
              conformanceLevel: 'EN 16931',
            )
          : '',
    ).create(),
  );
  PdfaColorProfile(pdf.document, _icc);
  if (isInvoice) {
    PdfaAttachedFiles(pdf.document, [
      PdfaAttachedFile(
        name: facturxFileName,
        data: buildFacturxXml(doc),
        AFRelationship: '/Data',
      ),
    ]);
  }

  final totals = doc.totals;
  const small = pw.TextStyle(fontSize: 8.5, color: _muted);
  const body = pw.TextStyle(fontSize: 9.5);
  final strong = pw.TextStyle(fontSize: 9.5, fontWeight: pw.FontWeight.bold);

  pw.Widget partyBlock(String title, Party p, {bool boxed = false}) {
    final content = pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: small),
        pw.SizedBox(height: 3),
        pw.Text(p.name, style: strong),
        for (final line in p.addressLines) pw.Text(line, style: body),
        if (p.siret != null || p.siren != null)
          pw.Text(
            p.siret != null ? 'SIRET ${p.siret}' : 'SIREN ${p.siren}',
            style: small,
          ),
        if (p.vatNumber != null) pw.Text('TVA ${p.vatNumber}', style: small),
        if (p.email != null) pw.Text(p.email!, style: small),
      ],
    );
    return boxed
        ? pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: _line),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
            ),
            child: content,
          )
        : content;
  }

  final meta = <(String, String)>[
    ('Date', _day(doc.issueDate)),
    if (doc.serviceDate != null) ('Date de prestation', _day(doc.serviceDate!)),
    if (doc.dueDate != null && isInvoice) ('Échéance', _day(doc.dueDate!)),
    if (doc.validUntil != null && !isInvoice)
      ('Valable jusqu’au', _day(doc.validUntil!)),
    if (doc.originalNumber != null) ('Facture d’origine', doc.originalNumber!),
    if (doc.buyerReference != null)
      ('Engagement / commande', doc.buyerReference!),
    if (doc.serviceCode != null) ('Code service', doc.serviceCode!),
  ];

  final legal = [
    doc.seller.name,
    if (doc.seller.legalForm != null)
      [
        doc.seller.legalForm,
        if (doc.seller.capital != null) 'au capital de ${doc.seller.capital}',
      ].whereType<String>().join(' '),
    if (doc.seller.siren != null)
      [
        'SIREN ${doc.seller.siren}',
        if (doc.seller.rcs != null) 'RCS ${doc.seller.rcs}',
      ].join(' — '),
    if (doc.seller.vatNumber != null)
      'TVA intracommunautaire ${doc.seller.vatNumber}',
  ].join(' · ');

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.fromLTRB(40, 40, 40, 50),
      footer: (context) => pw.Column(
        children: [
          pw.Divider(color: _line, thickness: 0.5),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Text(
                  [legal, ?doc.footer].join('\n'),
                  style: const pw.TextStyle(fontSize: 7, color: _muted),
                ),
              ),
              pw.Text(
                '${context.pageNumber} / ${context.pagesCount}',
                style: const pw.TextStyle(fontSize: 7, color: _muted),
              ),
            ],
          ),
        ],
      ),
      build: (context) => [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(child: partyBlock('Émetteur', doc.seller)),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  doc.kind.label.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 22,
                    fontWeight: pw.FontWeight.bold,
                    color: _accent,
                  ),
                ),
                pw.Text('N° ${doc.number}', style: strong),
                pw.SizedBox(height: 6),
                for (final (label, value) in meta)
                  pw.Text('$label : $value', style: body),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 18),
        pw.Row(
          children: [
            pw.Spacer(),
            pw.SizedBox(
              width: 250,
              child: partyBlock('Client', doc.buyer, boxed: true),
            ),
          ],
        ),
        if (doc.subject != null) ...[
          pw.SizedBox(height: 16),
          pw.Text('Objet : ${doc.subject}', style: strong),
        ],
        pw.SizedBox(height: 14),
        pw.TableHelper.fromTextArray(
          border: null,
          headerStyle: pw.TextStyle(
            fontSize: 8.5,
            fontWeight: pw.FontWeight.bold,
            color: _muted,
          ),
          headerDecoration: const pw.BoxDecoration(color: _band),
          cellStyle: body,
          rowDecoration: const pw.BoxDecoration(
            border: pw.Border(bottom: pw.BorderSide(color: _line, width: 0.5)),
          ),
          columnWidths: {
            0: const pw.FlexColumnWidth(5),
            1: const pw.FlexColumnWidth(1),
            2: const pw.FlexColumnWidth(1.6),
            3: const pw.FlexColumnWidth(1),
            4: const pw.FlexColumnWidth(1.7),
          },
          cellAlignments: {
            1: pw.Alignment.centerRight,
            2: pw.Alignment.centerRight,
            3: pw.Alignment.centerRight,
            4: pw.Alignment.centerRight,
          },
          headers: ['Désignation', 'Qté', 'P.U. HT', 'TVA', 'Total HT'],
          data: [
            for (final line in doc.lines)
              [
                line.discountPercent == 0
                    ? line.description
                    : '${line.description} (remise ${_quantity(line.discountPercent)} %)',
                '${_quantity(line.quantity)}${line.unit == null ? '' : ' ${line.unit}'}',
                _euros(line.unitPriceCents),
                vatRates[line.vatRate] ?? '',
                _euros(line.totalCents),
              ],
          ],
        ),
        pw.SizedBox(height: 12),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (totals.breakdown.containsKey(0) &&
                      doc.vatExemptionReason != null)
                    pw.Text(doc.vatExemptionReason!, style: small),
                  if (doc.notes != null) ...[
                    pw.SizedBox(height: 6),
                    pw.Text(doc.notes!, style: body),
                  ],
                ],
              ),
            ),
            pw.SizedBox(width: 20),
            pw.SizedBox(
              width: 210,
              child: pw.Column(
                children: [
                  _totalRow('Total HT', _euros(totals.htCents), body),
                  for (final MapEntry(key: rate, value: line)
                      in totals.breakdown.entries)
                    _totalRow(
                      'TVA ${vatRates[rate]} sur ${_euros(line.baseCents)}',
                      _euros(line.vatCents),
                      small,
                    ),
                  pw.Container(
                    margin: const pw.EdgeInsets.only(top: 4),
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 5,
                    ),
                    color: _band,
                    child: _totalRow(
                      doc.kind == DocumentKind.creditNote
                          ? 'Total TTC à déduire'
                          : 'Total TTC',
                      _euros(totals.ttcCents),
                      pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 18),
        if (isInvoice) ...[
          if (doc.paymentTerms != null)
            pw.Text(
              'Conditions de règlement : ${doc.paymentTerms}',
              style: body,
            ),
          if (doc.iban != null)
            pw.Text(
              'Règlement par virement — IBAN ${doc.iban}'
              '${doc.bic == null ? '' : ' — BIC ${doc.bic}'}',
              style: body,
            ),
          if (doc.latePenalties != null) ...[
            pw.SizedBox(height: 6),
            pw.Text(doc.latePenalties!, style: small),
          ],
        ] else ...[
          if (doc.paymentTerms != null)
            pw.Text(
              'Conditions de règlement : ${doc.paymentTerms}',
              style: body,
            ),
          pw.SizedBox(height: 18),
          pw.Container(
            width: 250,
            height: 80,
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(border: pw.Border.all(color: _line)),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Bon pour accord (date, nom, signature et cachet)',
                  style: small,
                ),
                pw.SizedBox(height: 4),
                // Ancre de signature électronique (Yousign), invisible.
                pw.Text(
                  signatureAnchor,
                  style: const pw.TextStyle(
                    fontSize: 6,
                    color: PdfColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    ),
  );
  return pdf.save();
}

/// Ancre de la signature électronique d'un devis (Yousign : signataire 1,
/// zone de 180 × 48 points).
const signatureAnchor = '{{s1|signature|180|48}}';

pw.Widget _totalRow(String label, String value, pw.TextStyle style) =>
    pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 1.5),
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(label, style: style)),
          pw.Text(value, style: style),
        ],
      ),
    );
