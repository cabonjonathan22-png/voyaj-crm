import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../app/router.dart';
import '../../core/api_client.dart';
import '../../core/format.dart';
import '../../data/local/database.dart';
import '../../design_system/design_system.dart';
import '../crm/crm_data.dart';
import '../crm/crm_format.dart';
import 'gdpr_actions.dart';

/// Nom posé par le serveur sur un contact anonymisé.
const anonymizedContactName = 'Contact anonymisé';

/// Contact sans activité depuis [months] mois, avec sa dernière date de
/// contact (modification de la fiche ou activité).
typedef InactiveContact = ({ContactRow contact, DateTime lastTouch});

List<InactiveContact> inactiveContacts({
  required List<ContactRow> contacts,
  required List<ActivityRow> activities,
  required int months,
  required DateTime now,
}) {
  final last = <String, DateTime>{};
  void touch(String? id, DateTime? at) {
    if (id == null || at == null) return;
    final current = last[id];
    if (current == null || at.isAfter(current)) last[id] = at;
  }

  for (final c in contacts) {
    touch(c.id, c.updatedAt);
  }
  for (final a in activities) {
    touch(a.contactId, a.createdAt);
    touch(a.contactId, a.startsAt);
    touch(a.contactId, a.doneAt);
  }
  final limit = DateTime(now.year, now.month - months, now.day);
  return [
    for (final c in contacts)
      if (c.lastName != anonymizedContactName && last[c.id]!.isBefore(limit))
        (contact: c, lastTouch: last[c.id]!),
  ]..sort((a, b) => a.lastTouch.compareTo(b.lastTouch));
}

/// RGPD (durées de conservation, droits des personnes) et sauvegardes.
class GdprPage extends ConsumerStatefulWidget {
  const GdprPage({super.key});

  @override
  ConsumerState<GdprPage> createState() => _GdprPageState();
}

class _GdprPageState extends ConsumerState<GdprPage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canGdpr = ref.watch(permissionProvider(Permission.gdprManage));
    final canBackup = ref.watch(permissionProvider(Permission.backupManage));
    final tabs = [
      if (canGdpr) (VTab(l10n.gdprRetention, icon: LucideIcons.userX), 'gdpr'),
      if (canBackup)
        (VTab(l10n.backupsTab, icon: LucideIcons.databaseBackup), 'backups'),
    ];
    final index = _tab.clamp(0, tabs.isEmpty ? 0 : tabs.length - 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageHeader(
          title: l10n.navGdpr,
          subtitle: l10n.gdprSubtitle,
          icon: LucideIcons.shieldCheck,
        ),
        if (tabs.length > 1)
          VTabBar(
            index: index,
            onChanged: (i) => setState(() => _tab = i),
            tabs: [for (final (tab, _) in tabs) tab],
          ),
        Expanded(
          child: tabs.isEmpty
              ? const SizedBox.shrink()
              : tabs[index].$2 == 'gdpr'
              ? const _Retention()
              : const _Backups(),
        ),
      ],
    );
  }
}

class _Retention extends ConsumerStatefulWidget {
  const _Retention();

  @override
  ConsumerState<_Retention> createState() => _RetentionState();
}

