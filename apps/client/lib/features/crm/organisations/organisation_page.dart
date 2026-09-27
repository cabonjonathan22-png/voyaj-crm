import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../app/router.dart';
import '../../../app/shell/work_tabs.dart';
import '../../../core/format.dart';
import '../../../data/local/database.dart';
import '../../../design_system/design_system.dart';
import '../contacts/contact_forms.dart';
import '../crm_data.dart';
import '../crm_format.dart';
import '../deals/deal_form.dart';
import '../deals/deals_list.dart';
import '../widgets/activity_timeline.dart';
import '../widgets/attachments_panel.dart';
import '../widgets/record_header.dart';
import '../widgets/record_tags.dart';
import 'organisation_form.dart';

/// Fiche d'une organisation.
class OrganisationPage extends ConsumerStatefulWidget {
  const OrganisationPage({super.key, required this.id});

  final String id;

  @override
  ConsumerState<OrganisationPage> createState() => _OrganisationPageState();
}

class _OrganisationPageState extends ConsumerState<OrganisationPage> {
  int _tab = 0;

  Future<void> _delete(OrganisationRow o) async {
    final l10n = context.l10n;
    final ok = await confirm(
      context,
      title: l10n.organisationDeleteTitle(1),
      message: l10n.organisationDeleteMessage(1, o.name),
      confirmLabel: l10n.delete,
      destructive: true,
    );
    if (!ok || !mounted) return;
    await ref.read(recordStoreProvider).delete(SyncEntities.organisations, [
      o.id,
    ]);
    ref.read(toastProvider).success(l10n.organisationDeleted(1));
    final route = '${Routes.organisations}/${o.id}';
    ref.read(workTabsProvider.notifier).close(route, current: null);
    if (mounted) context.go(Routes.organisations);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final async = ref.watch(organisationsProvider);
    final o = ref.watch(organisationByIdProvider)[widget.id];
    if (o == null) {
      return async.isLoading
          ? const SkeletonRows()
          : EmptyState(
              icon: LucideIcons.searchX,
              title: l10n.recordNotFound,
              action: VButton(
                label: l10n.navOrganisations,
                onPressed: () => context.go(Routes.organisations),
              ),
            );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref
          .read(workTabsProvider.notifier)
          .open(
            WorkTab(
              route: '${Routes.organisations}/${o.id}',
              title: o.name,
              kind: WorkTabKind.organisation,
            ),
          );
    });

    final canWrite = ref.watch(
      permissionProvider(Permission.organisationWrite),
    );
    final kind = enumByKey(OrganisationKind.values, o.kind);
    final status = enumByKey(OrganisationStatus.values, o.status);
    final contacts = [
      for (final c in ref.watch(contactsProvider).value ?? const <ContactRow>[])
        if (c.organisationId == o.id) c,
    ];
    final positions = [
      for (final p
          in ref.watch(positionsProvider).value ?? const <PositionRow>[])
        if (p.organisationId == o.id) p,
    ];
    final deals = [
      for (final d in ref.watch(dealsProvider).value ?? const <DealRow>[])
        if (d.organisationId == o.id) d,
    ];
    final contactIds = {
      for (final c in contacts) c.id,
      for (final p in positions) p.contactId,
    };
    final dealIds = {for (final d in deals) d.id};
    final activities =
        ref.watch(activitiesProvider).value ?? const <ActivityRow>[];
    bool activityFilter(ActivityRow a) =>
        a.organisationId == o.id ||
        (a.organisationId == null && contactIds.contains(a.contactId)) ||
        dealIds.contains(a.dealId);
    final files =
        ref.watch(attachmentsProvider).value ?? const <AttachmentRow>[];
    bool fileFilter(AttachmentRow f) => f.organisationId == o.id;

