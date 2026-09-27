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
import '../crm_data.dart';
import '../crm_format.dart';
import '../deals/deal_form.dart';
import '../deals/deals_list.dart';
import '../widgets/activity_timeline.dart';
import '../widgets/attachments_panel.dart';
import '../widgets/record_header.dart';
import '../widgets/record_tags.dart';
import 'contact_forms.dart';

/// Fiche d'un contact (ou d'un élu).
class ContactPage extends ConsumerStatefulWidget {
  const ContactPage({super.key, required this.id});

  final String id;

  @override
  ConsumerState<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends ConsumerState<ContactPage> {
  int _tab = 0;

  Future<void> _delete(ContactRow contact) async {
    final l10n = context.l10n;
    final ok = await confirm(
      context,
      title: l10n.contactDeleteTitle(1),
      message: l10n.contactDeleteMessage(1, contactName(contact)),
      confirmLabel: l10n.delete,
      destructive: true,
    );
    if (!ok || !mounted) return;
    await ref.read(recordStoreProvider).delete(SyncEntities.contacts, [
      contact.id,
    ]);
    ref.read(toastProvider).success(l10n.contactDeleted(1));
    ref
        .read(workTabsProvider.notifier)
        .close('${Routes.contacts}/${contact.id}', current: null);
    if (mounted) context.go(Routes.contacts);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final async = ref.watch(contactsProvider);
    final contact = ref.watch(contactByIdProvider)[widget.id];
    if (contact == null) {
      return async.isLoading
          ? const SkeletonRows()
          : EmptyState(
              icon: LucideIcons.searchX,
              title: l10n.recordNotFound,
              action: VButton(
                label: l10n.navContacts,
                onPressed: () => context.go(Routes.contacts),
              ),
            );
    }
    final name = contactName(contact);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref
          .read(workTabsProvider.notifier)
          .open(
            WorkTab(
              route: '${Routes.contacts}/${contact.id}',
              title: name,
              kind: WorkTabKind.contact,
            ),
          );
    });

    final canWrite = ref.watch(permissionProvider(Permission.contactWrite));
    final organisation = ref.watch(
      organisationByIdProvider,
    )[contact.organisationId];
    final positions = [
      for (final p
          in ref.watch(positionsProvider).value ?? const <PositionRow>[])
        if (p.contactId == contact.id) p,
    ];
    final deals = [
      for (final d in ref.watch(dealsProvider).value ?? const <DealRow>[])
        if (d.contactId == contact.id) d,
    ];
    bool activityFilter(ActivityRow a) => a.contactId == contact.id;
    bool fileFilter(AttachmentRow f) => f.contactId == contact.id;
    final activityCount = (ref.watch(activitiesProvider).value ?? const [])
        .where(activityFilter)
        .length;
    final fileCount = (ref.watch(attachmentsProvider).value ?? const [])
        .where(fileFilter)
        .length;