class _RetentionState extends ConsumerState<_Retention> {
  int _months = 36;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    final c = context.colors;
    final organisations = ref.watch(organisationByIdProvider);
    final list = inactiveContacts(
      contacts: ref.watch(contactsProvider).value ?? const [],
      activities: ref.watch(activitiesProvider).value ?? const [],
      months: _months,
      now: DateTime.now(),
    );
    return ListView(
      padding: const EdgeInsets.all(VSpace.x6),
      children: [
        VBanner(icon: LucideIcons.info, message: l10n.gdprRetentionHelp),
        const SizedBox(height: VSpace.x4),
        Row(
          children: [
            Text(l10n.gdprInactiveFor, style: t.body),
            const SizedBox(width: VSpace.x2),
            VSegmented<int>(
              value: _months,
              options: [
                for (final m in const [12, 24, 36])
                  VSelectOption(m, l10n.gdprMonths(m)),
              ],
              onChanged: (v) => setState(() => _months = v),
            ),
            const Spacer(),
            Text(l10n.gdprInactiveCount(list.length), style: t.small),
          ],
        ),
        const SizedBox(height: VSpace.x3),
        if (list.isEmpty)
          EmptyState(icon: LucideIcons.userCheck, title: l10n.gdprNoInactive),
        for (final (:contact, :lastTouch) in list.take(200))
          Container(
            margin: const EdgeInsets.only(bottom: VSpace.x1_5),
            padding: const EdgeInsets.symmetric(
              horizontal: VSpace.x3,
              vertical: VSpace.x2,
            ),
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: VRadius.mdAll,
              border: Border.all(color: c.border),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VLink(
                        contactName(contact),
                        onPressed: () =>
                            context.go('${Routes.contacts}/${contact.id}'),
                      ),
                      Text(
                        [
                          organisations[contact.organisationId]?.name,
                          l10n.gdprLastTouch(formatShortDate(lastTouch)),
                        ].whereType<String>().join(' · '),
                        style: t.small,
                      ),
                    ],
                  ),
                ),
                GdprButton(contact: contact),
              ],
            ),
          ),
      ],
    );
  }
}

final _backupsProvider = FutureProvider.autoDispose<BackupStatus>((ref) async {
  final json = await ref.watch(apiClientProvider)!.get('/api/v1/admin/backups');
  return BackupStatus.fromJson(json! as Map<String, dynamic>);
});

class _Backups extends ConsumerStatefulWidget {
  const _Backups();

  @override
  ConsumerState<_Backups> createState() => _BackupsState();
}

class _BackupsState extends ConsumerState<_Backups> {
  bool _running = false;

  Future<void> _run() async {
    setState(() => _running = true);
    try {
      await ref.read(apiClientProvider)!.post('/api/v1/admin/backups');
      ref.read(toastProvider).success(context.l10n.backupDone);
      ref.invalidate(_backupsProvider);
    } on ApiFailure catch (e) {
      ref.read(toastProvider).error(e.message);
    } finally {
      if (mounted) setState(() => _running = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final t = context.text;
    if (ref.watch(apiClientProvider) == null) {
      return Center(
        child: EmptyState(
          icon: LucideIcons.cloudOff,
          title: l10n.billingSettingsOffline,
        ),
      );
    }
    return ref
        .watch(_backupsProvider)
        .when(
          loading: () => const Center(child: VSpinner()),
          error: (e, _) => Center(
            child: EmptyState(
              icon: LucideIcons.triangleAlert,
              title: e is ApiFailure ? e.message : '$e',
            ),
          ),
          data: (status) => ListView(
            padding: const EdgeInsets.all(VSpace.x6),
            children: [
              VCard(
                title: l10n.backupsTitle,
                description: status.hour == null
                    ? l10n.backupsManualOnly(status.directory)
                    : l10n.backupsSchedule(
                        status.hour!,
                        status.keepDays,
                        status.directory,
                      ),
                actions: [
                  VButton.primary(
                    label: l10n.backupNow,
                    icon: LucideIcons.databaseBackup,
                    loading: _running,
                    onPressed: () => unawaited(_run()),
                  ),
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (status.lastError != null)
                      VBanner(message: status.lastError!, tone: VTone.danger),
                    if (status.backups.isEmpty)
                      Text(l10n.backupsNone, style: t.small),
                    for (final b in status.backups)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: VSpace.x1,
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Text(b.name, style: t.mono)),
                            Text(
                              l10n.backupLine(
                                formatDateTime(b.createdAt.toLocal()),
                                (b.databaseBytes / 1024 / 1024).toStringAsFixed(
                                  1,
                                ),
                                b.totalFiles,
                              ),
                              style: t.small,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: VSpace.x4),
              VBanner(icon: LucideIcons.info, message: l10n.backupsRestoreHelp),
            ],
          ),
        );
  }
}
