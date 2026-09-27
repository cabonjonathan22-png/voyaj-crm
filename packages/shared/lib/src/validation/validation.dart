import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation.freezed.dart';
part 'validation.g.dart';

/// Problème de validation sur un champ, avec un message lisible (français).
@freezed
abstract class ValidationIssue with _$ValidationIssue {
  const factory ValidationIssue({
    required String field,
    required String code,
    required String message,
  }) = _ValidationIssue;

  factory ValidationIssue.fromJson(Map<String, dynamic> json) =>
      _$ValidationIssueFromJson(json);
}

/// Codes d'erreur de validation stables (utilisables pour l'i18n client).
abstract final class ValidationCodes {
  static const required = 'required';
  static const tooShort = 'too_short';
  static const tooLong = 'too_long';
  static const invalidFormat = 'invalid_format';
  static const invalidType = 'invalid_type';
  static const unknownField = 'unknown_field';
  static const readOnly = 'read_only';
}

/// Vérifie une chaîne obligatoire (après suppression des espaces de bord).
ValidationIssue? validateRequiredText(
  String field,
  Object? value, {
  required String label,
  int min = 1,
  int? max,
}) {
  if (value is! String || value.trim().isEmpty) {
    return ValidationIssue(
      field: field,
      code: ValidationCodes.required,
      message: '$label est obligatoire.',
    );
  }
  return validateOptionalText(field, value, label: label, min: min, max: max);
}

/// Vérifie une chaîne facultative (null accepté).
ValidationIssue? validateOptionalText(
  String field,
  Object? value, {
  required String label,
  int min = 0,
  int? max,
}) {
  if (value == null) return null;
  if (value is! String) {
    return ValidationIssue(
      field: field,
      code: ValidationCodes.invalidType,
      message: '$label doit être un texte.',
    );
  }
  final length = value.trim().length;
  if (length < min) {
    return ValidationIssue(
      field: field,
      code: ValidationCodes.tooShort,
      message: '$label doit contenir au moins $min caractères.',
    );
  }
  if (max != null && length > max) {
    return ValidationIssue(
      field: field,
      code: ValidationCodes.tooLong,
      message: '$label ne doit pas dépasser $max caractères.',
    );
  }
  return null;
}

final _hexColor = RegExp(r'^#[0-9a-fA-F]{6}$');

/// Vérifie une couleur au format `#RRGGBB`.
ValidationIssue? validateHexColor(String field, Object? value) {
  if (value is String && _hexColor.hasMatch(value)) return null;
  return ValidationIssue(
    field: field,
    code: ValidationCodes.invalidFormat,
    message: 'La couleur doit être au format #RRGGBB.',
  );
}

final _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

/// Vérifie une adresse email (format simple, sans validation DNS).
ValidationIssue? validateEmail(String field, Object? value) {
  if (value is String && _email.hasMatch(value.trim())) return null;
  return ValidationIssue(
    field: field,
    code: ValidationCodes.invalidFormat,
    message: 'Adresse email invalide.',
  );
}

/// Longueur minimale des mots de passe (recommandation ANSSI / CNIL : 12).
const minPasswordLength = 12;

/// Politique de mot de passe : longueur minimale, sans règle de composition
/// (les phrases de passe longues sont préférables aux règles de complexité).
ValidationIssue? validatePassword(String field, Object? value) {
  if (value is String && value.length >= minPasswordLength) {
    if (value.length > 256) {
      return ValidationIssue(
        field: field,
        code: ValidationCodes.tooLong,
        message: 'Le mot de passe ne doit pas dépasser 256 caractères.',
      );
    }
    return null;
  }
  return ValidationIssue(
    field: field,
    code: ValidationCodes.tooShort,
    message:
        'Le mot de passe doit contenir au moins $minPasswordLength caractères.',
  );
}

/// Filtre les résultats nuls d'une série de validations.
List<ValidationIssue> collectIssues(Iterable<ValidationIssue?> results) =>
    results.whereType<ValidationIssue>().toList();
