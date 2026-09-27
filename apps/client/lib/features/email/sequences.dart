import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../data/local/database.dart';
import '../../data/records/record_store.dart';
import '../../design_system/design_system.dart';
import '../crm/crm_data.dart';
import 'email_data.dart';

/// Création ou modification d'une séquence (étapes : délai + modèle).
Future<void> showSequenceForm(
  BuildContext context, {
  EmailSequenceRow? sequence,
}) => showVModal<void>(
  context,
  builder: (_) => _SequenceForm(sequence: sequence),
);

class _SequenceForm extends ConsumerStatefulWidget {
  const _SequenceForm({this.sequence});

  final EmailSequenceRow? sequence;

  @override
  ConsumerState<_SequenceForm> createState() => _SequenceFormState();
}

class _SequenceFormState extends ConsumerState<_SequenceForm> {
  late final _name = TextEditingController(text: widget.sequence?.name ?? '');
  late final _description = TextEditingController(
    text: widget.sequence?.description ?? '',
  );
  late bool _active = widget.sequence?.active ?? true;
  late final List<({TextEditingController delay, String? templateId})> _steps =
      [
        if (widget.sequence != null)
          for (final s in sequenceSteps(widget.sequence!.steps))
            (
              delay: TextEditingController(text: '${s.delayDays}'),
              templateId: s.templateId,
            )
        else
          (delay: TextEditingController(text: '0'), templateId: null),
      ];
  Map<String, String> _errors = const {};

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    for (final s in _steps) {
      s.delay.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final fields = {
      'name': _name.text,
      'description': _description.text,
      'active': _active,
      'steps': [
        for (final s in _steps)
          {
            'delay_days': int.tryParse(s.delay.text.trim()) ?? -1,
            'template_id': s.templateId,
          },
      ],
    };
    final store = ref.read(recordStoreProvider);
    try {
      if (widget.sequence == null) {
        await store.create(SyncEntities.emailSequences, fields);
      } else {
        await store.update(
          SyncEntities.emailSequences,
          widget.sequence!.id,
          fields,
        );
      }
      if (mounted) Navigator.of(context).pop();
    } on RecordValidationException catch (e) {
      setState(() => _errors = e.byField);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    final templates =
        ref.watch(emailTemplatesProvider).value ?? const <EmailTemplateRow>[];
    return VModal(
      title: widget.sequence == null ? l10n.sequenceNew : l10n.sequenceEdit,
      icon: LucideIcons.listOrdered,
      width: 640,
      actions: [
        VButton(
          label: l10n.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        VButton.primary(
          label: widget.sequence == null ? l10n.create : l10n.save,
          onPressed: _save,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          VTextField(
            controller: _name,
            label: l10n.sequenceName,
            autofocus: widget.sequence == null,
            error: _errors['name'],
          ),
          const SizedBox(height: VSpace.x3),
          VTextField(
            controller: _description,
            label: l10n.segmentDescription,
            maxLines: 2,
          ),
          Row(
            children: [
              Checkbox(
                value: _active,
                onChanged: (v) => setState(() => _active = v ?? true),
              ),
              Text(l10n.sequenceActive, style: t.body),
            ],
          ),
          const SizedBox(height: VSpace.x2),
          Text(l10n.sequenceSteps, style: t.heading),
          Text(l10n.sequenceStepsHelp, style: t.small),
          const SizedBox(height: VSpace.x2),
          if (templates.isEmpty)
            VBanner(message: l10n.sequenceNeedsTemplate, tone: VTone.warning),
          for (final (i, step) in _steps.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: VSpace.x2),
              child: Row(
                children: [
                  SizedBox(
                    width: 28,
                    child: Text('${i + 1}.', style: t.bodyStrong),
                  ),
                  SizedBox(
                    width: 110,
                    child: VTextField(
                      controller: step.delay,
                      dense: true,
                      suffix: Padding(
                        padding: const EdgeInsets.only(right: VSpace.x2),
                        child: Text(l10n.sequenceDays, style: t.small),
                      ),
                    ),
                  ),
                  const SizedBox(width: VSpace.x2),
                  Expanded(
                    child: VSelect<String>(
                      value: step.templateId,
                      width: double.infinity,
                      placeholder: l10n.sequenceChooseTemplate,
                      options: [
                        for (final t in templates) VSelectOption(t.id, t.name),
                      ],
                      onChanged: (v) => setState(
                        () => _steps[i] = (delay: step.delay, templateId: v),
                      ),
                    ),
                  ),
                  VIconButton(
                    icon: LucideIcons.trash2,
                    tooltip: l10n.delete,
                    size: VButtonSize.sm,
                    onPressed: _steps.length == 1
                        ? null
                        : () => setState(
                            () => _steps.removeAt(i).delay.dispose(),
                          ),
                  ),
                ],
              ),
            ),
          if (_errors['steps'] != null)
            Text(
              _errors['steps']!,
              style: t.small.copyWith(color: context.colors.danger),
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: VButton.ghost(
              label: l10n.sequenceAddStep,
              icon: LucideIcons.plus,
              size: VButtonSize.sm,
              onPressed: () => setState(
                () => _steps.add((
                  delay: TextEditingController(text: '7'),
                  templateId: null,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Inscrit [contactId] à une séquence choisie ; les emails partent du
/// compte de l'utilisateur connecté.
Future<void> enrollContact(
  BuildContext context,
  WidgetRef ref, {
  required String contactId,
}) async {
  final l10n = context.l10n;
  final sequences = [
    for (final s
        in ref.read(emailSequencesProvider).value ?? const <EmailSequenceRow>[])
      if (s.active != false) s,
  ];
  final option = await showSearchPicker<String>(
    context,
    title: l10n.sequenceEnroll,
    options: [
      for (final s in sequences)
        VSelectOption(s.id, s.name, icon: LucideIcons.listOrdered),
    ],
  );
  if (option == null) return;
  final sequence = sequences.firstWhere((s) => s.id == option.value);
  final active =
      (ref.read(enrollmentsProvider).value ?? const <EnrollmentRow>[]).any(
        (e) =>
            e.contactId == contactId &&
            e.sequenceId == sequence.id &&
            e.status == EnrollmentStatus.active.key,
      );
  if (active) {
    ref.read(toastProvider).info(l10n.sequenceAlreadyEnrolled);
    return;
  }
  final first = sequenceSteps(sequence.steps).first;
  await ref.read(recordStoreProvider).create(SyncEntities.sequenceEnrollments, {
    'sequence_id': sequence.id,
    'contact_id': contactId,
    'owner_id': ref.read(currentUserProvider)!.id,
    'step': 0,
    'status': EnrollmentStatus.active.key,
    'next_send_at': DateTime.now()
        .toUtc()
        .add(Duration(days: first.delayDays))
        .toIso8601String(),
  });
  ref.read(toastProvider).success(l10n.sequenceEnrolled(sequence.name));
}

/// Ton d'un état d'inscription.
VTone enrollmentTone(String status) =>
    switch (enumByKey(EnrollmentStatus.values, status)) {
      EnrollmentStatus.active => VTone.info,
      EnrollmentStatus.completed => VTone.success,
      EnrollmentStatus.replied => VTone.accent,
      EnrollmentStatus.failed => VTone.danger,
      _ => VTone.neutral,
    };

/// Arrête une inscription en cours.
Future<void> stopEnrollment(WidgetRef ref, EnrollmentRow enrollment) =>
    ref.read(recordStoreProvider).update(
      SyncEntities.sequenceEnrollments,
      enrollment.id,
      {'status': EnrollmentStatus.stopped.key, 'next_send_at': null},
    );

/// Inscriptions d'une séquence (panneau de détail).
class EnrollmentList extends ConsumerWidget {
  const EnrollmentList({super.key, required this.enrollments});

  final List<EnrollmentRow> enrollments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final contacts = ref.watch(contactByIdProvider);
    final canUse = ref.watch(permissionProvider(Permission.emailUse));
    if (enrollments.isEmpty) {
      return Text(l10n.sequenceNoEnrollment, style: context.text.small);
    }
    return Column(
      children: [
        for (final e in enrollments)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: VSpace.x1),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    [
                      contacts[e.contactId]?.firstName,
                      contacts[e.contactId]?.lastName,
                    ].whereType<String>().join(' '),
                    style: context.text.body,
                  ),
                ),
                Text(l10n.sequenceStepOf(e.step), style: context.text.small),
                const SizedBox(width: VSpace.x2),
                Tooltip(
                  message: e.lastError ?? '',
                  child: VBadge(
                    enumByKey(EnrollmentStatus.values, e.status)?.label ??
                        e.status,
                    tone: enrollmentTone(e.status),
                  ),
                ),
                if (canUse && e.status == EnrollmentStatus.active.key)
                  VIconButton(
                    icon: LucideIcons.circleStop,
                    tooltip: l10n.sequenceStop,
                    size: VButtonSize.sm,
                    onPressed: () => unawaited(stopEnrollment(ref, e)),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
