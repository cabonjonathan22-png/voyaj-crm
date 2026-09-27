// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'public_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PublicDataRun {

 String get id; String get source; PublicRunTrigger get trigger; PublicRunStatus get status; DateTime get startedAt; DateTime? get finishedAt; int get fetched; int get created; int get updated; int get unchanged;/// Fiches refusées par les règles de validation.
 int get rejected; String? get error;
/// Create a copy of PublicDataRun
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicDataRunCopyWith<PublicDataRun> get copyWith => _$PublicDataRunCopyWithImpl<PublicDataRun>(this as PublicDataRun, _$identity);

  /// Serializes this PublicDataRun to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicDataRun&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.fetched, fetched) || other.fetched == fetched)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.unchanged, unchanged) || other.unchanged == unchanged)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,source,trigger,status,startedAt,finishedAt,fetched,created,updated,unchanged,rejected,error);

@override
String toString() {
  return 'PublicDataRun(id: $id, source: $source, trigger: $trigger, status: $status, startedAt: $startedAt, finishedAt: $finishedAt, fetched: $fetched, created: $created, updated: $updated, unchanged: $unchanged, rejected: $rejected, error: $error)';
}


}

/// @nodoc
abstract mixin class $PublicDataRunCopyWith<$Res>  {
  factory $PublicDataRunCopyWith(PublicDataRun value, $Res Function(PublicDataRun) _then) = _$PublicDataRunCopyWithImpl;
@useResult
$Res call({
 String id, String source, PublicRunTrigger trigger, PublicRunStatus status, DateTime startedAt, DateTime? finishedAt, int fetched, int created, int updated, int unchanged, int rejected, String? error
});




}
/// @nodoc
class _$PublicDataRunCopyWithImpl<$Res>
    implements $PublicDataRunCopyWith<$Res> {
  _$PublicDataRunCopyWithImpl(this._self, this._then);

  final PublicDataRun _self;
  final $Res Function(PublicDataRun) _then;

/// Create a copy of PublicDataRun
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? source = null,Object? trigger = null,Object? status = null,Object? startedAt = null,Object? finishedAt = freezed,Object? fetched = null,Object? created = null,Object? updated = null,Object? unchanged = null,Object? rejected = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as PublicRunTrigger,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PublicRunStatus,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fetched: null == fetched ? _self.fetched : fetched // ignore: cast_nullable_to_non_nullable
as int,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as int,unchanged: null == unchanged ? _self.unchanged : unchanged // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PublicDataRun].
extension PublicDataRunPatterns on PublicDataRun {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicDataRun value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicDataRun() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicDataRun value)  $default,){
final _that = this;
switch (_that) {
case _PublicDataRun():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicDataRun value)?  $default,){
final _that = this;
switch (_that) {
case _PublicDataRun() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String source,  PublicRunTrigger trigger,  PublicRunStatus status,  DateTime startedAt,  DateTime? finishedAt,  int fetched,  int created,  int updated,  int unchanged,  int rejected,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicDataRun() when $default != null:
return $default(_that.id,_that.source,_that.trigger,_that.status,_that.startedAt,_that.finishedAt,_that.fetched,_that.created,_that.updated,_that.unchanged,_that.rejected,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String source,  PublicRunTrigger trigger,  PublicRunStatus status,  DateTime startedAt,  DateTime? finishedAt,  int fetched,  int created,  int updated,  int unchanged,  int rejected,  String? error)  $default,) {final _that = this;
switch (_that) {
case _PublicDataRun():
return $default(_that.id,_that.source,_that.trigger,_that.status,_that.startedAt,_that.finishedAt,_that.fetched,_that.created,_that.updated,_that.unchanged,_that.rejected,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String source,  PublicRunTrigger trigger,  PublicRunStatus status,  DateTime startedAt,  DateTime? finishedAt,  int fetched,  int created,  int updated,  int unchanged,  int rejected,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _PublicDataRun() when $default != null:
return $default(_that.id,_that.source,_that.trigger,_that.status,_that.startedAt,_that.finishedAt,_that.fetched,_that.created,_that.updated,_that.unchanged,_that.rejected,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicDataRun implements PublicDataRun {
  const _PublicDataRun({required this.id, required this.source, required this.trigger, required this.status, required this.startedAt, this.finishedAt, this.fetched = 0, this.created = 0, this.updated = 0, this.unchanged = 0, this.rejected = 0, this.error});
  factory _PublicDataRun.fromJson(Map<String, dynamic> json) => _$PublicDataRunFromJson(json);

@override final  String id;
@override final  String source;
@override final  PublicRunTrigger trigger;
@override final  PublicRunStatus status;
@override final  DateTime startedAt;
@override final  DateTime? finishedAt;
@override@JsonKey() final  int fetched;
@override@JsonKey() final  int created;
@override@JsonKey() final  int updated;
@override@JsonKey() final  int unchanged;
/// Fiches refusées par les règles de validation.
@override@JsonKey() final  int rejected;
@override final  String? error;

/// Create a copy of PublicDataRun
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicDataRunCopyWith<_PublicDataRun> get copyWith => __$PublicDataRunCopyWithImpl<_PublicDataRun>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicDataRunToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicDataRun&&(identical(other.id, id) || other.id == id)&&(identical(other.source, source) || other.source == source)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.fetched, fetched) || other.fetched == fetched)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.unchanged, unchanged) || other.unchanged == unchanged)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,source,trigger,status,startedAt,finishedAt,fetched,created,updated,unchanged,rejected,error);

@override
String toString() {
  return 'PublicDataRun(id: $id, source: $source, trigger: $trigger, status: $status, startedAt: $startedAt, finishedAt: $finishedAt, fetched: $fetched, created: $created, updated: $updated, unchanged: $unchanged, rejected: $rejected, error: $error)';
}


}

