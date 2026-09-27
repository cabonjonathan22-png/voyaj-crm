import 'package:meta/meta.dart';

import '../auth/permission.dart';
import '../validation/validation.dart';

/// Type d'un champ synchronisé (valeur JSON transmise sur le réseau).
enum FieldType {
  /// `String`.
  text,

  /// `int`.
  integer,

  /// `num`.
  decimal,

  /// `bool`.
  boolean,

  /// Chaîne ISO 8601 UTC.
  dateTime,

  /// Date calendaire `AAAA-MM-JJ` (sans heure ni fuseau).
  date,

  /// Valeur JSON arbitraire (objet ou liste).
  json,
}

final _datePattern = RegExp(r'^\d{4}-\d{2}-\d{2}$');

/// Définition d'un champ synchronisé.
@immutable
final class FieldSpec {
  const FieldSpec(this.type, {this.nullable = true, this.values});

  /// Champ texte limité à une liste de valeurs (énumération).
  const FieldSpec.oneOf(Set<String> this.values, {this.nullable = true})
    : type = FieldType.text;

  final FieldType type;
  final bool nullable;

  /// Valeurs autorisées (champ énuméré), ou `null`.
  final Set<String>? values;

  bool accepts(Object? value) {
    if (value == null) return nullable;
    return switch (type) {
      FieldType.text =>
        value is String && (values == null || values!.contains(value)),
      FieldType.integer => value is int,
      FieldType.decimal => value is num,
      FieldType.boolean => value is bool,
      FieldType.dateTime => value is String && DateTime.tryParse(value) != null,
      FieldType.date => value is String && _isCalendarDate(value),
      FieldType.json => value is Map || value is List,
    };
  }
}

/// Date `AAAA-MM-JJ` existante (`2026-02-30` est refusée : [DateTime.parse]
/// la convertirait silencieusement en 2 mars).
bool _isCalendarDate(String value) {
  if (!_datePattern.hasMatch(value)) return false;
  final parsed = DateTime.tryParse(value);
  return parsed != null && formatDateOnly(parsed) == value;
}

/// Formate une date calendaire (`AAAA-MM-JJ`).
String formatDateOnly(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

/// Colonnes techniques communes à toutes les entités synchronisées.
abstract final class SyncColumns {
  static const id = 'id';
  static const version = 'version';
  static const fieldMeta = 'field_meta';
  static const createdAt = 'created_at';
  static const createdBy = 'created_by';
  static const updatedAt = 'updated_at';
  static const updatedBy = 'updated_by';
  static const deletedAt = 'deleted_at';

  /// Colonnes gérées exclusivement par le serveur.
  static const serverManaged = {
    id,
    version,
    fieldMeta,
    createdAt,
    createdBy,
    updatedAt,
    updatedBy,
  };
}

final _identifier = RegExp(r'^[a-z][a-z0-9_]{0,62}$');

/// Schéma d'une entité synchronisée : nom (= table), champs modifiables,
/// règles de validation et permissions requises.
///
/// Le serveur construit ses requêtes SQL uniquement à partir de ces noms
/// (liste blanche), jamais à partir des données reçues.
@immutable
final class EntitySchema {
  EntitySchema({
    required this.name,
    required Map<String, FieldSpec> fields,
    required this.readPermission,
    required this.writePermission,
    required List<ValidationIssue> Function(Map<String, Object?> record)
    validate,
    this.serverFields = const {},
    this.lockedFields,
  }) : fields = {
         ...fields,
         SyncColumns.deletedAt: const FieldSpec(FieldType.dateTime),
       },
       _validator = validate {
    for (final column in [name, ...this.fields.keys]) {
      if (!_identifier.hasMatch(column)) {
        throw ArgumentError.value(column, 'identifiant SQL invalide');
      }
    }
  }

  final String name;

  /// Champs modifiables par les clients (incluant `deleted_at`).
  final Map<String, FieldSpec> fields;

  final Permission readPermission;
  final Permission writePermission;
  final List<ValidationIssue> Function(Map<String, Object?> record) _validator;

  /// Champs écrits uniquement par le serveur (ex. numéro de facture) :
  /// refusés dans les opérations des clients.
  final Set<String> serverFields;

  /// Champs verrouillés selon l'état de l'enregistrement (`null` : aucun).
  final Set<String> Function(Map<String, Object?> current)? lockedFields;

  /// Refus des champs verrouillés : un document émis (facture numérotée)
  /// n'est plus modifiable, sauf les champs laissés libres par l'entité.
  List<ValidationIssue> checkLocks(
    Map<String, Object?> current,
    Map<String, Object?> incoming,
  ) {
    final locked = lockedFields?.call(current) ?? const <String>{};
    return [
      for (final field in incoming.keys)
        if (locked.contains(field))
          ValidationIssue(
            field: field,
            code: ValidationCodes.readOnly,
            message: 'Document émis : « $field » ne peut plus être modifié.',
          ),
    ];
  }

  /// Vérifie une opération d'un client : champs connus et typés, hors
  /// champs réservés au serveur.
  List<ValidationIssue> checkClientFields(Map<String, Object?> incoming) => [
    ...checkFields(incoming),
    for (final field in incoming.keys)
      if (serverFields.contains(field))
        ValidationIssue(
          field: field,
          code: ValidationCodes.readOnly,
          message: 'Le champ $field est attribué par le serveur.',
        ),
  ];

  /// Vérifie que les champs d'une opération existent et ont le bon type.
  List<ValidationIssue> checkFields(Map<String, Object?> incoming) => [
    for (final MapEntry(:key, :value) in incoming.entries)
      if (SyncColumns.serverManaged.contains(key))
        ValidationIssue(
          field: key,
          code: ValidationCodes.readOnly,
          message: 'Le champ $key est géré par le serveur.',
        )
      else if (fields[key] == null)
        ValidationIssue(
          field: key,
          code: ValidationCodes.unknownField,
          message: 'Champ inconnu : $key.',
        )
      else if (!fields[key]!.accepts(value))
        ValidationIssue(
          field: key,
          code: ValidationCodes.invalidType,
          message: 'Type invalide pour $key.',
        ),
  ];

  /// Valide l'enregistrement complet (après fusion). Les enregistrements
  /// supprimés ne sont pas revalidés.
  List<ValidationIssue> validate(Map<String, Object?> record) =>
      record[SyncColumns.deletedAt] != null ? const [] : _validator(record);
}
