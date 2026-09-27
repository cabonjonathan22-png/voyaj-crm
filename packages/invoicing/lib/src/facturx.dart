import 'package:voyaj_shared/voyaj_shared.dart';

import 'document.dart';
import 'totals.dart';

/// Profil Factur-X produit (EN 16931, dit « Comfort »).
const facturxProfile = 'urn:cen.eu:en16931:2017';

/// Nom conventionnel du XML embarqué dans le PDF.
const facturxFileName = 'factur-x.xml';

String _escape(String text) => text
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;');

String _date(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}${d.month.toString().padLeft(2, '0')}'
    '${d.day.toString().padLeft(2, '0')}';

String _rate(int basisPoints) => (basisPoints / 100).toStringAsFixed(2);

/// Quantité sans zéros inutiles (4 décimales au plus).
String _quantity(num q) {
  final text = q.toStringAsFixed(4);
  return text.contains('.')
      ? text.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '')
      : text;
}

/// Prix net en euros (4 décimales au plus).
String _price(double cents) => _quantity(cents / 100);

/// XML Factur-X (Cross Industry Invoice D16B, profil EN 16931) d'une
/// facture (380) ou d'un avoir (381).
String buildFacturxXml(IssuedDocument doc) {
  if (doc.kind == DocumentKind.quote) {
    throw ArgumentError('Un devis n’a pas de XML Factur-X.');
  }
  final totals = doc.totals;
  final b = StringBuffer()
    ..write('<?xml version="1.0" encoding="UTF-8"?>\n')
    ..write(
      '<rsm:CrossIndustryInvoice '
      'xmlns:rsm="urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100" '
      'xmlns:ram="urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100" '
      'xmlns:qdt="urn:un:unece:uncefact:data:standard:QualifiedDataType:100" '
      'xmlns:udt="urn:un:unece:uncefact:data:standard:UnqualifiedDataType:100">',
    )
    ..write('<rsm:ExchangedDocumentContext>')
    ..write('<ram:GuidelineSpecifiedDocumentContextParameter>')
    ..write('<ram:ID>$facturxProfile</ram:ID>')
    ..write('</ram:GuidelineSpecifiedDocumentContextParameter>')
    ..write('</rsm:ExchangedDocumentContext>')
    ..write('<rsm:ExchangedDocument>')
    ..write('<ram:ID>${_escape(doc.number)}</ram:ID>')
    ..write(
      '<ram:TypeCode>${doc.kind == DocumentKind.creditNote ? 381 : 380}'
      '</ram:TypeCode>',
    )
    ..write('<ram:IssueDateTime><udt:DateTimeString format="102">')
    ..write(_date(doc.issueDate))
    ..write('</udt:DateTimeString></ram:IssueDateTime>');
  for (final note in [
    doc.subject,
    doc.notes,
    doc.latePenalties,
  ].whereType<String>().where((n) => n.trim().isNotEmpty)) {
    b.write(
      '<ram:IncludedNote><ram:Content>${_escape(note)}</ram:Content>'
      '</ram:IncludedNote>',
    );
  }
  b
    ..write('</rsm:ExchangedDocument>')
    ..write('<rsm:SupplyChainTradeTransaction>');

  for (final (i, line) in doc.lines.indexed) {
    b
      ..write('<ram:IncludedSupplyChainTradeLineItem>')
      ..write(
        '<ram:AssociatedDocumentLineDocument><ram:LineID>${i + 1}'
        '</ram:LineID></ram:AssociatedDocumentLineDocument>',
      )
      ..write(
        '<ram:SpecifiedTradeProduct><ram:Name>'
        '${_escape(line.description)}</ram:Name></ram:SpecifiedTradeProduct>',
      )
      ..write(
        '<ram:SpecifiedLineTradeAgreement><ram:NetPriceProductTradePrice>'
        '<ram:ChargeAmount>${_price(line.netUnitPriceCents)}</ram:ChargeAmount>'
        '</ram:NetPriceProductTradePrice></ram:SpecifiedLineTradeAgreement>',
      )
      ..write(
        '<ram:SpecifiedLineTradeDelivery><ram:BilledQuantity '
        'unitCode="C62">${_quantity(line.quantity)}</ram:BilledQuantity>'
        '</ram:SpecifiedLineTradeDelivery>',
      )
      ..write('<ram:SpecifiedLineTradeSettlement>')
      ..write(_lineTax(line.vatRate))
      ..write(
        '<ram:SpecifiedTradeSettlementLineMonetarySummation>'
        '<ram:LineTotalAmount>${formatCentsDot(line.totalCents)}'
        '</ram:LineTotalAmount>'
        '</ram:SpecifiedTradeSettlementLineMonetarySummation>',
      )
      ..write('</ram:SpecifiedLineTradeSettlement>')
      ..write('</ram:IncludedSupplyChainTradeLineItem>');
  }

  b.write('<ram:ApplicableHeaderTradeAgreement>');
  if (doc.buyerReference != null) {
    b.write(
      '<ram:BuyerReference>${_escape(doc.buyerReference!)}'
      '</ram:BuyerReference>',
    );
  }
  b
    ..write(_party('SellerTradeParty', doc.seller))
    ..write(_party('BuyerTradeParty', doc.buyer));
  if (doc.buyerReference != null) {
    b.write(
      '<ram:BuyerOrderReferencedDocument><ram:IssuerAssignedID>'
      '${_escape(doc.buyerReference!)}</ram:IssuerAssignedID>'
      '</ram:BuyerOrderReferencedDocument>',
    );
  }
  b
    ..write('</ram:ApplicableHeaderTradeAgreement>')
    ..write('<ram:ApplicableHeaderTradeDelivery>');
  final delivery = doc.serviceDate ?? doc.issueDate;
  b
    ..write(
      '<ram:ActualDeliverySupplyChainEvent><ram:OccurrenceDateTime>'
      '<udt:DateTimeString format="102">${_date(delivery)}'
      '</udt:DateTimeString></ram:OccurrenceDateTime>'
      '</ram:ActualDeliverySupplyChainEvent>',
    )
    ..write('</ram:ApplicableHeaderTradeDelivery>')
    ..write('<ram:ApplicableHeaderTradeSettlement>')
    ..write('<ram:InvoiceCurrencyCode>EUR</ram:InvoiceCurrencyCode>')
    ..write('<ram:SpecifiedTradeSettlementPaymentMeans>');
  if (doc.iban != null) {
    b
      ..write('<ram:TypeCode>58</ram:TypeCode>')
      ..write(
        '<ram:PayeePartyCreditorFinancialAccount><ram:IBANID>'
        '${_escape(doc.iban!.replaceAll(' ', ''))}</ram:IBANID>'
        '</ram:PayeePartyCreditorFinancialAccount>',
      );
  } else {
    b.write('<ram:TypeCode>30</ram:TypeCode>');
  }
  b.write('</ram:SpecifiedTradeSettlementPaymentMeans>');
  for (final MapEntry(key: rate, value: line) in totals.breakdown.entries) {
    b
      ..write('<ram:ApplicableTradeTax>')
      ..write(
        '<ram:CalculatedAmount>${formatCentsDot(line.vatCents)}'
        '</ram:CalculatedAmount>',
      )
      ..write('<ram:TypeCode>VAT</ram:TypeCode>');
    if (rate == 0) {
      b.write(
        '<ram:ExemptionReason>${_escape(doc.vatExemptionReason ?? 'Exonération de TVA')}'
        '</ram:ExemptionReason>',
      );
    }
    b
      ..write(
        '<ram:BasisAmount>${formatCentsDot(line.baseCents)}'
        '</ram:BasisAmount>',
      )
      ..write('<ram:CategoryCode>${rate == 0 ? 'E' : 'S'}</ram:CategoryCode>')
      ..write(
        '<ram:RateApplicablePercent>${_rate(rate)}'
        '</ram:RateApplicablePercent>',
      )
      ..write('</ram:ApplicableTradeTax>');
  }
  if (doc.paymentTerms != null || doc.dueDate != null) {
    b.write('<ram:SpecifiedTradePaymentTerms>');
    if (doc.paymentTerms != null) {
      b.write(
        '<ram:Description>${_escape(doc.paymentTerms!)}</ram:Description>',
      );
    }
    if (doc.dueDate != null) {
      b.write(
        '<ram:DueDateDateTime><udt:DateTimeString format="102">'
        '${_date(doc.dueDate!)}</udt:DateTimeString></ram:DueDateDateTime>',
      );
    }
    b.write('</ram:SpecifiedTradePaymentTerms>');
  }
  b
    ..write('<ram:SpecifiedTradeSettlementHeaderMonetarySummation>')
    ..write(
      '<ram:LineTotalAmount>${formatCentsDot(totals.htCents)}'
      '</ram:LineTotalAmount>',
    )
    ..write(
      '<ram:TaxBasisTotalAmount>${formatCentsDot(totals.htCents)}'
      '</ram:TaxBasisTotalAmount>',
    )
    ..write(
      '<ram:TaxTotalAmount currencyID="EUR">'
      '${formatCentsDot(totals.vatCents)}</ram:TaxTotalAmount>',
    )
    ..write(
      '<ram:GrandTotalAmount>${formatCentsDot(totals.ttcCents)}'
      '</ram:GrandTotalAmount>',
    )
    ..write(
      '<ram:DuePayableAmount>${formatCentsDot(totals.ttcCents)}'
      '</ram:DuePayableAmount>',
    )
    ..write('</ram:SpecifiedTradeSettlementHeaderMonetarySummation>');
  if (doc.originalNumber != null) {
    b.write(
      '<ram:InvoiceReferencedDocument><ram:IssuerAssignedID>'
      '${_escape(doc.originalNumber!)}</ram:IssuerAssignedID>'
      '</ram:InvoiceReferencedDocument>',
    );
  }
  b
    ..write('</ram:ApplicableHeaderTradeSettlement>')
    ..write('</rsm:SupplyChainTradeTransaction>')
    ..write('</rsm:CrossIndustryInvoice>');
  return b.toString();
}

