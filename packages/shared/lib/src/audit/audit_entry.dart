import 'package:freezed_annotation/freezed_annotation.dart';

part 'audit_entry.freezed.dart';
part 'audit_entry.g.dart';

/// Entrée du journal d'audit (lecture seule).
@freezed
abstract class AuditEntry with _$AuditEntry {
  const factory AuditEntry({
    required int id,
    required DateTime occurredAt,
    String? actorUserId,
    String? actorName,
    required String action,
    String? entity,
    String? entityId,
    required Map<String, Object?> payload,
    String? ip,
  }) = _AuditEntry;

  factory AuditEntry.fromJson(Map<String, dynamic> json) =>
      _$AuditEntryFromJson(json);
}
