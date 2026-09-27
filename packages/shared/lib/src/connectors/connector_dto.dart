import 'package:freezed_annotation/freezed_annotation.dart';

import '../crm/enums.dart';

part 'connector_dto.freezed.dart';
part 'connector_dto.g.dart';

/// Type de source externe.
enum ConnectorKind implements KeyedEnum {
  rest('rest', 'API REST (JSON)'),
  supabase('supabase', 'Supabase'),
  firebase('firebase', 'Firebase (Cloud Firestore)'),
  mysql('mysql', 'MySQL / MariaDB'),
  mongodb('mongodb', 'MongoDB'),
  webhook('webhook', 'Webhook entrant');

  const ConnectorKind(this.key, this.label);

  @override
  final String key;
  @override
  final String label;
}

/// Transformation d'une valeur source avant écriture.
enum MappingTransform implements KeyedEnum {
  none('none', 'Aucune'),
  trim('trim', 'Espaces retirés'),
  lower('lower', 'Minuscules'),
  upper('upper', 'Majuscules'),
  digits('digits', 'Chiffres seulement'),
  number('number', 'Nombre décimal'),
  integer('integer', 'Nombre entier'),
  cents('cents', 'Montant en euros → centimes'),
  boolean('boolean', 'Oui / non'),
  date('date', 'Date (AAAA-MM-JJ)'),
  dateTime('date_time', 'Date et heure');

  const MappingTransform(this.key, this.label);

  @override
  final String key;
  @override
  final String label;
}

/// Entités alimentables par un connecteur (champs de provenance).
const connectorEntities = ['organisations', 'contacts'];

/// Champs de rapprochement proposés, par entité (fiche existante de même
/// valeur adoptée à la première importation).
const connectorMatchFields = {
  'organisations': ['siren', 'siret', 'insee_code', 'email'],
  'contacts': ['email'],
};

/// Correspondance d'un champ Voyaj avec la source.
@freezed
abstract class FieldMapping with _$FieldMapping {
  const factory FieldMapping({
    /// Champ Voyaj (nom du schéma).
    required String target,

    /// Chemin dans l'enregistrement source (`adresse.ville`, `tags.0`).
    String? source,
    @Default('none') String transform,

    /// Valeur fixe (quand [source] est vide).
    Object? constant,
  }) = _FieldMapping;

  factory FieldMapping.fromJson(Map<String, dynamic> json) =>
      _$FieldMappingFromJson(json);
}

/// Rattachement d'un contact à une organisation existante.
@freezed
abstract class OrganisationLookup with _$OrganisationLookup {
  const factory OrganisationLookup({
    /// Chemin de la valeur dans la source.
    required String source,

    /// Champ de l'organisation comparé (`siren`, `siret`, `insee_code`,
    /// `name`, `email`).
    @Default('siren') String field,
  }) = _OrganisationLookup;

  factory OrganisationLookup.fromJson(Map<String, dynamic> json) =>
      _$OrganisationLookupFromJson(json);
}

/// Conversion des enregistrements source en fiches Voyaj.
@freezed
abstract class ConnectorMapping with _$ConnectorMapping {
  const factory ConnectorMapping({
    @Default('organisations') String entity,

    /// Chemin de l'identifiant stable dans la source.
    @Default('id') String refPath,
    @Default([]) List<FieldMapping> fields,

    /// Valeurs posées seulement à la création (ex. statut).
    @Default({}) Map<String, Object?> defaults,

    /// Champ de rapprochement avec une fiche existante.
    String? matchField,
    OrganisationLookup? organisationLookup,
  }) = _ConnectorMapping;

  factory ConnectorMapping.fromJson(Map<String, dynamic> json) =>
      _$ConnectorMappingFromJson(json);
}

/// Bilan d'une exécution.
@freezed
abstract class ConnectorRun with _$ConnectorRun {
  const factory ConnectorRun({
    required String id,
    required String connectorId,

    /// `manual`, `schedule` ou `webhook`.
    required String trigger,

    /// `running`, `succeeded` ou `failed`.
    required String status,
    required DateTime startedAt,
    DateTime? finishedAt,
    @Default(0) int fetched,
    @Default(0) int created,
    @Default(0) int updated,
    @Default(0) int unchanged,
    @Default(0) int rejected,

    /// Premiers rejets : « référence : motif ».
    @Default([]) List<String> problems,
    String? error,
  }) = _ConnectorRun;