    return CallbackShortcuts(
      bindings: {
        if (canWrite)
          const SingleActivator(LogicalKeyboardKey.keyE, control: true): () =>
              unawaited(showOrganisationForm(context, ref, organisation: o)),
      },
      child: Focus(
        autofocus: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RecordHeader(
              icon: kindIcon(kind),
              title: o.name,
              subtitle: [
                kind?.label ?? o.kind,
                if (o.city != null) o.city!,
                if (o.departementCode != null) '(${o.departementCode})',
              ].join(' · '),
              actions: [
                VSelect<String>(
                  value: o.status,
                  options: [
                    for (final s in OrganisationStatus.values)
                      VSelectOption(
                        s.key,
                        s.label,
                        leading: ColorDot(
                          context.colors.toneColor(statusTone(s)),
                          size: 8,
                        ),
                      ),
                  ],
                  onChanged: canWrite
                      ? (v) => unawaited(
                          ref.read(recordStoreProvider).update(
                            SyncEntities.organisations,
                            o.id,
                            {'status': v},
                          ),
                        )
                      : null,
                ),
                if (canWrite)
                  VButton(
                    label: l10n.edit,
                    icon: LucideIcons.pencil,
                    shortcut: 'Ctrl E',
                    onPressed: () => unawaited(
                      showOrganisationForm(context, ref, organisation: o),
                    ),
                  ),
                if (canWrite)
                  VIconButton(
                    icon: LucideIcons.trash2,
                    tooltip: l10n.delete,
                    onPressed: () => unawaited(_delete(o)),
                  ),
              ],
              below: Row(
                children: [
                  if (status != null) ...[
                    VBadge(status.label, tone: statusTone(status)),
                    const SizedBox(width: VSpace.x3),
                  ],
                  Expanded(
                    child: RecordTags(
                      entity: CrmEntity.organisations,
                      recordId: o.id,
                    ),
                  ),
                ],
              ),
            ),
            VTabBar(
              index: _tab,
              onChanged: (i) => setState(() => _tab = i),
              tabs: [
                VTab(l10n.tabOverview, icon: LucideIcons.layoutList),
                VTab(
                  l10n.navContacts,
                  icon: LucideIcons.users,
                  count: contactIds.length,
                ),
                VTab(
                  l10n.tabDeals,
                  icon: LucideIcons.handCoins,
                  count: deals.length,
                ),
                VTab(
                  l10n.tabActivities,
                  icon: LucideIcons.history,
                  count: activities.where(activityFilter).length,
                ),
                VTab(
                  l10n.tabFiles,
                  icon: LucideIcons.paperclip,
                  count: files.where(fileFilter).length,
                ),
              ],
            ),
            Expanded(
              child: switch (_tab) {
                0 => _Overview(organisation: o),
                1 => _ContactsTab(
                  organisation: o,
                  contacts: contacts,
                  positions: positions,
                ),
                2 => DealsList(
                  deals: deals,
                  onCreate: () => unawaited(
                    showDealForm(context, ref, organisationId: o.id),
                  ),
                ),
                3 => ActivityTimeline(
                  filter: activityFilter,
                  organisationId: o.id,
                ),
                _ => AttachmentsPanel(filter: fileFilter, organisationId: o.id),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Overview extends ConsumerWidget {
  const _Overview({required this.organisation});

  final OrganisationRow organisation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final o = organisation;
    final byId = ref.watch(organisationByIdProvider);
    final parent = byId[o.parentId];
    final children = [
      for (final other in byId.values)
        if (other.parentId == o.id) other,
    ];
    final customFields = ref.watch(
      customFieldsForProvider(CrmEntity.organisations),
    );
    final customValues = decodeCustomValues(o.customFields);

    Widget link(String? value, Uri? Function(String) uri) => value == null
        ? const Text('—')
        : VLink(
            value,
            onPressed: () {
              final target = uri(value);
              if (target != null) unawaited(launchUrl(target));
            },
          );

    final left = [
      RecordSection(
        title: l10n.orgSectionContact,
        children: [
          VInfoRow(
            l10n.orgAddress,
            [
              o.address,
              [o.postalCode, o.city].whereType<String>().join(' '),
            ].whereType<String>().where((s) => s.isNotEmpty).join('\n'),
          ),
          VInfoRow(
            l10n.orgPhone,
            null,
            child: link(o.phone, (v) => Uri(scheme: 'tel', path: v)),
          ),
          VInfoRow(
            l10n.orgEmail,
            null,
            child: link(o.email, (v) => Uri(scheme: 'mailto', path: v)),
          ),
          VInfoRow(l10n.orgWebsite, null, child: link(o.website, Uri.tryParse)),
        ],
      ),
      RecordSection(
        title: l10n.orgSectionIdentity,
        children: [
          VInfoRow(
            l10n.orgKind,
            enumByKey(OrganisationKind.values, o.kind)?.label,
          ),
          VInfoRow(l10n.orgSiren, o.siren),
          VInfoRow(l10n.orgSiret, o.siret),
          VInfoRow(l10n.orgInsee, o.inseeCode),
          VInfoRow(l10n.orgPopulation, formatInteger(o.population)),
          VInfoRow(l10n.orgDepartement, o.departementCode),
          VInfoRow(l10n.orgRegion, frenchRegions[o.regionCode]),
        ],
      ),
      if (o.description != null)
        RecordSection(
          title: l10n.orgDescription,
          children: [SelectableText(o.description!, style: context.text.body)],
        ),
    ];

    final right = [
      RecordSection(
        title: l10n.orgSectionHierarchy,
        children: [
          VInfoRow(
            l10n.orgParent,
            null,
            child: parent == null
                ? const Text('—')
                : VLink(
                    parent.name,
                    onPressed: () =>
                        context.go('${Routes.organisations}/${parent.id}'),
                  ),
          ),
          if (children.isNotEmpty) ...[
            const SizedBox(height: VSpace.x2),
            Text(l10n.orgChildren(children.length), style: context.text.label),
            const SizedBox(height: VSpace.x1),
            for (final child in children.take(30))
              Align(
                alignment: Alignment.centerLeft,
                child: VButton.ghost(
                  label: child.name,
                  icon: kindIcon(
                    enumByKey(OrganisationKind.values, child.kind),
                  ),
                  size: VButtonSize.sm,
                  onPressed: () =>
                      context.go('${Routes.organisations}/${child.id}'),
                ),
              ),
          ],
        ],
      ),
      if (customFields.isNotEmpty)
        RecordSection(
          title: l10n.customFieldsTitle,
          children: [
            for (final f in customFields)
              VInfoRow(f.label, formatCustomValue(f, customValues[f.key])),
          ],
        ),
      RecordSection(
        title: l10n.orgSectionTraceability,
        children: [
          VInfoRow(l10n.orgSource, o.source),
          VInfoRow(
            l10n.orgCollectedAt,
            o.collectedAt == null ? null : formatDateTime(o.collectedAt!),
          ),
          VInfoRow(l10n.metaCreated, formatDateTime(o.createdAt)),
          VInfoRow(l10n.metaUpdated, formatDateTime(o.updatedAt)),
          VInfoRow(l10n.metaVersion, o.version == 0 ? null : '${o.version}'),
        ],
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth > 900;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(VSpace.x6),
          child: wide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Column(children: left)),
                    const SizedBox(width: VSpace.x4),
                    Expanded(child: Column(children: right)),
                  ],
                )
              : Column(children: [...left, ...right]),
        );
      },
    );
  }
}

