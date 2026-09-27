// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tender_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TenderInfo {

 String get id;/// Référence BOAMP (`idweb`).
 String get ref; String get title; String? get buyer;/// Date de parution (`AAAA-MM-JJ`).
 String get publishedOn; DateTime? get deadline; List<String> get departements; String? get nature; String? get procedure; String? get url; List<String> get descriptors; String get status;/// Affaire créée pour y répondre.
 String? get dealId;
/// Create a copy of TenderInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenderInfoCopyWith<TenderInfo> get copyWith => _$TenderInfoCopyWithImpl<TenderInfo>(this as TenderInfo, _$identity);

  /// Serializes this TenderInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenderInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.ref, ref) || other.ref == ref)&&(identical(other.title, title) || other.title == title)&&(identical(other.buyer, buyer) || other.buyer == buyer)&&(identical(other.publishedOn, publishedOn) || other.publishedOn == publishedOn)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&const DeepCollectionEquality().equals(other.departements, departements)&&(identical(other.nature, nature) || other.nature == nature)&&(identical(other.procedure, procedure) || other.procedure == procedure)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.descriptors, descriptors)&&(identical(other.status, status) || other.status == status)&&(identical(other.dealId, dealId) || other.dealId == dealId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ref,title,buyer,publishedOn,deadline,const DeepCollectionEquality().hash(departements),nature,procedure,url,const DeepCollectionEquality().hash(descriptors),status,dealId);

@override
String toString() {
  return 'TenderInfo(id: $id, ref: $ref, title: $title, buyer: $buyer, publishedOn: $publishedOn, deadline: $deadline, departements: $departements, nature: $nature, procedure: $procedure, url: $url, descriptors: $descriptors, status: $status, dealId: $dealId)';
}


}

