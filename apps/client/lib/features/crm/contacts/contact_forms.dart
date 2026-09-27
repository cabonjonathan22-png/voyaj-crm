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

/// Civilités proposées.
const civilities = ['M.', 'Mme'];

/// Création ([contact] `null`) ou modification d'un contact.
Future<String?> showContactForm(
  BuildContext context,
  WidgetRef ref, {
  ContactRow? contact,
  String? organisationId,
}) {
  final l10n = context.l10n;
  return showRecordForm(
    context,
    schema: SyncEntities.contacts,
    title: contact == null ? l10n.contactNew : l10n.contactEdit,
    icon: LucideIcons.user,
    id: contact?.id,
    customFieldsOf: CrmEntity.contacts,
    initial: contact == null
        ? {
            'organisation_id': organisationId,
            'owner_id': ref.read(currentUserProvider)?.id,
          }
        : rowToWire(SyncEntities.contacts, contact),
    fields: [
      ChoiceFieldDef('civility', l10n.contactCivility, [
        for (final c in civilities) VSelectOption(c, c),
      ]),
      TextFieldDef('first_name', l10n.contactFirstName, autofocus: true),
      TextFieldDef('last_name', l10n.contactLastName),
      RefFieldDef(
        'organisation_id',
        l10n.contactOrganisation,
        organisationOptions(ref.read(organisationsProvider).value ?? const []),
      ),
      TextFieldDef('job_title', l10n.contactJobTitle),
      ChoiceFieldDef(
        'service',
        l10n.contactService,
        enumOptions(ContactService.values),
      ),
      SectionDef(l10n.orgSectionContact),
      TextFieldDef('email', l10n.orgEmail),
      TextFieldDef('phone', l10n.orgPhone),
      TextFieldDef('mobile', l10n.contactMobile),
      BoolFieldDef('do_not_contact', l10n.contactDoNotContact),
      TextFieldDef('notes', l10n.contactNotes, wide: true, maxLines: 5),
    ],
  );
}

/// Création ou modification d'un poste / mandat.
Future<String?> showPositionForm(
  BuildContext context,
  WidgetRef ref, {
  PositionRow? position,
  String? contactId,
  String? organisationId,
  bool elected = false,
}) {
  final l10n = context.l10n;
  return showRecordForm(
    context,
    schema: SyncEntities.positions,
    title: position == null ? l10n.positionNew : l10n.positionEdit,
    icon: LucideIcons.briefcase,
    id: position?.id,
    initial: position == null
        ? {
            'contact_id': contactId,
            'organisation_id': organisationId,
            'is_elected': elected,
          }
        : rowToWire(SyncEntities.positions, position),
    fields: [
      RefFieldDef(
        'contact_id',
        l10n.positionContact,
        contactOptions(
          ref.read(contactsProvider).value ?? const [],
          ref.read(organisationByIdProvider),
        ),
      ),
      RefFieldDef(
        'organisation_id',
        l10n.contactOrganisation,
        organisationOptions(ref.read(organisationsProvider).value ?? const []),
      ),
      TextFieldDef('job_title', l10n.contactJobTitle),
      ChoiceFieldDef(
        'service',
        l10n.contactService,
        enumOptions(ContactService.values),
      ),
      BoolFieldDef('is_elected', l10n.positionIsElected),
      ChoiceFieldDef(
        'mandate_role',
        l10n.positionMandate,
        enumOptions(MandateRole.values),
      ),
      TextFieldDef('delegation', l10n.positionDelegation),
      DateFieldDef('start_date', l10n.positionStart),
      DateFieldDef('end_date', l10n.positionEnd),
    ],
  );
}
