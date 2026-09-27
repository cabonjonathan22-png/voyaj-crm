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
import '../crm_data.dart';
import '../crm_format.dart';
import 'merge.dart';

/// Groupes de doublons ignorés (« ce ne sont pas des doublons »), par
/// poste.
final ignoredDuplicatesProvider =
    NotifierProvider<IgnoredDuplicatesController, Set<String>>(
      IgnoredDuplicatesController.new,
    );

final class IgnoredDuplicatesController extends Notifier<Set<String>> {
  @override
  Set<String> build() {
    unawaited(_load());
    return const {};
  }

  Future<void> _load() async {
    final json = await ref
        .read(appDatabaseProvider)
        .readSetting<List<dynamic>>(SettingKeys.ignoredDuplicates);
    if (json != null && ref.mounted) state = {for (final k in json) '$k'};
  }

  void ignore(Iterable<String> ids) {
    state = {...state, groupKey(ids)};
    unawaited(
      ref
          .read(appDatabaseProvider)
          .writeSetting(SettingKeys.ignoredDuplicates, state.toList()),
    );
  }

  /// Clé stable d'un groupe (identifiants triés).
  static String groupKey(Iterable<String> ids) =>
      (ids.toList()..sort()).join('|');
}

/// Détection et fusion des doublons.
class DuplicatesPage extends ConsumerStatefulWidget {
  const DuplicatesPage({super.key});

  @override
  ConsumerState<DuplicatesPage> createState() => _DuplicatesPageState();
}

class _DuplicatesPageState extends ConsumerState<DuplicatesPage> {
  CrmEntity _entity = CrmEntity.organisations;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final ignored = ref.watch(ignoredDuplicatesProvider);
    final List<List<_Candidate>> groups;
    if (_entity == CrmEntity.organisations) {
      final rows = ref.watch(organisationsProvider).value ?? const [];
      groups = groupDuplicates([
        for (final o in rows)
          _Candidate(
            id: o.id,
            title: o.name,
            subtitle: [
              enumByKey(OrganisationKind.values, o.kind)?.label,
              o.postalCode,
              o.city,
              if (o.siren != null) 'SIREN ${o.siren}',
            ].whereType<String>().join(' · '),
            createdAt: o.createdAt,
            wire: wireOf(SyncEntities.organisations, o),
          ),
      ], (c) => organisationDuplicateKeys(c.wire));
    } else {
      final rows = ref.watch(contactsProvider).value ?? const [];
      final organisations = ref.watch(organisationByIdProvider);
      groups = groupDuplicates([
        for (final c in rows)
          _Candidate(
            id: c.id,
            title: contactName(c),
            subtitle: [
              organisations[c.organisationId]?.name,
              c.email,
              c.mobile,
            ].whereType<String>().join(' · '),
            createdAt: c.createdAt,
            wire: wireOf(SyncEntities.contacts, c),
          ),
      ], (c) => contactDuplicateKeys(c.wire));
    }
    final visible = [
      for (final g in groups)
        if (!ignored.contains(
          IgnoredDuplicatesController.groupKey(g.map((c) => c.id)),
        ))
          g,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PageHeader(
          title: l10n.navDuplicates,
          subtitle: l10n.duplicatesSubtitle,
          icon: LucideIcons.copy,
          actions: [
            VSegmented<CrmEntity>(
              value: _entity,
              onChanged: (e) => setState(() => _entity = e),
              options: [
                VSelectOption(CrmEntity.organisations, l10n.navOrganisations),
                VSelectOption(CrmEntity.contacts, l10n.navContacts),
              ],
            ),
          ],
        ),
        Expanded(
          child: visible.isEmpty
              ? EmptyState(
                  icon: LucideIcons.circleCheck,
                  title: l10n.duplicatesNone,
                  message: l10n.duplicatesNoneMessage,
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(VSpace.x6),
                  itemCount: visible.length,
                  itemBuilder: (context, i) => _GroupCard(
                    key: ValueKey(visible[i].map((c) => c.id).join()),
                    entity: _entity,
                    candidates: visible[i],
                  ),
                ),
        ),
      ],
    );
  }
}

