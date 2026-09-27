import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_stamp.freezed.dart';
part 'field_stamp.g.dart';

/// Métadonnées de la dernière écriture d'un champ d'un enregistrement.
///
/// Stockées dans la colonne `field_meta` (clé = nom du champ). Clés JSON
/// courtes car répétées pour chaque champ de chaque enregistrement.
@freezed
abstract class FieldStamp with _$FieldStamp {
  const factory FieldStamp({
    /// HLC de l'écriture gagnante.
    @JsonKey(name: 'h') required String hlc,

    /// Version de l'enregistrement produite par cette écriture.
    @JsonKey(name: 'v') required int version,

    /// Utilisateur auteur de l'écriture.
    @JsonKey(name: 'u') String? userId,
  }) = _FieldStamp;

  factory FieldStamp.fromJson(Map<String, dynamic> json) =>
      _$FieldStampFromJson(json);
}

/// Décode la colonne `field_meta`.
Map<String, FieldStamp> decodeFieldMeta(Map<String, dynamic>? json) => {
  for (final MapEntry(:key, :value) in (json ?? const {}).entries)
    key: FieldStamp.fromJson(value as Map<String, dynamic>),
};

/// Encode la colonne `field_meta`.
Map<String, dynamic> encodeFieldMeta(Map<String, FieldStamp> meta) => {
  for (final MapEntry(:key, :value) in meta.entries) key: value.toJson(),
};
