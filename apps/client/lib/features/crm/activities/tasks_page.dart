import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../data/local/database.dart';
import '../../../design_system/design_system.dart';
import '../crm_data.dart';
import '../widgets/activity_timeline.dart';
import 'activity_form.dart';

/// Filtre de la liste des tâches.
enum TaskFilter { todo, overdue, today, done, activities }

/// Tâches (à faire, en retard, du jour, terminées) et journal des
/// activités.
class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage> {
  TaskFilter _filter = TaskFilter.todo;
  bool _mine = false;

  Future<void> _create() =>
      showActivityForm(context, ref, kind: ActivityKind.task);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canWrite = ref.watch(permissionProvider(Permission.activityWrite));
    final me = ref.watch(currentUserProvider)?.id;
    final now = DateTime.now().toUtc();
    final localNow = DateTime.now();
    final endOfDay = DateTime(
      localNow.year,
      localNow.month,
      localNow.day,
    ).add(const Duration(days: 1)).toUtc();
    final all = [
      for (final a
          in ref.watch(activitiesProvider).value ?? const <ActivityRow>[])
        if (!_mine || a.ownerId == me || a.assigneeId == me) a,
    ];
    final tasks = [
      for (final a in all)
        if (a.kind == ActivityKind.task.key) a,
    ];
    final todo =
        [
          for (final a in tasks)
            if (a.doneAt == null) a,
        ]..sort(
          (a, b) => (a.dueAt ?? a.createdAt.add(const Duration(days: 3650)))
              .compareTo(
                b.dueAt ?? b.createdAt.add(const Duration(days: 3650)),
              ),
        );
    final overdue = [
      for (final a in todo)
        if (isOverdue(a, now)) a,
    ];
    final today = [
      for (final a in todo)
        if (a.dueAt != null && a.dueAt!.isBefore(endOfDay)) a,
    ];
    final done = [
      for (final a in tasks)
        if (a.doneAt != null) a,
    ]..sort((a, b) => b.doneAt!.compareTo(a.doneAt!));
    final activities = [
      for (final a in all)
        if (a.kind != ActivityKind.task.key) a,
    ]..sort((a, b) => activityDate(b).compareTo(activityDate(a)));

    final shown = switch (_filter) {
      TaskFilter.todo => todo,
      TaskFilter.overdue => overdue,
      TaskFilter.today => today,
      TaskFilter.done => done,
      TaskFilter.activities => activities,
    };

    return CallbackShortcuts(
      bindings: {
        if (canWrite)
          const SingleActivator(LogicalKeyboardKey.keyN, control: true): () =>
              unawaited(_create()),
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PageHeader(
            title: l10n.navTasks,
            subtitle: l10n.tasksSubtitle,
            icon: LucideIcons.squareCheck,
            actions: [
              if (canWrite)
                VButton.primary(
                  label: l10n.taskNew,
                  icon: LucideIcons.plus,
                  shortcut: 'Ctrl N',
                  onPressed: () => unawaited(_create()),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              VSpace.x6,
              VSpace.x3,
              VSpace.x6,
              0,
            ),
            child: Row(
              children: [
                VSegmented<TaskFilter>(
                  value: _filter,
                  onChanged: (f) => setState(() => _filter = f),
                  options: [
                    VSelectOption(TaskFilter.todo, l10n.tasksTodo(todo.length)),
                    VSelectOption(
                      TaskFilter.overdue,
                      l10n.tasksOverdue(overdue.length),
                    ),
                    VSelectOption(
                      TaskFilter.today,
                      l10n.tasksToday(today.length),
                    ),
                    VSelectOption(TaskFilter.done, l10n.tasksDone),
                    VSelectOption(TaskFilter.activities, l10n.tasksActivities),
                  ],
                ),
                const Spacer(),
                Checkbox(
                  value: _mine,
                  onChanged: (v) => setState(() => _mine = v ?? false),
                ),
                Text(l10n.tasksMine, style: context.text.body),
              ],
            ),
          ),
          Expanded(
            child: shown.isEmpty
                ? EmptyState(
                    icon: LucideIcons.squareCheck,
                    title: _filter == TaskFilter.activities
                        ? l10n.activityEmpty
                        : l10n.tasksEmpty,
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(VSpace.x6),
                    itemCount: shown.length,
                    itemBuilder: (context, i) =>
                        ActivityTile(activity: shown[i]),
                  ),
          ),
        ],
      ),
    );
  }
}
