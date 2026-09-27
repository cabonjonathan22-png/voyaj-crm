import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoicing/invoicing.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../data/local/database.dart';
import '../../data/records/record_store.dart';
import '../../design_system/design_system.dart';
import '../crm/crm_data.dart';
import '../crm/crm_format.dart';
import 'billing_data.dart';

/// Création ou modification d'un brouillon (devis, facture, avoir).
/// Retourne l'identifiant enregistré, ou `null`.
Future<String?> showDocumentEditor(
  BuildContext context, {
  InvoiceRow? document,
  DocumentKind kind = DocumentKind.invoice,
  String? organisationId,
  String? dealId,
}) => showVModal<String>(
  context,
  builder: (_) => _DocumentEditor(
    document: document,
    kind: document == null ? kind : documentKind(document),
    organisationId: organisationId,
    dealId: dealId,
  ),
);

/// Ligne en cours de saisie.
final class _LineInput {
  _LineInput({
    String description = '',
    String quantity = '1',
    String price = '',
    this.vatRate = 2000,
    String discount = '',
    this.unit,
    this.accountCode,
  }) : description = TextEditingController(text: description),
       quantity = TextEditingController(text: quantity),
       price = TextEditingController(text: price),
       discount = TextEditingController(text: discount);

  factory _LineInput.from(DocumentLine line) => _LineInput(
    description: line.description,
    quantity: _numText(line.quantity),
    price: _numText(line.unitPriceCents / 100),
    vatRate: line.vatRate,
    discount: line.discountPercent == 0 ? '' : _numText(line.discountPercent),
    unit: line.unit,
    accountCode: line.accountCode,
  );

  final TextEditingController description;
  final TextEditingController quantity;
  final TextEditingController price;
  final TextEditingController discount;
  int vatRate;
  final String? unit;
  final String? accountCode;

  static String _numText(num n) =>
      n == n.roundToDouble() ? '${n.round()}' : '$n'.replaceAll('.', ',');

  static num? _parse(String text) {
    final clean = text.trim().replaceAll(' ', '').replaceAll(',', '.');
    return clean.isEmpty ? null : num.tryParse(clean);
  }

  /// Ligne au format réseau (valeurs invalides laissées aux règles
  /// partagées).
  Map<String, Object?> toJson() {
    final price = _parse(this.price.text);
    return {
      'description': description.text.trim(),
      'quantity': _parse(quantity.text) ?? 0,
      'unit_price_cents': price == null ? null : (price * 100).round(),
      'vat_rate': vatRate,
      if (_parse(discount.text) case final d? when d != 0)
        'discount_percent': d,
      'unit': ?unit,
      'account_code': ?accountCode,
    };
  }

  /// Ligne pour l'aperçu des totaux (`null` si incomplète).
  DocumentLine? preview() {
    final q = _parse(quantity.text);
    final p = _parse(price.text);
    if (q == null || p == null) return null;
    return DocumentLine(
      description: description.text,
      quantity: q,
      unitPriceCents: (p * 100).round(),
      vatRate: vatRate,
      discountPercent: _parse(discount.text) ?? 0,
    );
  }

  void dispose() {
    description.dispose();
    quantity.dispose();
    price.dispose();
    discount.dispose();
  }
}

class _DocumentEditor extends ConsumerStatefulWidget {
  const _DocumentEditor({
    required this.document,
    required this.kind,
    this.organisationId,
    this.dealId,
  });

  final InvoiceRow? document;
  final DocumentKind kind;
  final String? organisationId;
  final String? dealId;

  @override
  ConsumerState<_DocumentEditor> createState() => _DocumentEditorState();
}

class _DocumentEditorState extends ConsumerState<_DocumentEditor> {
  InvoiceRow? get _doc => widget.document;

