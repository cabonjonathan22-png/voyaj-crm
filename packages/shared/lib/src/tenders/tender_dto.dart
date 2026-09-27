import 'package:freezed_annotation/freezed_annotation.dart';

import '../crm/enums.dart';

part 'tender_dto.freezed.dart';
part 'tender_dto.g.dart';

/// Suite donnée à un appel d'offres.
enum TenderStatus implements KeyedEnum {
  fresh('new', 'Nouveau'),
  followed('followed', 'Suivi'),
  ignored('ignored', 'Ignoré');

  const TenderStatus(this.key, this.label);

  @override
  final String key;
  @override
  final String label;
}

/// Appel d'offres repéré (BOAMP).
@freezed
abstract class TenderInfo with _$TenderInfo {
  const factory TenderInfo({
    required String id,

    /// Référence BOAMP (`idweb`).
    required String ref,
    required String title,
    String? buyer,

    /// Date de parution (`AAAA-MM-JJ`).
    required String publishedOn,
    DateTime? deadline,
    @Default([]) List<String> departements,
    String? nature,
    String? procedure,
    String? url,
    @Default([]) List<String> descriptors,
    @Default('new') String status,

    /// Affaire créée pour y répondre.
    String? dealId,
  }) = _TenderInfo;

  factory TenderInfo.fromJson(Map<String, dynamic> json) =>
      _$TenderInfoFromJson(json);
}

/// Veille : mots-clés et départements surveillés.
@freezed
abstract class TenderWatch with _$TenderWatch {
  const factory TenderWatch({
    @Default(false) bool enabled,
    @Default([]) List<String> keywords,
    @Default([]) List<String> departements,
    DateTime? lastRunAt,
    String? lastError,
  }) = _TenderWatch;

  factory TenderWatch.fromJson(Map<String, dynamic> json) =>
      _$TenderWatchFromJson(json);
}

@freezed
abstract class UpdateTenderRequest with _$UpdateTenderRequest {
  const factory UpdateTenderRequest({required String status, String? dealId}) =
      _UpdateTenderRequest;

  factory UpdateTenderRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateTenderRequestFromJson(json);
}
