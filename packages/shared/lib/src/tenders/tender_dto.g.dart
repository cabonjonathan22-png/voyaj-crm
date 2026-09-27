// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tender_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TenderInfo _$TenderInfoFromJson(Map<String, dynamic> json) => _TenderInfo(
  id: json['id'] as String,
  ref: json['ref'] as String,
  title: json['title'] as String,
  buyer: json['buyer'] as String?,
  publishedOn: json['published_on'] as String,
  deadline: json['deadline'] == null
      ? null
      : DateTime.parse(json['deadline'] as String),
  departements:
      (json['departements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  nature: json['nature'] as String?,
  procedure: json['procedure'] as String?,
  url: json['url'] as String?,
  descriptors:
      (json['descriptors'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  status: json['status'] as String? ?? 'new',
  dealId: json['deal_id'] as String?,
);

Map<String, dynamic> _$TenderInfoToJson(_TenderInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ref': instance.ref,
      'title': instance.title,
      'buyer': instance.buyer,
      'published_on': instance.publishedOn,
      'deadline': instance.deadline?.toIso8601String(),
      'departements': instance.departements,
      'nature': instance.nature,
      'procedure': instance.procedure,
      'url': instance.url,
      'descriptors': instance.descriptors,
      'status': instance.status,
      'deal_id': instance.dealId,
    };

_TenderWatch _$TenderWatchFromJson(Map<String, dynamic> json) => _TenderWatch(
  enabled: json['enabled'] as bool? ?? false,
  keywords:
      (json['keywords'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  departements:
      (json['departements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  lastRunAt: json['last_run_at'] == null
      ? null
      : DateTime.parse(json['last_run_at'] as String),
  lastError: json['last_error'] as String?,
);

Map<String, dynamic> _$TenderWatchToJson(_TenderWatch instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'keywords': instance.keywords,
      'departements': instance.departements,
      'last_run_at': instance.lastRunAt?.toIso8601String(),
      'last_error': instance.lastError,
    };

_UpdateTenderRequest _$UpdateTenderRequestFromJson(Map<String, dynamic> json) =>
    _UpdateTenderRequest(
      status: json['status'] as String,
      dealId: json['deal_id'] as String?,
    );

Map<String, dynamic> _$UpdateTenderRequestToJson(
  _UpdateTenderRequest instance,
) => <String, dynamic>{'status': instance.status, 'deal_id': instance.dealId};
