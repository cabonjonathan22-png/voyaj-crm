import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/router.dart';
import '../../../data/local/database.dart';
import '../../../design_system/design_system.dart';
import '../crm_data.dart';
import '../crm_format.dart';
import '../widgets/crm_table.dart';

/// Mandat en cours affiché dans la liste des élus.
typedef ElectedRow = ({
  PositionRow position,
  ContactRow contact,
  OrganisationRow? organisation,
});

/// Élus : mandats en cours (postes électifs sans date de fin passée).
class ElectedPage extends ConsumerWidget {
  const ElectedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final contacts = ref.watch(contactByIdProvider);
    final organisations = ref.watch(organisationByIdProvider);
    final async = ref.watch(positionsProvider);
    final today = formatDateOnly(DateTime.now());
    final rows = <ElectedRow>[
      for (final p in async.value ?? const <PositionRow>[])
        if (p.isElected &&
            (p.endDate == null || p.endDate!.compareTo(today) >= 0) &&
            contacts[p.contactId] != null)
          (
            position: p,
            contact: contacts[p.contactId]!,
            organisation: organisations[p.organisationId],
          ),
    ];
    final tagsByRecord = ref.watch(tagsByRecordProvider);

    final columns = <VColumn<ElectedRow>>[
      VColumn(
        id: 'name',
        label: l10n.contactName,
        width: 220,
        hideable: false,
        sortValue: (r) =>
            searchText('${r.contact.lastName} ${r.contact.firstName}'),
        filterValue: (r) => contactName(r.contact),
        cell: (context, r) => Row(
          children: [
            VAvatar(contactName(r.contact), size: 22),
            const SizedBox(width: VSpace.x2),
            Flexible(
              child: Text(
                contactName(r.contact),
                overflow: TextOverflow.ellipsis,
                style: context.text.bodyStrong,
              ),
            ),
          ],
        ),
      ),
      VColumn(
        id: 'mandate',
        label: l10n.positionMandate,
        width: 200,
        sortValue: (r) => MandateRole.values.indexWhere(
          (m) => m.key == r.position.mandateRole,
        ),
        filterValue: (r) =>
            enumByKey(MandateRole.values, r.position.mandateRole)?.label,
        cell: (context, r) => Text(
          enumByKey(MandateRole.values, r.position.mandateRole)?.label ?? '',
          style: context.text.body,
        ),
      ),
      VColumn(
        id: 'delegation',
        label: l10n.positionDelegation,
        width: 220,
        flex: true,
        sortValue: (r) => searchText(r.position.delegation),
        filterValue: (r) => r.position.delegation,
        cell: (context, r) => Text(
          r.position.delegation ?? '',
          overflow: TextOverflow.ellipsis,
          style: context.text.body,
        ),
      ),
      VColumn(
        id: 'organisation',
        label: l10n.contactOrganisation,
        width: 220,
        sortValue: (r) => searchText(r.organisation?.name),
        filterValue: (r) => r.organisation?.name,
        cell: (context, r) => Text(
          r.organisation?.name ?? '',
          overflow: TextOverflow.ellipsis,
          style: context.text.body,
        ),
      ),
      VColumn(
        id: 'departement',
        label: l10n.orgDepartementShort,
        width: 80,
        sortValue: (r) => r.organisation?.departementCode,
        filterValue: (r) => r.organisation?.departementCode,
        cell: (context, r) => Text(
          r.organisation?.departementCode ?? '',
          style: context.text.body,
        ),
      ),
      VColumn(
        id: 'start',
        label: l10n.positionStart,
        width: 110,
        sortValue: (r) => r.position.startDate,
        filterValue: (r) => formatDay(r.position.startDate),
        cell: (context, r) =>
            Text(formatDay(r.position.startDate), style: context.text.body),
      ),
      VColumn(
        id: 'email',
        label: l10n.orgEmail,
        width: 200,
        filterValue: (r) => r.contact.email,
        cell: (context, r) => Text(
          r.contact.email ?? '',
          overflow: TextOverflow.ellipsis,
          style: context.text.body,
        ),
      ),
      tagsColumn(l10n.navTags, tagsByRecord, (r) => r.contact.id),
    ];

    return Column(
      children: [
        PageHeader(
          title: l10n.navElected,
          subtitle: l10n.electedSubtitle,
          icon: LucideIcons.award,
        ),
        Expanded(
          child: CrmTable<ElectedRow>(
            tableId: 'elected',
            entity: null,
            rows: rows,
            columns: columns,
            rowId: (r) => r.position.id,
            loading: async.isLoading,
            exportName: 'elus',
            onOpen: (r) => context.go('${Routes.contacts}/${r.contact.id}'),
            empty: EmptyState(
              icon: LucideIcons.award,
              title: l10n.electedEmptyTitle,
              message: l10n.electedEmptyMessage,
            ),
          ),
        ),
      ],
    );
  }
}
