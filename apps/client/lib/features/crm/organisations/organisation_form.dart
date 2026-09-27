import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../../app/app.dart';
import '../../../app/providers.dart';
import '../../../data/local/database.dart';
import '../../../data/sync/local_entities.dart';
import '../../../design_system/design_system.dart';
import '../crm_data.dart';
import '../widgets/record_form.dart';

/// Création ([organisation] `null`) ou modification d'une organisation.
Future<String?> showOrganisationForm(
  BuildContext context,
  WidgetRef ref, {
  OrganisationRow? organisation,
  Map<String, Object?> initial = const {},
}) {
  final l10n = context.l10n;
  final organisations = ref.read(organisationsProvider).value ?? const [];
  return showRecordForm(
    context,
    schema: SyncEntities.organisations,
    title: organisation == null ? l10n.organisationNew : l10n.organisationEdit,
    icon: LucideIcons.building2,
    id: organisation?.id,
    customFieldsOf: CrmEntity.organisations,
    width: 720,
    initial: organisation == null
        ? {
            'kind': OrganisationKind.commune.key,
            'status': OrganisationStatus.aProspecter.key,
            'owner_id': ref.read(currentUserProvider)?.id,
            ...initial,
          }
        : rowToWire(SyncEntities.organisations, organisation),
    fields: [
      TextFieldDef('name', l10n.orgName, wide: true, autofocus: true),
      ChoiceFieldDef(
        'kind',
        l10n.orgKind,
        enumOptions(OrganisationKind.values),
        clearable: false,
      ),
      ChoiceFieldDef(
        'status',
        l10n.orgStatus,
        enumOptions(OrganisationStatus.values),
        clearable: false,
      ),
      RefFieldDef(
        'parent_id',
        l10n.orgParent,
        organisationOptions(organisations, exclude: organisation?.id),
        wide: true,
      ),
      SectionDef(l10n.orgSectionContact),
      TextFieldDef('phone', l10n.orgPhone),
      TextFieldDef('email', l10n.orgEmail),
      TextFieldDef('website', l10n.orgWebsite, wide: true, hint: 'https://'),
      SectionDef(l10n.orgSectionAddress),
      TextFieldDef('address', l10n.orgAddress, wide: true),
      TextFieldDef('postal_code', l10n.orgPostalCode),
      TextFieldDef('city', l10n.orgCity),
      TextFieldDef('departement_code', l10n.orgDepartement),
      ChoiceFieldDef('region_code', l10n.orgRegion, [
        for (final MapEntry(:key, :value) in frenchRegions.entries)
          VSelectOption(key, value),
      ]),
      NumberFieldDef('latitude', l10n.orgLatitude, decimal: true),
      NumberFieldDef('longitude', l10n.orgLongitude, decimal: true),
      SectionDef(l10n.orgSectionIdentity),
      TextFieldDef('siren', l10n.orgSiren),
      TextFieldDef('siret', l10n.orgSiret),
      TextFieldDef('insee_code', l10n.orgInsee),
      NumberFieldDef('population', l10n.orgPopulation),
      TextFieldDef('description', l10n.orgDescription, wide: true, maxLines: 5),
    ],
  );
}
