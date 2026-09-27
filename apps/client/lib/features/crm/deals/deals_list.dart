import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../app/router.dart';
import '../../../data/local/database.dart';
import '../../../design_system/design_system.dart';
import '../crm_data.dart';
import '../crm_format.dart';
import 'deal_form.dart';

/// Ton d'un statut d'affaire.
VTone dealTone(String status) =>
    switch (enumByKey(StageOutcome.values, status)) {
      StageOutcome.won => VTone.success,
      StageOutcome.lost => VTone.danger,
      _ => VTone.info,
    };

/// Affaires d'une fiche.
class DealsList extends ConsumerWidget {
  const DealsList({super.key, required this.deals, required this.onCreate});

  final List<DealRow> deals;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final t = context.text;
    final canWrite = ref.watch(permissionProvider(Permission.dealWrite));
    final hasPipeline =
        (ref.watch(stagesProvider).value ?? const []).isNotEmpty;
    final stages = {
      for (final s in ref.watch(stagesProvider).value ?? const <StageRow>[])
        s.id: s,
    };
    final pipelines = {
      for (final p
          in ref.watch(pipelinesProvider).value ?? const <PipelineRow>[])
        p.id: p,
    };
    final open = deals
        .where((d) => d.status == StageOutcome.open.key)
        .fold<int>(0, (sum, d) => sum + (d.amountCents ?? 0));

    return ListView(
      padding: const EdgeInsets.all(VSpace.x4),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                deals.isEmpty ? '' : l10n.dealsOpenTotal(formatAmount(open)),
                style: t.small,
              ),
            ),
            if (canWrite && hasPipeline)
              VButton.primary(
                label: l10n.dealNew,
                icon: LucideIcons.plus,
                size: VButtonSize.sm,
                onPressed: onCreate,
              ),
            if (canWrite && !hasPipeline)
              VButton(
                label: l10n.pipelineSetupFirst,
                icon: LucideIcons.kanban,
                size: VButtonSize.sm,
                onPressed: () => context.go(Routes.pipelines),
              ),
          ],
        ),
        const SizedBox(height: VSpace.x3),
        if (deals.isEmpty)
          EmptyState(icon: LucideIcons.handCoins, title: l10n.dealsEmpty),
        for (final d in deals)
          Pressable(
            onPressed: canWrite
                ? () => unawaited(showDealForm(context, ref, deal: d))
                : null,
            semanticLabel: d.title,
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
                  Icon(LucideIcons.handCoins, size: 16, color: c.textMuted),
                  const SizedBox(width: VSpace.x3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(d.title, style: t.bodyStrong),
                        Text(
                          [
                            pipelines[d.pipelineId]?.name,
                            stages[d.stageId]?.name,
                            if (d.expectedCloseDate != null)
                              l10n.dealCloseOn(formatDay(d.expectedCloseDate)),
                          ].whereType<String>().join(' · '),
                          style: t.small,
                        ),
                      ],
                    ),
                  ),
                  Text(formatAmount(d.amountCents), style: t.numeric),
                  const SizedBox(width: VSpace.x3),
                  VBadge(
                    enumByKey(StageOutcome.values, d.status)?.label ?? d.status,
                    tone: dealTone(d.status),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