/// @nodoc
abstract mixin class _$PublicDataRunCopyWith<$Res> implements $PublicDataRunCopyWith<$Res> {
  factory _$PublicDataRunCopyWith(_PublicDataRun value, $Res Function(_PublicDataRun) _then) = __$PublicDataRunCopyWithImpl;
@override @useResult
$Res call({
 String id, String source, PublicRunTrigger trigger, PublicRunStatus status, DateTime startedAt, DateTime? finishedAt, int fetched, int created, int updated, int unchanged, int rejected, String? error
});




}
/// @nodoc
class __$PublicDataRunCopyWithImpl<$Res>
    implements _$PublicDataRunCopyWith<$Res> {
  __$PublicDataRunCopyWithImpl(this._self, this._then);

  final _PublicDataRun _self;
  final $Res Function(_PublicDataRun) _then;

/// Create a copy of PublicDataRun
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? source = null,Object? trigger = null,Object? status = null,Object? startedAt = null,Object? finishedAt = freezed,Object? fetched = null,Object? created = null,Object? updated = null,Object? unchanged = null,Object? rejected = null,Object? error = freezed,}) {
  return _then(_PublicDataRun(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as PublicRunTrigger,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PublicRunStatus,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fetched: null == fetched ? _self.fetched : fetched // ignore: cast_nullable_to_non_nullable
as int,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as int,unchanged: null == unchanged ? _self.unchanged : unchanged // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PublicSourceStatus {

 String get source; bool get enabled;/// Départements retenus (codes) ; vide = toute la France.
 List<String> get departements; PublicDataRun? get lastRun;
/// Create a copy of PublicSourceStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicSourceStatusCopyWith<PublicSourceStatus> get copyWith => _$PublicSourceStatusCopyWithImpl<PublicSourceStatus>(this as PublicSourceStatus, _$identity);

  /// Serializes this PublicSourceStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicSourceStatus&&(identical(other.source, source) || other.source == source)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other.departements, departements)&&(identical(other.lastRun, lastRun) || other.lastRun == lastRun));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,enabled,const DeepCollectionEquality().hash(departements),lastRun);

@override
String toString() {
  return 'PublicSourceStatus(source: $source, enabled: $enabled, departements: $departements, lastRun: $lastRun)';
}


}

/// @nodoc
abstract mixin class $PublicSourceStatusCopyWith<$Res>  {
  factory $PublicSourceStatusCopyWith(PublicSourceStatus value, $Res Function(PublicSourceStatus) _then) = _$PublicSourceStatusCopyWithImpl;
@useResult
$Res call({
 String source, bool enabled, List<String> departements, PublicDataRun? lastRun
});


$PublicDataRunCopyWith<$Res>? get lastRun;

}
/// @nodoc
class _$PublicSourceStatusCopyWithImpl<$Res>
    implements $PublicSourceStatusCopyWith<$Res> {
  _$PublicSourceStatusCopyWithImpl(this._self, this._then);

  final PublicSourceStatus _self;
  final $Res Function(PublicSourceStatus) _then;

/// Create a copy of PublicSourceStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? source = null,Object? enabled = null,Object? departements = null,Object? lastRun = freezed,}) {
  return _then(_self.copyWith(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,departements: null == departements ? _self.departements : departements // ignore: cast_nullable_to_non_nullable
as List<String>,lastRun: freezed == lastRun ? _self.lastRun : lastRun // ignore: cast_nullable_to_non_nullable
as PublicDataRun?,
  ));
}
/// Create a copy of PublicSourceStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicDataRunCopyWith<$Res>? get lastRun {
    if (_self.lastRun == null) {
    return null;
  }

  return $PublicDataRunCopyWith<$Res>(_self.lastRun!, (value) {
    return _then(_self.copyWith(lastRun: value));
  });
}
}


