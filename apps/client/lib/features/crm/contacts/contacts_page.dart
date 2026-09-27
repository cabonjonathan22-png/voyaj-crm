import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import '../import/import_wizard.dart';
import '../widgets/crm_table.dart';
import 'contact_forms.dart';

/// Liste des contacts.
class ContactsPage extends ConsumerStatefulWidget {
  const ContactsPage({super.key, this.create = false});

  final bool create;

  @override
  ConsumerState<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends ConsumerState<ContactsPage> {
  final _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.create) {
      WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(_create()));
    }
  }

  @override
  void didUpdateWidget(covariant ContactsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.create && !oldWidget.create) {
      WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(_create()));
    }
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    final id = await showContactForm(context, ref);
    if (!mounted) return;
    if (id == null) {
      // Formulaire ouvert par `?new=1` : l'URL revient à la liste.
      if (widget.create) context.go(Routes.contacts);
      return;
    }
    ref.read(toastProvider).success(context.l10n.contactCreated);
    context.go('${Routes.contacts}/$id');
  }

  Future<void> _delete(Set<String> ids) async {
    final l10n = context.l10n;
    final byId = ref.read(contactByIdProvider);
    final ok = await confirm(
      context,
      title: l10n.contactDeleteTitle(ids.length),
      message: l10n.contactDeleteMessage(
        ids.length,
        ids
            .map((id) => byId[id] == null ? '' : contactName(byId[id]!))
            .take(3)
            .join(', '),
      ),
      confirmLabel: l10n.delete,
      destructive: true,
    );
    if (!ok || !mounted) return;
    await ref.read(recordStoreProvider).delete(SyncEntities.contacts, ids);
    ref.read(toastProvider).success(l10n.contactDeleted(ids.length));
  }

  List<VColumn<ContactRow>> _columns() {
    final l10n = context.l10n;
    final organisations = ref.watch(organisationByIdProvider);
    final tagsByRecord = ref.watch(tagsByRecordProvider);
    final elected = {
      for (final p
          in ref.watch(positionsProvider).value ?? const <PositionRow>[])
        if (p.isElected && p.endDate == null) p.contactId,
    };
    return [
      VColumn(
        id: 'name',
        label: l10n.contactName,
        width: 220,
        hideable: false,
        sortValue: (c) => searchText('${c.lastName} ${c.firstName ?? ''}'),
        filterValue: contactName,
        cell: (context, c) => Row(
          children: [
            VAvatar(contactName(c), size: 22),
            const SizedBox(width: VSpace.x2),
            Flexible(
              child: Text(
                contactName(c),
                overflow: TextOverflow.ellipsis,
                style: context.text.bodyStrong,
              ),
            ),
            if (elected.contains(c.id)) ...[
              const SizedBox(width: VSpace.x1_5),
              Tooltip(
                message: l10n.positionElected,
                child: Icon(
                  LucideIcons.award,
                  size: 13,
                  color: context.colors.accentText,
                ),
              ),
            ],
          ],
        ),
      ),
      VColumn(
        id: 'organisation',
        label: l10n.contactOrganisation,
        width: 220,
        sortValue: (c) => searchText(organisations[c.organisationId]?.name),
        filterValue: (c) => organisations[c.organisationId]?.name,
        cell: (context, c) => Text(
          organisations[c.organisationId]?.name ?? '',
          overflow: TextOverflow.ellipsis,
          style: context.text.body,
        ),
      ),
      VColumn(
        id: 'job',
        label: l10n.contactJobTitle,
        width: 180,
        sortValue: (c) => searchText(c.jobTitle),
        filterValue: (c) => c.jobTitle,
        cell: (context, c) => Text(
          c.jobTitle ?? '',
          overflow: TextOverflow.ellipsis,
          style: context.text.body,
        ),
      ),
      VColumn(
        id: 'service',
        label: l10n.contactService,
        width: 160,
        sortValue: (c) => enumByKey(ContactService.values, c.service)?.label,
        filterValue: (c) => enumByKey(ContactService.values, c.service)?.label,
        cell: (context, c) => Text(
          enumByKey(ContactService.values, c.service)?.label ?? '',
          overflow: TextOverflow.ellipsis,
          style: context.text.body,
        ),
      ),
      VColumn(
        id: 'email',
        label: l10n.orgEmail,
        width: 220,
        sortValue: (c) => c.email,
        filterValue: (c) => c.email,
        cell: (context, c) => Text(
          c.email ?? '',
          overflow: TextOverflow.ellipsis,
          style: context.text.body,
        ),
      ),
      VColumn(
        id: 'phone',
        label: l10n.orgPhone,
        width: 140,
        filterValue: (c) => c.phone,
        cell: (context, c) => Text(c.phone ?? '', style: context.text.body),
      ),
      VColumn(
        id: 'mobile',
        label: l10n.contactMobile,
        width: 140,
        filterValue: (c) => c.mobile,
        cell: (context, c) => Text(c.mobile ?? '', style: context.text.body),
      ),
      VColumn(
        id: 'city',
        label: l10n.orgCity,
        width: 140,
        sortValue: (c) => organisations[c.organisationId]?.city,
        filterValue: (c) => organisations[c.organisationId]?.city,
        cell: (context, c) => Text(
          organisations[c.organisationId]?.city ?? '',
          style: context.text.body,
        ),
      ),
      tagsColumn(l10n.navTags, tagsByRecord, (c) => c.id),
      VColumn(
        id: 'do_not_contact',
        label: l10n.contactDoNotContactShort,
        width: 150,
        minWidth: 150,
        sortValue: (c) => c.doNotContact == true ? 0 : 1,
        filterValue: (c) => c.doNotContact == true ? l10n.yes : l10n.no,
        cell: (context, c) => c.doNotContact == true
            ? VBadge(l10n.contactDoNotContactShort, tone: VTone.danger)
            : const SizedBox.shrink(),
      ),
      ...customFieldColumns<ContactRow>(
        ref.watch(customFieldsForProvider(CrmEntity.contacts)),
        (c) => c.customFields,
      ),
      VColumn(
        id: 'updated',
        label: l10n.tagUpdated,
        width: 140,
        sortValue: (c) => c.updatedAt,
        cell: (context, c) => Tooltip(
          message: formatDateTime(c.updatedAt),
          child: Text(formatRelative(c.updatedAt), style: context.text.small),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canWrite = ref.watch(permissionProvider(Permission.contactWrite));
    final canImport = ref.watch(permissionProvider(Permission.dataImport));
    final async = ref.watch(contactsProvider);

    return CallbackShortcuts(
      bindings: {
        if (canWrite)
          const SingleActivator(LogicalKeyboardKey.keyN, control: true): () =>
              unawaited(_create()),
        const SingleActivator(LogicalKeyboardKey.keyF, control: true):
            _searchFocus.requestFocus,
      },
      child: Column(
        children: [
          PageHeader(
            title: l10n.navContacts,
            subtitle: l10n.contactsSubtitle,
            icon: LucideIcons.users,
            actions: [
              if (canImport && canWrite)
                VButton(
                  label: l10n.importCsv,
                  icon: LucideIcons.upload,
                  onPressed: () =>
                      unawaited(showImportWizard(context, CrmEntity.contacts)),
                ),
              if (canWrite)
                VButton.primary(
                  label: l10n.contactNew,
                  icon: LucideIcons.userPlus,
                  shortcut: 'Ctrl N',
                  onPressed: () => unawaited(_create()),
                ),
            ],
          ),
          Expanded(
            child: CrmTable<ContactRow>(
              tableId: 'contacts',
              entity: CrmEntity.contacts,
              rows: async.value ?? const [],
              columns: _columns(),
              rowId: (c) => c.id,
              loading: async.isLoading,
              searchFocusNode: _searchFocus,
              exportName: 'contacts',
              onOpen: (c) => context.go('${Routes.contacts}/${c.id}'),
              onDelete: canWrite ? _delete : null,
              extraMenu: (c) => [
                if (c.email != null)
                  VMenuItem(
                    label: l10n.copyEmail,
                    icon: LucideIcons.copy,
                    onSelected: () =>
                        Clipboard.setData(ClipboardData(text: c.email!)),
                  ),
              ],
              empty: EmptyState(
                icon: LucideIcons.users,
                title: l10n.contactsEmptyTitle,
                message: l10n.contactsEmptyMessage,
                action: canWrite
                    ? VButton.primary(
                        label: l10n.contactNew,
                        icon: LucideIcons.userPlus,
                        onPressed: () => unawaited(_create()),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
