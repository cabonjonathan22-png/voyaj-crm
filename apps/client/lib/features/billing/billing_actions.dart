import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../data/local/database.dart';
import '../../design_system/design_system.dart';
import '../crm/crm_data.dart';
import '../crm/crm_format.dart';
import '../crm/widgets/record_form.dart';
import 'billing_data.dart';

/// Ton d'un état de document.
VTone documentTone(String status) =>
    switch (enumByKey(DocumentStatus.values, status)) {
      DocumentStatus.draft => VTone.neutral,
      DocumentStatus.sent || DocumentStatus.issued => VTone.info,
      DocumentStatus.accepted || DocumentStatus.paid => VTone.success,
      DocumentStatus.refused || DocumentStatus.cancelled => VTone.danger,
      null => VTone.neutral,
    };

/// Date du jour (`AAAA-MM-JJ`).
String todayIso() => DateTime.now().toIso8601String().substring(0, 10);

/// Enregistre le fichier produit par [load] à l'emplacement choisi, puis
/// l'ouvre.
Future<void> saveDownload(
  BuildContext context,
  WidgetRef ref, {
  required String fileName,
  required Future<List<int>> Function() load,
}) async {
  final toasts = ref.read(toastProvider);
  final l10n = context.l10n;
  final location = await getSaveLocation(suggestedName: fileName);
  if (location == null) return;
  try {
    await File(location.path).writeAsBytes(await load());
    toasts.success(l10n.billingFileSaved(fileName));
    await launchUrl(Uri.file(location.path));
  } on ApiFailure catch (e) {
    toasts.error(e.message);
  }
}

/// Émet un brouillon : envoie d'abord les saisies locales, puis demande
/// au serveur le numéro définitif et le PDF.
Future<void> issueDocument(
  BuildContext context,
  WidgetRef ref,
  InvoiceRow document,
) async {
  final l10n = context.l10n;
  final toasts = ref.read(toastProvider);
  final api = ref.read(billingApiProvider);
  if (api == null) return;
  final kind = documentKind(document);
  final ok = await confirm(
    context,
    title: l10n.billingIssueTitle(kind.label.toLowerCase()),
    message: l10n.billingIssueMessage,
    confirmLabel: l10n.billingIssue,
  );
  if (!ok) return;
  final engine = ref.read(syncEngineProvider);
  await engine?.syncNow();
  final db = ref.read(appDatabaseProvider);
  final pending = await db.pendingOperations();
  if (pending.any((op) => op.entityId == document.id)) {
    toasts.error(l10n.billingIssueOffline);
    return;
  }
  try {
    final number = await api.issue(document.id);
    toasts.success(l10n.billingIssued(number));
    await engine?.syncNow();
  } on ApiFailure catch (e) {
    toasts.error(
      e.message,
      description: e.issues.map((i) => i.message).join(' '),
    );
  }
}

/// Télécharge le PDF d'un document émis.
Future<void> downloadDocumentPdf(
  BuildContext context,
  WidgetRef ref,
  InvoiceRow document,
) {
  final api = ref.read(billingApiProvider);
  if (api == null) return Future.value();
  return saveDownload(
    context,
    ref,
    fileName: '${document.number}.pdf',
    load: () => api.pdf(document.id),
  );
}

/// Dépose une facture ou un avoir émis sur Chorus Pro.
Future<void> depositToChorus(
  BuildContext context,
  WidgetRef ref,
  InvoiceRow document,
) async {
  final l10n = context.l10n;
  final toasts = ref.read(toastProvider);
  final api = ref.read(billingApiProvider);
  if (api == null) return;
  final ok = await confirm(
    context,
    title: l10n.chorusDepositTitle(document.number ?? ''),
    message: l10n.chorusDepositMessage,
    confirmLabel: l10n.chorusDeposit,
  );
  if (!ok) return;
  try {
    final flux = await api.depositToChorus(document.id);
    toasts.success(l10n.chorusDeposited(flux));
    await ref.read(syncEngineProvider)?.syncNow();
  } on ApiFailure catch (e) {
    toasts.error(
      e.message,
      description: e.issues.map((i) => i.message).join(' '),
    );
  }
}

