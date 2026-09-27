import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../core/format.dart';
import '../../data/local/database.dart';
import '../../design_system/design_system.dart';
import '../crm/crm_data.dart';
import '../crm/crm_format.dart';
import 'billing_actions.dart';
import 'billing_data.dart';
import 'document_editor.dart';

/// Détail d'un document : lignes, totaux, paiements et actions selon son
/// état (modifier, émettre, PDF, paiement, facture, avoir, Chorus Pro).
Future<void> showDocumentDetail(BuildContext context, String id) =>
    showVModal<void>(context, builder: (_) => _DocumentDetail(id: id));

class _DocumentDetail extends ConsumerWidget {
  const _DocumentDetail({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final t = context.text;
    final doc = ref.watch(invoiceByIdProvider)[id];
    if (doc == null) {
      return VModal(
        title: l10n.billingDocument,
        child: EmptyState(
          icon: LucideIcons.receipt,
          title: l10n.billingDocumentMissing,
        ),
      );
    }
    final kind = documentKind(doc);
    final issued = doc.number != null;
    final canWrite = ref.watch(permissionProvider(Permission.invoiceWrite));
    final canIssue = ref.watch(permissionProvider(Permission.invoiceIssue));
    final organisation = ref.watch(
      organisationByIdProvider,
    )[doc.organisationId];
    final contact = ref.watch(contactByIdProvider)[doc.contactId];
    final lines = documentLines(doc);
    final totals = documentTotals(doc);
    final payments = [
      for (final p in ref.watch(paymentsProvider).value ?? const <PaymentRow>[])
        if (p.invoiceId == doc.id) p,
    ];
    final paid = payments.fold<int>(0, (sum, p) => sum + p.amountCents);
    final original = ref.watch(invoiceByIdProvider)[doc.originalInvoiceId];
    final status = enumByKey(DocumentStatus.values, doc.status);

    void close() => Navigator.of(context).pop();

    final actions = <Widget>[
      if (!issued && canWrite)
        VButton(
          label: l10n.edit,
          icon: LucideIcons.pencil,
          onPressed: () =>
              unawaited(showDocumentEditor(context, document: doc)),
        ),
      if (!issued && canWrite)
        VIconButton(
          icon: LucideIcons.trash2,
          tooltip: l10n.delete,
          onPressed: () async {
            await ref.read(recordStoreProvider).delete(SyncEntities.invoices, [
              doc.id,
            ]);
            close();
          },
        ),
      if (!issued && canIssue)
        VButton.primary(
          label: l10n.billingIssue,
          icon: LucideIcons.stamp,
          onPressed: () => unawaited(issueDocument(context, ref, doc)),
        ),
      if (issued)
        VButton(
          label: l10n.billingPdf,
          icon: LucideIcons.fileDown,
          onPressed: () => unawaited(downloadDocumentPdf(context, ref, doc)),
        ),
      if (issued && kind == DocumentKind.quote && canWrite) ...[
        if (doc.status == DocumentStatus.sent.key) ...[
          VButton(
            label: l10n.billingQuoteRefused,
            icon: LucideIcons.x,
            onPressed: () => unawaited(
              ref.read(recordStoreProvider).update(
                SyncEntities.invoices,
                doc.id,
                {'status': DocumentStatus.refused.key},
              ),
            ),
          ),
        ],
        if (doc.status == DocumentStatus.sent.key &&
            ref.watch(apiClientProvider) != null)
          VButton(
            label: l10n.signatureSend,
            icon: LucideIcons.signature,
            onPressed: () => unawaited(sendForSignature(context, ref, doc)),
          ),
        VButton.primary(
          label: l10n.billingToInvoice,
          icon: LucideIcons.receipt,
          onPressed: () async {
            final invoiceId = await invoiceFromQuote(ref, doc);
            close();
            if (context.mounted) {
              await showDocumentDetail(context, invoiceId);
            }
          },
        ),
      ],
      if (issued && kind == DocumentKind.invoice && canWrite) ...[
        VButton(
          label: l10n.billingCreditNote,
          icon: LucideIcons.undo2,
          onPressed: () async {
            final creditId = await creditNoteFor(ref, doc);
            close();
            if (context.mounted) {
              await showDocumentDetail(context, creditId);
            }
          },
        ),
        if (paid < totals.ttcCents)
          VButton.primary(
            label: l10n.paymentAdd,
            icon: LucideIcons.banknote,
            onPressed: () => unawaited(recordPayment(context, ref, doc)),
          ),
      ],
      if (issued &&
          kind != DocumentKind.quote &&
          canIssue &&
          doc.chorusFlux == null)
        VButton(
          label: l10n.chorusDeposit,
          icon: LucideIcons.landmark,
          onPressed: () => unawaited(depositToChorus(context, ref, doc)),
        ),
    ];

    return VModal(
      title: issued
          ? '${kind.label} ${doc.number}'
          : l10n.billingDraftOf(kind.label),
      description: doc.subject,
      icon: LucideIcons.receipt,
      width: 820,
      actions: [VButton(label: l10n.close, onPressed: close)],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Wrap(
            spacing: VSpace.x2,
            runSpacing: VSpace.x2,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              VBadge(
                status?.label ?? doc.status,
                tone: documentTone(doc.status),
              ),
              if (doc.chorusFlux != null)
                VBadge(l10n.chorusFlux(doc.chorusFlux!), tone: VTone.accent),
              ...actions,
            ],
          ),
          const SizedBox(height: VSpace.x4),
          VInfoRow(l10n.billingCustomer, organisation?.name),
          if (contact != null)
            VInfoRow(l10n.billingContact, contactName(contact)),
          if (doc.issueDate != null)
            VInfoRow(l10n.billingIssueDate, formatDay(doc.issueDate)),
          if (doc.serviceDate != null)
            VInfoRow(l10n.billingServiceDate, formatDay(doc.serviceDate)),
          if (doc.dueDate != null)
            VInfoRow(l10n.billingDueDate, formatDay(doc.dueDate)),
          if (doc.validUntil != null)
            VInfoRow(l10n.billingValidUntil, formatDay(doc.validUntil)),
          if (original != null)
            VInfoRow(l10n.billingOriginalInvoice, original.number),
          if (doc.buyerReference != null)
            VInfoRow(l10n.billingBuyerReference, doc.buyerReference!),
          const SizedBox(height: VSpace.x4),
          Text(l10n.billingLines, style: t.heading),
          const SizedBox(height: VSpace.x2),
          for (final line in lines)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: VSpace.x1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(line.description, style: t.body)),
                  SizedBox(
                    width: 200,
                    child: Text(
                      '${line.quantity} × ${formatAmount(line.unitPriceCents)}'
                      ' · ${vatRates[line.vatRate]}',
                      style: t.small,
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    child: Text(
                      formatAmount(line.totalCents),
                      textAlign: TextAlign.right,
                      style: t.numeric,
                    ),
                  ),
                ],
              ),
            ),
          Divider(height: VSpace.x4, color: context.colors.border),
          Align(
            alignment: Alignment.centerRight,
            child: DocumentTotalsView(totals: totals),
          ),
          if (kind == DocumentKind.quote &&
              issued &&
              ref.watch(apiClientProvider) != null)
            _Signatures(invoiceId: doc.id),
          if (kind == DocumentKind.invoice && issued) ...[
            const SizedBox(height: VSpace.x4),
            Text(l10n.payments, style: t.heading),
            const SizedBox(height: VSpace.x2),
            if (payments.isEmpty) Text(l10n.paymentsEmpty, style: t.small),
            for (final p in payments)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: VSpace.x1),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        [
                          formatDay(p.paidOn),
                          enumByKey(PaymentMethod.values, p.method)?.label,
                          p.reference,
                        ].whereType<String>().join(' · '),
                        style: t.body,
                      ),
                    ),
                    Text(formatAmount(p.amountCents), style: t.numeric),
                    if (canWrite)
                      VIconButton(
                        icon: LucideIcons.trash2,
                        tooltip: l10n.delete,
                        size: VButtonSize.sm,
                        onPressed: () => unawaited(
                          ref.read(recordStoreProvider).delete(
                            SyncEntities.payments,
                            [p.id],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            Text(
              l10n.paymentsBalance(
                formatAmount(paid),
                formatAmount(totals.ttcCents - paid),
              ),
              style: t.small,
            ),
          ],
          if (doc.notes != null) ...[
            const SizedBox(height: VSpace.x4),
            Text(doc.notes!, style: t.small),
          ],
        ],
      ),
    );
  }
}

