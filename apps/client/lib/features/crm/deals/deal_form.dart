import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../data/local/database.dart';
import '../../../data/sync/local_entities.dart';
import '../../../design_system/design_system.dart';
import '../crm_data.dart';
import '../widgets/record_form.dart';

/// Création ([deal] `null`) ou modification d'une affaire. L'étape
/// détermine le pipeline et le statut (gagnée, perdue, en cours).
/// [prefill] : valeurs initiales d'une nouvelle affaire (titre…).
Future<String?> showDealForm(
  BuildContext context,
  WidgetRef ref, {
  DealRow? deal,
  String? pipelineId,
  String? stageId,
  String? organisationId,
  String? contactId,
  Map<String, Object?> prefill = const {},
}) {
  final l10n = context.l10n;
  final pipelines = {
    for (final p in ref.read(pipelinesProvider).value ?? const <PipelineRow>[])
      p.id: p,
  };
  final stages =
      [
        for (final s in ref.read(stagesProvider).value ?? const <StageRow>[])
          if (pipelines[s.pipelineId]?.archived != true &&
              pipelines.containsKey(s.pipelineId))
            s,
      ]..sort((a, b) {
        final p = pipelines.keys.toList();
        final byPipeline = p.indexOf(a.pipelineId) - p.indexOf(b.pipelineId);
        return byPipeline != 0
            ? byPipeline
            : (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0);
      });
  final stageById = {for (final s in stages) s.id: s};
  final firstStage =
      stageId ??
      stages.where((s) => s.pipelineId == pipelineId).firstOrNull?.id ??
      stages.firstOrNull?.id;

  return showRecordForm(
    context,
    schema: SyncEntities.deals,
    title: deal == null ? l10n.dealNew : l10n.dealEdit,
    icon: LucideIcons.handCoins,
    id: deal?.id,
    customFieldsOf: CrmEntity.deals,
    initial: deal == null
        ? {
            'stage_id': firstStage,
            'organisation_id': organisationId,
            'contact_id': contactId,
            'owner_id': ref.read(currentUserProvider)?.id,
            ...prefill,
          }
        : rowToWire(SyncEntities.deals, deal),
    transform: (values) {
      final stage = stageById[values['stage_id']];
      if (stage == null) return values;
      final outcome = stage.outcome;
      final wasClosed = deal != null && deal.status != StageOutcome.open.key;
      return {
        ...values,
        'pipeline_id': stage.pipelineId,
        'status': outcome,
        if (outcome != StageOutcome.open.key && !wasClosed)
          'closed_at': DateTime.now().toUtc().toIso8601String(),
        if (outcome == StageOutcome.open.key) 'closed_at': null,
        if (values['probability'] == null && stage.probability != null)
          'probability': stage.probability,
      };
    },
    fields: [
      TextFieldDef('title', l10n.dealTitle, wide: true, autofocus: true),
      ChoiceFieldDef(
        'stage_id',
        l10n.dealStage,
        [
          for (final s in stages)
            VSelectOption(
              s.id,
              pipelines.length > 1
                  ? '${pipelines[s.pipelineId]!.name} — ${s.name}'
                  : s.name,
            ),
        ],
        clearable: false,
        wide: true,
      ),
      RefFieldDef(
        'organisation_id',
        l10n.contactOrganisation,
        organisationOptions(ref.read(organisationsProvider).value ?? const []),
      ),
      RefFieldDef(
        'contact_id',
        l10n.dealContact,
        contactOptions(
          ref.read(contactsProvider).value ?? const [],
          ref.read(organisationByIdProvider),
        ),
      ),
      NumberFieldDef('amount_cents', l10n.dealAmount, cents: true),
      NumberFieldDef('probability', l10n.dealProbability),
      DateFieldDef('expected_close_date', l10n.dealExpectedClose),
      TextFieldDef('description', l10n.orgDescription, wide: true, maxLines: 4),
    ],
  );
}