  late final _subject = TextEditingController(text: _doc?.subject ?? '');
  late final _notes = TextEditingController(text: _doc?.notes ?? '');
  late final _terms = TextEditingController(text: _doc?.paymentTerms ?? '');
  late final _buyerRef = TextEditingController(
    text: _doc?.buyerReference ?? '',
  );
  late final _serviceCode = TextEditingController(
    text: _doc?.serviceCode ?? '',
  );
  late String? _organisationId = _doc?.organisationId ?? widget.organisationId;
  late String? _contactId = _doc?.contactId;
  late String? _serviceDate = _doc?.serviceDate;
  late String? _dueDate = _doc?.dueDate;
  late String? _validUntil = _doc?.validUntil;
  late final List<_LineInput> _lines = [
    if (_doc != null)
      for (final line in documentLines(_doc!)) _LineInput.from(line),
    if (_doc == null || documentLines(_doc!).isEmpty) _LineInput(),
  ];
  Map<String, String> _errors = const {};
  bool _saving = false;

  @override
  void dispose() {
    for (final c in [_subject, _notes, _terms, _buyerRef, _serviceCode]) {
      c.dispose();
    }
    for (final line in _lines) {
      line.dispose();
    }
    super.dispose();
  }

  static DateTime? _toDate(String? iso) =>
      iso == null ? null : DateTime.tryParse(iso);

  static String? _toIso(DateTime? date) =>
      date?.toIso8601String().substring(0, 10);

  Future<void> _addFromCatalog() async {
    final products = [
      for (final p in ref.read(productsProvider).value ?? const <ProductRow>[])
        if (p.active != false) p,
    ];
    final option = await showSearchPicker<String>(
      context,
      title: context.l10n.billingAddProduct,
      options: [
        for (final p in products)
          VSelectOption(
            p.id,
            '${p.name} — ${formatAmount(p.unitPriceCents)}',
            icon: LucideIcons.package,
          ),
      ],
    );
    if (option == null) return;
    final p = products.firstWhere((p) => p.id == option.value);
    setState(() {
      if (_lines.length == 1 && _lines.single.description.text.trim().isEmpty) {
        _lines.removeAt(0).dispose();
      }
      _lines.add(
        _LineInput(
          description: [
            p.name,
            if (p.description != null && p.description!.isNotEmpty)
              p.description!,
          ].join('\n'),
          price: _LineInput._numText((p.unitPriceCents ?? 0) / 100),
          vatRate: p.vatRate ?? 2000,
          unit: p.unit,
          accountCode: p.accountCode,
        ),
      );
    });
  }

