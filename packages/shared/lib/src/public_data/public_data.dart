import 'package:freezed_annotation/freezed_annotation.dart';

import '../crm/enums.dart';

part 'public_data.freezed.dart';
part 'public_data.g.dart';

/// Source de données publiques importée en organisations. L'ordre est
/// celui des imports (les parents avant les enfants).
enum PublicSource implements KeyedEnum {
  regions('regions', 'Régions', 'geo.api.gouv.fr'),
  departements('departements', 'Départements', 'geo.api.gouv.fr'),
  epcis(
    'epcis',
    'EPCI (communautés de communes, d’agglomération, métropoles)',
    'geo.api.gouv.fr',
  ),
  communes('communes', 'Communes', 'geo.api.gouv.fr'),
  aoms(
    'aoms',
    'AOM (autorités organisatrices de la mobilité)',
    'transport.data.gouv.fr',
  ),
  festivals(
    'festivals',
    'Festivals (Panorama des festivals)',
    'data.culture.gouv.fr',
  );

  const PublicSource(this.key, this.label, this.provider);

  @override
  final String key;
  @override
  final String label;

  /// Fournisseur des données (affiché, et valeur de `source` des fiches).
  final String provider;

  /// Valeur du champ `source` des organisations importées.
  String get sourceName => '$provider/$key';
}

/// Déclenchement d'un import.
enum PublicRunTrigger { manual, schedule }

/// État d'un import.
enum PublicRunStatus { running, succeeded, failed }

/// Exécution d'un import de données publiques.
@freezed
abstract class PublicDataRun with _$PublicDataRun {
  const factory PublicDataRun({
    required String id,
    required String source,
    required PublicRunTrigger trigger,
    required PublicRunStatus status,
    required DateTime startedAt,
    DateTime? finishedAt,
    @Default(0) int fetched,
    @Default(0) int created,
    @Default(0) int updated,
    @Default(0) int unchanged,
    String? error,
  }) = _PublicDataRun;

  factory PublicDataRun.fromJson(Map<String, dynamic> json) =>
      _$PublicDataRunFromJson(json);
}

/// Configuration et dernier import d'une source.
@freezed
abstract class PublicSourceStatus with _$PublicSourceStatus {
  const factory PublicSourceStatus({
    required String source,
    required bool enabled,

    /// Départements retenus (codes) ; vide = toute la France.
    required List<String> departements,
    PublicDataRun? lastRun,
  }) = _PublicSourceStatus;

  factory PublicSourceStatus.fromJson(Map<String, dynamic> json) =>
      _$PublicSourceStatusFromJson(json);
}

/// Modification de la configuration d'une source.
@freezed
abstract class ConfigurePublicSourceRequest
    with _$ConfigurePublicSourceRequest {
  const factory ConfigurePublicSourceRequest({
    required bool enabled,
    required List<String> departements,
  }) = _ConfigurePublicSourceRequest;

  factory ConfigurePublicSourceRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfigurePublicSourceRequestFromJson(json);
}
