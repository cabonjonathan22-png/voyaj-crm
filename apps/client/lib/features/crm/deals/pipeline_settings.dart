import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../data/local/database.dart';
import '../../../data/records/record_store.dart';
import '../../../data/sync/local_entities.dart';
import '../../../design_system/design_system.dart';
import '../crm_data.dart';
import '../widgets/record_form.dart';
import 'default_pipelines.dart';

/// Configuration d'un pipeline et de ses étapes ([pipelineId] `null` :
/// création). Retourne l'identifiant du pipeline.
Future<String?> showPipelineSettings(
  BuildContext context, {
  String? pipelineId,
}) => showVModal<String>(
  context,
  builder: (_) => _PipelineSettings(pipelineId: pipelineId),
);

class _PipelineSettings extends ConsumerStatefulWidget {
  const _PipelineSettings({required this.pipelineId});

  final String? pipelineId;

  @override
  ConsumerState<_PipelineSettings> createState() => _PipelineSettingsState();
}

class _PipelineSettingsState extends ConsumerState<_PipelineSettings> {
  late final PipelineRow? _pipeline =
      (ref.read(pipelinesProvider).value ?? const [])
          .where((p) => p.id == widget.pipelineId)
          .firstOrNull;
  late final _name = TextEditingController(text: _pipeline?.name ?? '');
  late String _kind = _pipeline?.kind ?? PipelineKind.collectivites.key;
  late bool _archived = _pipeline?.archived ?? false;
  Map<String, String> _errors = const {};

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  RecordStore get _store => ref.read(recordStoreProvider);

  Future<void> _save() async {
    try {
      final values = {'name': _name.text, 'kind': _kind, 'archived': _archived};
      final String id;
      if (_pipeline == null) {
        id = await _store.write((w) async {
          final count = (ref.read(pipelinesProvider).value ?? const []).length;
          final id = await w.create(SyncEntities.pipelines, {
            ...values,
            'sort_order': count.toDouble(),
          });
          for (final (i, (name, outcome)) in [
            (context.l10n.stageDefaultNew, StageOutcome.open),
            (StageOutcome.won.label, StageOutcome.won),
            (StageOutcome.lost.label, StageOutcome.lost),
          ].indexed) {
            await w.create(SyncEntities.pipelineStages, {
              'pipeline_id': id,
              'name': name,
              'sort_order': i.toDouble(),
              'outcome': outcome.key,
              'probability': switch (outcome) {
                StageOutcome.won => 100,
                StageOutcome.lost => 0,
                StageOutcome.open => 10,
              },
              'color': stageColor(i, outcome),
            });
          }
          return id;
        });
      } else {
        id = _pipeline.id;
        await _store.update(SyncEntities.pipelines, id, values);
      }
      if (mounted) Navigator.of(context).pop(id);
    } on RecordValidationException catch (e) {
      setState(() => _errors = e.byField);
    }
  }

  Future<void> _editStage({
    StageRow? stage,
    required int count,
  }) => showRecordForm(
    context,
    schema: SyncEntities.pipelineStages,
    title: stage == null ? context.l10n.stageNew : context.l10n.stageEdit,
    icon: LucideIcons.columns3,
    id: stage?.id,
    width: 480,
    initial: stage == null
        ? {
            'pipeline_id': _pipeline!.id,
            'outcome': StageOutcome.open.key,
            'sort_order': count.toDouble(),
            'color': stageColor(count, StageOutcome.open),
          }
        : rowToWire(SyncEntities.pipelineStages, stage),
    fields: [
      TextFieldDef('name', context.l10n.stageName, wide: true, autofocus: true),
      NumberFieldDef('probability', context.l10n.dealProbability),
      ChoiceFieldDef(
        'outcome',
        context.l10n.stageOutcome,
        enumOptions(StageOutcome.values),
        clearable: false,
      ),
      ChoiceFieldDef('color', context.l10n.tagColor, [
        for (final color in tagPalette)
          VSelectOption(color, color, leading: ColorDot(parseHexColor(color))),
      ], wide: true),
    ],
  );

  Future<void> _swap(StageRow a, StageRow b) => _store.write((w) async {
    await w.update(SyncEntities.pipelineStages, a.id, {
      'sort_order': b.sortOrder ?? 0,
    });
    await w.update(SyncEntities.pipelineStages, b.id, {
      'sort_order': a.sortOrder ?? 0,
    });
  });

