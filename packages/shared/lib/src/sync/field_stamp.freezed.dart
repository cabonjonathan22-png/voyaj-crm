// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_stamp.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FieldStamp {

/// HLC de l'écriture gagnante.
@JsonKey(name: 'h') String get hlc;/// Version de l'enregistrement produite par cette écriture.
@JsonKey(name: 'v') int get version;/// Utilisateur auteur de l'écriture.
@JsonKey(name: 'u') String? get userId;
/// Create a copy of FieldStamp
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldStampCopyWith<FieldStamp> get copyWith => _$FieldStampCopyWithImpl<FieldStamp>(this as FieldStamp, _$identity);

  /// Serializes this FieldStamp to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldStamp&&(identical(other.hlc, hlc) || other.hlc == hlc)&&(identical(other.version, version) || other.version == version)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hlc,version,userId);

@override
String toString() {
  return 'FieldStamp(hlc: $hlc, version: $version, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $FieldStampCopyWith<$Res>  {
  factory $FieldStampCopyWith(FieldStamp value, $Res Function(FieldStamp) _then) = _$FieldStampCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'h') String hlc,@JsonKey(name: 'v') int version,@JsonKey(name: 'u') String? userId
});




}
/// @nodoc
class _$FieldStampCopyWithImpl<$Res>
    implements $FieldStampCopyWith<$Res> {
  _$FieldStampCopyWithImpl(this._self, this._then);

  final FieldStamp _self;
  final $Res Function(FieldStamp) _then;

/// Create a copy of FieldStamp
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hlc = null,Object? version = null,Object? userId = freezed,}) {
  return _then(_self.copyWith(
hlc: null == hlc ? _self.hlc : hlc // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FieldStamp].
extension FieldStampPatterns on FieldStamp {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FieldStamp value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FieldStamp() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FieldStamp value)  $default,){
final _that = this;
switch (_that) {
case _FieldStamp():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FieldStamp value)?  $default,){
final _that = this;
switch (_that) {
case _FieldStamp() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'h')  String hlc, @JsonKey(name: 'v')  int version, @JsonKey(name: 'u')  String? userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldStamp() when $default != null:
return $default(_that.hlc,_that.version,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'h')  String hlc, @JsonKey(name: 'v')  int version, @JsonKey(name: 'u')  String? userId)  $default,) {final _that = this;
switch (_that) {
case _FieldStamp():
return $default(_that.hlc,_that.version,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'h')  String hlc, @JsonKey(name: 'v')  int version, @JsonKey(name: 'u')  String? userId)?  $default,) {final _that = this;
switch (_that) {
case _FieldStamp() when $default != null:
return $default(_that.hlc,_that.version,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FieldStamp implements FieldStamp {
  const _FieldStamp({@JsonKey(name: 'h') required this.hlc, @JsonKey(name: 'v') required this.version, @JsonKey(name: 'u') this.userId});
  factory _FieldStamp.fromJson(Map<String, dynamic> json) => _$FieldStampFromJson(json);

/// HLC de l'écriture gagnante.
@override@JsonKey(name: 'h') final  String hlc;
/// Version de l'enregistrement produite par cette écriture.
@override@JsonKey(name: 'v') final  int version;
/// Utilisateur auteur de l'écriture.
@override@JsonKey(name: 'u') final  String? userId;

/// Create a copy of FieldStamp
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldStampCopyWith<_FieldStamp> get copyWith => __$FieldStampCopyWithImpl<_FieldStamp>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FieldStampToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldStamp&&(identical(other.hlc, hlc) || other.hlc == hlc)&&(identical(other.version, version) || other.version == version)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hlc,version,userId);

@override
String toString() {
  return 'FieldStamp(hlc: $hlc, version: $version, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$FieldStampCopyWith<$Res> implements $FieldStampCopyWith<$Res> {
  factory _$FieldStampCopyWith(_FieldStamp value, $Res Function(_FieldStamp) _then) = __$FieldStampCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'h') String hlc,@JsonKey(name: 'v') int version,@JsonKey(name: 'u') String? userId
});




}
/// @nodoc
class __$FieldStampCopyWithImpl<$Res>
    implements _$FieldStampCopyWith<$Res> {
  __$FieldStampCopyWithImpl(this._self, this._then);

  final _FieldStamp _self;
  final $Res Function(_FieldStamp) _then;

/// Create a copy of FieldStamp
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hlc = null,Object? version = null,Object? userId = freezed,}) {
  return _then(_FieldStamp(
hlc: null == hlc ? _self.hlc : hlc // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
