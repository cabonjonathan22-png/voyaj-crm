import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/providers.dart';
import '../../../data/local/database.dart';
import '../crm_data.dart';

/// Activités dont le rappel est échu, non terminées et pas encore
/// signalées (ordre chronologique).
List<ActivityRow> dueReminders(
  List<ActivityRow> activities,
  Set<String> notified,
  DateTime now,
) => [
  for (final a in activities)
    if (a.remindAt != null &&
        !a.remindAt!.isAfter(now) &&
        a.doneAt == null &&
        !notified.contains(a.id))
      a,
]..sort((a, b) => a.remindAt!.compareTo(b.remindAt!));

/// Surveille les rappels (chaque minute) et les signale par un toast, une
/// seule fois par poste. Actif tant que l'application est ouverte.
final reminderWatcherProvider = Provider<void>((ref) {
  if (!ref.watch(permissionProvider(Permission.activityRead))) return;
  final db = ref.watch(appDatabaseProvider);
  Set<String>? notified;

  Future<void> check() async {
    notified ??= {
      for (final id
          in await db.readSetting<List<dynamic>>(
                SettingKeys.notifiedReminders,
              ) ??
              const [])
        '$id',
    };
    if (!ref.mounted) return;
    final activities = ref.read(activitiesProvider).value;
    if (activities == null) return;
    final due = dueReminders(activities, notified!, DateTime.now().toUtc());
    if (due.isEmpty) return;
    for (final a in due.take(3)) {
      ref.read(toastProvider).info(a.subject, description: a.body);
    }
    // On ne garde que les rappels encore d'actualité.
    final pending = {
      for (final a in activities)
        if (a.remindAt != null && a.doneAt == null) a.id,
    };
    notified = {...notified!.intersection(pending), for (final a in due) a.id};
    await db.writeSetting(SettingKeys.notifiedReminders, notified!.toList());
  }

  final timer = Timer.periodic(
    const Duration(minutes: 1),
    (_) => unawaited(check()),
  );
  ref.onDispose(timer.cancel);
});