  Future<void> _deleteStage(StageRow stage) async {
    final l10n = context.l10n;
    final used = (ref.read(dealsProvider).value ?? const <DealRow>[]).any(
      (d) => d.stageId == stage.id,
    );
    if (used) {
      ref.read(toastProvider).error(l10n.stageInUse);
      return;
    }
    await _store.delete(SyncEntities.pipelineStages, [stage.id]);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final t = context.text;
    final stages = [
      for (final s in ref.watch(stagesProvider).value ?? const <StageRow>[])
        if (s.pipelineId == _pipeline?.id) s,
    ];
    return VModal(
      title: _pipeline == null ? l10n.pipelineNew : l10n.pipelineConfigure,
      icon: LucideIcons.kanban,
      width: 620,
      actions: [
        VButton(
          label: l10n.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        VButton.primary(
          label: _pipeline == null ? l10n.create : l10n.save,
          onPressed: _save,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: VTextField(
                  controller: _name,
                  label: l10n.pipelineName,
                  autofocus: _pipeline == null,
                  error: _errors['name'],
                ),
              ),
              const SizedBox(width: VSpace.x3),
              VSelect<String>(
                label: l10n.pipelineKind,
                value: _kind,
                options: enumOptions(PipelineKind.values),
                onChanged: (v) => setState(() => _kind = v),
              ),
            ],
          ),
          if (_pipeline != null) ...[
            const SizedBox(height: VSpace.x2),
            Row(
              children: [
                Checkbox(
                  value: _archived,
                  onChanged: (v) => setState(() => _archived = v ?? false),
                ),
                Text(l10n.pipelineArchived, style: t.body),
              ],
            ),
            const SizedBox(height: VSpace.x3),
            Row(
              children: [
                Expanded(child: Text(l10n.stagesTitle, style: t.heading)),
                VButton(
                  label: l10n.stageNew,
                  icon: LucideIcons.plus,
                  size: VButtonSize.sm,
                  onPressed: () => unawaited(
                    _editStage(
                      count: stages.isEmpty
                          ? 0
                          : (stages.last.sortOrder ?? 0).toInt() + 1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: VSpace.x2),
            for (final (i, stage) in stages.indexed)
              Container(
                margin: const EdgeInsets.only(bottom: VSpace.x1),
                padding: const EdgeInsets.symmetric(horizontal: VSpace.x2),
                height: 40,
                decoration: BoxDecoration(
                  color: c.surface,
                  borderRadius: VRadius.smAll,
                  border: Border.all(color: c.border),
                ),
                child: Row(
                  children: [
                    ColorDot(parseHexColor(stage.color ?? '#64748B')),
                    const SizedBox(width: VSpace.x2),
                    Expanded(child: Text(stage.name, style: t.bodyStrong)),
                    if (stage.probability != null)
                      Text('${stage.probability} %', style: t.small),
                    const SizedBox(width: VSpace.x2),
                    VBadge(
                      enumByKey(StageOutcome.values, stage.outcome)?.label ??
                          stage.outcome,
                    ),
                    VIconButton(
                      icon: LucideIcons.arrowUp,
                      tooltip: l10n.moveUp,
                      size: VButtonSize.sm,
                      onPressed: i == 0
                          ? null
                          : () => unawaited(_swap(stage, stages[i - 1])),
                    ),
                    VIconButton(
                      icon: LucideIcons.arrowDown,
                      tooltip: l10n.moveDown,
                      size: VButtonSize.sm,
                      onPressed: i == stages.length - 1
                          ? null
                          : () => unawaited(_swap(stage, stages[i + 1])),
                    ),
                    VIconButton(
                      icon: LucideIcons.pencil,
                      tooltip: l10n.edit,
                      size: VButtonSize.sm,
                      onPressed: () => unawaited(
                        _editStage(stage: stage, count: stages.length),
                      ),
                    ),
                    VIconButton(
                      icon: LucideIcons.trash2,
                      tooltip: l10n.delete,
                      size: VButtonSize.sm,
                      onPressed: () => unawaited(_deleteStage(stage)),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}