  factory ConnectorRun.fromJson(Map<String, dynamic> json) =>
      _$ConnectorRunFromJson(json);
}

/// Connecteur (le secret n'est jamais renvoyé).
@freezed
abstract class ConnectorInfo with _$ConnectorInfo {
  const factory ConnectorInfo({
    required String id,
    required String name,
    required String kind,
    @Default({}) Map<String, Object?> config,
    @Default(ConnectorMapping()) ConnectorMapping mapping,
    @Default(true) bool enabled,

    /// Import planifié toutes les N minutes (`null` : manuel).
    int? scheduleMinutes,
    @Default(false) bool hasSecret,

    /// Un jeton de webhook entrant a été généré.
    @Default(false) bool hasWebhookToken,
    ConnectorRun? lastRun,
  }) = _ConnectorInfo;

  factory ConnectorInfo.fromJson(Map<String, dynamic> json) =>
      _$ConnectorInfoFromJson(json);
}

/// Création ou modification d'un connecteur.
@freezed
abstract class ConnectorInput with _$ConnectorInput {
  const factory ConnectorInput({
    required String name,
    required String kind,
    @Default({}) Map<String, Object?> config,
    @Default(ConnectorMapping()) ConnectorMapping mapping,
    @Default(true) bool enabled,
    int? scheduleMinutes,

    /// Écriture seule : clé d'API, mot de passe ou chaîne de connexion
    /// (`null` : inchangé, vide : supprimé).
    String? secret,
  }) = _ConnectorInput;

  factory ConnectorInput.fromJson(Map<String, dynamic> json) =>
      _$ConnectorInputFromJson(json);
}

/// Enregistrement source converti (aperçu).
@freezed
abstract class MappedRecord with _$MappedRecord {
  const factory MappedRecord({
    String? ref,
    @Default({}) Map<String, Object?> fields,
    @Default([]) List<String> problems,
  }) = _MappedRecord;

  factory MappedRecord.fromJson(Map<String, dynamic> json) =>
      _$MappedRecordFromJson(json);
}

/// Premiers enregistrements de la source, bruts et convertis.
@freezed
abstract class ConnectorPreview with _$ConnectorPreview {
  const factory ConnectorPreview({
    /// Chemins disponibles (aplatis) dans les enregistrements lus.
    @Default([]) List<String> paths,
    @Default([]) List<Map<String, Object?>> raw,
    @Default([]) List<MappedRecord> mapped,
  }) = _ConnectorPreview;

  factory ConnectorPreview.fromJson(Map<String, dynamic> json) =>
      _$ConnectorPreviewFromJson(json);
}

/// Jeton d'un webhook entrant (affiché une seule fois).
@freezed
abstract class WebhookToken with _$WebhookToken {
  const factory WebhookToken({required String url, required String token}) =
      _WebhookToken;

  factory WebhookToken.fromJson(Map<String, dynamic> json) =>
      _$WebhookTokenFromJson(json);
}

/// Webhook sortant : les changements des entités choisies sont envoyés
/// (POST JSON signé) à l'URL.
@freezed
abstract class WebhookInfo with _$WebhookInfo {
  const factory WebhookInfo({
    required String id,
    required String name,
    required String url,
    @Default([]) List<String> entities,
    @Default(true) bool enabled,
    @Default(false) bool hasSecret,

    /// Dernière séquence livrée.
    @Default(0) int lastSeq,
    DateTime? lastDeliveryAt,
    int? lastStatus,
    String? lastError,
    @Default(0) int failures,
  }) = _WebhookInfo;

  factory WebhookInfo.fromJson(Map<String, dynamic> json) =>
      _$WebhookInfoFromJson(json);
}

@freezed
abstract class WebhookInput with _$WebhookInput {
  const factory WebhookInput({
    required String name,
    required String url,
    @Default([]) List<String> entities,
    @Default(true) bool enabled,

    /// Écriture seule : secret de signature HMAC (`null` : inchangé).
    String? secret,
  }) = _WebhookInput;

  factory WebhookInput.fromJson(Map<String, dynamic> json) =>
      _$WebhookInputFromJson(json);
}