/// Adds pattern-matching-related methods to [PublicSourceStatus].
extension PublicSourceStatusPatterns on PublicSourceStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicSourceStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicSourceStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicSourceStatus value)  $default,){
final _that = this;
switch (_that) {
case _PublicSourceStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicSourceStatus value)?  $default,){
final _that = this;
switch (_that) {
case _PublicSourceStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String source,  bool enabled,  List<String> departements,  PublicDataRun? lastRun)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicSourceStatus() when $default != null:
return $default(_that.source,_that.enabled,_that.departements,_that.lastRun);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String source,  bool enabled,  List<String> departements,  PublicDataRun? lastRun)  $default,) {final _that = this;
switch (_that) {
case _PublicSourceStatus():
return $default(_that.source,_that.enabled,_that.departements,_that.lastRun);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String source,  bool enabled,  List<String> departements,  PublicDataRun? lastRun)?  $default,) {final _that = this;
switch (_that) {
case _PublicSourceStatus() when $default != null:
return $default(_that.source,_that.enabled,_that.departements,_that.lastRun);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicSourceStatus implements PublicSourceStatus {
  const _PublicSourceStatus({required this.source, required this.enabled, required final  List<String> departements, this.lastRun}): _departements = departements;
  factory _PublicSourceStatus.fromJson(Map<String, dynamic> json) => _$PublicSourceStatusFromJson(json);

@override final  String source;
@override final  bool enabled;
/// Départements retenus (codes) ; vide = toute la France.
 final  List<String> _departements;
/// Départements retenus (codes) ; vide = toute la France.
@override List<String> get departements {
  if (_departements is EqualUnmodifiableListView) return _departements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_departements);
}

@override final  PublicDataRun? lastRun;

/// Create a copy of PublicSourceStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicSourceStatusCopyWith<_PublicSourceStatus> get copyWith => __$PublicSourceStatusCopyWithImpl<_PublicSourceStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicSourceStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicSourceStatus&&(identical(other.source, source) || other.source == source)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other._departements, _departements)&&(identical(other.lastRun, lastRun) || other.lastRun == lastRun));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,enabled,const DeepCollectionEquality().hash(_departements),lastRun);

@override
String toString() {
  return 'PublicSourceStatus(source: $source, enabled: $enabled, departements: $departements, lastRun: $lastRun)';
}


}

/// @nodoc
abstract mixin class _$PublicSourceStatusCopyWith<$Res> implements $PublicSourceStatusCopyWith<$Res> {
  factory _$PublicSourceStatusCopyWith(_PublicSourceStatus value, $Res Function(_PublicSourceStatus) _then) = __$PublicSourceStatusCopyWithImpl;
@override @useResult
$Res call({
 String source, bool enabled, List<String> departements, PublicDataRun? lastRun
});


@override $PublicDataRunCopyWith<$Res>? get lastRun;

}
/// @nodoc
class __$PublicSourceStatusCopyWithImpl<$Res>
    implements _$PublicSourceStatusCopyWith<$Res> {
  __$PublicSourceStatusCopyWithImpl(this._self, this._then);

  final _PublicSourceStatus _self;
  final $Res Function(_PublicSourceStatus) _then;

/// Create a copy of PublicSourceStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? enabled = null,Object? departements = null,Object? lastRun = freezed,}) {
  return _then(_PublicSourceStatus(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,departements: null == departements ? _self._departements : departements // ignore: cast_nullable_to_non_nullable
as List<String>,lastRun: freezed == lastRun ? _self.lastRun : lastRun // ignore: cast_nullable_to_non_nullable
as PublicDataRun?,
  ));
}

/// Create a copy of PublicSourceStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicDataRunCopyWith<$Res>? get lastRun {
    if (_self.lastRun == null) {
    return null;
  }

  return $PublicDataRunCopyWith<$Res>(_self.lastRun!, (value) {
    return _then(_self.copyWith(lastRun: value));
  });
}
}


