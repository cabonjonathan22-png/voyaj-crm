import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../app/router.dart';
import '../../data/local/database.dart';
import '../../design_system/design_system.dart';
import '../billing/billing_data.dart';
import '../crm/crm_data.dart';
import '../crm/crm_format.dart';
import 'dashboard_stats.dart';

final dashboardProvider = Provider<DashboardStats>(
  (ref) => computeDashboard(
    deals: ref.watch(dealsProvider).value ?? const [],
    invoices: ref.watch(invoicesProvider).value ?? const [],
    payments: ref.watch(paymentsProvider).value ?? const [],
    activities: ref.watch(activitiesProvider).value ?? const [],
    organisations: ref.watch(organisationsProvider).value ?? const [],
    stages: ref.watch(stagesProvider).value ?? const [],
    now: DateTime.now(),
    userId: ref.watch(currentUserProvider.select((u) => u?.id)),
  ),
);

/// Tableau de bord : pipeline, chiffre d'affaires, impayés, tâches et
/// activité récente (données locales, disponibles hors ligne).
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final stats = ref.watch(dashboardProvider);
    bool can(Permission p) => ref.watch(permissionProvider(p));
    final user = ref.watch(currentUserProvider);

    final kpis = [
      if (can(Permission.dealRead)) ...[
        _Kpi(
          label: l10n.dashOpenPipeline,
          value: formatAmount(stats.openPipelineCents),
          detail: l10n.dashOpenDeals(stats.openDeals),
          icon: LucideIcons.kanban,
          onTap: () => context.go(Routes.pipelines),
        ),
        _Kpi(
          label: l10n.dashWeighted,
          value: formatAmount(stats.weightedPipelineCents),
          detail: l10n.dashWeightedHelp,
          icon: LucideIcons.scale,
        ),
        _Kpi(
          label: l10n.dashWon,
          value: formatAmount(stats.wonThisYearCents),
          detail: '${DateTime.now().year}',
          icon: LucideIcons.trophy,
          tone: VTone.success,
        ),
      ],
      if (can(Permission.invoiceRead)) ...[
        _Kpi(
          label: l10n.dashRevenue,
          value: formatAmount(stats.revenueThisYearCents),
          detail: l10n.dashRevenueHelp,
          icon: LucideIcons.receipt,
          onTap: () => context.go(Routes.billing),
        ),
        _Kpi(
          label: l10n.dashOutstanding,
          value: formatAmount(stats.outstandingCents),
          detail: stats.overdueInvoices == 0
              ? l10n.dashNoOverdue
              : l10n.dashOverdue(
                  stats.overdueInvoices,
                  formatAmount(stats.overdueCents),
                ),
          icon: LucideIcons.hourglass,
          tone: stats.overdueInvoices == 0 ? VTone.neutral : VTone.danger,
          onTap: () => context.go(Routes.billing),
        ),
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageHeader(
          title: l10n.navDashboard,
          subtitle: user == null ? null : l10n.dashHello(user.displayName),
          icon: LucideIcons.layoutDashboard,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(VSpace.x6),
            children: [
              Wrap(
                spacing: VSpace.x4,
                runSpacing: VSpace.x4,
                children: [
                  for (final kpi in kpis) SizedBox(width: 216, child: kpi),
                ],
              ),
              const SizedBox(height: VSpace.x6),
              LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth > 1000;
                  final left = [
                    if (can(Permission.activityRead)) _TasksCard(stats: stats),
                    if (can(Permission.invoiceRead))
                      _RevenueChart(months: stats.monthlyRevenue),
                  ];
                  final right = [
                    if (can(Permission.dealRead))
                      _PipelineCard(byStage: stats.pipelineByStage),
                    if (can(Permission.organisationRead))
                      _Breakdown(
                        title: l10n.dashOrganisations,
                        values: {
                          for (final s in OrganisationStatus.values)
                            s.label: ?stats.organisationsByStatus[s.key],
                        },
                      ),
                    if (can(Permission.activityRead))
                      _Breakdown(
                        title: l10n.dashActivity,
                        values: {
                          for (final k in ActivityKind.values)
                            k.label: ?stats.activitiesByKind[k.key],
                        },
                      ),
                  ];
                  Widget column(List<Widget> cards) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final card in cards)
                        Padding(
                          padding: const EdgeInsets.only(bottom: VSpace.x4),
                          child: card,
                        ),
                    ],
                  );
                  if (!wide) return column([...left, ...right]);
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: column(left)),
                      const SizedBox(width: VSpace.x4),
                      Expanded(flex: 2, child: column(right)),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Kpi extends StatelessWidget {
  const _Kpi({
    required this.label,
    required this.value,
    required this.icon,
    this.detail,
    this.tone = VTone.accent,
    this.onTap,
  });

  final String label;
  final String value;
  final String? detail;
  final IconData icon;
  final VTone tone;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final t = context.text;
    return Pressable(
      onPressed: onTap,
      semanticLabel: label,
      builder: (context, s) => AnimatedContainer(
        duration: VMotion.fast,
        padding: const EdgeInsets.all(VSpace.x4),
        decoration: BoxDecoration(
          color: s.hovered && onTap != null ? c.surfaceHover : c.surface,
          borderRadius: VRadius.mdAll,
          border: Border.all(color: c.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 14, color: c.toneColor(tone)),
                const SizedBox(width: VSpace.x2),
                Expanded(child: Text(label, style: t.label)),
              ],
            ),
            const SizedBox(height: VSpace.x2),
            Text(value, style: t.title),
            if (detail != null) ...[
              const SizedBox(height: VSpace.x1),
              Text(
                detail!,
                style: t.small,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TasksCard extends ConsumerWidget {
  const _TasksCard({required this.stats});

  final DashboardStats stats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final t = context.text;
    final c = context.colors;
    final organisations = ref.watch(organisationByIdProvider);
    Widget line(ActivityRow task, {required bool late}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: VSpace.x1),
      child: Row(
        children: [
          Icon(
            late ? LucideIcons.circleAlert : LucideIcons.circle,
            size: 14,
            color: late ? c.danger : c.textMuted,
          ),
          const SizedBox(width: VSpace.x2),
          Expanded(
            child: Text(
              [
                task.subject,
                organisations[task.organisationId]?.name,
              ].whereType<String>().join(' — '),
              style: t.body,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            formatShortDate(task.dueAt!.toLocal()),
            style: t.small.copyWith(color: late ? c.danger : null),
          ),
        ],
      ),
    );
    final empty = stats.overdueTasks.isEmpty && stats.todayTasks.isEmpty;
    return VCard(
      title: l10n.dashTasks,
      description: l10n.dashTasksHelp(
        stats.overdueTasks.length,
        stats.todayTasks.length,
      ),
      actions: [
        VButton.ghost(
          label: l10n.navTasks,
          size: VButtonSize.sm,
          onPressed: () => context.go(Routes.tasks),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (empty) Text(l10n.dashTasksNone, style: t.small),
          for (final task in stats.overdueTasks.take(8)) line(task, late: true),
          for (final task in stats.todayTasks.take(8)) line(task, late: false),
        ],
      ),
    );
  }
}

class _RevenueChart extends StatelessWidget {
  const _RevenueChart({required this.months});

  final List<MonthRevenue> months;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    final c = context.colors;
    final max = months.fold<int>(1, (m, e) => e.htCents > m ? e.htCents : m);
    final label = DateFormat('MMM', 'fr');
    return VCard(
      title: l10n.dashRevenueChart,
      description: l10n.dashRevenueChartHelp,
      child: SizedBox(
        height: 180,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final m in months)
              Expanded(
                child: Tooltip(
                  message:
                      '${label.format(m.month)} : ${formatAmount(m.htCents)}',
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: m.htCents <= 0 ? 2 : 140 * m.htCents / max,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: m.htCents <= 0 ? c.border : c.accent,
                          borderRadius: VRadius.smAll,
                        ),
                      ),
                      const SizedBox(height: VSpace.x1),
                      Text(label.format(m.month), style: t.caption),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PipelineCard extends ConsumerWidget {
  const _PipelineCard({required this.byStage});

  final Map<String, int> byStage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final stages = ref.watch(stagesProvider).value ?? const <StageRow>[];
    return _Breakdown(
      title: l10n.dashPipelineByStage,
      money: true,
      values: {for (final s in stages) s.name: ?byStage[s.id]},
    );
  }
}

/// Répartition en barres horizontales.
class _Breakdown extends StatelessWidget {
  const _Breakdown({
    required this.title,
    required this.values,
    this.money = false,
  });

  final String title;
  final Map<String, int> values;
  final bool money;

  @override
  Widget build(BuildContext context) {
    final t = context.text;
    final c = context.colors;
    final max = values.values.fold<int>(1, (m, v) => v > m ? v : m);
    return VCard(
      title: title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (values.isEmpty) Text(context.l10n.dashNoData, style: t.small),
          for (final MapEntry(:key, :value) in values.entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: VSpace.x1),
              child: Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      key,
                      style: t.small,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: value <= 0 ? 0.01 : value / max,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: c.accent,
                          borderRadius: VRadius.smAll,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 110,
                    child: Text(
                      money ? formatAmount(value) : '$value',
                      textAlign: TextAlign.right,
                      style: t.numeric,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
