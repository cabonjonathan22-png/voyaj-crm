import 'package:meta/meta.dart';

/// Référence vers l'organisation parente (résolue par le serveur) : la
/// fiche de type [kinds] dont le champ [field] vaut [value].
@immutable
final class ParentRef {
  const ParentRef(this.field, this.value, this.kinds);

  final String field;
  final String value;
  final Set<String> kinds;
}

/// Organisation issue d'une source publique.
@immutable
final class PublicRecord {
  const PublicRecord({
    required this.ref,
    required this.fields,
    this.matchField,
    this.parent,
  });

  /// Identifiant dans la source (`source_ref` : code INSEE, SIREN…).
  final String ref;

  /// Champs de l'organisation (format réseau), hors `source`,
  /// `source_ref`, `collected_at` et `parent_id`.
  final Map<String, Object?> fields;

  /// Champ permettant de rattacher une fiche saisie à la main (même type,
  /// même valeur), ex. `insee_code`. `null` : pas de rapprochement.
  final String? matchField;
  final ParentRef? parent;

  String get kind => fields['kind']! as String;
}

/// Erreur de lecture d'une source (message en français).
final class PublicDataException implements Exception {
  const PublicDataException(this.message);

  final String message;

  @override
  String toString() => message;
}
