import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:invoicing/invoicing.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../data/local/database.dart';

final productsProvider = StreamProvider<List<ProductRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.products)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([(t) => OrderingTerm.asc(t.name.lower())]))
      .watch();
});

final invoicesProvider = StreamProvider<List<InvoiceRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.invoices)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([
          (t) => OrderingTerm.desc(t.issueDate),
          (t) => OrderingTerm.desc(t.createdAt),
        ]))
      .watch();
});

final paymentsProvider = StreamProvider<List<PaymentRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.payments)
        ..where((t) => t.deletedAt.isNull())
        ..orderBy([(t) => OrderingTerm.desc(t.paidOn)]))
      .watch();
});

final invoiceByIdProvider = Provider<Map<String, InvoiceRow>>(
  (ref) => {
    for (final i in ref.watch(invoicesProvider).value ?? const <InvoiceRow>[])
      i.id: i,
  },
);

/// Montant encaissé par document.
final paidByInvoiceProvider = Provider<Map<String, int>>((ref) {
  final result = <String, int>{};
  for (final p in ref.watch(paymentsProvider).value ?? const <PaymentRow>[]) {
    result.update(
      p.invoiceId,
      (v) => v + p.amountCents,
      ifAbsent: () => p.amountCents,
    );
  }
  return result;
});

/// Lignes d'un document (JSON stocké).
List<DocumentLine> documentLines(InvoiceRow row) =>
    linesFromJson(jsonDecode(row.lines));

/// Totaux calculés depuis les lignes (règles identiques à l'émission).
DocumentTotals documentTotals(InvoiceRow row) =>
    computeTotals(documentLines(row));

DocumentKind documentKind(InvoiceRow row) =>
    enumByKey(DocumentKind.values, row.kind) ?? DocumentKind.invoice;

/// Accès à l'API de facturation (émission, PDF, exports, Chorus Pro).
final class BillingApi {
  const BillingApi(this._api);

  final ApiClient _api;

  Future<BillingSettings> settings() async => BillingSettings.fromJson(
    (await _api.get('/api/v1/billing/settings'))! as Map<String, dynamic>,
  );

  Future<BillingSettings> saveSettings(BillingSettings settings) async =>
      BillingSettings.fromJson(
        (await _api.put('/api/v1/billing/settings', settings.toJson()))!
            as Map<String, dynamic>,
      );

  /// Émet le brouillon ; retourne le numéro attribué.
  Future<String> issue(String id) async =>
      ((await _api.post('/api/v1/billing/documents/$id/issue'))!
              as Map<String, dynamic>)['number']
          as String;

  Future<List<int>> pdf(String id) async =>
      (await _api.send(
            'GET',
            '/api/v1/billing/documents/$id/pdf',
            rawResponse: true,
          ))!
          as List<int>;

  /// Dépôt sur Chorus Pro ; retourne le numéro de flux.
  Future<String> depositToChorus(String id) async =>
      ((await _api.post('/api/v1/billing/documents/$id/chorus'))!
              as Map<String, dynamic>)['flux']
          as String;

  Future<List<SignatureInfo>> signatures(String invoiceId) async => [
    for (final s
        in (await _api.get('/api/v1/billing/documents/$invoiceId/signatures'))!
            as List)
      SignatureInfo.fromJson(s as Map<String, dynamic>),
  ];

  Future<SignatureInfo> sendForSignature(
    String invoiceId,
    String contactId,
  ) async => SignatureInfo.fromJson(
    (await _api.post(
          '/api/v1/billing/documents/$invoiceId/signatures',
          SendSignatureRequest(contactId: contactId).toJson(),
        ))!
        as Map<String, dynamic>,
  );

  Future<SignatureInfo> refreshSignature(String id) async =>
      SignatureInfo.fromJson(
        (await _api.post('/api/v1/signatures/$id/refresh'))!
            as Map<String, dynamic>,
      );

  Future<List<int>> fec(int year) async =>
      (await _api.send(
            'GET',
            '/api/v1/billing/fec?year=$year',
            rawResponse: true,
          ))!
          as List<int>;

  Future<VatReport> vatReport(DateTime from, DateTime to) async {
    String day(DateTime d) => d.toIso8601String().substring(0, 10);
    return VatReport.fromJson(
      (await _api.get('/api/v1/billing/vat?from=${day(from)}&to=${day(to)}'))!
          as Map<String, dynamic>,
    );
  }
}

final billingApiProvider = Provider<BillingApi?>((ref) {
  final api = ref.watch(apiClientProvider);
  return api == null ? null : BillingApi(api);
});

/// Paramètres de facturation (rechargés par `ref.invalidate`).
final billingSettingsProvider = FutureProvider.autoDispose<BillingSettings>(
  (ref) => ref.watch(billingApiProvider)!.settings(),
);

/// Demandes de signature d'un devis (rechargées par `ref.invalidate`).
final signaturesProvider = FutureProvider.autoDispose
    .family<List<SignatureInfo>, String>(
      (ref, invoiceId) => ref.watch(billingApiProvider)!.signatures(invoiceId),
    );
