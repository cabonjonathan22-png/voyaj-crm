import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voyaj_client/data/local/database.dart';
import 'package:voyaj_client/features/dashboard/dashboard_stats.dart';

import 'support/crm_seed.dart';

void main() {
  test('indicateurs calculés sur les données de démonstration', () async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await seedCrm(db);
    final now = DateTime(2026, 9, 27, 10);
    final stats = computeDashboard(
      deals: await db.select(db.deals).get(),
      invoices: await db.select(db.invoices).get(),
      payments: await db.select(db.payments).get(),
      activities: await db.select(db.activities).get(),
      organisations: await db.select(db.organisations).get(),
      now: now,
      userId: null,
    );

    expect(stats.openDeals, 3);
    expect(stats.openPipelineCents, 4500000 + 12000000 + 800000);
    expect(stats.pipelineByStage[sid('st-3')], 4500000);
    // Facture F2026-00001 émise (le devis et le brouillon ne comptent pas).
    expect(stats.revenueThisYearCents, 615000);
    expect(stats.outstandingCents, 684000 - 300000);
    expect(stats.overdueInvoices, 1);
    expect(stats.monthlyRevenue, hasLength(12));
    expect(stats.monthlyRevenue.last.month, DateTime(2026, 9));
    expect(
      stats.monthlyRevenue
          .firstWhere((m) => m.month == DateTime(2026, 7))
          .htCents,
      615000,
    );
    expect(stats.overdueTasks.map((t) => t.subject), [
      'Envoyer la proposition chiffrée',
    ]);
    expect(stats.todayTasks, isEmpty);
    expect(stats.activitiesByKind['task'], 2);
  });
}
