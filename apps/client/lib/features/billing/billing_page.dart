import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../data/local/database.dart';
import '../../data/sync/local_entities.dart';
import '../../design_system/design_system.dart';
import '../crm/crm_data.dart';
import '../crm/crm_format.dart';
import '../crm/widgets/crm_table.dart';
import '../crm/widgets/record_form.dart';
import 'billing_actions.dart';
import 'billing_data.dart';
import 'document_detail.dart';
import 'document_editor.dart';

/// Facturation : devis, factures, avoirs, catalogue et exports comptables.
class BillingPage extends ConsumerStatefulWidget {
  const BillingPage({super.key});

  @override
  ConsumerState<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends ConsumerState<BillingPage> {
  int _tab = 1;

  static const _kinds = [
    DocumentKind.quote,
    DocumentKind.invoice,
    DocumentKind.creditNote,
  ];

  Future<void> _newDocument(DocumentKind kind) async {
    final id = await showDocumentEditor(context, kind: kind);
    if (id != null && mounted) await showDocumentDetail(context, id);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canWrite = ref.watch(permissionProvider(Permission.invoiceWrite));
    final canExport = ref.watch(permissionProvider(Permission.billingSettings));
    final documents = ref.watch(invoicesProvider).value ?? const <InvoiceRow>[];
    int count(DocumentKind kind) =>
        documents.where((d) => d.kind == kind.key).length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageHeader(
          title: l10n.navBilling,
          subtitle: l10n.billingSubtitle,
          icon: LucideIcons.receipt,
          actions: [
            if (canWrite && _tab < 2)
              VButton.primary(
                label: _tab == 0
                    ? l10n.billingNewQuote
                    : l10n.billingNewInvoice,
                icon: LucideIcons.plus,
                onPressed: () => unawaited(_newDocument(_kinds[_tab])),
              ),
            if (canWrite && _tab == 3)
              VButton.primary(
                label: l10n.productNew,
                icon: LucideIcons.plus,
                onPressed: () => unawaited(editProduct(context)),
              ),
          ],
        ),
        VTabBar(
          index: _tab,
          onChanged: (i) => setState(() => _tab = i),
          tabs: [
            VTab(
              l10n.billingQuotes,
              icon: LucideIcons.fileText,
              count: count(DocumentKind.quote),
            ),
            VTab(
              l10n.billingInvoices,
              icon: LucideIcons.receipt,
              count: count(DocumentKind.invoice),
            ),
            VTab(
              l10n.billingCreditNotes,
              icon: LucideIcons.undo2,
              count: count(DocumentKind.creditNote),
            ),
            VTab(
              l10n.billingProducts,
              icon: LucideIcons.package,
              count: (ref.watch(productsProvider).value ?? const []).length,
            ),
            if (canExport)
              VTab(l10n.billingExports, icon: LucideIcons.fileDown),
          ],
        ),
        Expanded(
          child: switch (_tab) {
            0 || 1 || 2 => _DocumentsTable(
              key: ValueKey(_kinds[_tab]),
              kind: _kinds[_tab],
            ),
            3 => const _Products(),
            _ => const _Exports(),
          },
        ),
      ],
    );
  }
}

class _DocumentsTable extends ConsumerWidget {
  const _DocumentsTable({super.key, required this.kind});

  final DocumentKind kind;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(invoicesProvider);
    final rows = [
      for (final d in async.value ?? const <InvoiceRow>[])
        if (d.kind == kind.key) d,
    ];
    final organisations = ref.watch(organisationByIdProvider);
    final paid = ref.watch(paidByInvoiceProvider);
    final canWrite = ref.watch(permissionProvider(Permission.invoiceWrite));

