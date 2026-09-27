import 'package:voyaj_shared/voyaj_shared.dart';

import '../../data/local/database.dart';
import '../billing/billing_data.dart';

/// Chiffre d'affaires HT d'un mois.
typedef MonthRevenue = ({DateTime month, int htCents});

/// Indicateurs du tableau de bord, calculés sur les données locales.
final class DashboardStats {
  const DashboardStats({
    required this.openPipelineCents,
    required this.weightedPipelineCents,
    required this.openDeals,
    required this.wonThisYearCents,
    required this.revenueThisYearCents,
    required this.outstandingCents,
    required this.overdueInvoices,
    required this.overdueCents,
    required this.monthlyRevenue,
    required this.pipelineByStage,
    required this.overdueTasks,
    required this.todayTasks,
    required this.activitiesByKind,
    required this.organisationsByStatus,
  });

  final int openPipelineCents;
  final int weightedPipelineCents;
  final int openDeals;
  final int wonThisYearCents;

  /// Factures moins avoirs émis cette année (HT).
  final int revenueThisYearCents;

  /// Reste dû des factures émises (TTC).
  final int outstandingCents;
  final int overdueInvoices;
  final int overdueCents;

  /// 12 derniers mois, du plus ancien au plus récent.
  final List<MonthRevenue> monthlyRevenue;

  /// Montant des affaires en cours par étape (identifiant d'étape).
  final Map<String, int> pipelineByStage;

  /// Tâches de l'utilisateur en retard / du jour (non faites).
  final List<ActivityRow> overdueTasks;
  final List<ActivityRow> todayTasks;

  /// Activités des 30 derniers jours, par type.
  final Map<String, int> activitiesByKind;
  final Map<String, int> organisationsByStatus;
}

DateTime? _day(String? iso) => iso == null ? null : DateTime.tryParse(iso);

/// Calcule les indicateurs à la date [now] pour l'utilisateur [userId].
DashboardStats computeDashboard({
  required List<DealRow> deals,
  required List<InvoiceRow> invoices,
  required List<PaymentRow> payments,
  required List<ActivityRow> activities,
  required List<OrganisationRow> organisations,
  List<StageRow> stages = const [],
  required DateTime now,
  required String? userId,
}) {
  // Probabilité de l'affaire, sinon celle de son étape.
  final stageProbability = {for (final s in stages) s.id: s.probability};
  int probability(DealRow d) =>
      d.probability ?? stageProbability[d.stageId] ?? 0;
  final open = [
    for (final d in deals)
      if (d.status == StageOutcome.open.key) d,
  ];
  final pipelineByStage = <String, int>{};
  for (final d in open) {
    pipelineByStage.update(
      d.stageId,
      (v) => v + (d.amountCents ?? 0),
      ifAbsent: () => d.amountCents ?? 0,
    );
  }

  final paid = <String, int>{};
  for (final p in payments) {
    paid.update(
      p.invoiceId,
      (v) => v + p.amountCents,
      ifAbsent: () => p.amountCents,
    );
  }
  final today = DateTime(now.year, now.month, now.day);
  final firstMonth = DateTime(now.year, now.month - 11);
  final monthly = <DateTime, int>{
    for (var i = 0; i < 12; i++)
      DateTime(firstMonth.year, firstMonth.month + i): 0,
  };
  var revenue = 0;
  var outstanding = 0;
  var overdue = 0;
  var overdueCents = 0;
  for (final doc in invoices) {
    final issued = _day(doc.issueDate);
    if (doc.number == null || issued == null) continue;
    final kind = documentKind(doc);
    if (kind == DocumentKind.quote) continue;
    final sign = kind == DocumentKind.creditNote ? -1 : 1;
    final ht = sign * (doc.totalHtCents ?? documentTotals(doc).htCents);
    if (issued.year == now.year) revenue += ht;
    final month = DateTime(issued.year, issued.month);
    if (monthly.containsKey(month)) monthly[month] = monthly[month]! + ht;
    if (kind == DocumentKind.invoice) {
      final balance = (doc.totalTtcCents ?? 0) - (paid[doc.id] ?? 0);
      if (balance > 0 && doc.status != DocumentStatus.paid.key) {
        outstanding += balance;
        final due = _day(doc.dueDate);
        if (due != null && due.isBefore(today)) {
          overdue++;
          overdueCents += balance;
        }
      }
    }
  }

  final tomorrow = today.add(const Duration(days: 1));
  bool mine(ActivityRow a) =>
      userId == null || (a.assigneeId ?? a.ownerId) == userId;
  final tasks = [
    for (final a in activities)
      if (a.kind == ActivityKind.task.key &&
          a.doneAt == null &&
          a.dueAt != null &&
          mine(a))
        a,
  ]..sort((a, b) => a.dueAt!.compareTo(b.dueAt!));
  final since = now.subtract(const Duration(days: 30));
  final byKind = <String, int>{};
  for (final a in activities) {
    if (a.createdAt.isAfter(since)) {
      byKind.update(a.kind, (v) => v + 1, ifAbsent: () => 1);
    }
  }
  final byStatus = <String, int>{};
  for (final o in organisations) {
    byStatus.update(o.status, (v) => v + 1, ifAbsent: () => 1);
  }

  return DashboardStats(
    openPipelineCents: open.fold(0, (s, d) => s + (d.amountCents ?? 0)),
    weightedPipelineCents: open.fold(
      0,
      (s, d) => s + ((d.amountCents ?? 0) * probability(d) / 100).round(),
    ),
    openDeals: open.length,
    wonThisYearCents: deals
        .where(
          (d) =>
              d.status == StageOutcome.won.key &&
              (d.closedAt ?? d.updatedAt).toLocal().year == now.year,
        )
        .fold(0, (s, d) => s + (d.amountCents ?? 0)),
    revenueThisYearCents: revenue,
    outstandingCents: outstanding,
    overdueInvoices: overdue,
    overdueCents: overdueCents,
    monthlyRevenue: [
      for (final MapEntry(:key, :value) in monthly.entries)
        (month: key, htCents: value),
    ],
    pipelineByStage: pipelineByStage,
    overdueTasks: [
      for (final t in tasks)
        if (t.dueAt!.toLocal().isBefore(today)) t,
    ],
    todayTasks: [
      for (final t in tasks)
        if (!t.dueAt!.toLocal().isBefore(today) &&
            t.dueAt!.toLocal().isBefore(tomorrow))
          t,
    ],
    activitiesByKind: byKind,
    organisationsByStatus: byStatus,
  );
}