/// @nodoc
abstract mixin class $TenderInfoCopyWith<$Res>  {
  factory $TenderInfoCopyWith(TenderInfo value, $Res Function(TenderInfo) _then) = _$TenderInfoCopyWithImpl;
@useResult
$Res call({
 String id, String ref, String title, String? buyer, String publishedOn, DateTime? deadline, List<String> departements, String? nature, String? procedure, String? url, List<String> descriptors, String status, String? dealId
});




}
/// @nodoc
class _$TenderInfoCopyWithImpl<$Res>
    implements $TenderInfoCopyWith<$Res> {
  _$TenderInfoCopyWithImpl(this._self, this._then);

  final TenderInfo _self;
  final $Res Function(TenderInfo) _then;

/// Create a copy of TenderInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ref = null,Object? title = null,Object? buyer = freezed,Object? publishedOn = null,Object? deadline = freezed,Object? departements = null,Object? nature = freezed,Object? procedure = freezed,Object? url = freezed,Object? descriptors = null,Object? status = null,Object? dealId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ref: null == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,buyer: freezed == buyer ? _self.buyer : buyer // ignore: cast_nullable_to_non_nullable
as String?,publishedOn: null == publishedOn ? _self.publishedOn : publishedOn // ignore: cast_nullable_to_non_nullable
as String,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,departements: null == departements ? _self.departements : departements // ignore: cast_nullable_to_non_nullable
as List<String>,nature: freezed == nature ? _self.nature : nature // ignore: cast_nullable_to_non_nullable
as String?,procedure: freezed == procedure ? _self.procedure : procedure // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,descriptors: null == descriptors ? _self.descriptors : descriptors // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,dealId: freezed == dealId ? _self.dealId : dealId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TenderInfo].
extension TenderInfoPatterns on TenderInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenderInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenderInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenderInfo value)  $default,){
final _that = this;
switch (_that) {
case _TenderInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenderInfo value)?  $default,){
final _that = this;
switch (_that) {
case _TenderInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ref,  String title,  String? buyer,  String publishedOn,  DateTime? deadline,  List<String> departements,  String? nature,  String? procedure,  String? url,  List<String> descriptors,  String status,  String? dealId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenderInfo() when $default != null:
return $default(_that.id,_that.ref,_that.title,_that.buyer,_that.publishedOn,_that.deadline,_that.departements,_that.nature,_that.procedure,_that.url,_that.descriptors,_that.status,_that.dealId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ref,  String title,  String? buyer,  String publishedOn,  DateTime? deadline,  List<String> departements,  String? nature,  String? procedure,  String? url,  List<String> descriptors,  String status,  String? dealId)  $default,) {final _that = this;
switch (_that) {
case _TenderInfo():
return $default(_that.id,_that.ref,_that.title,_that.buyer,_that.publishedOn,_that.deadline,_that.departements,_that.nature,_that.procedure,_that.url,_that.descriptors,_that.status,_that.dealId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ref,  String title,  String? buyer,  String publishedOn,  DateTime? deadline,  List<String> departements,  String? nature,  String? procedure,  String? url,  List<String> descriptors,  String status,  String? dealId)?  $default,) {final _that = this;
switch (_that) {
case _TenderInfo() when $default != null:
return $default(_that.id,_that.ref,_that.title,_that.buyer,_that.publishedOn,_that.deadline,_that.departements,_that.nature,_that.procedure,_that.url,_that.descriptors,_that.status,_that.dealId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenderInfo implements TenderInfo {
  const _TenderInfo({required this.id, required this.ref, required this.title, this.buyer, required this.publishedOn, this.deadline, final  List<String> departements = const [], this.nature, this.procedure, this.url, final  List<String> descriptors = const [], this.status = 'new', this.dealId}): _departements = departements,_descriptors = descriptors;
  factory _TenderInfo.fromJson(Map<String, dynamic> json) => _$TenderInfoFromJson(json);

@override final  String id;
/// Référence BOAMP (`idweb`).
@override final  String ref;
@override final  String title;
@override final  String? buyer;
/// Date de parution (`AAAA-MM-JJ`).
@override final  String publishedOn;
@override final  DateTime? deadline;
 final  List<String> _departements;
@override@JsonKey() List<String> get departements {
  if (_departements is EqualUnmodifiableListView) return _departements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_departements);
}

@override final  String? nature;
@override final  String? procedure;
@override final  String? url;
 final  List<String> _descriptors;
@override@JsonKey() List<String> get descriptors {
  if (_descriptors is EqualUnmodifiableListView) return _descriptors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_descriptors);
}

@override@JsonKey() final  String status;
/// Affaire créée pour y répondre.
@override final  String? dealId;

/// Create a copy of TenderInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenderInfoCopyWith<_TenderInfo> get copyWith => __$TenderInfoCopyWithImpl<_TenderInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenderInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenderInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.ref, ref) || other.ref == ref)&&(identical(other.title, title) || other.title == title)&&(identical(other.buyer, buyer) || other.buyer == buyer)&&(identical(other.publishedOn, publishedOn) || other.publishedOn == publishedOn)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&const DeepCollectionEquality().equals(other._departements, _departements)&&(identical(other.nature, nature) || other.nature == nature)&&(identical(other.procedure, procedure) || other.procedure == procedure)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._descriptors, _descriptors)&&(identical(other.status, status) || other.status == status)&&(identical(other.dealId, dealId) || other.dealId == dealId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ref,title,buyer,publishedOn,deadline,const DeepCollectionEquality().hash(_departements),nature,procedure,url,const DeepCollectionEquality().hash(_descriptors),status,dealId);

@override
String toString() {
  return 'TenderInfo(id: $id, ref: $ref, title: $title, buyer: $buyer, publishedOn: $publishedOn, deadline: $deadline, departements: $departements, nature: $nature, procedure: $procedure, url: $url, descriptors: $descriptors, status: $status, dealId: $dealId)';
}


}

/// @nodoc
abstract mixin class _$TenderInfoCopyWith<$Res> implements $TenderInfoCopyWith<$Res> {
  factory _$TenderInfoCopyWith(_TenderInfo value, $Res Function(_TenderInfo) _then) = __$TenderInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String ref, String title, String? buyer, String publishedOn, DateTime? deadline, List<String> departements, String? nature, String? procedure, String? url, List<String> descriptors, String status, String? dealId
});




}
/// @nodoc
class __$TenderInfoCopyWithImpl<$Res>
    implements _$TenderInfoCopyWith<$Res> {
  __$TenderInfoCopyWithImpl(this._self, this._then);

  final _TenderInfo _self;
  final $Res Function(_TenderInfo) _then;

/// Create a copy of TenderInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ref = null,Object? title = null,Object? buyer = freezed,Object? publishedOn = null,Object? deadline = freezed,Object? departements = null,Object? nature = freezed,Object? procedure = freezed,Object? url = freezed,Object? descriptors = null,Object? status = null,Object? dealId = freezed,}) {
  return _then(_TenderInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ref: null == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,buyer: freezed == buyer ? _self.buyer : buyer // ignore: cast_nullable_to_non_nullable
as String?,publishedOn: null == publishedOn ? _self.publishedOn : publishedOn // ignore: cast_nullable_to_non_nullable
as String,deadline: freezed == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime?,departements: null == departements ? _self._departements : departements // ignore: cast_nullable_to_non_nullable
as List<String>,nature: freezed == nature ? _self.nature : nature // ignore: cast_nullable_to_non_nullable
as String?,procedure: freezed == procedure ? _self.procedure : procedure // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,descriptors: null == descriptors ? _self._descriptors : descriptors // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,dealId: freezed == dealId ? _self.dealId : dealId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TenderWatch {

 bool get enabled; List<String> get keywords; List<String> get departements; DateTime? get lastRunAt; String? get lastError;
/// Create a copy of TenderWatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenderWatchCopyWith<TenderWatch> get copyWith => _$TenderWatchCopyWithImpl<TenderWatch>(this as TenderWatch, _$identity);

  /// Serializes this TenderWatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenderWatch&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other.keywords, keywords)&&const DeepCollectionEquality().equals(other.departements, departements)&&(identical(other.lastRunAt, lastRunAt) || other.lastRunAt == lastRunAt)&&(identical(other.lastError, lastError) || other.lastError == lastError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,const DeepCollectionEquality().hash(keywords),const DeepCollectionEquality().hash(departements),lastRunAt,lastError);

@override
String toString() {
  return 'TenderWatch(enabled: $enabled, keywords: $keywords, departements: $departements, lastRunAt: $lastRunAt, lastError: $lastError)';
}


}

/// @nodoc
abstract mixin class $TenderWatchCopyWith<$Res>  {
  factory $TenderWatchCopyWith(TenderWatch value, $Res Function(TenderWatch) _then) = _$TenderWatchCopyWithImpl;
@useResult
$Res call({
 bool enabled, List<String> keywords, List<String> departements, DateTime? lastRunAt, String? lastError
});




}
/// @nodoc
class _$TenderWatchCopyWithImpl<$Res>
    implements $TenderWatchCopyWith<$Res> {
  _$TenderWatchCopyWithImpl(this._self, this._then);

  final TenderWatch _self;
  final $Res Function(TenderWatch) _then;

/// Create a copy of TenderWatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? keywords = null,Object? departements = null,Object? lastRunAt = freezed,Object? lastError = freezed,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,keywords: null == keywords ? _self.keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>,departements: null == departements ? _self.departements : departements // ignore: cast_nullable_to_non_nullable
as List<String>,lastRunAt: freezed == lastRunAt ? _self.lastRunAt : lastRunAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TenderWatch].
extension TenderWatchPatterns on TenderWatch {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenderWatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenderWatch() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenderWatch value)  $default,){
final _that = this;
switch (_that) {
case _TenderWatch():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenderWatch value)?  $default,){
final _that = this;
switch (_that) {
case _TenderWatch() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  List<String> keywords,  List<String> departements,  DateTime? lastRunAt,  String? lastError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenderWatch() when $default != null:
return $default(_that.enabled,_that.keywords,_that.departements,_that.lastRunAt,_that.lastError);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  List<String> keywords,  List<String> departements,  DateTime? lastRunAt,  String? lastError)  $default,) {final _that = this;
switch (_that) {
case _TenderWatch():
return $default(_that.enabled,_that.keywords,_that.departements,_that.lastRunAt,_that.lastError);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  List<String> keywords,  List<String> departements,  DateTime? lastRunAt,  String? lastError)?  $default,) {final _that = this;
switch (_that) {
case _TenderWatch() when $default != null:
return $default(_that.enabled,_that.keywords,_that.departements,_that.lastRunAt,_that.lastError);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenderWatch implements TenderWatch {
  const _TenderWatch({this.enabled = false, final  List<String> keywords = const [], final  List<String> departements = const [], this.lastRunAt, this.lastError}): _keywords = keywords,_departements = departements;
  factory _TenderWatch.fromJson(Map<String, dynamic> json) => _$TenderWatchFromJson(json);

@override@JsonKey() final  bool enabled;
 final  List<String> _keywords;
@override@JsonKey() List<String> get keywords {
  if (_keywords is EqualUnmodifiableListView) return _keywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keywords);
}

 final  List<String> _departements;
@override@JsonKey() List<String> get departements {
  if (_departements is EqualUnmodifiableListView) return _departements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_departements);
}

@override final  DateTime? lastRunAt;
@override final  String? lastError;

/// Create a copy of TenderWatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenderWatchCopyWith<_TenderWatch> get copyWith => __$TenderWatchCopyWithImpl<_TenderWatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenderWatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenderWatch&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other._keywords, _keywords)&&const DeepCollectionEquality().equals(other._departements, _departements)&&(identical(other.lastRunAt, lastRunAt) || other.lastRunAt == lastRunAt)&&(identical(other.lastError, lastError) || other.lastError == lastError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,const DeepCollectionEquality().hash(_keywords),const DeepCollectionEquality().hash(_departements),lastRunAt,lastError);

@override
String toString() {
  return 'TenderWatch(enabled: $enabled, keywords: $keywords, departements: $departements, lastRunAt: $lastRunAt, lastError: $lastError)';
}


}

/// @nodoc
abstract mixin class _$TenderWatchCopyWith<$Res> implements $TenderWatchCopyWith<$Res> {
  factory _$TenderWatchCopyWith(_TenderWatch value, $Res Function(_TenderWatch) _then) = __$TenderWatchCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, List<String> keywords, List<String> departements, DateTime? lastRunAt, String? lastError
});




}
/// @nodoc
class __$TenderWatchCopyWithImpl<$Res>
    implements _$TenderWatchCopyWith<$Res> {
  __$TenderWatchCopyWithImpl(this._self, this._then);

  final _TenderWatch _self;
  final $Res Function(_TenderWatch) _then;

/// Create a copy of TenderWatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? keywords = null,Object? departements = null,Object? lastRunAt = freezed,Object? lastError = freezed,}) {
  return _then(_TenderWatch(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,keywords: null == keywords ? _self._keywords : keywords // ignore: cast_nullable_to_non_nullable
as List<String>,departements: null == departements ? _self._departements : departements // ignore: cast_nullable_to_non_nullable
as List<String>,lastRunAt: freezed == lastRunAt ? _self.lastRunAt : lastRunAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UpdateTenderRequest {

 String get status; String? get dealId;
/// Create a copy of UpdateTenderRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateTenderRequestCopyWith<UpdateTenderRequest> get copyWith => _$UpdateTenderRequestCopyWithImpl<UpdateTenderRequest>(this as UpdateTenderRequest, _$identity);

  /// Serializes this UpdateTenderRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateTenderRequest&&(identical(other.status, status) || other.status == status)&&(identical(other.dealId, dealId) || other.dealId == dealId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,dealId);

@override
String toString() {
  return 'UpdateTenderRequest(status: $status, dealId: $dealId)';
}


}

/// @nodoc
abstract mixin class $UpdateTenderRequestCopyWith<$Res>  {
  factory $UpdateTenderRequestCopyWith(UpdateTenderRequest value, $Res Function(UpdateTenderRequest) _then) = _$UpdateTenderRequestCopyWithImpl;
@useResult
$Res call({
 String status, String? dealId
});




}
/// @nodoc
class _$UpdateTenderRequestCopyWithImpl<$Res>
    implements $UpdateTenderRequestCopyWith<$Res> {
  _$UpdateTenderRequestCopyWithImpl(this._self, this._then);

  final UpdateTenderRequest _self;
  final $Res Function(UpdateTenderRequest) _then;

/// Create a copy of UpdateTenderRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? dealId = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,dealId: freezed == dealId ? _self.dealId : dealId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateTenderRequest].
extension UpdateTenderRequestPatterns on UpdateTenderRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateTenderRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateTenderRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateTenderRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateTenderRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateTenderRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateTenderRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String? dealId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateTenderRequest() when $default != null:
return $default(_that.status,_that.dealId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String? dealId)  $default,) {final _that = this;
switch (_that) {
case _UpdateTenderRequest():
return $default(_that.status,_that.dealId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String? dealId)?  $default,) {final _that = this;
switch (_that) {
case _UpdateTenderRequest() when $default != null:
return $default(_that.status,_that.dealId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateTenderRequest implements UpdateTenderRequest {
  const _UpdateTenderRequest({required this.status, this.dealId});
  factory _UpdateTenderRequest.fromJson(Map<String, dynamic> json) => _$UpdateTenderRequestFromJson(json);

@override final  String status;
@override final  String? dealId;

/// Create a copy of UpdateTenderRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateTenderRequestCopyWith<_UpdateTenderRequest> get copyWith => __$UpdateTenderRequestCopyWithImpl<_UpdateTenderRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateTenderRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateTenderRequest&&(identical(other.status, status) || other.status == status)&&(identical(other.dealId, dealId) || other.dealId == dealId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,dealId);

@override
String toString() {
  return 'UpdateTenderRequest(status: $status, dealId: $dealId)';
}


}

/// @nodoc
abstract mixin class _$UpdateTenderRequestCopyWith<$Res> implements $UpdateTenderRequestCopyWith<$Res> {
  factory _$UpdateTenderRequestCopyWith(_UpdateTenderRequest value, $Res Function(_UpdateTenderRequest) _then) = __$UpdateTenderRequestCopyWithImpl;
@override @useResult
$Res call({
 String status, String? dealId
});




}
/// @nodoc
class __$UpdateTenderRequestCopyWithImpl<$Res>
    implements _$UpdateTenderRequestCopyWith<$Res> {
  __$UpdateTenderRequestCopyWithImpl(this._self, this._then);

  final _UpdateTenderRequest _self;
  final $Res Function(_UpdateTenderRequest) _then;

/// Create a copy of UpdateTenderRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? dealId = freezed,}) {
  return _then(_UpdateTenderRequest(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,dealId: freezed == dealId ? _self.dealId : dealId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