    return CallbackShortcuts(
      bindings: {
        if (canWrite)
          const SingleActivator(LogicalKeyboardKey.keyE, control: true): () =>
              unawaited(showContactForm(context, ref, contact: contact)),
      },
      child: Focus(
        autofocus: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RecordHeader(
              icon: LucideIcons.user,
              title: [contact.civility, name].whereType<String>().join(' '),
              subtitle: [
                contact.jobTitle,
                organisation?.name,
              ].whereType<String>().join(' · '),
              actions: [
                if (organisation != null)
                  VButton.ghost(
                    label: organisation.name,
                    icon: LucideIcons.building2,
                    onPressed: () => context.go(
                      '${Routes.organisations}/${organisation.id}',
                    ),
                  ),
                if (canWrite)
                  VButton(
                    label: l10n.edit,
                    icon: LucideIcons.pencil,
                    shortcut: 'Ctrl E',
                    onPressed: () => unawaited(
                      showContactForm(context, ref, contact: contact),
                    ),
                  ),
                if (canWrite)
                  VIconButton(
                    icon: LucideIcons.trash2,
                    tooltip: l10n.delete,
                    onPressed: () => unawaited(_delete(contact)),
                  ),
              ],
              below: Row(
                children: [
                  if (contact.doNotContact == true) ...[
                    VBadge(
                      l10n.contactDoNotContactShort,
                      tone: VTone.danger,
                      icon: LucideIcons.ban,
                    ),
                    const SizedBox(width: VSpace.x3),
                  ],
                  Expanded(
                    child: RecordTags(
                      entity: CrmEntity.contacts,
                      recordId: contact.id,
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
                  l10n.tabPositions,
                  icon: LucideIcons.briefcase,
                  count: positions.length,
                ),
                VTab(
                  l10n.tabDeals,
                  icon: LucideIcons.handCoins,
                  count: deals.length,
                ),
                VTab(
                  l10n.tabActivities,
                  icon: LucideIcons.history,
                  count: activityCount,
                ),
                VTab(
                  l10n.tabFiles,
                  icon: LucideIcons.paperclip,
                  count: fileCount,
                ),
              ],
            ),
            Expanded(
              child: switch (_tab) {
                0 => _Overview(contact: contact),
                1 => _PositionsTab(contact: contact, positions: positions),
                2 => DealsList(
                  deals: deals,
                  onCreate: () => unawaited(
                    showDealForm(
                      context,
                      ref,
                      contactId: contact.id,
                      organisationId: contact.organisationId,
                    ),
                  ),
                ),
                3 => ActivityTimeline(
                  filter: activityFilter,
                  contactId: contact.id,
                  organisationId: contact.organisationId,
                ),
                _ => AttachmentsPanel(
                  filter: fileFilter,
                  contactId: contact.id,
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Overview extends ConsumerWidget {
  const _Overview({required this.contact});

  final ContactRow contact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = contact;
    final customFields = ref.watch(customFieldsForProvider(CrmEntity.contacts));
    final customValues = decodeCustomValues(c.customFields);

    Widget link(String? value, String scheme) => value == null
        ? const Text('—')
        : VLink(
            value,
            onPressed: () =>
                unawaited(launchUrl(Uri(scheme: scheme, path: value))),
          );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(VSpace.x6),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Column(
          children: [
            RecordSection(
              title: l10n.orgSectionContact,
              children: [
                VInfoRow(l10n.orgEmail, null, child: link(c.email, 'mailto')),
                VInfoRow(l10n.orgPhone, null, child: link(c.phone, 'tel')),
                VInfoRow(
                  l10n.contactMobile,
                  null,
                  child: link(c.mobile, 'tel'),
                ),
                VInfoRow(l10n.contactJobTitle, c.jobTitle),
                VInfoRow(
                  l10n.contactService,
                  enumByKey(ContactService.values, c.service)?.label,
                ),
              ],
            ),
            if (c.notes != null)
              RecordSection(
                title: l10n.contactNotes,
                children: [SelectableText(c.notes!, style: context.text.body)],
              ),
            if (customFields.isNotEmpty)
              RecordSection(
                title: l10n.customFieldsTitle,
                children: [
                  for (final f in customFields)
                    VInfoRow(
                      f.label,
                      formatCustomValue(f, customValues[f.key]),
                    ),
                ],
              ),
            RecordSection(
              title: l10n.orgSectionTraceability,
              children: [
                VInfoRow(l10n.orgSource, c.source),
                VInfoRow(
                  l10n.orgCollectedAt,
                  c.collectedAt == null ? null : formatDateTime(c.collectedAt!),
                ),
                VInfoRow(l10n.metaCreated, formatDateTime(c.createdAt)),
                VInfoRow(l10n.metaUpdated, formatDateTime(c.updatedAt)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PositionsTab extends ConsumerWidget {
  const _PositionsTab({required this.contact, required this.positions});

  final ContactRow contact;
  final List<PositionRow> positions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final c = context.colors;
    final t = context.text;
    final canWrite = ref.watch(permissionProvider(Permission.contactWrite));
    final organisations = ref.watch(organisationByIdProvider);

    return ListView(
      padding: const EdgeInsets.all(VSpace.x4),
      children: [
        if (canWrite)
          Wrap(
            spacing: VSpace.x2,
            children: [
              VButton.primary(
                label: l10n.positionAddElected,
                icon: LucideIcons.award,
                size: VButtonSize.sm,
                onPressed: () => unawaited(
                  showPositionForm(
                    context,
                    ref,
                    contactId: contact.id,
                    organisationId: contact.organisationId,
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
                    contactId: contact.id,
                    organisationId: contact.organisationId,
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(height: VSpace.x3),
        if (positions.isEmpty)
          EmptyState(icon: LucideIcons.briefcase, title: l10n.positionsEmpty),
        for (final p in positions)
          Pressable(
            onPressed: canWrite
                ? () => unawaited(showPositionForm(context, ref, position: p))
                : null,
            builder: (context, s) => AnimatedContainer(
              duration: VMotion.fast,
              margin: const EdgeInsets.only(bottom: VSpace.x1_5),
              padding: const EdgeInsets.all(VSpace.x3),
              decoration: BoxDecoration(
                color: s.hovered ? c.surfaceHover : c.surface,
                borderRadius: VRadius.mdAll,
                border: Border.all(color: c.border),
              ),
              child: Row(
                children: [
                  Icon(
                    p.isElected ? LucideIcons.award : LucideIcons.briefcase,
                    size: 16,
                    color: c.textMuted,
                  ),
                  const SizedBox(width: VSpace.x3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          [
                            if (p.isElected)
                              enumByKey(
                                MandateRole.values,
                                p.mandateRole,
                              )?.label
                            else
                              p.jobTitle,
                            p.delegation,
                          ].whereType<String>().join(' — '),
                          style: t.bodyStrong,
                        ),
                        Text(
                          organisations[p.organisationId]?.name ?? '—',
                          style: t.small,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    [
                      if (p.startDate != null) formatDay(p.startDate),
                      if (p.endDate != null) formatDay(p.endDate),
                    ].join(' → '),
                    style: t.small,
                  ),
                  if (p.isElected) ...[
                    const SizedBox(width: VSpace.x2),
                    VBadge(l10n.positionElected, tone: VTone.accent),
                  ],
                  VIconButton(
                    icon: LucideIcons.building2,
                    tooltip: l10n.contactOrganisation,
                    size: VButtonSize.sm,
                    onPressed: () => context.go(
                      '${Routes.organisations}/${p.organisationId}',
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