String _lineTax(int rate) =>
    '<ram:ApplicableTradeTax><ram:TypeCode>VAT</ram:TypeCode>'
    '<ram:CategoryCode>${rate == 0 ? 'E' : 'S'}</ram:CategoryCode>'
    '<ram:RateApplicablePercent>${_rate(rate)}</ram:RateApplicablePercent>'
    '</ram:ApplicableTradeTax>';

String _party(String element, Party p) {
  final b = StringBuffer('<ram:$element>')
    ..write('<ram:Name>${_escape(p.name)}</ram:Name>');
  final legalId = p.siret ?? p.siren;
  if (legalId != null) {
    // 0002 : SIREN, 0009 : SIRET (codes ICD).
    b.write(
      '<ram:SpecifiedLegalOrganization><ram:ID schemeID="'
      '${p.siret != null ? '0009' : '0002'}">${_escape(legalId)}</ram:ID>'
      '</ram:SpecifiedLegalOrganization>',
    );
  }
  b.write('<ram:PostalTradeAddress>');
  if (p.postalCode != null) {
    b.write('<ram:PostcodeCode>${_escape(p.postalCode!)}</ram:PostcodeCode>');
  }
  if (p.address != null) {
    b.write(
      '<ram:LineOne>${_escape(p.address!.split('\n').first)}</ram:LineOne>',
    );
  }
  if (p.city != null) {
    b.write('<ram:CityName>${_escape(p.city!)}</ram:CityName>');
  }
  b.write(
    '<ram:CountryID>${_escape(p.country)}</ram:CountryID>'
    '</ram:PostalTradeAddress>',
  );
  if (p.email != null) {
    b.write(
      '<ram:URIUniversalCommunication><ram:URIID schemeID="EM">'
      '${_escape(p.email!)}</ram:URIID></ram:URIUniversalCommunication>',
    );
  }
  if (p.vatNumber != null) {
    b.write(
      '<ram:SpecifiedTaxRegistration><ram:ID schemeID="VA">'
      '${_escape(p.vatNumber!)}</ram:ID></ram:SpecifiedTaxRegistration>',
    );
  }
  b.write('</ram:$element>');
  return b.toString();
}