final class _Candidate {
  const _Candidate({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAt,
    required this.wire,
  });

  final String id;
  final String title;
  final String subtitle;
  final DateTime createdAt;
  final Map<String, Object?> wire;
}

class _GroupCard extends ConsumerStatefulWidget {
  const _GroupCard({super.key, required this.entity, required this.candidates});

  final CrmEntity entity;
  final List<_Candidate> candidates;

  @override
  ConsumerState<_GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends ConsumerState<_GroupCard> {
  late String _master =
      (widget.candidates.toList()..sort((a, b) {
            final byFields =
                filledFieldCount(b.wire) - filledFieldCount(a.wire);
            return byFields != 0
                ? byFields
                : a.createdAt.compareTo(b.createdAt);
          }))
          .first
          .id;
  bool _merging = false;

  EntitySchema get _schema => widget.entity == CrmEntity.organisations
      ? SyncEntities.organisations
      : SyncEntities.contacts;

  Future<void> _merge() async {
    final l10n = context.l10n;
    final others = [
      for (final c in widget.candidates)
        if (c.id != _master) c.id,
    ];
    final ok = await confirm(
      context,
      title: l10n.duplicatesMergeTitle,
      message: l10n.duplicatesMergeMessage(others.length),
      confirmLabel: l10n.duplicatesMerge,
    );
    if (!ok || !mounted) return;
    setState(() => _merging = true);
    try {
      await mergeRecords(
        ref.read(recordStoreProvider),
        schema: _schema,
        masterId: _master,
        otherIds: others,
      );
      ref.read(toastProvider).success(l10n.duplicatesMerged);
    } finally {
      if (mounted) setState(() => _merging = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.colors;
    final t = context.text;
    final canWrite = ref.watch(
      permissionProvider(
        widget.entity == CrmEntity.organisations
            ? Permission.organisationWrite
            : Permission.contactWrite,
      ),
    );
    final route = widget.entity == CrmEntity.organisations
        ? Routes.organisations
        : Routes.contacts;

    return Padding(
      padding: const EdgeInsets.only(bottom: VSpace.x4),
      child: VCard(
        title: l10n.duplicatesGroup(widget.candidates.length),
        actions: [
          VButton.ghost(
            label: l10n.duplicatesIgnore,
            size: VButtonSize.sm,
            onPressed: () => ref
                .read(ignoredDuplicatesProvider.notifier)
                .ignore(widget.candidates.map((c) => c.id)),
          ),
          if (canWrite)
            VButton.primary(
              label: l10n.duplicatesMerge,
              icon: LucideIcons.merge,
              size: VButtonSize.sm,
              loading: _merging,
              onPressed: () => unawaited(_merge()),
            ),
        ],
        child: RadioGroup<String>(
          groupValue: _master,
          onChanged: (v) => setState(() => _master = v ?? _master),
          child: Column(
            children: [
              for (final candidate in widget.candidates)
                Container(
                  margin: const EdgeInsets.only(bottom: VSpace.x1),
                  padding: const EdgeInsets.symmetric(horizontal: VSpace.x1),
                  decoration: BoxDecoration(
                    color: candidate.id == _master
                        ? c.accentSubtle
                        : Colors.transparent,
                    borderRadius: VRadius.smAll,
                  ),
                  child: Row(
                    children: [
                      Radio<String>(value: candidate.id),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(candidate.title, style: t.bodyStrong),
                            Text(candidate.subtitle, style: t.small),
                          ],
                        ),
                      ),
                      if (candidate.id == _master)
                        VBadge(l10n.duplicatesKept, tone: VTone.accent),
                      const SizedBox(width: VSpace.x2),
                      Text(
                        l10n.duplicatesCreated(
                          formatRelative(candidate.createdAt),
                        ),
                        style: t.small,
                      ),
                      VIconButton(
                        icon: LucideIcons.externalLink,
                        tooltip: l10n.open,
                        size: VButtonSize.sm,
                        onPressed: () => context.go('$route/${candidate.id}'),
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