    return CrmTable<InvoiceRow>(
      tableId: 'billing_${kind.key}',
      entity: null,
      rows: rows,
      rowId: (d) => d.id,
      loading: async.isLoading,
      exportName: kind.key,
      onOpen: (d) => unawaited(showDocumentDetail(context, d.id)),
      onDelete: canWrite
          ? (ids) async {
              final drafts = [
                for (final d in rows)
                  if (ids.contains(d.id) && d.number == null) d.id,
              ];
              if (drafts.length < ids.length) {
                ref.read(toastProvider).info(l10n.billingOnlyDraftsDeleted);
              }
              await ref
                  .read(recordStoreProvider)
                  .delete(SyncEntities.invoices, drafts);
            }
          : null,
      empty: EmptyState(
        icon: LucideIcons.receipt,
        title: l10n.billingEmpty(kind.label.toLowerCase()),
      ),
      columns: [
        VColumn(
          id: 'number',
          label: l10n.billingNumber,
          width: 140,
          hideable: false,
          sortValue: (d) => d.number ?? '',
          filterValue: (d) => d.number,
          cell: (context, d) => Text(
            d.number ?? l10n.billingDraft,
            style: d.number == null
                ? context.text.small
                : context.text.bodyStrong,
          ),
        ),
        VColumn(
          id: 'customer',
          label: l10n.billingCustomer,
          width: 200,
          sortValue: (d) =>
              searchText(organisations[d.organisationId]?.name ?? ''),
          filterValue: (d) => organisations[d.organisationId]?.name,
          cell: (context, d) => Text(
            organisations[d.organisationId]?.name ?? '—',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        VColumn(
          id: 'subject',
          label: l10n.billingSubject,
          width: 180,
          flex: true,
          filterValue: (d) => d.subject,
          cell: (context, d) =>
              Text(d.subject ?? '', overflow: TextOverflow.ellipsis),
        ),
        VColumn(
          id: 'issue_date',
          label: l10n.billingIssueDate,
          width: 110,
          sortValue: (d) => d.issueDate ?? '',
          cell: (context, d) => Text(formatDay(d.issueDate)),
        ),
        if (kind == DocumentKind.invoice)
          VColumn(
            id: 'due_date',
            label: l10n.billingDueDate,
            width: 110,
            sortValue: (d) => d.dueDate ?? '',
            cell: (context, d) => Text(formatDay(d.dueDate)),
          ),
        VColumn(
          id: 'total',
          label: l10n.billingTotalTtc,
          width: 120,
          sortValue: (d) => d.totalTtcCents ?? documentTotals(d).ttcCents,
          cell: (context, d) => Text(
            formatAmount(d.totalTtcCents ?? documentTotals(d).ttcCents),
            style: context.text.numeric,
          ),
        ),
        if (kind == DocumentKind.invoice)
          VColumn(
            id: 'balance',
            label: l10n.billingBalance,
            width: 120,
            sortValue: (d) => (d.totalTtcCents ?? 0) - (paid[d.id] ?? 0),
            cell: (context, d) => Text(
              d.number == null
                  ? ''
                  : formatAmount((d.totalTtcCents ?? 0) - (paid[d.id] ?? 0)),
              style: context.text.numeric,
            ),
          ),
        VColumn(
          id: 'status',
          label: l10n.billingStatus,
          width: 110,
          sortValue: (d) => d.status,
          filterValue: (d) => enumByKey(DocumentStatus.values, d.status)?.label,
          cell: (context, d) => Row(
            children: [
              VBadge(
                enumByKey(DocumentStatus.values, d.status)?.label ?? d.status,
                tone: documentTone(d.status),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Création ou modification d'un produit du catalogue.
Future<String?> editProduct(BuildContext context, {ProductRow? product}) {
  final l10n = context.l10n;
  return showRecordForm(
    context,
    schema: SyncEntities.products,
    title: product == null ? l10n.productNew : l10n.productEdit,
    icon: LucideIcons.package,
    id: product?.id,
    // Le choix du taux se fait sur sa clé texte (« 2000 »).
    initial: product == null
        ? {'vat_rate': '2000', 'active': true}
        : {
            ...rowToWire(SyncEntities.products, product),
            'vat_rate': '${product.vatRate ?? 2000}',
          },
    fields: [
      TextFieldDef('name', l10n.productName, autofocus: true, wide: true),
      TextFieldDef(
        'description',
        l10n.productDescription,
        wide: true,
        maxLines: 3,
      ),
      NumberFieldDef('unit_price_cents', l10n.billingUnitPriceHt, cents: true),
      ChoiceFieldDef('vat_rate', l10n.billingVat, [
        for (final e in vatRates.entries) VSelectOption('${e.key}', e.value),
      ], clearable: false),
      TextFieldDef('unit', l10n.productUnit, hint: l10n.productUnitHint),
      TextFieldDef('account_code', l10n.productAccount, hint: '706000'),
      BoolFieldDef('active', l10n.productActive),
    ],
    transform: (values) => {
      ...values,
      'vat_rate': switch (values['vat_rate']) {
        final String s => int.parse(s),
        final other => other,
      },
    },
  );
}

class _Products extends ConsumerWidget {
  const _Products();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final async = ref.watch(productsProvider);
    final canWrite = ref.watch(permissionProvider(Permission.invoiceWrite));
    return CrmTable<ProductRow>(
      tableId: 'billing_products',
      entity: null,
      rows: async.value ?? const [],
      rowId: (p) => p.id,
      loading: async.isLoading,
      exportName: 'produits',
      onOpen: (p) {
        if (canWrite) unawaited(editProduct(context, product: p));
      },
      onDelete: canWrite
          ? (ids) =>
                ref.read(recordStoreProvider).delete(SyncEntities.products, ids)
          : null,
      empty: EmptyState(
        icon: LucideIcons.package,
        title: l10n.productsEmpty,
        message: l10n.productsEmptyMessage,
      ),
      columns: [
        VColumn(
          id: 'name',
          label: l10n.productName,
          width: 280,
          hideable: false,
          flex: true,
          sortValue: (p) => searchText(p.name),
          filterValue: (p) => p.name,
          cell: (context, p) => Text(p.name, style: context.text.bodyStrong),
        ),
        VColumn(
          id: 'price',
          label: l10n.billingUnitPriceHt,
          width: 140,
          sortValue: (p) => p.unitPriceCents ?? 0,
          cell: (context, p) =>
              Text(formatAmount(p.unitPriceCents), style: context.text.numeric),
        ),
        VColumn(
          id: 'vat',
          label: l10n.billingVat,
          width: 90,
          cell: (context, p) => Text(vatRates[p.vatRate] ?? '—'),
        ),
        VColumn(
          id: 'unit',
          label: l10n.productUnit,
          width: 100,
          cell: (context, p) => Text(p.unit ?? ''),
        ),
        VColumn(
          id: 'active',
          label: l10n.productActive,
          width: 90,
          cell: (context, p) => Text(p.active == false ? l10n.no : l10n.yes),
        ),
      ],
    );
  }
}

class _Exports extends ConsumerStatefulWidget {
  const _Exports();

  @override
  ConsumerState<_Exports> createState() => _ExportsState();
}

class _ExportsState extends ConsumerState<_Exports> {
  late int _year = DateTime.now().year;
  late DateTime _from = DateTime(DateTime.now().year, DateTime.now().month);
  late DateTime _to = DateTime(_from.year, _from.month + 1, 0);
  VatReport? _report;
  bool _loading = false;

  Future<void> _loadVat() async {
    final api = ref.read(billingApiProvider);
    if (api == null) return;
    setState(() => _loading = true);
    try {
      final report = await api.vatReport(_from, _to);
      if (mounted) setState(() => _report = report);
    } on ApiFailure catch (e) {
      ref.read(toastProvider).error(e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    final api = ref.watch(billingApiProvider);
    final settings = ref.watch(billingSettingsProvider).value;
    final thisYear = DateTime.now().year;

    Widget vatTable(String title, List<VatReportRow> rows) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: t.bodyStrong),
        const SizedBox(height: VSpace.x1),
        if (rows.isEmpty) Text(l10n.billingVatNone, style: t.small),
        for (final r in rows)
          Row(
            children: [
              SizedBox(width: 80, child: Text(vatRates[r.rate] ?? '${r.rate}')),
              SizedBox(
                width: 160,
                child: Text(
                  l10n.billingVatBase(formatAmount(r.baseCents)),
                  style: t.small,
                ),
              ),
              Text(formatAmount(r.vatCents), style: t.numeric),
            ],
          ),
      ],
    );

    return ListView(
      padding: const EdgeInsets.all(VSpace.x6),
      children: [
        VBanner(
          icon: LucideIcons.info,
          message: l10n.billingAccountantNotice,
          tone: VTone.warning,
        ),
        const SizedBox(height: VSpace.x4),
        VCard(
          title: l10n.fecTitle,
          description: l10n.fecDescription,
          child: Row(
            children: [
              VSelect<int>(
                value: _year,
                width: 120,
                options: [
                  for (var y = thisYear; y >= thisYear - 6; y--)
                    VSelectOption(y, '$y'),
                ],
                onChanged: (v) => setState(() => _year = v),
              ),
              const SizedBox(width: VSpace.x3),
              VButton.primary(
                label: l10n.fecDownload,
                icon: LucideIcons.fileDown,
                onPressed: api == null || settings?.siren == null
                    ? null
                    : () => unawaited(
                        saveDownload(
                          context,
                          ref,
                          fileName: '${settings!.siren}FEC${_year}1231.txt',
                          load: () => api.fec(_year),
                        ),
                      ),
              ),
              if (settings != null && settings.siren == null) ...[
                const SizedBox(width: VSpace.x3),
                Expanded(child: Text(l10n.fecNeedsSiren, style: t.small)),
              ],
            ],
          ),
        ),
        const SizedBox(height: VSpace.x4),
        VCard(
          title: l10n.vatReportTitle,
          description: l10n.vatReportDescription,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: VDateField(
                      label: l10n.periodFrom,
                      value: _from,
                      onChanged: (d) => setState(() => _from = d ?? _from),
                    ),
                  ),
                  const SizedBox(width: VSpace.x3),
                  SizedBox(
                    width: 170,
                    child: VDateField(
                      label: l10n.periodTo,
                      value: _to,
                      onChanged: (d) => setState(() => _to = d ?? _to),
                    ),
                  ),
                  const SizedBox(width: VSpace.x3),
                  Padding(
                    padding: const EdgeInsets.only(top: VSpace.x5),
                    child: VButton(
                      label: l10n.vatReportCompute,
                      icon: LucideIcons.calculator,
                      loading: _loading,
                      onPressed: api == null ? null : _loadVat,
                    ),
                  ),
                ],
              ),
              if (_report != null) ...[
                const SizedBox(height: VSpace.x4),
                vatTable(l10n.vatOnDebits, _report!.debits),
                const SizedBox(height: VSpace.x3),
                vatTable(l10n.vatOnReceipts, _report!.receipts),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Documents d'une organisation (onglet de la fiche).
class OrganisationDocuments extends ConsumerWidget {
  const OrganisationDocuments({super.key, required this.organisationId});

  final String organisationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final t = context.text;
    final canWrite = ref.watch(permissionProvider(Permission.invoiceWrite));
    final documents = [
      for (final d in ref.watch(invoicesProvider).value ?? const <InvoiceRow>[])
        if (d.organisationId == organisationId) d,
    ];
    Future<void> create(DocumentKind kind) async {
      final id = await showDocumentEditor(
        context,
        kind: kind,
        organisationId: organisationId,
      );
      if (id != null && context.mounted) await showDocumentDetail(context, id);
    }

    return ListView(
      padding: const EdgeInsets.all(VSpace.x4),
      children: [
        if (canWrite)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              VButton(
                label: l10n.billingNewQuote,
                icon: LucideIcons.fileText,
                size: VButtonSize.sm,
                onPressed: () => unawaited(create(DocumentKind.quote)),
              ),
              const SizedBox(width: VSpace.x2),
              VButton.primary(
                label: l10n.billingNewInvoice,
                icon: LucideIcons.plus,
                size: VButtonSize.sm,
                onPressed: () => unawaited(create(DocumentKind.invoice)),
              ),
            ],
          ),
        const SizedBox(height: VSpace.x3),
        if (documents.isEmpty)
          EmptyState(
            icon: LucideIcons.receipt,
            title: l10n.billingOrganisationEmpty,
          ),
        for (final d in documents)
          Pressable(
            onPressed: () => unawaited(showDocumentDetail(context, d.id)),
            semanticLabel: d.number ?? d.subject ?? '',
            builder: (context, s) => AnimatedContainer(
              duration: VMotion.fast,
              margin: const EdgeInsets.only(bottom: VSpace.x1_5),
              padding: const EdgeInsets.symmetric(
                horizontal: VSpace.x3,
                vertical: VSpace.x2 + 2,
              ),
              decoration: BoxDecoration(
                color: s.hovered ? c.surfaceHover : c.surface,
                borderRadius: VRadius.mdAll,
                border: Border.all(color: c.border),
              ),
              child: Row(
                children: [
                  Icon(LucideIcons.receipt, size: 16, color: c.textMuted),
                  const SizedBox(width: VSpace.x3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${documentKind(d).label} '
                          '${d.number ?? l10n.billingDraft.toLowerCase()}',
                          style: t.bodyStrong,
                        ),
                        if (d.subject != null) Text(d.subject!, style: t.small),
                      ],
                    ),
                  ),
                  Text(
                    formatAmount(d.totalTtcCents ?? documentTotals(d).ttcCents),
                    style: t.numeric,
                  ),
                  const SizedBox(width: VSpace.x3),
                  VBadge(
                    enumByKey(DocumentStatus.values, d.status)?.label ??
                        d.status,
                    tone: documentTone(d.status),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
