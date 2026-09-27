import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../app/app.dart';
import '../../app/providers.dart';
import '../../core/api_client.dart';
import '../../core/format.dart';
import '../../data/local/database.dart';
import '../../data/sync/sync_engine.dart';
import '../../design_system/design_system.dart';

final _syncErrorsProvider = StreamProvider<List<SyncErrorRow>>(
  (ref) => ref.watch(appDatabaseProvider).watchSyncErrors(),
);

final _conflictsProvider = FutureProvider.autoDispose
    .family<List<SyncConflict>, bool>((ref, unreviewedOnly) async {
      final api = ref.watch(apiClientProvider);
      if (api == null) return const [];
      final json = await api.get(
        '/api/v1/sync/conflicts?unreviewed=$unreviewedOnly',
      );
      return [
        for (final c in json! as List<dynamic>)
          SyncConflict.fromJson(c as Map<String, dynamic>),
      ];
    });

/// État de la synchronisation, opérations refusées et conflits.
class SyncPage extends ConsumerStatefulWidget {
  const SyncPage({super.key});

  @override
  ConsumerState<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends ConsumerState<SyncPage> {
  bool _unreviewedOnly = true;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final status = ref.watch(syncStatusProvider).value ?? const SyncStatus();
    final pending = ref.watch(pendingOperationsProvider).value ?? 0;
    final errors = ref.watch(_syncErrorsProvider).value ?? const [];
    final canReadConflicts = ref.watch(
      permissionProvider(Permission.syncConflictRead),
    );
    final server = ref.watch(serverUrlProvider);

    final (connectionLabel, connectionTone) = switch (status.connection) {
      SyncConnection.online => (l10n.syncOnline, VTone.success),
      SyncConnection.connecting => (l10n.syncConnecting, VTone.warning),
      SyncConnection.offline => (l10n.syncOffline, VTone.neutral),
    };

    return Column(
      children: [
        PageHeader(
          title: l10n.syncTitle,
          subtitle: l10n.syncSubtitle,
          icon: LucideIcons.refreshCw,
          actions: [
            VButton.primary(
              label: l10n.syncNow,
              icon: LucideIcons.refreshCw,
              shortcut: 'F5',
              loading: status.syncing,
              onPressed: () {
                unawaited(ref.read(syncEngineProvider)?.syncNow());
                ref.invalidate(_conflictsProvider);
              },
            ),
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(VSpace.x5),
            children: [
              Wrap(
                spacing: VSpace.x3,
                runSpacing: VSpace.x3,
                children: [
                  _StatCard(
                    icon: status.connection == SyncConnection.online
                        ? LucideIcons.cloud
                        : LucideIcons.cloudOff,
                    label: l10n.syncConnection,
                    value: VBadge(connectionLabel, tone: connectionTone),
                    detail: server?.host,
                  ),
                  _StatCard(
                    icon: LucideIcons.cloudUpload,
                    label: l10n.syncPendingLabel,
                    value: Text('$pending', style: context.text.display),
                    detail: pending == 0 ? l10n.syncAllSent : null,
                  ),
                  _StatCard(
                    icon: LucideIcons.clock,
                    label: l10n.syncLastLabel,
                    value: Text(
                      status.lastSyncAt == null
                          ? '—'
                          : formatRelative(status.lastSyncAt!),
                      style: context.text.heading,
                    ),
                    detail: status.lastSyncAt == null
                        ? null
                        : formatDateTime(status.lastSyncAt!),
                  ),
                ],
              ),
              if (status.lastError != null) ...[
                const SizedBox(height: VSpace.x4),
                VBanner(
                  message: status.lastError!,
                  tone: VTone.danger,
                  icon: LucideIcons.circleAlert,
                ),
              ],
              const SizedBox(height: VSpace.x6),
              VCard(
                title: l10n.syncErrorsTitle,
                description: l10n.syncErrorsDescription,
                actions: [
                  if (errors.isNotEmpty)
                    VButton.ghost(
                      label: l10n.clear,
                      size: VButtonSize.sm,
                      onPressed: () =>
                          ref.read(appDatabaseProvider).clearSyncErrors(),
                    ),
                ],
                child: errors.isEmpty
                    ? _EmptyLine(l10n.syncErrorsEmpty)
                    : Column(
                        children: [
                          for (final e in errors)
                            _ListRow(
                              icon: LucideIcons.circleX,
                              iconColor: c.danger,
                              title: e.message,
                              subtitle:
                                  '${e.entity} · ${_fieldsSummary(e.fields)}',
                              trailing: formatRelative(e.createdAt),
                            ),
                        ],
                      ),
              ),
              if (canReadConflicts) ...[
                const SizedBox(height: VSpace.x4),
                _ConflictsCard(
                  unreviewedOnly: _unreviewedOnly,
                  onToggle: (v) => setState(() => _unreviewedOnly = v),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  static String _fieldsSummary(String json) {
    final fields = jsonDecode(json) as Map<String, dynamic>;
    return fields.keys.join(', ');
  }
}

class _ConflictsCard extends ConsumerWidget {
  const _ConflictsCard({required this.unreviewedOnly, required this.onToggle});

  final bool unreviewedOnly;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final conflicts = ref.watch(_conflictsProvider(unreviewedOnly));
    final tags = {
      for (final t in ref.watch(tagsProvider).value ?? const <Tag>[]) t.id: t,
    };
    final canManage = ref.watch(
      permissionProvider(Permission.syncConflictManage),
    );

    Future<void> review(String id) async {
      try {
        await ref
            .read(apiClientProvider)!
            .post('/api/v1/sync/conflicts/$id/review');
        ref.invalidate(_conflictsProvider);
      } on ApiFailure catch (e) {
        ref.read(toastProvider).error(e.message);
      }
    }

    return VCard(
      title: l10n.conflictsTitle,
      description: l10n.conflictsDescription,
      actions: [
        VSegmented<bool>(
          value: unreviewedOnly,
          onChanged: onToggle,
          options: [
            VSelectOption(true, l10n.conflictsUnreviewed),
            VSelectOption(false, l10n.conflictsAll),
          ],
        ),
      ],
      child: switch (conflicts) {
        AsyncData(:final value) when value.isEmpty => _EmptyLine(
          l10n.conflictsEmpty,
        ),
        AsyncData(:final value) => Column(
          children: [
            for (final conflict in value)
              _ListRow(
                icon: LucideIcons.gitMerge,
                iconColor: conflict.reviewedAt == null
                    ? c.warning
                    : c.textSubtle,
                title: l10n.conflictSummary(
                  tags[conflict.entityId]?.name ?? conflict.entity,
                  conflict.field,
                ),
                subtitle: l10n.conflictDetail(
                  _display(conflict.winningValue),
                  conflict.winnerName ?? '?',
                  _display(conflict.losingValue),
                  conflict.loserName ?? '?',
                ),
                trailing: formatRelative(conflict.createdAt),
                action: canManage && conflict.reviewedAt == null
                    ? VButton(
                        label: l10n.conflictMarkReviewed,
                        size: VButtonSize.sm,
                        icon: LucideIcons.check,
                        onPressed: () => review(conflict.id),
                      )
                    : null,
              ),
          ],
        ),
        AsyncError(:final error) => _EmptyLine(
          error is ApiFailure ? error.message : l10n.genericError,
        ),
        _ => const Padding(
          padding: EdgeInsets.all(VSpace.x3),
          child: Column(
            children: [
              Skeleton(height: 14),
              SizedBox(height: VSpace.x3),
              Skeleton(height: 14),
            ],
          ),
        ),
      },
    );
  }

  static String _display(Object? value) {
    if (value == null) return '∅';
    final text = value is String ? value : jsonEncode(value);
    return text.length > 40 ? '${text.substring(0, 40)}…' : '« $text »';
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    this.detail,
  });

  final IconData icon;
  final String label;
  final Widget value;
  final String? detail;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 240,
    child: VCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: context.colors.textSubtle),
              const SizedBox(width: VSpace.x2),
              Text(label, style: context.text.label),
            ],
          ),
          const SizedBox(height: VSpace.x3),
          SizedBox(
            height: 32,
            child: Align(alignment: Alignment.centerLeft, child: value),
          ),
          const SizedBox(height: VSpace.x1),
          Text(
            detail ?? '',
            style: context.text.small,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

class _ListRow extends StatelessWidget {
  const _ListRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.action,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String trailing;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: VSpace.x2 + 2),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: context.colors.borderSubtle)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: VSpace.x3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.text.bodyStrong),
              const SizedBox(height: 2),
              Text(subtitle, style: context.text.small),
            ],
          ),
        ),
        Text(trailing, style: context.text.small),
        if (action != null) ...[const SizedBox(width: VSpace.x3), action!],
      ],
    ),
  );
}

class _EmptyLine extends StatelessWidget {
  const _EmptyLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: VSpace.x2),
    child: Text(text, style: context.text.small),
  );
}