class _ContactsTab extends ConsumerWidget {
  const _ContactsTab({
    required this.organisation,
    required this.contacts,
    required this.positions,
  });

  final OrganisationRow organisation;
  final List<ContactRow> contacts;
  final List<PositionRow> positions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final t = context.text;
    final canWrite = ref.watch(permissionProvider(Permission.contactWrite));
    final contactById = ref.watch(contactByIdProvider);
    final today = formatDateOnly(DateTime.now());
    final current = [
      for (final p in positions)
        if (p.endDate == null || p.endDate!.compareTo(today) >= 0) p,
    ];
    final past = [
      for (final p in positions)
        if (!current.contains(p)) p,
    ];

    Widget contactTile(ContactRow contact, {PositionRow? position}) {
      final role = position == null
          ? contact.jobTitle
          : position.isElected
          ? [
              enumByKey(MandateRole.values, position.mandateRole)?.label,
              position.delegation,
            ].whereType<String>().join(' — ')
          : position.jobTitle ?? contact.jobTitle;
      return Pressable(
        onPressed: () => context.go('${Routes.contacts}/${contact.id}'),
        semanticLabel: contactName(contact),
        builder: (context, s) => AnimatedContainer(
          duration: VMotion.fast,
          margin: const EdgeInsets.only(bottom: VSpace.x1_5),
          padding: const EdgeInsets.symmetric(
            horizontal: VSpace.x3,
            vertical: VSpace.x2,
          ),
          decoration: BoxDecoration(
            color: s.hovered ? c.surfaceHover : c.surface,
            borderRadius: VRadius.mdAll,
            border: Border.all(color: c.border),
          ),
          child: Row(
            children: [
              VAvatar(contactName(contact), size: 28),
              const SizedBox(width: VSpace.x3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contactName(contact), style: t.bodyStrong),
                    if (role != null && role.isNotEmpty)
                      Text(role, style: t.small),
                  ],
                ),
              ),
              if (position?.isElected ?? false)
                VBadge(l10n.positionElected, tone: VTone.accent),
              if (position?.endDate != null) ...[
                const SizedBox(width: VSpace.x2),
                Text(
                  l10n.positionUntil(formatDay(position!.endDate)),
                  style: t.small,
                ),
              ],
              if (contact.email != null) ...[
                const SizedBox(width: VSpace.x3),
                Text(contact.email!, style: t.small),
              ],
              if (position != null && canWrite)
                VIconButton(
                  icon: LucideIcons.pencil,
                  tooltip: l10n.positionEdit,
                  size: VButtonSize.sm,
                  onPressed: () => unawaited(
                    showPositionForm(context, ref, position: position),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(VSpace.x4),
      children: [
        if (canWrite)
          Wrap(
            spacing: VSpace.x2,
            children: [
              VButton.primary(
                label: l10n.contactNew,
                icon: LucideIcons.userPlus,
                size: VButtonSize.sm,
                onPressed: () => unawaited(
                  showContactForm(
                    context,
                    ref,
                    organisationId: organisation.id,
                  ),
                ),
              ),
              VButton(
                label: l10n.positionAddElected,
                icon: LucideIcons.award,
                size: VButtonSize.sm,
                onPressed: () => unawaited(
                  showPositionForm(
                    context,
                    ref,
                    organisationId: organisation.id,
                    elected: true,
                  ),
                ),
              ),
              VButton(
                label: l10n.positionNew,
                icon: LucideIcons.briefcase,
                size: VButtonSize.sm,
                onPressed: () => unawaited(
                  showPositionForm(
                    context,
                    ref,
                    organisationId: organisation.id,
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(height: VSpace.x4),
        if (contacts.isEmpty && positions.isEmpty)
          EmptyState(icon: LucideIcons.users, title: l10n.contactsEmptyTitle),
        if (current.isNotEmpty) ...[
          Text(l10n.positionsCurrent, style: t.label),
          const SizedBox(height: VSpace.x2),
          for (final p in current)
            if (contactById[p.contactId] case final contact?)
              contactTile(contact, position: p),
          const SizedBox(height: VSpace.x3),
        ],
        if (contacts.isNotEmpty) ...[
          Text(l10n.contactsAttached, style: t.label),
          const SizedBox(height: VSpace.x2),
          for (final contact in contacts) contactTile(contact),
          const SizedBox(height: VSpace.x3),
        ],
        if (past.isNotEmpty) ...[
          Text(l10n.positionsPast, style: t.label),
          const SizedBox(height: VSpace.x2),
          for (final p in past)
            if (contactById[p.contactId] case final contact?)
              contactTile(contact, position: p),
        ],
      ],
    );
  }
}
