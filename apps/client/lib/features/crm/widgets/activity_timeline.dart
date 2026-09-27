import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../app/router.dart';
import '../../../core/format.dart';
import '../../../data/local/database.dart';
import '../../../design_system/design_system.dart';
import '../activities/activity_form.dart';
import '../crm_data.dart';
import '../crm_format.dart';

/// Date de référence d'une activité (début, échéance ou création).
DateTime activityDate(ActivityRow a) => a.startsAt ?? a.dueAt ?? a.createdAt;

/// Tâche en retard (échéance passée, non terminée).
bool isOverdue(ActivityRow a, DateTime now) =>
    a.kind == ActivityKind.task.key &&
    a.doneAt == null &&
    a.dueAt != null &&
    a.dueAt!.isBefore(now);

/// Marque une tâche terminée (ou non).
Future<void> setActivityDone(
  WidgetRef ref,
  ActivityRow a, {
  required bool done,
}) => ref.read(recordStoreProvider).update(SyncEntities.activities, a.id, {
  'done_at': done ? DateTime.now().toUtc().toIso8601String() : null,
});

/// Historique des activités d'une fiche, avec ajout rapide.
class ActivityTimeline extends ConsumerWidget {
  const ActivityTimeline({
    super.key,
    required this.filter,
    this.organisationId,
    this.contactId,
    this.dealId,
  });

  /// Activités à afficher.
  final bool Function(ActivityRow activity) filter;

  /// Rattachements par défaut des nouvelles activités.
  final String? organisationId;
  final String? contactId;
  final String? dealId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final canWrite = ref.watch(permissionProvider(Permission.activityWrite));
    final activities = [
      for (final a
          in ref.watch(activitiesProvider).value ?? const <ActivityRow>[])
        if (filter(a)) a,
    ]..sort((a, b) => activityDate(b).compareTo(activityDate(a)));
    final open =
        [
          for (final a in activities)
            if (a.kind == ActivityKind.task.key && a.doneAt == null) a,
        ]..sort(
          (a, b) => (a.dueAt ?? a.createdAt).compareTo(b.dueAt ?? b.createdAt),
        );
    final history = [
      for (final a in activities)
        if (!(a.kind == ActivityKind.task.key && a.doneAt == null)) a,
    ];

    Future<void> add(ActivityKind kind) async {
      final id = await showActivityForm(
        context,
        ref,
        kind: kind,
        organisationId: organisationId,
        contactId: contactId,
        dealId: dealId,
      );
      if (id != null && context.mounted) {
        ref.read(toastProvider).success(l10n.activitySaved);
      }
    }

    return ListView(
      padding: const EdgeInsets.all(VSpace.x4),
      children: [
        if (canWrite)
          Wrap(
            spacing: VSpace.x2,
            runSpacing: VSpace.x2,
            children: [
              for (final kind in const [
                ActivityKind.note,
                ActivityKind.call,
                ActivityKind.meeting,
                ActivityKind.task,
                ActivityKind.email,
              ])
                VButton(
                  label: kind.label,
                  icon: activityIcon(kind),
                  size: VButtonSize.sm,
                  onPressed: () => unawaited(add(kind)),
                ),
            ],
          ),
        if (open.isNotEmpty) ...[
          const SizedBox(height: VSpace.x4),
          Text(l10n.activityOpenTasks, style: context.text.label),
          const SizedBox(height: VSpace.x2),
          for (final a in open) ActivityTile(activity: a),
        ],
        const SizedBox(height: VSpace.x4),
        Text(l10n.activityHistory, style: context.text.label),
        const SizedBox(height: VSpace.x2),
        if (history.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: VSpace.x4),
            child: Text(l10n.activityEmpty, style: context.text.small),
          ),
        for (final a in history) ActivityTile(activity: a),
      ],
    );
  }
}

/// Ligne d'activité (icône, objet, date, rattachements, menu).
class ActivityTile extends ConsumerWidget {
  const ActivityTile({
    super.key,
    required this.activity,
    this.showLinks = true,
  });

  final ActivityRow activity;
  final bool showLinks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.colors;
    final t = context.text;
    final l10n = context.l10n;
    final a = activity;
    final kind = enumByKey(ActivityKind.values, a.kind);
    final canWrite = ref.watch(permissionProvider(Permission.activityWrite));
    final organisation = ref.watch(organisationByIdProvider)[a.organisationId];
    final contact = ref.watch(contactByIdProvider)[a.contactId];
    final isTask = kind == ActivityKind.task;
    final overdue = isOverdue(a, DateTime.now().toUtc());

    return VContextMenuRegion(
      items: () => [
        if (canWrite)
          VMenuItem(
            label: l10n.edit,
            icon: LucideIcons.pencil,
            onSelected: () =>
                unawaited(showActivityForm(context, ref, activity: a)),
          ),
        if (organisation != null)
          VMenuItem(
            label: organisation.name,
            icon: LucideIcons.building2,
            onSelected: () =>
                context.go('${Routes.organisations}/${organisation.id}'),
          ),
        if (contact != null)
          VMenuItem(
            label: contactName(contact),
            icon: LucideIcons.user,
            onSelected: () => context.go('${Routes.contacts}/${contact.id}'),
          ),
        if (canWrite)
          VMenuItem(
            label: l10n.delete,
            icon: LucideIcons.trash2,
            destructive: true,
            dividerBefore: true,
            onSelected: () => unawaited(
              ref.read(recordStoreProvider).delete(SyncEntities.activities, [
                a.id,
              ]),
            ),
          ),
      ],
      child: Pressable(
        onPressed: canWrite
            ? () => unawaited(showActivityForm(context, ref, activity: a))
            : null,
        builder: (context, s) => AnimatedContainer(
          duration: VMotion.fast,
          margin: const EdgeInsets.only(bottom: VSpace.x1_5),
          padding: const EdgeInsets.all(VSpace.x3),
          decoration: BoxDecoration(
            color: s.hovered ? c.surfaceHover : c.surface,
            borderRadius: VRadius.mdAll,
            border: Border.all(color: overdue ? c.danger : c.border),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isTask)
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: a.doneAt != null,
                    onChanged: canWrite
                        ? (v) => unawaited(
                            setActivityDone(ref, a, done: v ?? false),
                          )
                        : null,
                  ),
                )
              else
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: c.accentSubtle,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    activityIcon(kind),
                    size: 13,
                    color: c.accentText,
                  ),
                ),
              const SizedBox(width: VSpace.x3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            a.subject,
                            style: t.bodyStrong.copyWith(
                              decoration: isTask && a.doneAt != null
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                        Text(
                          isTask && a.dueAt != null
                              ? l10n.activityDueOn(formatDateTime(a.dueAt!))
                              : formatDateTime(activityDate(a)),
                          style: t.small.copyWith(
                            color: overdue ? c.danger : null,
                          ),
                        ),
                      ],
                    ),
                    if (a.body != null && a.body!.isNotEmpty) ...[
                      const SizedBox(height: VSpace.x1),
                      Text(
                        a.body!,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: t.body.copyWith(color: c.textMuted),
                      ),
                    ],
                    if (showLinks && (organisation != null || contact != null))
                      Padding(
                        padding: const EdgeInsets.only(top: VSpace.x1_5),
                        child: Wrap(
                          spacing: VSpace.x1_5,
                          children: [
                            if (organisation != null)
                              VBadge(
                                organisation.name,
                                icon: LucideIcons.building2,
                              ),
                            if (contact != null)
                              VBadge(
                                contactName(contact),
                                icon: LucideIcons.user,
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
