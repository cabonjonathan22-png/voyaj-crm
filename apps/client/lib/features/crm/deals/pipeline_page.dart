import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../data/local/database.dart';
import '../../../data/records/record_store.dart';
import '../../../design_system/design_system.dart';
import '../crm_data.dart';
import '../crm_format.dart';
import 'deal_form.dart';
import 'default_pipelines.dart';
import 'pipeline_settings.dart';

/// Déplace une affaire vers [stage] (fin de colonne), en mettant à jour
/// son statut.
Future<void> moveDeal(
  WidgetRef ref,
  DealRow deal,
  StageRow stage, {
  required double sortOrder,
}) {
  final wasOpen = deal.status == StageOutcome.open.key;
  return ref.read(recordStoreProvider).update(SyncEntities.deals, deal.id, {
    'stage_id': stage.id,
    'pipeline_id': stage.pipelineId,
    'status': stage.outcome,
    'sort_order': sortOrder,
    if (stage.outcome != StageOutcome.open.key && wasOpen)
      'closed_at': DateTime.now().toUtc().toIso8601String(),
    if (stage.outcome == StageOutcome.open.key) 'closed_at': null,
    if (stage.probability != null) 'probability': stage.probability,
  });
}

/// Pipelines commerciaux en Kanban.
class PipelinePage extends ConsumerStatefulWidget {
  const PipelinePage({super.key, this.pipelineId});

  final String? pipelineId;

  @override
  ConsumerState<PipelinePage> createState() => _PipelinePageState();
}

class _PipelinePageState extends ConsumerState<PipelinePage> {
  String? _pipelineId;
  final _search = TextEditingController();
  bool _creatingDefaults = false;

  @override
  void initState() {
    super.initState();
    _pipelineId = widget.pipelineId;
    if (_pipelineId == null) unawaited(_restore());
  }

  Future<void> _restore() async {
    final saved = await ref
        .read(appDatabaseProvider)
        .readSetting<String>(SettingKeys.lastPipeline);
    if (saved != null && mounted && _pipelineId == null) {
      setState(() => _pipelineId = saved);
    }
  }

