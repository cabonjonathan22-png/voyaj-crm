import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:voyaj_shared/voyaj_shared.dart';

import '../../data/local/database.dart';
import '../../design_system/design_system.dart';

/// Nom affiché d'un contact (« Anne Durand »).
String contactName(ContactRow c) =>
    [c.firstName, c.lastName].whereType<String>().join(' ');

/// Couleur d'un statut d'organisation (badges, carte).
VTone statusTone(OrganisationStatus? status) => switch (status) {
  OrganisationStatus.contacte => VTone.info,
  OrganisationStatus.enDiscussion => VTone.warning,
  OrganisationStatus.partenaire => VTone.accent,
  OrganisationStatus.client => VTone.success,
  OrganisationStatus.perdu => VTone.danger,
  OrganisationStatus.aProspecter ||
  OrganisationStatus.inactif ||
  null => VTone.neutral,
};

/// Icône d'un type d'organisation.
IconData kindIcon(OrganisationKind? kind) => switch (kind) {
  OrganisationKind.commune => LucideIcons.landmark,
  OrganisationKind.epci || OrganisationKind.metropole => LucideIcons.network,
  OrganisationKind.departement || OrganisationKind.region => LucideIcons.map,
  OrganisationKind.aom => LucideIcons.bus,
  OrganisationKind.syndicat => LucideIcons.handshake,
  OrganisationKind.festival => LucideIcons.music,
  OrganisationKind.entreprise => LucideIcons.building2,
  OrganisationKind.association => LucideIcons.heartHandshake,
  OrganisationKind.officeTourisme => LucideIcons.mapPin,
  OrganisationKind.autre || null => LucideIcons.building,
};

/// Icône d'un type d'activité.
IconData activityIcon(ActivityKind? kind) => switch (kind) {
  ActivityKind.note => LucideIcons.stickyNote,
  ActivityKind.call => LucideIcons.phone,
  ActivityKind.meeting => LucideIcons.calendarDays,
  ActivityKind.task => LucideIcons.squareCheck,
  ActivityKind.email => LucideIcons.mail,
  null => LucideIcons.circle,
};

final _amount = NumberFormat.currency(
  locale: 'fr',
  symbol: '€',
  decimalDigits: 0,
);

/// Montant en centimes → « 12 500 € ».
String formatAmount(int? cents) =>
    cents == null ? '' : _amount.format(cents / 100);

/// Date calendaire `AAAA-MM-JJ` → `27/09/2026`.
String formatDay(String? isoDate) {
  final date = isoDate == null ? null : DateTime.tryParse(isoDate);
  return date == null ? '' : DateFormat('dd/MM/yyyy', 'fr').format(date);
}

/// Date locale courte (`27/09/2026`).
String formatShortDate(DateTime date) =>
    DateFormat('dd/MM/yyyy', 'fr').format(date.toLocal());

/// Nombre avec séparateur de milliers (`24 000`).
String formatInteger(int? value) =>
    value == null ? '' : NumberFormat.decimalPattern('fr').format(value);

/// Champs personnalisés stockés (JSON) d'un enregistrement.
Map<String, Object?> decodeCustomValues(String? json) =>
    json == null ? const {} : (jsonDecode(json) as Map<String, dynamic>);

/// Valeur d'un champ personnalisé, pour affichage.
String formatCustomValue(CustomFieldRow field, Object? value) {
  if (value == null || (value is String && value.isEmpty)) return '';
  return switch (enumByKey(CustomFieldType.values, field.type)) {
    CustomFieldType.boolean => value == true ? 'Oui' : 'Non',
    CustomFieldType.date => formatDay(value as String),
    CustomFieldType.number when value is num => NumberFormat.decimalPattern(
      'fr',
    ).format(value),
    _ => '$value',
  };
}

/// Options d'un champ personnalisé « liste de choix ».
List<String> customFieldOptions(CustomFieldRow field) => field.options == null
    ? const []
    : [for (final o in jsonDecode(field.options!) as List<dynamic>) '$o'];