/// @nodoc
mixin _$ConfigurePublicSourceRequest {

 bool get enabled; List<String> get departements;
/// Create a copy of ConfigurePublicSourceRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfigurePublicSourceRequestCopyWith<ConfigurePublicSourceRequest> get copyWith => _$ConfigurePublicSourceRequestCopyWithImpl<ConfigurePublicSourceRequest>(this as ConfigurePublicSourceRequest, _$identity);

  /// Serializes this ConfigurePublicSourceRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigurePublicSourceRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other.departements, departements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,const DeepCollectionEquality().hash(departements));

@override
String toString() {
  return 'ConfigurePublicSourceRequest(enabled: $enabled, departements: $departements)';
}


}

/// @nodoc
abstract mixin class $ConfigurePublicSourceRequestCopyWith<$Res>  {
  factory $ConfigurePublicSourceRequestCopyWith(ConfigurePublicSourceRequest value, $Res Function(ConfigurePublicSourceRequest) _then) = _$ConfigurePublicSourceRequestCopyWithImpl;
@useResult
$Res call({
 bool enabled, List<String> departements
});




}
/// @nodoc
class _$ConfigurePublicSourceRequestCopyWithImpl<$Res>
    implements $ConfigurePublicSourceRequestCopyWith<$Res> {
  _$ConfigurePublicSourceRequestCopyWithImpl(this._self, this._then);

  final ConfigurePublicSourceRequest _self;
  final $Res Function(ConfigurePublicSourceRequest) _then;

/// Create a copy of ConfigurePublicSourceRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? departements = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,departements: null == departements ? _self.departements : departements // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfigurePublicSourceRequest].
extension ConfigurePublicSourceRequestPatterns on ConfigurePublicSourceRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfigurePublicSourceRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfigurePublicSourceRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfigurePublicSourceRequest value)  $default,){
final _that = this;
switch (_that) {
case _ConfigurePublicSourceRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfigurePublicSourceRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ConfigurePublicSourceRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  List<String> departements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfigurePublicSourceRequest() when $default != null:
return $default(_that.enabled,_that.departements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  List<String> departements)  $default,) {final _that = this;
switch (_that) {
case _ConfigurePublicSourceRequest():
return $default(_that.enabled,_that.departements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  List<String> departements)?  $default,) {final _that = this;
switch (_that) {
case _ConfigurePublicSourceRequest() when $default != null:
return $default(_that.enabled,_that.departements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfigurePublicSourceRequest implements ConfigurePublicSourceRequest {
  const _ConfigurePublicSourceRequest({required this.enabled, required final  List<String> departements}): _departements = departements;
  factory _ConfigurePublicSourceRequest.fromJson(Map<String, dynamic> json) => _$ConfigurePublicSourceRequestFromJson(json);

@override final  bool enabled;
 final  List<String> _departements;
@override List<String> get departements {
  if (_departements is EqualUnmodifiableListView) return _departements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_departements);
}


/// Create a copy of ConfigurePublicSourceRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfigurePublicSourceRequestCopyWith<_ConfigurePublicSourceRequest> get copyWith => __$ConfigurePublicSourceRequestCopyWithImpl<_ConfigurePublicSourceRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfigurePublicSourceRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfigurePublicSourceRequest&&(identical(other.enabled, enabled) || other.enabled == enabled)&&const DeepCollectionEquality().equals(other._departements, _departements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,const DeepCollectionEquality().hash(_departements));

@override
String toString() {
  return 'ConfigurePublicSourceRequest(enabled: $enabled, departements: $departements)';
}


}

/// @nodoc
abstract mixin class _$ConfigurePublicSourceRequestCopyWith<$Res> implements $ConfigurePublicSourceRequestCopyWith<$Res> {
  factory _$ConfigurePublicSourceRequestCopyWith(_ConfigurePublicSourceRequest value, $Res Function(_ConfigurePublicSourceRequest) _then) = __$ConfigurePublicSourceRequestCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, List<String> departements
});




}
/// @nodoc
class __$ConfigurePublicSourceRequestCopyWithImpl<$Res>
    implements _$ConfigurePublicSourceRequestCopyWith<$Res> {
  __$ConfigurePublicSourceRequestCopyWithImpl(this._self, this._then);

  final _ConfigurePublicSourceRequest _self;
  final $Res Function(_ConfigurePublicSourceRequest) _then;

/// Create a copy of ConfigurePublicSourceRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? departements = null,}) {
  return _then(_ConfigurePublicSourceRequest(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,departements: null == departements ? _self._departements : departements // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
