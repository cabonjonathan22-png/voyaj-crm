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
import 'organisation_form.dart';

/// Liste des organisations (collectivités, festivals, partenaires…).
class OrganisationsPage extends ConsumerStatefulWidget {
  const OrganisationsPage({super.key, this.create = false});

  /// Ouvre directement le formulaire de création (`?new=1`).
  final bool create;

  @override
  ConsumerState<OrganisationsPage> createState() => _OrganisationsPageState();
}

class _OrganisationsPageState extends ConsumerState<OrganisationsPage> {
  final _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.create) {
      WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(_create()));
    }
  }

  @override
  void didUpdateWidget(covariant OrganisationsPage oldWidget) {
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
    final id = await showOrganisationForm(context, ref);
    if (!mounted) return;
    if (id == null) {
      // Formulaire ouvert par `?new=1` : l'URL revient à la liste.
      if (widget.create) context.go(Routes.organisations);
      return;
    }
    ref.read(toastProvider).success(context.l10n.organisationCreated);
    context.go('${Routes.organisations}/$id');
  }

  Future<void> _delete(Set<String> ids) async {
    final l10n = context.l10n;
    final byId = ref.read(organisationByIdProvider);
    final ok = await confirm(
      context,
      title: l10n.organisationDeleteTitle(ids.length),
      message: l10n.organisationDeleteMessage(
        ids.length,
        ids.map((id) => byId[id]?.name ?? '').take(3).join(', '),
      ),
      confirmLabel: l10n.delete,
      destructive: true,
    );
    if (!ok || !mounted) return;
    await ref.read(recordStoreProvider).delete(SyncEntities.organisations, ids);
    ref.read(toastProvider).success(l10n.organisationDeleted(ids.length));
  }

  List<VColumn<OrganisationRow>> _columns() {
    final l10n = context.l10n;
    final byId = ref.watch(organisationByIdProvider);
    final tagsByRecord = ref.watch(tagsByRecordProvider);
    final contactCount = <String, int>{};
    for (final c in ref.watch(contactsProvider).value ?? const <ContactRow>[]) {
      if (c.organisationId != null) {
        contactCount.update(c.organisationId!, (n) => n + 1, ifAbsent: () => 1);
      }
    }
    final pending =
        ref.watch(pendingIdsProvider(SyncEntities.organisations.name)).value ??
        const <String>{};

    return [
      VColumn(
        id: 'name',
        label: l10n.orgName,
        width: 260,
        hideable: false,
        sortValue: (o) => searchText(o.name),
        filterValue: (o) => o.name,
        cell: (context, o) => Row(
          children: [
            Icon(
              kindIcon(enumByKey(OrganisationKind.values, o.kind)),
              size: 14,
              color: context.colors.textMuted,
            ),
            const SizedBox(width: VSpace.x2),
            Flexible(
              child: Text(
                o.name,
                overflow: TextOverflow.ellipsis,
                style: context.text.bodyStrong,
              ),
            ),
            if (pending.contains(o.id)) ...[
              const SizedBox(width: VSpace.x1_5),
              Tooltip(
                message: l10n.syncStatePending,
                child: Icon(
                  LucideIcons.cloudUpload,
                  size: 12,
                  color: context.colors.warning,
                ),
              ),
            ],
          ],
        ),
      ),
      VColumn(
        id: 'kind',
        label: l10n.orgKind,
        width: 170,
        sortValue: (o) => enumByKey(OrganisationKind.values, o.kind)?.label,
        filterValue: (o) => enumByKey(OrganisationKind.values, o.kind)?.label,
        cell: (context, o) => Text(
          enumByKey(OrganisationKind.values, o.kind)?.label ?? o.kind,
          overflow: TextOverflow.ellipsis,
          style: context.text.body,
        ),
      ),
      VColumn(
        id: 'status',
        label: l10n.orgStatus,
        width: 140,
        sortValue: (o) =>
            OrganisationStatus.values.indexWhere((s) => s.key == o.status),
        filterValue: (o) =>
            enumByKey(OrganisationStatus.values, o.status)?.label,
        cell: (context, o) {
          final status = enumByKey(OrganisationStatus.values, o.status);
          return VBadge(status?.label ?? o.status, tone: statusTone(status));
        },
      ),
      VColumn(
        id: 'city',
        label: l10n.orgCity,
        width: 160,
        sortValue: (o) => searchText(o.city),
        filterValue: (o) => o.city,
        cell: (context, o) => Text(o.city ?? '', style: context.text.body),
      ),
      VColumn(
        id: 'departement',
        label: l10n.orgDepartementShort,
        width: 80,
        sortValue: (o) => o.departementCode,
        filterValue: (o) => o.departementCode,
        cell: (context, o) =>
            Text(o.departementCode ?? '', style: context.text.body),
      ),
      VColumn(
        id: 'region',
        label: l10n.orgRegion,
        width: 170,
        sortValue: (o) => frenchRegions[o.regionCode],
        filterValue: (o) => frenchRegions[o.regionCode],
        cell: (context, o) => Text(
          frenchRegions[o.regionCode] ?? '',
          overflow: TextOverflow.ellipsis,
          style: context.text.body,
        ),
      ),
      VColumn(
        id: 'population',
        label: l10n.orgPopulation,
        width: 110,
        alignEnd: true,
        sortValue: (o) => o.population,
        filterValue: (o) => o.population?.toString(),
        cell: (context, o) =>
            Text(formatInteger(o.population), style: context.text.numeric),
      ),
      VColumn(
        id: 'parent',
        label: l10n.orgParent,
        width: 180,
        sortValue: (o) => byId[o.parentId]?.name,
        filterValue: (o) => byId[o.parentId]?.name,
        cell: (context, o) => Text(
          byId[o.parentId]?.name ?? '',
          overflow: TextOverflow.ellipsis,
          style: context.text.body,
        ),
      ),
      VColumn(
        id: 'contacts',
        label: l10n.navContacts,
        width: 90,
        alignEnd: true,
        sortValue: (o) => contactCount[o.id] ?? 0,
        cell: (context, o) =>
            Text('${contactCount[o.id] ?? ''}', style: context.text.numeric),
      ),
      tagsColumn(l10n.navTags, tagsByRecord, (o) => o.id),
      VColumn(
        id: 'email',
        label: l10n.orgEmail,
        width: 200,
        filterValue: (o) => o.email,
        sortValue: (o) => o.email,
        cell: (context, o) => Text(
          o.email ?? '',
          overflow: TextOverflow.ellipsis,
          style: context.text.body,
        ),
      ),
      VColumn(
        id: 'phone',
        label: l10n.orgPhone,
        width: 140,
        filterValue: (o) => o.phone,
        cell: (context, o) => Text(o.phone ?? '', style: context.text.body),
      ),
      VColumn(
        id: 'siren',
        label: l10n.orgSiren,
        width: 110,
        filterValue: (o) => o.siren,
        cell: (context, o) => Text(o.siren ?? '', style: context.text.mono),
      ),
      ...customFieldColumns<OrganisationRow>(
        ref.watch(customFieldsForProvider(CrmEntity.organisations)),
        (o) => o.customFields,
      ),
      VColumn(
        id: 'updated',
        label: l10n.tagUpdated,
        width: 140,
        sortValue: (o) => o.updatedAt,
        cell: (context, o) => Tooltip(
          message: formatDateTime(o.updatedAt),
          child: Text(formatRelative(o.updatedAt), style: context.text.small),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final canWrite = ref.watch(
      permissionProvider(Permission.organisationWrite),
    );
    final canImport = ref.watch(permissionProvider(Permission.dataImport));
    final async = ref.watch(organisationsProvider);
    final organisations = async.value ?? const <OrganisationRow>[];

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
            title: l10n.navOrganisations,
            subtitle: l10n.organisationsSubtitle,
            icon: LucideIcons.building2,
            actions: [
              VButton.ghost(
                label: l10n.navMap,
                icon: LucideIcons.map,
                onPressed: () => context.go(Routes.map),
              ),
              if (canImport && canWrite)
                VButton(
                  label: l10n.importCsv,
                  icon: LucideIcons.upload,
                  onPressed: () => unawaited(
                    showImportWizard(context, CrmEntity.organisations),
                  ),
                ),
              if (canWrite)
                VButton.primary(
                  label: l10n.organisationNew,
                  icon: LucideIcons.plus,
                  shortcut: 'Ctrl N',
                  onPressed: () => unawaited(_create()),
                ),
            ],
          ),
          Expanded(
            child: CrmTable<OrganisationRow>(
              tableId: 'organisations',
              entity: CrmEntity.organisations,
              rows: organisations,
              columns: _columns(),
              rowId: (o) => o.id,
              loading: async.isLoading,
              searchFocusNode: _searchFocus,
              exportName: 'organisations',
              onOpen: (o) => context.go('${Routes.organisations}/${o.id}'),
              onDelete: canWrite ? _delete : null,
              empty: EmptyState(
                icon: LucideIcons.building2,
                title: l10n.organisationsEmptyTitle,
                message: l10n.organisationsEmptyMessage,
                action: canWrite
                    ? VButton.primary(
                        label: l10n.organisationNew,
                        icon: LucideIcons.plus,
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
