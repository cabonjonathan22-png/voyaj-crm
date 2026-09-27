// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_token_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApiTokenInfo {

 String get id; String get name;/// Permissions accordées (limitées à celles de l'utilisateur au moment
/// de chaque appel).
 List<String> get permissions; DateTime get createdAt; DateTime? get lastUsedAt; DateTime? get expiresAt;
/// Create a copy of ApiTokenInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiTokenInfoCopyWith<ApiTokenInfo> get copyWith => _$ApiTokenInfoCopyWithImpl<ApiTokenInfo>(this as ApiTokenInfo, _$identity);

  /// Serializes this ApiTokenInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiTokenInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.permissions, permissions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(permissions),createdAt,lastUsedAt,expiresAt);

@override
String toString() {
  return 'ApiTokenInfo(id: $id, name: $name, permissions: $permissions, createdAt: $createdAt, lastUsedAt: $lastUsedAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $ApiTokenInfoCopyWith<$Res>  {
  factory $ApiTokenInfoCopyWith(ApiTokenInfo value, $Res Function(ApiTokenInfo) _then) = _$ApiTokenInfoCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<String> permissions, DateTime createdAt, DateTime? lastUsedAt, DateTime? expiresAt
});




}
/// @nodoc
class _$ApiTokenInfoCopyWithImpl<$Res>
    implements $ApiTokenInfoCopyWith<$Res> {
  _$ApiTokenInfoCopyWithImpl(this._self, this._then);

  final ApiTokenInfo _self;
  final $Res Function(ApiTokenInfo) _then;

/// Create a copy of ApiTokenInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? permissions = null,Object? createdAt = null,Object? lastUsedAt = freezed,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiTokenInfo].
extension ApiTokenInfoPatterns on ApiTokenInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiTokenInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiTokenInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiTokenInfo value)  $default,){
final _that = this;
switch (_that) {
case _ApiTokenInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiTokenInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ApiTokenInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<String> permissions,  DateTime createdAt,  DateTime? lastUsedAt,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiTokenInfo() when $default != null:
return $default(_that.id,_that.name,_that.permissions,_that.createdAt,_that.lastUsedAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<String> permissions,  DateTime createdAt,  DateTime? lastUsedAt,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _ApiTokenInfo():
return $default(_that.id,_that.name,_that.permissions,_that.createdAt,_that.lastUsedAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<String> permissions,  DateTime createdAt,  DateTime? lastUsedAt,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _ApiTokenInfo() when $default != null:
return $default(_that.id,_that.name,_that.permissions,_that.createdAt,_that.lastUsedAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApiTokenInfo implements ApiTokenInfo {
  const _ApiTokenInfo({required this.id, required this.name, required final  List<String> permissions, required this.createdAt, this.lastUsedAt, this.expiresAt}): _permissions = permissions;
  factory _ApiTokenInfo.fromJson(Map<String, dynamic> json) => _$ApiTokenInfoFromJson(json);

@override final  String id;
@override final  String name;
/// Permissions accordées (limitées à celles de l'utilisateur au moment
/// de chaque appel).
 final  List<String> _permissions;
/// Permissions accordées (limitées à celles de l'utilisateur au moment
/// de chaque appel).
@override List<String> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}

@override final  DateTime createdAt;
@override final  DateTime? lastUsedAt;
@override final  DateTime? expiresAt;

/// Create a copy of ApiTokenInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiTokenInfoCopyWith<_ApiTokenInfo> get copyWith => __$ApiTokenInfoCopyWithImpl<_ApiTokenInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApiTokenInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiTokenInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._permissions, _permissions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_permissions),createdAt,lastUsedAt,expiresAt);

@override
String toString() {
  return 'ApiTokenInfo(id: $id, name: $name, permissions: $permissions, createdAt: $createdAt, lastUsedAt: $lastUsedAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$ApiTokenInfoCopyWith<$Res> implements $ApiTokenInfoCopyWith<$Res> {
  factory _$ApiTokenInfoCopyWith(_ApiTokenInfo value, $Res Function(_ApiTokenInfo) _then) = __$ApiTokenInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<String> permissions, DateTime createdAt, DateTime? lastUsedAt, DateTime? expiresAt
});




}
/// @nodoc
class __$ApiTokenInfoCopyWithImpl<$Res>
    implements _$ApiTokenInfoCopyWith<$Res> {
  __$ApiTokenInfoCopyWithImpl(this._self, this._then);

  final _ApiTokenInfo _self;
  final $Res Function(_ApiTokenInfo) _then;

/// Create a copy of ApiTokenInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? permissions = null,Object? createdAt = null,Object? lastUsedAt = freezed,Object? expiresAt = freezed,}) {
  return _then(_ApiTokenInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CreateApiTokenRequest {

 String get name; List<String> get permissions;/// Durée de validité (jours) ; `null` : sans expiration.
 int? get expiresInDays;
/// Create a copy of CreateApiTokenRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateApiTokenRequestCopyWith<CreateApiTokenRequest> get copyWith => _$CreateApiTokenRequestCopyWithImpl<CreateApiTokenRequest>(this as CreateApiTokenRequest, _$identity);

  /// Serializes this CreateApiTokenRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateApiTokenRequest&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.permissions, permissions)&&(identical(other.expiresInDays, expiresInDays) || other.expiresInDays == expiresInDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(permissions),expiresInDays);

@override
String toString() {
  return 'CreateApiTokenRequest(name: $name, permissions: $permissions, expiresInDays: $expiresInDays)';
}


}

/// @nodoc
abstract mixin class $CreateApiTokenRequestCopyWith<$Res>  {
  factory $CreateApiTokenRequestCopyWith(CreateApiTokenRequest value, $Res Function(CreateApiTokenRequest) _then) = _$CreateApiTokenRequestCopyWithImpl;
@useResult
$Res call({
 String name, List<String> permissions, int? expiresInDays
});




}
/// @nodoc
class _$CreateApiTokenRequestCopyWithImpl<$Res>
    implements $CreateApiTokenRequestCopyWith<$Res> {
  _$CreateApiTokenRequestCopyWithImpl(this._self, this._then);

  final CreateApiTokenRequest _self;
  final $Res Function(CreateApiTokenRequest) _then;

/// Create a copy of CreateApiTokenRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? permissions = null,Object? expiresInDays = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,expiresInDays: freezed == expiresInDays ? _self.expiresInDays : expiresInDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateApiTokenRequest].
extension CreateApiTokenRequestPatterns on CreateApiTokenRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateApiTokenRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateApiTokenRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateApiTokenRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateApiTokenRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateApiTokenRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateApiTokenRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  List<String> permissions,  int? expiresInDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateApiTokenRequest() when $default != null:
return $default(_that.name,_that.permissions,_that.expiresInDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  List<String> permissions,  int? expiresInDays)  $default,) {final _that = this;
switch (_that) {
case _CreateApiTokenRequest():
return $default(_that.name,_that.permissions,_that.expiresInDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  List<String> permissions,  int? expiresInDays)?  $default,) {final _that = this;
switch (_that) {
case _CreateApiTokenRequest() when $default != null:
return $default(_that.name,_that.permissions,_that.expiresInDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateApiTokenRequest implements CreateApiTokenRequest {
  const _CreateApiTokenRequest({required this.name, required final  List<String> permissions, this.expiresInDays}): _permissions = permissions;
  factory _CreateApiTokenRequest.fromJson(Map<String, dynamic> json) => _$CreateApiTokenRequestFromJson(json);

@override final  String name;
 final  List<String> _permissions;
@override List<String> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}

/// Durée de validité (jours) ; `null` : sans expiration.
@override final  int? expiresInDays;

/// Create a copy of CreateApiTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateApiTokenRequestCopyWith<_CreateApiTokenRequest> get copyWith => __$CreateApiTokenRequestCopyWithImpl<_CreateApiTokenRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateApiTokenRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateApiTokenRequest&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._permissions, _permissions)&&(identical(other.expiresInDays, expiresInDays) || other.expiresInDays == expiresInDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_permissions),expiresInDays);

@override
String toString() {
  return 'CreateApiTokenRequest(name: $name, permissions: $permissions, expiresInDays: $expiresInDays)';
}


}

/// @nodoc
abstract mixin class _$CreateApiTokenRequestCopyWith<$Res> implements $CreateApiTokenRequestCopyWith<$Res> {
  factory _$CreateApiTokenRequestCopyWith(_CreateApiTokenRequest value, $Res Function(_CreateApiTokenRequest) _then) = __$CreateApiTokenRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, List<String> permissions, int? expiresInDays
});




}
/// @nodoc
class __$CreateApiTokenRequestCopyWithImpl<$Res>
    implements _$CreateApiTokenRequestCopyWith<$Res> {
  __$CreateApiTokenRequestCopyWithImpl(this._self, this._then);

  final _CreateApiTokenRequest _self;
  final $Res Function(_CreateApiTokenRequest) _then;

/// Create a copy of CreateApiTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? permissions = null,Object? expiresInDays = freezed,}) {
  return _then(_CreateApiTokenRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,expiresInDays: freezed == expiresInDays ? _self.expiresInDays : expiresInDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$CreatedApiToken {

 ApiTokenInfo get info;/// Valeur du jeton (`vpat_…`), affichée une seule fois.
 String get token;
/// Create a copy of CreatedApiToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreatedApiTokenCopyWith<CreatedApiToken> get copyWith => _$CreatedApiTokenCopyWithImpl<CreatedApiToken>(this as CreatedApiToken, _$identity);

  /// Serializes this CreatedApiToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreatedApiToken&&(identical(other.info, info) || other.info == info)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,token);

@override
String toString() {
  return 'CreatedApiToken(info: $info, token: $token)';
}


}

/// @nodoc
abstract mixin class $CreatedApiTokenCopyWith<$Res>  {
  factory $CreatedApiTokenCopyWith(CreatedApiToken value, $Res Function(CreatedApiToken) _then) = _$CreatedApiTokenCopyWithImpl;
@useResult
$Res call({
 ApiTokenInfo info, String token
});


$ApiTokenInfoCopyWith<$Res> get info;

}
/// @nodoc
class _$CreatedApiTokenCopyWithImpl<$Res>
    implements $CreatedApiTokenCopyWith<$Res> {
  _$CreatedApiTokenCopyWithImpl(this._self, this._then);

  final CreatedApiToken _self;
  final $Res Function(CreatedApiToken) _then;

/// Create a copy of CreatedApiToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? info = null,Object? token = null,}) {
  return _then(_self.copyWith(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as ApiTokenInfo,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of CreatedApiToken
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiTokenInfoCopyWith<$Res> get info {
  
  return $ApiTokenInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreatedApiToken].
extension CreatedApiTokenPatterns on CreatedApiToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreatedApiToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreatedApiToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreatedApiToken value)  $default,){
final _that = this;
switch (_that) {
case _CreatedApiToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreatedApiToken value)?  $default,){
final _that = this;
switch (_that) {
case _CreatedApiToken() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ApiTokenInfo info,  String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreatedApiToken() when $default != null:
return $default(_that.info,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ApiTokenInfo info,  String token)  $default,) {final _that = this;
switch (_that) {
case _CreatedApiToken():
return $default(_that.info,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ApiTokenInfo info,  String token)?  $default,) {final _that = this;
switch (_that) {
case _CreatedApiToken() when $default != null:
return $default(_that.info,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreatedApiToken implements CreatedApiToken {
  const _CreatedApiToken({required this.info, required this.token});
  factory _CreatedApiToken.fromJson(Map<String, dynamic> json) => _$CreatedApiTokenFromJson(json);

@override final  ApiTokenInfo info;
/// Valeur du jeton (`vpat_…`), affichée une seule fois.
@override final  String token;

/// Create a copy of CreatedApiToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreatedApiTokenCopyWith<_CreatedApiToken> get copyWith => __$CreatedApiTokenCopyWithImpl<_CreatedApiToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreatedApiTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreatedApiToken&&(identical(other.info, info) || other.info == info)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,info,token);

@override
String toString() {
  return 'CreatedApiToken(info: $info, token: $token)';
}


}

/// @nodoc
abstract mixin class _$CreatedApiTokenCopyWith<$Res> implements $CreatedApiTokenCopyWith<$Res> {
  factory _$CreatedApiTokenCopyWith(_CreatedApiToken value, $Res Function(_CreatedApiToken) _then) = __$CreatedApiTokenCopyWithImpl;
@override @useResult
$Res call({
 ApiTokenInfo info, String token
});


@override $ApiTokenInfoCopyWith<$Res> get info;

}
/// @nodoc
class __$CreatedApiTokenCopyWithImpl<$Res>
    implements _$CreatedApiTokenCopyWith<$Res> {
  __$CreatedApiTokenCopyWithImpl(this._self, this._then);

  final _CreatedApiToken _self;
  final $Res Function(_CreatedApiToken) _then;

/// Create a copy of CreatedApiToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? info = null,Object? token = null,}) {
  return _then(_CreatedApiToken(
info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as ApiTokenInfo,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of CreatedApiToken
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApiTokenInfoCopyWith<$Res> get info {
  
  return $ApiTokenInfoCopyWith<$Res>(_self.info, (value) {
    return _then(_self.copyWith(info: value));
  });
}
}

// dart format on