/// Demandes de signature électronique d'un devis.
class _Signatures extends ConsumerWidget {
  const _Signatures({required this.invoiceId});

  final String invoiceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final t = context.text;
    final list = ref.watch(signaturesProvider(invoiceId)).value ?? const [];
    if (list.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: VSpace.x4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.signatureTitle, style: t.heading),
          const SizedBox(height: VSpace.x2),
          for (final s in list)
            Row(
              children: [
                VBadge(
                  switch (s.status) {
                    'done' => l10n.signatureDone,
                    'ongoing' => l10n.signatureOngoing,
                    'declined' => l10n.signatureDeclined,
                    _ => l10n.signatureEnded,
                  },
                  tone: switch (s.status) {
                    'done' => VTone.success,
                    'ongoing' => VTone.info,
                    'declined' => VTone.danger,
                    _ => VTone.neutral,
                  },
                ),
                const SizedBox(width: VSpace.x2),
                Expanded(
                  child: Text(
                    [
                      '${s.signerName} <${s.signerEmail}>',
                      formatDateTime(s.updatedAt.toLocal()),
                      ?s.error,
                    ].join(' · '),
                    style: t.small,
                  ),
                ),
                if (s.status == 'ongoing')
                  VIconButton(
                    icon: LucideIcons.refreshCw,
                    tooltip: l10n.refresh,
                    size: VButtonSize.sm,
                    onPressed: () async {
                      try {
                        await ref
                            .read(billingApiProvider)!
                            .refreshSignature(s.id);
                        ref.invalidate(signaturesProvider(invoiceId));
                        await ref.read(syncEngineProvider)?.syncNow();
                      } on ApiFailure catch (e) {
                        ref.read(toastProvider).error(e.message);
                      }
                    },
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