  void _select(String id) {
    setState(() => _pipelineId = id);
    unawaited(
      ref.read(appDatabaseProvider).writeSetting(SettingKeys.lastPipeline, id),
    );
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _createDefaults() async {
    setState(() => _creatingDefaults = true);
    try {
      final id = await createDefaultPipelines(ref.read(recordStoreProvider));
      if (mounted) _select(id);
    } finally {
      if (mounted) setState(() => _creatingDefaults = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canManage = ref.watch(permissionProvider(Permission.pipelineManage));
    final canWrite = ref.watch(permissionProvider(Permission.dealWrite));
    final pipelinesAsync = ref.watch(pipelinesProvider);
    final pipelines = [
      for (final p in pipelinesAsync.value ?? const <PipelineRow>[])
        if (p.archived != true) p,
    ];
    final pipeline =
        pipelines.where((p) => p.id == _pipelineId).firstOrNull ??
        pipelines.firstOrNull;

    final header = PageHeader(
      title: l10n.navPipelines,
      subtitle: l10n.pipelinesSubtitle,
      icon: LucideIcons.kanban,
      actions: [
        if (pipeline != null && canManage)
          VButton(
            label: l10n.pipelineConfigure,
            icon: LucideIcons.settings2,
            onPressed: () => unawaited(
              showPipelineSettings(context, pipelineId: pipeline.id),
            ),
          ),
        if (canManage)
          VIconButton(
            icon: LucideIcons.plus,
            tooltip: l10n.pipelineNew,
            onPressed: () => unawaited(
              showPipelineSettings(context).then((id) {
                if (id != null && mounted) _select(id);
              }),
            ),
          ),
        if (pipeline != null && canWrite)
          VButton.primary(
            label: l10n.dealNew,
            icon: LucideIcons.plus,
            shortcut: 'Ctrl N',
            onPressed: () =>
                unawaited(showDealForm(context, ref, pipelineId: pipeline.id)),
          ),
      ],
    );

    if (pipeline == null) {
      return Column(
        children: [
          header,
          Expanded(
            child: pipelinesAsync.isLoading
                ? const SkeletonRows()
                : EmptyState(
                    icon: LucideIcons.kanban,
                    title: l10n.pipelinesEmptyTitle,
                    message: canManage
                        ? l10n.pipelinesEmptyMessage
                        : l10n.pipelinesEmptyReadOnly,
                    action: canManage
                        ? VButton.primary(
                            label: l10n.pipelineCreateDefaults,
                            icon: LucideIcons.wandSparkles,
                            loading: _creatingDefaults,
                            onPressed: () => unawaited(_createDefaults()),
                          )
                        : null,
                  ),
          ),
        ],
      );
    }

    final stages = [
      for (final s in ref.watch(stagesProvider).value ?? const <StageRow>[])
        if (s.pipelineId == pipeline.id) s,
    ];
    final organisations = ref.watch(organisationByIdProvider);
    final query = searchText(_search.text);
    final deals = [
      for (final d in ref.watch(dealsProvider).value ?? const <DealRow>[])
        if (d.pipelineId == pipeline.id &&
            (query.isEmpty ||
                searchText(
                  '${d.title} ${organisations[d.organisationId]?.name ?? ''}',
                ).contains(query)))
          d,
    ];
    final openTotal = deals
        .where((d) => d.status == StageOutcome.open.key)
        .fold<int>(0, (s, d) => s + (d.amountCents ?? 0));
    final stageProbability = {for (final s in stages) s.id: s.probability};
    final weighted = deals
        .where((d) => d.status == StageOutcome.open.key)
        .fold<double>(
          0,
          (sum, d) =>
              sum +
              (d.amountCents ?? 0) *
                  (d.probability ?? stageProbability[d.stageId] ?? 0) /
                  100,
        );

    return CallbackShortcuts(
      bindings: {
        if (canWrite)
          const SingleActivator(LogicalKeyboardKey.keyN, control: true): () =>
              unawaited(showDealForm(context, ref, pipelineId: pipeline.id)),
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          Padding(
            padding: const EdgeInsets.fromLTRB(
              VSpace.x6,
              VSpace.x3,
              VSpace.x6,
              VSpace.x3,
            ),
            child: Row(
              children: [
                if (pipelines.length > 1) ...[
                  VSegmented<String>(
                    value: pipeline.id,
                    options: [
                      for (final p in pipelines) VSelectOption(p.id, p.name),
                    ],
                    onChanged: _select,
                  ),
                  const SizedBox(width: VSpace.x3),
                ],
                SizedBox(
                  width: 260,
                  child: VTextField(
                    controller: _search,
                    dense: true,
                    prefixIcon: LucideIcons.search,
                    hint: l10n.dealSearch,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const Spacer(),
                Text(
                  l10n.pipelineTotals(
                    formatAmount(openTotal),
                    formatAmount(weighted.round()),
                  ),
                  style: context.text.small,
                ),
              ],
            ),
          ),
          Expanded(
            child: stages.isEmpty
                ? EmptyState(
                    icon: LucideIcons.columns3,
                    title: l10n.stagesEmpty,
                  )
                : ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(
                      VSpace.x6,
                      0,
                      VSpace.x6,
                      VSpace.x4,
                    ),
                    children: [
                      for (final stage in stages)
                        _StageColumn(
                          stage: stage,
                          deals: [
                            for (final d in deals)
                              if (d.stageId == stage.id) d,
                          ],
                          canWrite: canWrite,
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _StageColumn extends ConsumerWidget {
  const _StageColumn({
    required this.stage,
    required this.deals,
    required this.canWrite,
  });

  final StageRow stage;
  final List<DealRow> deals;
  final bool canWrite;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final t = context.text;
    final l10n = context.l10n;
    final total = deals.fold<int>(0, (s, d) => s + (d.amountCents ?? 0));
    final lastOrder = deals.isEmpty ? 0.0 : (deals.last.sortOrder ?? 0);

    return DragTarget<DealRow>(
      onWillAcceptWithDetails: (details) =>
          canWrite && details.data.stageId != stage.id,
      onAcceptWithDetails: (details) => unawaited(
        moveDeal(ref, details.data, stage, sortOrder: lastOrder + 1).catchError(
          (Object e) {
            ref.read(toastProvider).error(e.toString());
          },
          test: (e) => e is RecordValidationException,
        ),
      ),
      builder: (context, candidates, _) => AnimatedContainer(
        duration: VMotion.fast,
        width: 280,
        margin: const EdgeInsets.only(right: VSpace.x3),
        decoration: BoxDecoration(
          color: candidates.isNotEmpty ? c.accentSubtle : c.backgroundSubtle,
          borderRadius: VRadius.lgAll,
          border: Border.all(
            color: candidates.isNotEmpty ? c.accent : c.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                VSpace.x3,
                VSpace.x3,
                VSpace.x1,
                VSpace.x2,
              ),
              child: Row(
                children: [
                  ColorDot(parseHexColor(stage.color ?? '#64748B')),
                  const SizedBox(width: VSpace.x2),
                  Expanded(
                    child: Text(
                      stage.name,
                      overflow: TextOverflow.ellipsis,
                      style: t.heading,
                    ),
                  ),
                  VBadge('${deals.length}'),
                  if (canWrite)
                    VIconButton(
                      icon: LucideIcons.plus,
                      tooltip: l10n.dealNew,
                      size: VButtonSize.sm,
                      onPressed: () => unawaited(
                        showDealForm(context, ref, stageId: stage.id),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                VSpace.x3,
                0,
                VSpace.x3,
                VSpace.x2,
              ),
              child: Text(
                [
                  formatAmount(total),
                  if (stage.probability != null) '${stage.probability} %',
                ].join(' · '),
                style: t.small,
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  VSpace.x2,
                  0,
                  VSpace.x2,
                  VSpace.x2,
                ),
                children: [
                  for (final deal in deals)
                    canWrite
                        ? Draggable<DealRow>(
                            data: deal,
                            feedback: SizedBox(
                              width: 264,
                              child: _DealCard(deal: deal, dragging: true),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.35,
                              child: _DealCard(deal: deal),
                            ),
                            child: _DealCard(deal: deal),
                          )
                        : _DealCard(deal: deal),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DealCard extends ConsumerWidget {
  const _DealCard({required this.deal, this.dragging = false});

  final DealRow deal;
  final bool dragging;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final t = context.text;
    final l10n = context.l10n;
    final organisation = ref.watch(
      organisationByIdProvider,
    )[deal.organisationId];
    final contact = ref.watch(contactByIdProvider)[deal.contactId];
    final canWrite = ref.watch(permissionProvider(Permission.dealWrite));
    final late =
        deal.status == StageOutcome.open.key &&
        deal.expectedCloseDate != null &&
        deal.expectedCloseDate!.compareTo(formatDateOnly(DateTime.now())) < 0;

    return Material(
      type: MaterialType.transparency,
      child: Pressable(
        onPressed: canWrite
            ? () => unawaited(showDealForm(context, ref, deal: deal))
            : null,
        semanticLabel: deal.title,
        builder: (context, s) => AnimatedContainer(
          duration: VMotion.fast,
          margin: const EdgeInsets.only(bottom: VSpace.x2),
          padding: const EdgeInsets.all(VSpace.x3),
          decoration: BoxDecoration(
            color: s.hovered ? c.surfaceHover : c.surface,
            borderRadius: VRadius.mdAll,
            border: Border.all(color: c.border),
            boxShadow: dragging
                ? VShadows.lg(dark: c.isDark)
                : VShadows.sm(dark: c.isDark),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(deal.title, style: t.bodyStrong),
              if (organisation != null) ...[
                const SizedBox(height: VSpace.x1),
                Row(
                  children: [
                    Icon(
                      kindIcon(
                        enumByKey(OrganisationKind.values, organisation.kind),
                      ),
                      size: 12,
                      color: c.textSubtle,
                    ),
                    const SizedBox(width: VSpace.x1),
                    Expanded(
                      child: Text(
                        organisation.name,
                        overflow: TextOverflow.ellipsis,
                        style: t.small,
                      ),
                    ),
                  ],
                ),
              ],
              if (contact != null) Text(contactName(contact), style: t.small),
              const SizedBox(height: VSpace.x2),
              Row(
                children: [
                  Text(formatAmount(deal.amountCents), style: t.numeric),
                  const Spacer(),
                  if (deal.expectedCloseDate != null)
                    Text(
                      formatDay(deal.expectedCloseDate),
                      style: t.small.copyWith(color: late ? c.danger : null),
                    ),
                ],
              ),
              if (late)
                Padding(
                  padding: const EdgeInsets.only(top: VSpace.x1),
                  child: VBadge(l10n.dealLate, tone: VTone.danger),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
