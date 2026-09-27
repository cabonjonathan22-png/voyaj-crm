import 'package:freezed_annotation/freezed_annotation.dart';

import '../validation/validation.dart';
import 'field_stamp.dart';

part 'protocol.freezed.dart';
part 'protocol.g.dart';

/// Version du protocole de synchronisation (négociée à la connexion).
const syncProtocolVersion = 1;

/// Taille maximale d'un lot d'opérations envoyées en une requête.
const maxPushBatchSize = 200;

/// Taille maximale d'une page de changements récupérés.
const maxPullPageSize = 500;

/// Opération locale en attente d'envoi (entrée de l'outbox).
@freezed
abstract class SyncOperation with _$SyncOperation {
  const factory SyncOperation({
    /// UUID v7 unique : garantit l'idempotence en cas de renvoi.
    required String opId,
    required String entity,
    required String entityId,

    /// Version de l'enregistrement connue localement au moment de
    /// l'écriture (0 pour une création).
    required int baseVersion,

    /// Horodatage HLC de l'écriture (appliqué à tous les champs).
    required String hlc,

    /// Champs modifiés (clés snake_case), `deleted_at` inclus.
    required Map<String, Object?> fields,
  }) = _SyncOperation;

  factory SyncOperation.fromJson(Map<String, dynamic> json) =>
      _$SyncOperationFromJson(json);
}

@freezed
abstract class PushRequest with _$PushRequest {
  const factory PushRequest({
    required String deviceId,
    required List<SyncOperation> operations,
  }) = _PushRequest;

  factory PushRequest.fromJson(Map<String, dynamic> json) =>
      _$PushRequestFromJson(json);
}

/// Issue du traitement d'une opération.
enum OpStatus {
  /// Tous les champs ont été appliqués.
  applied,

  /// Une partie des champs a été rejetée (écritures plus récentes).
  partial,

  /// Aucun champ appliqué : l'état serveur était déjà plus récent.
  superseded,

  /// Opération déjà traitée (renvoi).
  duplicate,

  /// Données invalides : l'opération est abandonnée.
  invalid,

  /// Droits insuffisants.
  forbidden,
}

@freezed
abstract class OpResult with _$OpResult {
  const factory OpResult({
    required String opId,
    required OpStatus status,

    /// État serveur de l'enregistrement après traitement.
    SyncRecord? record,
    @Default(0) int conflicts,
    @Default([]) List<ValidationIssue> issues,
  }) = _OpResult;

  factory OpResult.fromJson(Map<String, dynamic> json) =>
      _$OpResultFromJson(json);
}

@freezed
abstract class PushResponse with _$PushResponse {
  const factory PushResponse({required List<OpResult> results}) = _PushResponse;

  factory PushResponse.fromJson(Map<String, dynamic> json) =>
      _$PushResponseFromJson(json);
}

/// État complet d'un enregistrement côté serveur.
@freezed
abstract class SyncRecord with _$SyncRecord {
  const factory SyncRecord({
    required String entity,
    required String id,
    required int version,

    /// Position dans le journal des changements (curseur de pull).
    required int seq,

    /// Champs modifiables + colonnes techniques (clés snake_case, dates
    /// ISO 8601 UTC).
    required Map<String, Object?> data,
    required Map<String, FieldStamp> fieldMeta,
  }) = _SyncRecord;

  factory SyncRecord.fromJson(Map<String, dynamic> json) =>
      _$SyncRecordFromJson(json);
}

@freezed
abstract class PullResponse with _$PullResponse {
  const factory PullResponse({
    required List<SyncRecord> records,

    /// Curseur à renvoyer au prochain pull.
    required int cursor,
    required bool hasMore,
  }) = _PullResponse;

  factory PullResponse.fromJson(Map<String, dynamic> json) =>
      _$PullResponseFromJson(json);
}

/// Conflit journalisé, consultable dans le client.
@freezed
abstract class SyncConflict with _$SyncConflict {
  const factory SyncConflict({
    required String id,
    required String entity,
    required String entityId,
    required String field,
    Object? winningValue,
    Object? losingValue,
    required String winningHlc,
    required String losingHlc,
    String? winnerUserId,
    String? winnerName,
    String? loserUserId,
    String? loserName,
    required DateTime createdAt,
    DateTime? reviewedAt,
    String? reviewedBy,
  }) = _SyncConflict;

  factory SyncConflict.fromJson(Map<String, dynamic> json) =>
      _$SyncConflictFromJson(json);
}

/// Message envoyé par le client sur le WebSocket.
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
sealed class ClientMessage with _$ClientMessage {
  /// Premier message obligatoire : authentification.
  const factory ClientMessage.auth({
    required String accessToken,
    required int protocolVersion,
  }) = ClientAuth;

  factory ClientMessage.fromJson(Map<String, dynamic> json) =>
      _$ClientMessageFromJson(json);
}

/// Message envoyé par le serveur sur le WebSocket.
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
sealed class ServerMessage with _$ServerMessage {
  /// Authentification acceptée ; [cursor] = dernier changement connu.
  const factory ServerMessage.ready({required int cursor}) = ServerReady;

  /// De nouveaux changements sont disponibles jusqu'à [cursor].
  const factory ServerMessage.changes({required int cursor}) = ServerChanges;

  /// La session a été révoquée : le client doit se déconnecter.
  const factory ServerMessage.sessionRevoked() = ServerSessionRevoked;

  /// Erreur fatale (authentification refusée, protocole incompatible…).
  const factory ServerMessage.error({
    required String code,
    required String message,
  }) = ServerError;

  factory ServerMessage.fromJson(Map<String, dynamic> json) =>
      _$ServerMessageFromJson(json);
}
