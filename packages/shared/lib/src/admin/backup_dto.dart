import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup_dto.freezed.dart';
part 'backup_dto.g.dart';

/// Sauvegarde du serveur : base PostgreSQL (`pg_dump`, format custom) et
/// copie des fichiers joints.
@freezed
abstract class BackupInfo with _$BackupInfo {
  const factory BackupInfo({
    required String name,
    required DateTime createdAt,

    /// `manual`, `schedule` ou `cli`.
    required String trigger,
    required int databaseBytes,

    /// Nombre de fichiers joints copiés par cette sauvegarde (les autres
    /// l'étaient déjà).
    @Default(0) int newFiles,
    @Default(0) int totalFiles,
    required int schemaVersion,
  }) = _BackupInfo;

  factory BackupInfo.fromJson(Map<String, dynamic> json) =>
      _$BackupInfoFromJson(json);
}

/// État des sauvegardes (configuration et liste).
@freezed
abstract class BackupStatus with _$BackupStatus {
  const factory BackupStatus({
    required String directory,

    /// Heure de la sauvegarde quotidienne (`null` : désactivée).
    int? hour,
    required int keepDays,
    @Default([]) List<BackupInfo> backups,
    String? lastError,
  }) = _BackupStatus;

  factory BackupStatus.fromJson(Map<String, dynamic> json) =>
      _$BackupStatusFromJson(json);
}
