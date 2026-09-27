import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../data/local/database.dart';
import '../../../data/sync/local_entities.dart';
import '../../../design_system/design_system.dart';
import '../crm_data.dart';
import '../crm_format.dart';
import '../widgets/record_form.dart';

/// Création ou modification d'une activité (note, appel, rendez-vous,
/// tâche, email).
Future<String?> showActivityForm(
  BuildContext context,
  WidgetRef ref, {
  ActivityRow? activity,
  ActivityKind kind = ActivityKind.note,
  String? organisationId,
  String? contactId,
  String? dealId,
}) {
  final l10n = context.l10n;
  final initial = activity == null
      ? <String, Object?>{
          'kind': kind.key,
          'organisation_id': organisationId,
          'contact_id': contactId,
          'deal_id': dealId,
          'owner_id': ref.read(currentUserProvider)?.id,
          if (kind == ActivityKind.call || kind == ActivityKind.note)
            'starts_at': DateTime.now().toUtc().toIso8601String(),
        }
      : rowToWire(SyncEntities.activities, activity);
  initial['done'] = initial['done_at'] != null;
  final deals = ref.read(dealsProvider).value ?? const <DealRow>[];

  return showRecordForm(
    context,
    schema: SyncEntities.activities,
    title: activity == null ? l10n.activityNew : l10n.activityEdit,
    icon: activityIcon(
      enumByKey(ActivityKind.values, initial['kind'] as String?),
    ),
    id: activity?.id,
    initial: initial,
    transform: (values) {
      final done = values['done'] == true;
      return {
        ...values,
        'done_at': done
            ? (initial['done_at'] ?? DateTime.now().toUtc().toIso8601String())
            : null,
      };
    },
    fields: [
      ChoiceFieldDef('kind', l10n.activityKind, [
        for (final k in ActivityKind.values)
          VSelectOption(k.key, k.label, icon: activityIcon(k)),
      ], clearable: false),
      DateFieldDef('due_at', l10n.activityDue, withTime: true),
      TextFieldDef(
        'subject',
        l10n.activitySubject,
        wide: true,
        autofocus: true,
      ),
      TextFieldDef('body', l10n.activityBody, wide: true, maxLines: 6),
      DateFieldDef('starts_at', l10n.activityStart, withTime: true),
      DateFieldDef('ends_at', l10n.activityEnd, withTime: true),
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
      RefFieldDef('deal_id', l10n.activityDeal, [
        for (final d in deals) VSelectOption(d.id, d.title),
      ]),
      DateFieldDef('remind_at', l10n.activityRemind, withTime: true),
      BoolFieldDef('done', l10n.activityDone),
    ],
  );
}