/// Champs d'un nouveau document repris d'un autre (devis → facture,
/// facture → avoir).
Map<String, Object?> _copyOf(InvoiceRow source, DocumentKind kind) => {
  'kind': kind.key,
  'status': DocumentStatus.draft.key,
  'subject': source.subject,
  'organisation_id': source.organisationId,
  'contact_id': source.contactId,
  'deal_id': source.dealId,
  'buyer_reference': source.buyerReference,
  'service_code': source.serviceCode,
  'lines': [for (final line in documentLines(source)) line.toJson()],
};

/// Crée la facture (brouillon) d'un devis et marque le devis accepté.
Future<String> invoiceFromQuote(WidgetRef ref, InvoiceRow quote) async {
  final store = ref.read(recordStoreProvider);
  final id = await store.create(SyncEntities.invoices, {
    ..._copyOf(quote, DocumentKind.invoice),
    'quote_id': quote.id,
  });
  if (quote.status == DocumentStatus.sent.key) {
    await store.update(SyncEntities.invoices, quote.id, {
      'status': DocumentStatus.accepted.key,
    });
  }
  return id;
}

/// Crée l'avoir (brouillon) d'une facture émise, reprenant ses lignes.
Future<String> creditNoteFor(WidgetRef ref, InvoiceRow invoice) =>
    ref.read(recordStoreProvider).create(SyncEntities.invoices, {
      ..._copyOf(invoice, DocumentKind.creditNote),
      'original_invoice_id': invoice.id,
      'subject': invoice.number == null
          ? invoice.subject
          : 'Avoir sur ${invoice.number}',
    });

/// Enregistre un paiement ; la facture passe « payée » une fois soldée.
Future<void> recordPayment(
  BuildContext context,
  WidgetRef ref,
  InvoiceRow invoice,
) async {
  final l10n = context.l10n;
  final total = invoice.totalTtcCents ?? documentTotals(invoice).ttcCents;
  final paid = ref.read(paidByInvoiceProvider)[invoice.id] ?? 0;
  final id = await showRecordForm(
    context,
    schema: SyncEntities.payments,
    title: l10n.paymentNew(invoice.number ?? ''),
    icon: LucideIcons.banknote,
    width: 520,
    initial: {
      'invoice_id': invoice.id,
      'amount_cents': total - paid > 0 ? total - paid : null,
      'paid_on': todayIso(),
      'method': PaymentMethod.transfer.key,
    },
    fields: [
      NumberFieldDef('amount_cents', l10n.paymentAmount, cents: true),
      DateFieldDef('paid_on', l10n.paymentDate),
      ChoiceFieldDef(
        'method',
        l10n.paymentMethod,
        enumOptions(PaymentMethod.values),
      ),
      TextFieldDef('reference', l10n.paymentReference),
      TextFieldDef('notes', l10n.billingNotes, wide: true, maxLines: 2),
    ],
  );
  if (id == null) return;
  final store = ref.read(recordStoreProvider);
  final amount =
      (await store.read(SyncEntities.payments, id))?['amount_cents'] as int? ??
      0;
  if (paid + amount >= total && invoice.status == DocumentStatus.issued.key) {
    await store.update(SyncEntities.invoices, invoice.id, {
      'status': DocumentStatus.paid.key,
    });
  }
  ref.read(toastProvider).success(l10n.paymentRecorded);
}

/// Envoie le devis émis pour signature électronique à un contact de
/// l'organisation (avec email).
Future<void> sendForSignature(
  BuildContext context,
  WidgetRef ref,
  InvoiceRow quote,
) async {
  final l10n = context.l10n;
  final api = ref.read(billingApiProvider);
  if (api == null) return;
  final contacts = [
    for (final c in ref.read(contactsProvider).value ?? const <ContactRow>[])
      if (c.email != null &&
          c.doNotContact != true &&
          (quote.organisationId == null ||
              c.organisationId == quote.organisationId))
        c,
  ];
  if (contacts.isEmpty) {
    ref.read(toastProvider).error(l10n.signatureNoContact);
    return;
  }
  final option = await showSearchPicker<String>(
    context,
    title: l10n.signatureChooseSigner,
    options: [
      for (final c in contacts)
        VSelectOption(c.id, '${contactName(c)} — ${c.email}'),
    ],
  );
  if (option == null) return;
  try {
    await api.sendForSignature(quote.id, option.value);
    ref.read(toastProvider).success(l10n.signatureSent);
    ref.invalidate(signaturesProvider(quote.id));
  } on ApiFailure catch (e) {
    ref
        .read(toastProvider)
        .error(
          e.message,
          description: e.issues.map((i) => i.message).join(' '),
        );
  }
}
