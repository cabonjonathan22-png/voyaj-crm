import 'package:freezed_annotation/freezed_annotation.dart';

import '../validation/validation.dart';

part 'tag.freezed.dart';
part 'tag.g.dart';

/// Étiquette libre appliquée aux organisations, contacts et affaires.
///
/// Première entité synchronisée : elle sert de référence pour le moteur
/// de synchronisation hors ligne.
@freezed
abstract class Tag with _$Tag {
  const factory Tag({
    required String id,
    required String name,
    required String color,
    String? description,
    @Default(0) int version,
    required DateTime createdAt,
    String? createdBy,
    required DateTime updatedAt,
    String? updatedBy,
    DateTime? deletedAt,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

/// Longueur maximale du nom d'un tag.
const tagNameMaxLength = 40;

/// Longueur maximale de la description d'un tag.
const tagDescriptionMaxLength = 500;

/// Palette proposée pour les tags (le format `#RRGGBB` reste libre).
const tagPalette = [
  '#6366F1',
  '#0EA5E9',
  '#10B981',
  '#84CC16',
  '#F59E0B',
  '#F97316',
  '#EF4444',
  '#EC4899',
  '#A855F7',
  '#64748B',
];

/// Règles de validation d'un tag (enregistrement complet, clés snake_case).
List<ValidationIssue> validateTagRecord(Map<String, Object?> record) =>
    collectIssues([
      validateRequiredText(
        'name',
        record['name'],
        label: 'Le nom',
        max: tagNameMaxLength,
      ),
      validateHexColor('color', record['color']),
      validateOptionalText(
        'description',
        record['description'],
        label: 'La description',
        max: tagDescriptionMaxLength,
      ),
    ]);