  Future<void> _save() async {
    final fields = <String, Object?>{
      'kind': widget.kind.key,
      'status': DocumentStatus.draft.key,
      'subject': _subject.text,
      'organisation_id': _organisationId,
      'contact_id': _contactId,
      'deal_id': _doc?.dealId ?? widget.dealId,
      'service_date': _serviceDate,
      if (widget.kind == DocumentKind.invoice) 'due_date': _dueDate,
      if (widget.kind == DocumentKind.quote) 'valid_until': _validUntil,
      'notes': _notes.text,
      'payment_terms': _terms.text,
      'buyer_reference': _buyerRef.text,
      'service_code': _serviceCode.text,
      'lines': [for (final line in _lines) line.toJson()],
    };
    final missingPrice = _lines.any(
      (l) => l.toJson()['unit_price_cents'] == null,
    );
    if (missingPrice) {
      setState(() => _errors = {'lines': context.l10n.billingLinePrice});
      return;
    }
    setState(() {
      _saving = true;
      _errors = const {};
    });
    final store = ref.read(recordStoreProvider);
    try {
      final String id;
      if (_doc == null) {
        id = await store.create(SyncEntities.invoices, fields);
      } else {
        id = _doc!.id;
        await store.update(SyncEntities.invoices, id, fields);
      }
      if (mounted) Navigator.of(context).pop(id);
    } on RecordValidationException catch (e) {
      if (mounted) {
        setState(() {
          _errors = e.byField;
          _saving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    final c = context.colors;
    final organisations =
        ref.watch(organisationsProvider).value ?? const <OrganisationRow>[];
    final contacts = [
      for (final ct
          in ref.watch(contactsProvider).value ?? const <ContactRow>[])
        if (_organisationId == null || ct.organisationId == _organisationId) ct,
    ];
    final totals = computeTotals(_lines.map((l) => l.preview()).nonNulls);
    // Catalogue chargé d'avance pour « Depuis le catalogue ».
    ref.watch(productsProvider);
    final creditNote = widget.kind == DocumentKind.creditNote;

    Widget pair(Widget a, Widget b) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: a),
        const SizedBox(width: VSpace.x3),
        Expanded(child: b),
      ],
    );

    return VModal(
      title: _doc == null
          ? l10n.billingNewDocument(widget.kind.label.toLowerCase())
          : l10n.billingEditDocument(widget.kind.label.toLowerCase()),
      icon: LucideIcons.receipt,
      width: 900,
      actions: [
        VButton(
          label: l10n.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        VButton.primary(
          label: _doc == null ? l10n.create : l10n.save,
          loading: _saving,
          onPressed: _save,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          pair(
            VSearchSelect<String>(
              label: l10n.billingCustomer,
              value: _organisationId,
              error: _errors['organisation_id'],
              options: [
                for (final o in organisations) VSelectOption(o.id, o.name),
              ],
              onChanged: creditNote
                  ? null
                  : (v) => setState(() {
                      _organisationId = v;
                      _contactId = null;
                    }),
            ),
            VSearchSelect<String>(
              label: l10n.billingContact,
              value: _contactId,
              options: [
                for (final ct in contacts)
                  VSelectOption(ct.id, contactName(ct)),
              ],
              onChanged: (v) => setState(() => _contactId = v),
            ),
          ),
          const SizedBox(height: VSpace.x3),
          VTextField(
            controller: _subject,
            label: l10n.billingSubject,
            autofocus: _doc == null,
            error: _errors['subject'],
          ),
          const SizedBox(height: VSpace.x3),
          pair(
            VDateField(
              label: l10n.billingServiceDate,
              value: _toDate(_serviceDate),
              onChanged: (d) => setState(() => _serviceDate = _toIso(d)),
            ),
            switch (widget.kind) {
              DocumentKind.invoice => VDateField(
                label: l10n.billingDueDate,
                value: _toDate(_dueDate),
                error: _errors['due_date'],
                onChanged: (d) => setState(() => _dueDate = _toIso(d)),
              ),
              DocumentKind.quote => VDateField(
                label: l10n.billingValidUntil,
                value: _toDate(_validUntil),
                onChanged: (d) => setState(() => _validUntil = _toIso(d)),
              ),
              DocumentKind.creditNote => const SizedBox.shrink(),
            },
          ),
          const SizedBox(height: VSpace.x4),
          Row(
            children: [
              Expanded(child: Text(l10n.billingLines, style: t.heading)),
              VButton.ghost(
                label: l10n.billingAddProduct,
                icon: LucideIcons.package,
                size: VButtonSize.sm,
                onPressed: () => unawaited(_addFromCatalog()),
              ),
              VButton.ghost(
                label: l10n.billingAddLine,
                icon: LucideIcons.plus,
                size: VButtonSize.sm,
                onPressed: () => setState(() => _lines.add(_LineInput())),
              ),
            ],
          ),
          const SizedBox(height: VSpace.x2),
          Row(
            children: [
              Expanded(
                child: Text(l10n.billingLineDescription, style: t.label),
              ),
              SizedBox(width: 80, child: Text(l10n.billingQty, style: t.label)),
              const SizedBox(width: VSpace.x2),
              SizedBox(
                width: 110,
                child: Text(l10n.billingUnitPrice, style: t.label),
              ),
              const SizedBox(width: VSpace.x2),
              SizedBox(
                width: 100,
                child: Text(l10n.billingVat, style: t.label),
              ),
              const SizedBox(width: VSpace.x2),
              SizedBox(
                width: 70,
                child: Text(l10n.billingDiscount, style: t.label),
              ),
              const SizedBox(width: 36),
            ],
          ),
          const SizedBox(height: VSpace.x1),
          for (final (i, line) in _lines.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: VSpace.x2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: VTextField(
                      controller: line.description,
                      dense: true,
                      maxLines: 3,
                      minLines: 1,
                    ),
                  ),
                  const SizedBox(width: VSpace.x2),
                  SizedBox(
                    width: 80,
                    child: VTextField(
                      controller: line.quantity,
                      dense: true,
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(width: VSpace.x2),
                  SizedBox(
                    width: 110,
                    child: VTextField(
                      controller: line.price,
                      dense: true,
                      suffix: Padding(
                        padding: const EdgeInsets.only(right: VSpace.x2),
                        child: Text('€', style: t.small),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(width: VSpace.x2),
                  VSelect<int>(
                    value: line.vatRate,
                    width: 100,
                    options: [
                      for (final MapEntry(:key, :value) in vatRates.entries)
                        VSelectOption(key, value),
                    ],
                    onChanged: (v) => setState(() => line.vatRate = v),
                  ),
                  const SizedBox(width: VSpace.x2),
                  SizedBox(
                    width: 70,
                    child: VTextField(
                      controller: line.discount,
                      dense: true,
                      hint: '%',
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  VIconButton(
                    icon: LucideIcons.trash2,
                    tooltip: l10n.delete,
                    size: VButtonSize.sm,
                    onPressed: _lines.length == 1
                        ? null
                        : () => setState(() => _lines.removeAt(i).dispose()),
                  ),
                ],
              ),
            ),
          if (_errors['lines'] != null)
            Text(_errors['lines']!, style: t.small.copyWith(color: c.danger)),
          const SizedBox(height: VSpace.x2),
          Align(
            alignment: Alignment.centerRight,
            child: DocumentTotalsView(totals: totals),
          ),
          const SizedBox(height: VSpace.x4),
          if (widget.kind == DocumentKind.invoice) ...[
            VTextField(
              controller: _terms,
              label: l10n.billingPaymentTerms,
              hint: l10n.billingPaymentTermsHint,
            ),
            const SizedBox(height: VSpace.x3),
          ],
          pair(
            VTextField(
              controller: _buyerRef,
              label: l10n.billingBuyerReference,
              helper: l10n.billingBuyerReferenceHelp,
            ),
            VTextField(
              controller: _serviceCode,
              label: l10n.billingServiceCode,
              helper: l10n.billingServiceCodeHelp,
            ),
          ),
          const SizedBox(height: VSpace.x3),
          VTextField(
            controller: _notes,
            label: l10n.billingNotes,
            maxLines: 3,
            minLines: 2,
          ),
        ],
      ),
    );
  }
}

/// Totaux HT / TVA par taux / TTC.
class DocumentTotalsView extends StatelessWidget {
  const DocumentTotalsView({super.key, required this.totals});

  final DocumentTotals totals;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    Widget row(String label, int cents, {bool strong = false}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 160,
            child: Text(label, style: strong ? t.bodyStrong : t.small),
          ),
          SizedBox(
            width: 120,
            child: Text(
              formatAmount(cents),
              textAlign: TextAlign.right,
              style: strong
                  ? t.numeric.copyWith(fontWeight: FontWeight.w600)
                  : t.numeric,
            ),
          ),
        ],
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        row(l10n.billingTotalHt, totals.htCents),
        for (final MapEntry(key: rate, value: line) in totals.breakdown.entries)
          row(l10n.billingVatAt(vatRates[rate] ?? '$rate'), line.vatCents),
        row(l10n.billingTotalTtc, totals.ttcCents, strong: true),
      ],
    );
  }
}
