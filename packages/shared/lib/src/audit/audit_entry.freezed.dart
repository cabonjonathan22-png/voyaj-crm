// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audit_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuditEntry {

 int get id; DateTime get occurredAt; String? get actorUserId; String? get actorName; String get action; String? get entity; String? get entityId; Map<String, Object?> get payload; String? get ip;
/// Create a copy of AuditEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuditEntryCopyWith<AuditEntry> get copyWith => _$AuditEntryCopyWithImpl<AuditEntry>(this as AuditEntry, _$identity);

  /// Serializes this AuditEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuditEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.actorUserId, actorUserId) || other.actorUserId == actorUserId)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&(identical(other.action, action) || other.action == action)&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&const DeepCollectionEquality().equals(other.payload, payload)&&(identical(other.ip, ip) || other.ip == ip));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,occurredAt,actorUserId,actorName,action,entity,entityId,const DeepCollectionEquality().hash(payload),ip);

@override
String toString() {
  return 'AuditEntry(id: $id, occurredAt: $occurredAt, actorUserId: $actorUserId, actorName: $actorName, action: $action, entity: $entity, entityId: $entityId, payload: $payload, ip: $ip)';
}


}

/// @nodoc
abstract mixin class $AuditEntryCopyWith<$Res>  {
  factory $AuditEntryCopyWith(AuditEntry value, $Res Function(AuditEntry) _then) = _$AuditEntryCopyWithImpl;
@useResult
$Res call({
 int id, DateTime occurredAt, String? actorUserId, String? actorName, String action, String? entity, String? entityId, Map<String, Object?> payload, String? ip
});




}
/// @nodoc
class _$AuditEntryCopyWithImpl<$Res>
    implements $AuditEntryCopyWith<$Res> {
  _$AuditEntryCopyWithImpl(this._self, this._then);

  final AuditEntry _self;
  final $Res Function(AuditEntry) _then;

/// Create a copy of AuditEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? occurredAt = null,Object? actorUserId = freezed,Object? actorName = freezed,Object? action = null,Object? entity = freezed,Object? entityId = freezed,Object? payload = null,Object? ip = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,actorUserId: freezed == actorUserId ? _self.actorUserId : actorUserId // ignore: cast_nullable_to_non_nullable
as String?,actorName: freezed == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String?,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,entity: freezed == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String?,entityId: freezed == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String?,payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,ip: freezed == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuditEntry].
extension AuditEntryPatterns on AuditEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuditEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuditEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuditEntry value)  $default,){
final _that = this;
switch (_that) {
case _AuditEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuditEntry value)?  $default,){
final _that = this;
switch (_that) {
case _AuditEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime occurredAt,  String? actorUserId,  String? actorName,  String action,  String? entity,  String? entityId,  Map<String, Object?> payload,  String? ip)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuditEntry() when $default != null:
return $default(_that.id,_that.occurredAt,_that.actorUserId,_that.actorName,_that.action,_that.entity,_that.entityId,_that.payload,_that.ip);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime occurredAt,  String? actorUserId,  String? actorName,  String action,  String? entity,  String? entityId,  Map<String, Object?> payload,  String? ip)  $default,) {final _that = this;
switch (_that) {
case _AuditEntry():
return $default(_that.id,_that.occurredAt,_that.actorUserId,_that.actorName,_that.action,_that.entity,_that.entityId,_that.payload,_that.ip);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime occurredAt,  String? actorUserId,  String? actorName,  String action,  String? entity,  String? entityId,  Map<String, Object?> payload,  String? ip)?  $default,) {final _that = this;
switch (_that) {
case _AuditEntry() when $default != null:
return $default(_that.id,_that.occurredAt,_that.actorUserId,_that.actorName,_that.action,_that.entity,_that.entityId,_that.payload,_that.ip);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuditEntry implements AuditEntry {
  const _AuditEntry({required this.id, required this.occurredAt, this.actorUserId, this.actorName, required this.action, this.entity, this.entityId, required final  Map<String, Object?> payload, this.ip}): _payload = payload;
  factory _AuditEntry.fromJson(Map<String, dynamic> json) => _$AuditEntryFromJson(json);

@override final  int id;
@override final  DateTime occurredAt;
@override final  String? actorUserId;
@override final  String? actorName;
@override final  String action;
@override final  String? entity;
@override final  String? entityId;
 final  Map<String, Object?> _payload;
@override Map<String, Object?> get payload {
  if (_payload is EqualUnmodifiableMapView) return _payload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_payload);
}

@override final  String? ip;

/// Create a copy of AuditEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuditEntryCopyWith<_AuditEntry> get copyWith => __$AuditEntryCopyWithImpl<_AuditEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuditEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuditEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.occurredAt, occurredAt) || other.occurredAt == occurredAt)&&(identical(other.actorUserId, actorUserId) || other.actorUserId == actorUserId)&&(identical(other.actorName, actorName) || other.actorName == actorName)&&(identical(other.action, action) || other.action == action)&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&const DeepCollectionEquality().equals(other._payload, _payload)&&(identical(other.ip, ip) || other.ip == ip));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,occurredAt,actorUserId,actorName,action,entity,entityId,const DeepCollectionEquality().hash(_payload),ip);

@override
String toString() {
  return 'AuditEntry(id: $id, occurredAt: $occurredAt, actorUserId: $actorUserId, actorName: $actorName, action: $action, entity: $entity, entityId: $entityId, payload: $payload, ip: $ip)';
}


}

/// @nodoc
abstract mixin class _$AuditEntryCopyWith<$Res> implements $AuditEntryCopyWith<$Res> {
  factory _$AuditEntryCopyWith(_AuditEntry value, $Res Function(_AuditEntry) _then) = __$AuditEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime occurredAt, String? actorUserId, String? actorName, String action, String? entity, String? entityId, Map<String, Object?> payload, String? ip
});




}
/// @nodoc
class __$AuditEntryCopyWithImpl<$Res>
    implements _$AuditEntryCopyWith<$Res> {
  __$AuditEntryCopyWithImpl(this._self, this._then);

  final _AuditEntry _self;
  final $Res Function(_AuditEntry) _then;

/// Create a copy of AuditEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? occurredAt = null,Object? actorUserId = freezed,Object? actorName = freezed,Object? action = null,Object? entity = freezed,Object? entityId = freezed,Object? payload = null,Object? ip = freezed,}) {
  return _then(_AuditEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,occurredAt: null == occurredAt ? _self.occurredAt : occurredAt // ignore: cast_nullable_to_non_nullable
as DateTime,actorUserId: freezed == actorUserId ? _self.actorUserId : actorUserId // ignore: cast_nullable_to_non_nullable
as String?,actorName: freezed == actorName ? _self.actorName : actorName // ignore: cast_nullable_to_non_nullable
as String?,action: null == action ? _self.action : action // ignore: cast_nullable_to_non_nullable
as String,entity: freezed == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String?,entityId: freezed == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String?,payload: null == payload ? _self._payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,ip: freezed == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
