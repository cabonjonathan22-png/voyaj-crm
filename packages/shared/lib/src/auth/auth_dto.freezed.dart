// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginRequest {

 String get email; String get password; DeviceInfo get device;
/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginRequestCopyWith<LoginRequest> get copyWith => _$LoginRequestCopyWithImpl<LoginRequest>(this as LoginRequest, _$identity);

  /// Serializes this LoginRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.device, device) || other.device == device));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,device);

@override
String toString() {
  return 'LoginRequest(email: $email, password: $password, device: $device)';
}


}

/// @nodoc
abstract mixin class $LoginRequestCopyWith<$Res>  {
  factory $LoginRequestCopyWith(LoginRequest value, $Res Function(LoginRequest) _then) = _$LoginRequestCopyWithImpl;
@useResult
$Res call({
 String email, String password, DeviceInfo device
});


$DeviceInfoCopyWith<$Res> get device;

}
/// @nodoc
class _$LoginRequestCopyWithImpl<$Res>
    implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._self, this._then);

  final LoginRequest _self;
  final $Res Function(LoginRequest) _then;

/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? device = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,device: null == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as DeviceInfo,
  ));
}
/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceInfoCopyWith<$Res> get device {
  
  return $DeviceInfoCopyWith<$Res>(_self.device, (value) {
    return _then(_self.copyWith(device: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginRequest].
extension LoginRequestPatterns on LoginRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginRequest value)  $default,){
final _that = this;
switch (_that) {
case _LoginRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginRequest value)?  $default,){
final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password,  DeviceInfo device)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
return $default(_that.email,_that.password,_that.device);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password,  DeviceInfo device)  $default,) {final _that = this;
switch (_that) {
case _LoginRequest():
return $default(_that.email,_that.password,_that.device);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password,  DeviceInfo device)?  $default,) {final _that = this;
switch (_that) {
case _LoginRequest() when $default != null:
return $default(_that.email,_that.password,_that.device);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginRequest implements LoginRequest {
  const _LoginRequest({required this.email, required this.password, required this.device});
  factory _LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

@override final  String email;
@override final  String password;
@override final  DeviceInfo device;

/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginRequestCopyWith<_LoginRequest> get copyWith => __$LoginRequestCopyWithImpl<_LoginRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.device, device) || other.device == device));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password,device);

@override
String toString() {
  return 'LoginRequest(email: $email, password: $password, device: $device)';
}


}

/// @nodoc
abstract mixin class _$LoginRequestCopyWith<$Res> implements $LoginRequestCopyWith<$Res> {
  factory _$LoginRequestCopyWith(_LoginRequest value, $Res Function(_LoginRequest) _then) = __$LoginRequestCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, DeviceInfo device
});


@override $DeviceInfoCopyWith<$Res> get device;

}
/// @nodoc
class __$LoginRequestCopyWithImpl<$Res>
    implements _$LoginRequestCopyWith<$Res> {
  __$LoginRequestCopyWithImpl(this._self, this._then);

  final _LoginRequest _self;
  final $Res Function(_LoginRequest) _then;

/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? device = null,}) {
  return _then(_LoginRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,device: null == device ? _self.device : device // ignore: cast_nullable_to_non_nullable
as DeviceInfo,
  ));
}

/// Create a copy of LoginRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeviceInfoCopyWith<$Res> get device {
  
  return $DeviceInfoCopyWith<$Res>(_self.device, (value) {
    return _then(_self.copyWith(device: value));
  });
}
}


/// @nodoc
mixin _$DeviceInfo {

/// Identifiant stable du poste (UUID généré à l'installation).
 String get id; String get name; String get platform; String get appVersion;
/// Create a copy of DeviceInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceInfoCopyWith<DeviceInfo> get copyWith => _$DeviceInfoCopyWithImpl<DeviceInfo>(this as DeviceInfo, _$identity);

  /// Serializes this DeviceInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,platform,appVersion);

@override
String toString() {
  return 'DeviceInfo(id: $id, name: $name, platform: $platform, appVersion: $appVersion)';
}


}

/// @nodoc
abstract mixin class $DeviceInfoCopyWith<$Res>  {
  factory $DeviceInfoCopyWith(DeviceInfo value, $Res Function(DeviceInfo) _then) = _$DeviceInfoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String platform, String appVersion
});




}
/// @nodoc
class _$DeviceInfoCopyWithImpl<$Res>
    implements $DeviceInfoCopyWith<$Res> {
  _$DeviceInfoCopyWithImpl(this._self, this._then);

  final DeviceInfo _self;
  final $Res Function(DeviceInfo) _then;

/// Create a copy of DeviceInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? platform = null,Object? appVersion = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceInfo].
extension DeviceInfoPatterns on DeviceInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceInfo value)  $default,){
final _that = this;
switch (_that) {
case _DeviceInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceInfo value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String platform,  String appVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceInfo() when $default != null:
return $default(_that.id,_that.name,_that.platform,_that.appVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String platform,  String appVersion)  $default,) {final _that = this;
switch (_that) {
case _DeviceInfo():
return $default(_that.id,_that.name,_that.platform,_that.appVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String platform,  String appVersion)?  $default,) {final _that = this;
switch (_that) {
case _DeviceInfo() when $default != null:
return $default(_that.id,_that.name,_that.platform,_that.appVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceInfo implements DeviceInfo {
  const _DeviceInfo({required this.id, required this.name, required this.platform, required this.appVersion});
  factory _DeviceInfo.fromJson(Map<String, dynamic> json) => _$DeviceInfoFromJson(json);

/// Identifiant stable du poste (UUID généré à l'installation).
@override final  String id;
@override final  String name;
@override final  String platform;
@override final  String appVersion;

/// Create a copy of DeviceInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceInfoCopyWith<_DeviceInfo> get copyWith => __$DeviceInfoCopyWithImpl<_DeviceInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,platform,appVersion);

@override
String toString() {
  return 'DeviceInfo(id: $id, name: $name, platform: $platform, appVersion: $appVersion)';
}


}

/// @nodoc
abstract mixin class _$DeviceInfoCopyWith<$Res> implements $DeviceInfoCopyWith<$Res> {
  factory _$DeviceInfoCopyWith(_DeviceInfo value, $Res Function(_DeviceInfo) _then) = __$DeviceInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String platform, String appVersion
});




}
/// @nodoc
class __$DeviceInfoCopyWithImpl<$Res>
    implements _$DeviceInfoCopyWith<$Res> {
  __$DeviceInfoCopyWithImpl(this._self, this._then);

  final _DeviceInfo _self;
  final $Res Function(_DeviceInfo) _then;

/// Create a copy of DeviceInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? platform = null,Object? appVersion = null,}) {
  return _then(_DeviceInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

LoginResponse _$LoginResponseFromJson(
  Map<String, dynamic> json
) {
        switch (json['status']) {
                  case 'authenticated':
          return LoginAuthenticated.fromJson(
            json
          );
                case 'mfa_required':
          return LoginMfaRequired.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'status',
  'LoginResponse',
  'Invalid union type "${json['status']}"!'
);
        }
      
}

/// @nodoc
mixin _$LoginResponse {



  /// Serializes this LoginResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginResponse);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginResponse()';
}


}

/// @nodoc
class $LoginResponseCopyWith<$Res>  {
$LoginResponseCopyWith(LoginResponse _, $Res Function(LoginResponse) __);
}


/// Adds pattern-matching-related methods to [LoginResponse].
extension LoginResponsePatterns on LoginResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoginAuthenticated value)?  authenticated,TResult Function( LoginMfaRequired value)?  mfaRequired,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoginAuthenticated() when authenticated != null:
return authenticated(_that);case LoginMfaRequired() when mfaRequired != null:
return mfaRequired(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoginAuthenticated value)  authenticated,required TResult Function( LoginMfaRequired value)  mfaRequired,}){
final _that = this;
switch (_that) {
case LoginAuthenticated():
return authenticated(_that);case LoginMfaRequired():
return mfaRequired(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoginAuthenticated value)?  authenticated,TResult? Function( LoginMfaRequired value)?  mfaRequired,}){
final _that = this;
switch (_that) {
case LoginAuthenticated() when authenticated != null:
return authenticated(_that);case LoginMfaRequired() when mfaRequired != null:
return mfaRequired(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AuthTokens tokens,  CurrentUser user)?  authenticated,TResult Function( String mfaToken)?  mfaRequired,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoginAuthenticated() when authenticated != null:
return authenticated(_that.tokens,_that.user);case LoginMfaRequired() when mfaRequired != null:
return mfaRequired(_that.mfaToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AuthTokens tokens,  CurrentUser user)  authenticated,required TResult Function( String mfaToken)  mfaRequired,}) {final _that = this;
switch (_that) {
case LoginAuthenticated():
return authenticated(_that.tokens,_that.user);case LoginMfaRequired():
return mfaRequired(_that.mfaToken);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AuthTokens tokens,  CurrentUser user)?  authenticated,TResult? Function( String mfaToken)?  mfaRequired,}) {final _that = this;
switch (_that) {
case LoginAuthenticated() when authenticated != null:
return authenticated(_that.tokens,_that.user);case LoginMfaRequired() when mfaRequired != null:
return mfaRequired(_that.mfaToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class LoginAuthenticated implements LoginResponse {
  const LoginAuthenticated({required this.tokens, required this.user, final  String? $type}): $type = $type ?? 'authenticated';
  factory LoginAuthenticated.fromJson(Map<String, dynamic> json) => _$LoginAuthenticatedFromJson(json);

 final  AuthTokens tokens;
 final  CurrentUser user;

@JsonKey(name: 'status')
final String $type;


/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginAuthenticatedCopyWith<LoginAuthenticated> get copyWith => _$LoginAuthenticatedCopyWithImpl<LoginAuthenticated>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginAuthenticatedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginAuthenticated&&(identical(other.tokens, tokens) || other.tokens == tokens)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tokens,user);

@override
String toString() {
  return 'LoginResponse.authenticated(tokens: $tokens, user: $user)';
}


}

/// @nodoc
abstract mixin class $LoginAuthenticatedCopyWith<$Res> implements $LoginResponseCopyWith<$Res> {
  factory $LoginAuthenticatedCopyWith(LoginAuthenticated value, $Res Function(LoginAuthenticated) _then) = _$LoginAuthenticatedCopyWithImpl;
@useResult
$Res call({
 AuthTokens tokens, CurrentUser user
});


$AuthTokensCopyWith<$Res> get tokens;$CurrentUserCopyWith<$Res> get user;

}
/// @nodoc
class _$LoginAuthenticatedCopyWithImpl<$Res>
    implements $LoginAuthenticatedCopyWith<$Res> {
  _$LoginAuthenticatedCopyWithImpl(this._self, this._then);

  final LoginAuthenticated _self;
  final $Res Function(LoginAuthenticated) _then;

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tokens = null,Object? user = null,}) {
  return _then(LoginAuthenticated(
tokens: null == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as AuthTokens,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as CurrentUser,
  ));
}

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthTokensCopyWith<$Res> get tokens {
  
  return $AuthTokensCopyWith<$Res>(_self.tokens, (value) {
    return _then(_self.copyWith(tokens: value));
  });
}/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CurrentUserCopyWith<$Res> get user {
  
  return $CurrentUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class LoginMfaRequired implements LoginResponse {
  const LoginMfaRequired({required this.mfaToken, final  String? $type}): $type = $type ?? 'mfa_required';
  factory LoginMfaRequired.fromJson(Map<String, dynamic> json) => _$LoginMfaRequiredFromJson(json);

/// Jeton temporaire (5 min) à renvoyer avec le code.
 final  String mfaToken;

@JsonKey(name: 'status')
final String $type;


/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginMfaRequiredCopyWith<LoginMfaRequired> get copyWith => _$LoginMfaRequiredCopyWithImpl<LoginMfaRequired>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginMfaRequiredToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginMfaRequired&&(identical(other.mfaToken, mfaToken) || other.mfaToken == mfaToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mfaToken);

@override
String toString() {
  return 'LoginResponse.mfaRequired(mfaToken: $mfaToken)';
}


}

/// @nodoc
abstract mixin class $LoginMfaRequiredCopyWith<$Res> implements $LoginResponseCopyWith<$Res> {
  factory $LoginMfaRequiredCopyWith(LoginMfaRequired value, $Res Function(LoginMfaRequired) _then) = _$LoginMfaRequiredCopyWithImpl;
@useResult
$Res call({
 String mfaToken
});




}
/// @nodoc
class _$LoginMfaRequiredCopyWithImpl<$Res>
    implements $LoginMfaRequiredCopyWith<$Res> {
  _$LoginMfaRequiredCopyWithImpl(this._self, this._then);

  final LoginMfaRequired _self;
  final $Res Function(LoginMfaRequired) _then;

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mfaToken = null,}) {
  return _then(LoginMfaRequired(
mfaToken: null == mfaToken ? _self.mfaToken : mfaToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MfaVerifyRequest {

 String get mfaToken;/// Code TOTP à 6 chiffres ou code de secours.
 String get code;
/// Create a copy of MfaVerifyRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MfaVerifyRequestCopyWith<MfaVerifyRequest> get copyWith => _$MfaVerifyRequestCopyWithImpl<MfaVerifyRequest>(this as MfaVerifyRequest, _$identity);

  /// Serializes this MfaVerifyRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MfaVerifyRequest&&(identical(other.mfaToken, mfaToken) || other.mfaToken == mfaToken)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mfaToken,code);

@override
String toString() {
  return 'MfaVerifyRequest(mfaToken: $mfaToken, code: $code)';
}


}

/// @nodoc
abstract mixin class $MfaVerifyRequestCopyWith<$Res>  {
  factory $MfaVerifyRequestCopyWith(MfaVerifyRequest value, $Res Function(MfaVerifyRequest) _then) = _$MfaVerifyRequestCopyWithImpl;
@useResult
$Res call({
 String mfaToken, String code
});




}
/// @nodoc
class _$MfaVerifyRequestCopyWithImpl<$Res>
    implements $MfaVerifyRequestCopyWith<$Res> {
  _$MfaVerifyRequestCopyWithImpl(this._self, this._then);

  final MfaVerifyRequest _self;
  final $Res Function(MfaVerifyRequest) _then;

/// Create a copy of MfaVerifyRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mfaToken = null,Object? code = null,}) {
  return _then(_self.copyWith(
mfaToken: null == mfaToken ? _self.mfaToken : mfaToken // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MfaVerifyRequest].
extension MfaVerifyRequestPatterns on MfaVerifyRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MfaVerifyRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MfaVerifyRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MfaVerifyRequest value)  $default,){
final _that = this;
switch (_that) {
case _MfaVerifyRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MfaVerifyRequest value)?  $default,){
final _that = this;
switch (_that) {
case _MfaVerifyRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mfaToken,  String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MfaVerifyRequest() when $default != null:
return $default(_that.mfaToken,_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mfaToken,  String code)  $default,) {final _that = this;
switch (_that) {
case _MfaVerifyRequest():
return $default(_that.mfaToken,_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mfaToken,  String code)?  $default,) {final _that = this;
switch (_that) {
case _MfaVerifyRequest() when $default != null:
return $default(_that.mfaToken,_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MfaVerifyRequest implements MfaVerifyRequest {
  const _MfaVerifyRequest({required this.mfaToken, required this.code});
  factory _MfaVerifyRequest.fromJson(Map<String, dynamic> json) => _$MfaVerifyRequestFromJson(json);

@override final  String mfaToken;
/// Code TOTP à 6 chiffres ou code de secours.
@override final  String code;

/// Create a copy of MfaVerifyRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MfaVerifyRequestCopyWith<_MfaVerifyRequest> get copyWith => __$MfaVerifyRequestCopyWithImpl<_MfaVerifyRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MfaVerifyRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MfaVerifyRequest&&(identical(other.mfaToken, mfaToken) || other.mfaToken == mfaToken)&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mfaToken,code);

@override
String toString() {
  return 'MfaVerifyRequest(mfaToken: $mfaToken, code: $code)';
}


}

/// @nodoc
abstract mixin class _$MfaVerifyRequestCopyWith<$Res> implements $MfaVerifyRequestCopyWith<$Res> {
  factory _$MfaVerifyRequestCopyWith(_MfaVerifyRequest value, $Res Function(_MfaVerifyRequest) _then) = __$MfaVerifyRequestCopyWithImpl;
@override @useResult
$Res call({
 String mfaToken, String code
});




}
/// @nodoc
class __$MfaVerifyRequestCopyWithImpl<$Res>
    implements _$MfaVerifyRequestCopyWith<$Res> {
  __$MfaVerifyRequestCopyWithImpl(this._self, this._then);

  final _MfaVerifyRequest _self;
  final $Res Function(_MfaVerifyRequest) _then;

/// Create a copy of MfaVerifyRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mfaToken = null,Object? code = null,}) {
  return _then(_MfaVerifyRequest(
mfaToken: null == mfaToken ? _self.mfaToken : mfaToken // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AuthTokens {

 String get sessionId; String get accessToken; DateTime get accessExpiresAt; String get refreshToken; DateTime get refreshExpiresAt;
/// Create a copy of AuthTokens
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthTokensCopyWith<AuthTokens> get copyWith => _$AuthTokensCopyWithImpl<AuthTokens>(this as AuthTokens, _$identity);

  /// Serializes this AuthTokens to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthTokens&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.accessExpiresAt, accessExpiresAt) || other.accessExpiresAt == accessExpiresAt)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.refreshExpiresAt, refreshExpiresAt) || other.refreshExpiresAt == refreshExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,accessToken,accessExpiresAt,refreshToken,refreshExpiresAt);

@override
String toString() {
  return 'AuthTokens(sessionId: $sessionId, accessToken: $accessToken, accessExpiresAt: $accessExpiresAt, refreshToken: $refreshToken, refreshExpiresAt: $refreshExpiresAt)';
}


}

/// @nodoc
abstract mixin class $AuthTokensCopyWith<$Res>  {
  factory $AuthTokensCopyWith(AuthTokens value, $Res Function(AuthTokens) _then) = _$AuthTokensCopyWithImpl;
@useResult
$Res call({
 String sessionId, String accessToken, DateTime accessExpiresAt, String refreshToken, DateTime refreshExpiresAt
});




}
/// @nodoc
class _$AuthTokensCopyWithImpl<$Res>
    implements $AuthTokensCopyWith<$Res> {
  _$AuthTokensCopyWithImpl(this._self, this._then);

  final AuthTokens _self;
  final $Res Function(AuthTokens) _then;

/// Create a copy of AuthTokens
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = null,Object? accessToken = null,Object? accessExpiresAt = null,Object? refreshToken = null,Object? refreshExpiresAt = null,}) {
  return _then(_self.copyWith(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,accessExpiresAt: null == accessExpiresAt ? _self.accessExpiresAt : accessExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,refreshExpiresAt: null == refreshExpiresAt ? _self.refreshExpiresAt : refreshExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthTokens].
extension AuthTokensPatterns on AuthTokens {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthTokens value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthTokens() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthTokens value)  $default,){
final _that = this;
switch (_that) {
case _AuthTokens():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthTokens value)?  $default,){
final _that = this;
switch (_that) {
case _AuthTokens() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sessionId,  String accessToken,  DateTime accessExpiresAt,  String refreshToken,  DateTime refreshExpiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthTokens() when $default != null:
return $default(_that.sessionId,_that.accessToken,_that.accessExpiresAt,_that.refreshToken,_that.refreshExpiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sessionId,  String accessToken,  DateTime accessExpiresAt,  String refreshToken,  DateTime refreshExpiresAt)  $default,) {final _that = this;
switch (_that) {
case _AuthTokens():
return $default(_that.sessionId,_that.accessToken,_that.accessExpiresAt,_that.refreshToken,_that.refreshExpiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sessionId,  String accessToken,  DateTime accessExpiresAt,  String refreshToken,  DateTime refreshExpiresAt)?  $default,) {final _that = this;
switch (_that) {
case _AuthTokens() when $default != null:
return $default(_that.sessionId,_that.accessToken,_that.accessExpiresAt,_that.refreshToken,_that.refreshExpiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthTokens implements AuthTokens {
  const _AuthTokens({required this.sessionId, required this.accessToken, required this.accessExpiresAt, required this.refreshToken, required this.refreshExpiresAt});
  factory _AuthTokens.fromJson(Map<String, dynamic> json) => _$AuthTokensFromJson(json);

@override final  String sessionId;
@override final  String accessToken;
@override final  DateTime accessExpiresAt;
@override final  String refreshToken;
@override final  DateTime refreshExpiresAt;

/// Create a copy of AuthTokens
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthTokensCopyWith<_AuthTokens> get copyWith => __$AuthTokensCopyWithImpl<_AuthTokens>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthTokensToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthTokens&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.accessExpiresAt, accessExpiresAt) || other.accessExpiresAt == accessExpiresAt)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.refreshExpiresAt, refreshExpiresAt) || other.refreshExpiresAt == refreshExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,accessToken,accessExpiresAt,refreshToken,refreshExpiresAt);

@override
String toString() {
  return 'AuthTokens(sessionId: $sessionId, accessToken: $accessToken, accessExpiresAt: $accessExpiresAt, refreshToken: $refreshToken, refreshExpiresAt: $refreshExpiresAt)';
}


}

/// @nodoc
abstract mixin class _$AuthTokensCopyWith<$Res> implements $AuthTokensCopyWith<$Res> {
  factory _$AuthTokensCopyWith(_AuthTokens value, $Res Function(_AuthTokens) _then) = __$AuthTokensCopyWithImpl;
@override @useResult
$Res call({
 String sessionId, String accessToken, DateTime accessExpiresAt, String refreshToken, DateTime refreshExpiresAt
});




}
/// @nodoc
class __$AuthTokensCopyWithImpl<$Res>
    implements _$AuthTokensCopyWith<$Res> {
  __$AuthTokensCopyWithImpl(this._self, this._then);

  final _AuthTokens _self;
  final $Res Function(_AuthTokens) _then;

/// Create a copy of AuthTokens
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? accessToken = null,Object? accessExpiresAt = null,Object? refreshToken = null,Object? refreshExpiresAt = null,}) {
  return _then(_AuthTokens(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,accessExpiresAt: null == accessExpiresAt ? _self.accessExpiresAt : accessExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,refreshExpiresAt: null == refreshExpiresAt ? _self.refreshExpiresAt : refreshExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$RefreshRequest {

 String get refreshToken;
/// Create a copy of RefreshRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RefreshRequestCopyWith<RefreshRequest> get copyWith => _$RefreshRequestCopyWithImpl<RefreshRequest>(this as RefreshRequest, _$identity);

  /// Serializes this RefreshRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RefreshRequest&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,refreshToken);

@override
String toString() {
  return 'RefreshRequest(refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $RefreshRequestCopyWith<$Res>  {
  factory $RefreshRequestCopyWith(RefreshRequest value, $Res Function(RefreshRequest) _then) = _$RefreshRequestCopyWithImpl;
@useResult
$Res call({
 String refreshToken
});




}
/// @nodoc
class _$RefreshRequestCopyWithImpl<$Res>
    implements $RefreshRequestCopyWith<$Res> {
  _$RefreshRequestCopyWithImpl(this._self, this._then);

  final RefreshRequest _self;
  final $Res Function(RefreshRequest) _then;

/// Create a copy of RefreshRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? refreshToken = null,}) {
  return _then(_self.copyWith(
refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RefreshRequest].
extension RefreshRequestPatterns on RefreshRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RefreshRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RefreshRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RefreshRequest value)  $default,){
final _that = this;
switch (_that) {
case _RefreshRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RefreshRequest value)?  $default,){
final _that = this;
switch (_that) {
case _RefreshRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String refreshToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RefreshRequest() when $default != null:
return $default(_that.refreshToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String refreshToken)  $default,) {final _that = this;
switch (_that) {
case _RefreshRequest():
return $default(_that.refreshToken);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String refreshToken)?  $default,) {final _that = this;
switch (_that) {
case _RefreshRequest() when $default != null:
return $default(_that.refreshToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RefreshRequest implements RefreshRequest {
  const _RefreshRequest({required this.refreshToken});
  factory _RefreshRequest.fromJson(Map<String, dynamic> json) => _$RefreshRequestFromJson(json);

@override final  String refreshToken;

/// Create a copy of RefreshRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RefreshRequestCopyWith<_RefreshRequest> get copyWith => __$RefreshRequestCopyWithImpl<_RefreshRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RefreshRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshRequest&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,refreshToken);

@override
String toString() {
  return 'RefreshRequest(refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class _$RefreshRequestCopyWith<$Res> implements $RefreshRequestCopyWith<$Res> {
  factory _$RefreshRequestCopyWith(_RefreshRequest value, $Res Function(_RefreshRequest) _then) = __$RefreshRequestCopyWithImpl;
@override @useResult
$Res call({
 String refreshToken
});




}
/// @nodoc
class __$RefreshRequestCopyWithImpl<$Res>
    implements _$RefreshRequestCopyWith<$Res> {
  __$RefreshRequestCopyWithImpl(this._self, this._then);

  final _RefreshRequest _self;
  final $Res Function(_RefreshRequest) _then;

/// Create a copy of RefreshRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? refreshToken = null,}) {
  return _then(_RefreshRequest(
refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CurrentUser {

 String get id; String get email; String get displayName; bool get totpEnabled; List<String> get roles; List<String> get permissions;
/// Create a copy of CurrentUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentUserCopyWith<CurrentUser> get copyWith => _$CurrentUserCopyWithImpl<CurrentUser>(this as CurrentUser, _$identity);

  /// Serializes this CurrentUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.totpEnabled, totpEnabled) || other.totpEnabled == totpEnabled)&&const DeepCollectionEquality().equals(other.roles, roles)&&const DeepCollectionEquality().equals(other.permissions, permissions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,totpEnabled,const DeepCollectionEquality().hash(roles),const DeepCollectionEquality().hash(permissions));

@override
String toString() {
  return 'CurrentUser(id: $id, email: $email, displayName: $displayName, totpEnabled: $totpEnabled, roles: $roles, permissions: $permissions)';
}


}

/// @nodoc
abstract mixin class $CurrentUserCopyWith<$Res>  {
  factory $CurrentUserCopyWith(CurrentUser value, $Res Function(CurrentUser) _then) = _$CurrentUserCopyWithImpl;
@useResult
$Res call({
 String id, String email, String displayName, bool totpEnabled, List<String> roles, List<String> permissions
});




}
/// @nodoc
class _$CurrentUserCopyWithImpl<$Res>
    implements $CurrentUserCopyWith<$Res> {
  _$CurrentUserCopyWithImpl(this._self, this._then);

  final CurrentUser _self;
  final $Res Function(CurrentUser) _then;

/// Create a copy of CurrentUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? totpEnabled = null,Object? roles = null,Object? permissions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,totpEnabled: null == totpEnabled ? _self.totpEnabled : totpEnabled // ignore: cast_nullable_to_non_nullable
as bool,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentUser].
extension CurrentUserPatterns on CurrentUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentUser value)  $default,){
final _that = this;
switch (_that) {
case _CurrentUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentUser value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String displayName,  bool totpEnabled,  List<String> roles,  List<String> permissions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentUser() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.totpEnabled,_that.roles,_that.permissions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String displayName,  bool totpEnabled,  List<String> roles,  List<String> permissions)  $default,) {final _that = this;
switch (_that) {
case _CurrentUser():
return $default(_that.id,_that.email,_that.displayName,_that.totpEnabled,_that.roles,_that.permissions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String displayName,  bool totpEnabled,  List<String> roles,  List<String> permissions)?  $default,) {final _that = this;
switch (_that) {
case _CurrentUser() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.totpEnabled,_that.roles,_that.permissions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentUser implements CurrentUser {
  const _CurrentUser({required this.id, required this.email, required this.displayName, required this.totpEnabled, required final  List<String> roles, required final  List<String> permissions}): _roles = roles,_permissions = permissions;
  factory _CurrentUser.fromJson(Map<String, dynamic> json) => _$CurrentUserFromJson(json);

@override final  String id;
@override final  String email;
@override final  String displayName;
@override final  bool totpEnabled;
 final  List<String> _roles;
@override List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

 final  List<String> _permissions;
@override List<String> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}


/// Create a copy of CurrentUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentUserCopyWith<_CurrentUser> get copyWith => __$CurrentUserCopyWithImpl<_CurrentUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentUser&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.totpEnabled, totpEnabled) || other.totpEnabled == totpEnabled)&&const DeepCollectionEquality().equals(other._roles, _roles)&&const DeepCollectionEquality().equals(other._permissions, _permissions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,totpEnabled,const DeepCollectionEquality().hash(_roles),const DeepCollectionEquality().hash(_permissions));

@override
String toString() {
  return 'CurrentUser(id: $id, email: $email, displayName: $displayName, totpEnabled: $totpEnabled, roles: $roles, permissions: $permissions)';
}


}

/// @nodoc
abstract mixin class _$CurrentUserCopyWith<$Res> implements $CurrentUserCopyWith<$Res> {
  factory _$CurrentUserCopyWith(_CurrentUser value, $Res Function(_CurrentUser) _then) = __$CurrentUserCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String displayName, bool totpEnabled, List<String> roles, List<String> permissions
});




}
/// @nodoc
class __$CurrentUserCopyWithImpl<$Res>
    implements _$CurrentUserCopyWith<$Res> {
  __$CurrentUserCopyWithImpl(this._self, this._then);

  final _CurrentUser _self;
  final $Res Function(_CurrentUser) _then;

/// Create a copy of CurrentUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? totpEnabled = null,Object? roles = null,Object? permissions = null,}) {
  return _then(_CurrentUser(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,totpEnabled: null == totpEnabled ? _self.totpEnabled : totpEnabled // ignore: cast_nullable_to_non_nullable
as bool,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$SessionInfo {

 String get id; String get deviceName; String get platform; String? get ip; String? get userAgent; DateTime get createdAt; DateTime get lastSeenAt; bool get current;
/// Create a copy of SessionInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionInfoCopyWith<SessionInfo> get copyWith => _$SessionInfoCopyWithImpl<SessionInfo>(this as SessionInfo, _$identity);

  /// Serializes this SessionInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.current, current) || other.current == current));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceName,platform,ip,userAgent,createdAt,lastSeenAt,current);

@override
String toString() {
  return 'SessionInfo(id: $id, deviceName: $deviceName, platform: $platform, ip: $ip, userAgent: $userAgent, createdAt: $createdAt, lastSeenAt: $lastSeenAt, current: $current)';
}


}

/// @nodoc
abstract mixin class $SessionInfoCopyWith<$Res>  {
  factory $SessionInfoCopyWith(SessionInfo value, $Res Function(SessionInfo) _then) = _$SessionInfoCopyWithImpl;
@useResult
$Res call({
 String id, String deviceName, String platform, String? ip, String? userAgent, DateTime createdAt, DateTime lastSeenAt, bool current
});




}
/// @nodoc
class _$SessionInfoCopyWithImpl<$Res>
    implements $SessionInfoCopyWith<$Res> {
  _$SessionInfoCopyWithImpl(this._self, this._then);

  final SessionInfo _self;
  final $Res Function(SessionInfo) _then;

/// Create a copy of SessionInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deviceName = null,Object? platform = null,Object? ip = freezed,Object? userAgent = freezed,Object? createdAt = null,Object? lastSeenAt = null,Object? current = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,ip: freezed == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastSeenAt: null == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionInfo].
extension SessionInfoPatterns on SessionInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionInfo value)  $default,){
final _that = this;
switch (_that) {
case _SessionInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionInfo value)?  $default,){
final _that = this;
switch (_that) {
case _SessionInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String deviceName,  String platform,  String? ip,  String? userAgent,  DateTime createdAt,  DateTime lastSeenAt,  bool current)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionInfo() when $default != null:
return $default(_that.id,_that.deviceName,_that.platform,_that.ip,_that.userAgent,_that.createdAt,_that.lastSeenAt,_that.current);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String deviceName,  String platform,  String? ip,  String? userAgent,  DateTime createdAt,  DateTime lastSeenAt,  bool current)  $default,) {final _that = this;
switch (_that) {
case _SessionInfo():
return $default(_that.id,_that.deviceName,_that.platform,_that.ip,_that.userAgent,_that.createdAt,_that.lastSeenAt,_that.current);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String deviceName,  String platform,  String? ip,  String? userAgent,  DateTime createdAt,  DateTime lastSeenAt,  bool current)?  $default,) {final _that = this;
switch (_that) {
case _SessionInfo() when $default != null:
return $default(_that.id,_that.deviceName,_that.platform,_that.ip,_that.userAgent,_that.createdAt,_that.lastSeenAt,_that.current);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionInfo implements SessionInfo {
  const _SessionInfo({required this.id, required this.deviceName, required this.platform, this.ip, this.userAgent, required this.createdAt, required this.lastSeenAt, required this.current});
  factory _SessionInfo.fromJson(Map<String, dynamic> json) => _$SessionInfoFromJson(json);

@override final  String id;
@override final  String deviceName;
@override final  String platform;
@override final  String? ip;
@override final  String? userAgent;
@override final  DateTime createdAt;
@override final  DateTime lastSeenAt;
@override final  bool current;

/// Create a copy of SessionInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionInfoCopyWith<_SessionInfo> get copyWith => __$SessionInfoCopyWithImpl<_SessionInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.ip, ip) || other.ip == ip)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastSeenAt, lastSeenAt) || other.lastSeenAt == lastSeenAt)&&(identical(other.current, current) || other.current == current));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deviceName,platform,ip,userAgent,createdAt,lastSeenAt,current);

@override
String toString() {
  return 'SessionInfo(id: $id, deviceName: $deviceName, platform: $platform, ip: $ip, userAgent: $userAgent, createdAt: $createdAt, lastSeenAt: $lastSeenAt, current: $current)';
}


}

/// @nodoc
abstract mixin class _$SessionInfoCopyWith<$Res> implements $SessionInfoCopyWith<$Res> {
  factory _$SessionInfoCopyWith(_SessionInfo value, $Res Function(_SessionInfo) _then) = __$SessionInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String deviceName, String platform, String? ip, String? userAgent, DateTime createdAt, DateTime lastSeenAt, bool current
});




}
/// @nodoc
class __$SessionInfoCopyWithImpl<$Res>
    implements _$SessionInfoCopyWith<$Res> {
  __$SessionInfoCopyWithImpl(this._self, this._then);

  final _SessionInfo _self;
  final $Res Function(_SessionInfo) _then;

/// Create a copy of SessionInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deviceName = null,Object? platform = null,Object? ip = freezed,Object? userAgent = freezed,Object? createdAt = null,Object? lastSeenAt = null,Object? current = null,}) {
  return _then(_SessionInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,ip: freezed == ip ? _self.ip : ip // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastSeenAt: null == lastSeenAt ? _self.lastSeenAt : lastSeenAt // ignore: cast_nullable_to_non_nullable
as DateTime,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TotpSetupResponse {

/// Secret en base32 (saisie manuelle).
 String get secret;/// URI `otpauth://` à encoder en QR code.
 String get otpauthUri;
/// Create a copy of TotpSetupResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TotpSetupResponseCopyWith<TotpSetupResponse> get copyWith => _$TotpSetupResponseCopyWithImpl<TotpSetupResponse>(this as TotpSetupResponse, _$identity);

  /// Serializes this TotpSetupResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TotpSetupResponse&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.otpauthUri, otpauthUri) || other.otpauthUri == otpauthUri));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,secret,otpauthUri);

@override
String toString() {
  return 'TotpSetupResponse(secret: $secret, otpauthUri: $otpauthUri)';
}


}

/// @nodoc
abstract mixin class $TotpSetupResponseCopyWith<$Res>  {
  factory $TotpSetupResponseCopyWith(TotpSetupResponse value, $Res Function(TotpSetupResponse) _then) = _$TotpSetupResponseCopyWithImpl;
@useResult
$Res call({
 String secret, String otpauthUri
});




}
/// @nodoc
class _$TotpSetupResponseCopyWithImpl<$Res>
    implements $TotpSetupResponseCopyWith<$Res> {
  _$TotpSetupResponseCopyWithImpl(this._self, this._then);

  final TotpSetupResponse _self;
  final $Res Function(TotpSetupResponse) _then;

/// Create a copy of TotpSetupResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? secret = null,Object? otpauthUri = null,}) {
  return _then(_self.copyWith(
secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,otpauthUri: null == otpauthUri ? _self.otpauthUri : otpauthUri // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TotpSetupResponse].
extension TotpSetupResponsePatterns on TotpSetupResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TotpSetupResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TotpSetupResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TotpSetupResponse value)  $default,){
final _that = this;
switch (_that) {
case _TotpSetupResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TotpSetupResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TotpSetupResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String secret,  String otpauthUri)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TotpSetupResponse() when $default != null:
return $default(_that.secret,_that.otpauthUri);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String secret,  String otpauthUri)  $default,) {final _that = this;
switch (_that) {
case _TotpSetupResponse():
return $default(_that.secret,_that.otpauthUri);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String secret,  String otpauthUri)?  $default,) {final _that = this;
switch (_that) {
case _TotpSetupResponse() when $default != null:
return $default(_that.secret,_that.otpauthUri);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TotpSetupResponse implements TotpSetupResponse {
  const _TotpSetupResponse({required this.secret, required this.otpauthUri});
  factory _TotpSetupResponse.fromJson(Map<String, dynamic> json) => _$TotpSetupResponseFromJson(json);

/// Secret en base32 (saisie manuelle).
@override final  String secret;
/// URI `otpauth://` à encoder en QR code.
@override final  String otpauthUri;

/// Create a copy of TotpSetupResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TotpSetupResponseCopyWith<_TotpSetupResponse> get copyWith => __$TotpSetupResponseCopyWithImpl<_TotpSetupResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TotpSetupResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TotpSetupResponse&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.otpauthUri, otpauthUri) || other.otpauthUri == otpauthUri));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,secret,otpauthUri);

@override
String toString() {
  return 'TotpSetupResponse(secret: $secret, otpauthUri: $otpauthUri)';
}


}

/// @nodoc
abstract mixin class _$TotpSetupResponseCopyWith<$Res> implements $TotpSetupResponseCopyWith<$Res> {
  factory _$TotpSetupResponseCopyWith(_TotpSetupResponse value, $Res Function(_TotpSetupResponse) _then) = __$TotpSetupResponseCopyWithImpl;
@override @useResult
$Res call({
 String secret, String otpauthUri
});




}
/// @nodoc
class __$TotpSetupResponseCopyWithImpl<$Res>
    implements _$TotpSetupResponseCopyWith<$Res> {
  __$TotpSetupResponseCopyWithImpl(this._self, this._then);

  final _TotpSetupResponse _self;
  final $Res Function(_TotpSetupResponse) _then;

/// Create a copy of TotpSetupResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? secret = null,Object? otpauthUri = null,}) {
  return _then(_TotpSetupResponse(
secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,otpauthUri: null == otpauthUri ? _self.otpauthUri : otpauthUri // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$CodeRequest {

 String get code;
/// Create a copy of CodeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CodeRequestCopyWith<CodeRequest> get copyWith => _$CodeRequestCopyWithImpl<CodeRequest>(this as CodeRequest, _$identity);

  /// Serializes this CodeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CodeRequest&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'CodeRequest(code: $code)';
}


}

/// @nodoc
abstract mixin class $CodeRequestCopyWith<$Res>  {
  factory $CodeRequestCopyWith(CodeRequest value, $Res Function(CodeRequest) _then) = _$CodeRequestCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class _$CodeRequestCopyWithImpl<$Res>
    implements $CodeRequestCopyWith<$Res> {
  _$CodeRequestCopyWithImpl(this._self, this._then);

  final CodeRequest _self;
  final $Res Function(CodeRequest) _then;

/// Create a copy of CodeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CodeRequest].
extension CodeRequestPatterns on CodeRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CodeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CodeRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CodeRequest value)  $default,){
final _that = this;
switch (_that) {
case _CodeRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CodeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CodeRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CodeRequest() when $default != null:
return $default(_that.code);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code)  $default,) {final _that = this;
switch (_that) {
case _CodeRequest():
return $default(_that.code);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code)?  $default,) {final _that = this;
switch (_that) {
case _CodeRequest() when $default != null:
return $default(_that.code);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CodeRequest implements CodeRequest {
  const _CodeRequest({required this.code});
  factory _CodeRequest.fromJson(Map<String, dynamic> json) => _$CodeRequestFromJson(json);

@override final  String code;

/// Create a copy of CodeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CodeRequestCopyWith<_CodeRequest> get copyWith => __$CodeRequestCopyWithImpl<_CodeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CodeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CodeRequest&&(identical(other.code, code) || other.code == code));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code);

@override
String toString() {
  return 'CodeRequest(code: $code)';
}


}

/// @nodoc
abstract mixin class _$CodeRequestCopyWith<$Res> implements $CodeRequestCopyWith<$Res> {
  factory _$CodeRequestCopyWith(_CodeRequest value, $Res Function(_CodeRequest) _then) = __$CodeRequestCopyWithImpl;
@override @useResult
$Res call({
 String code
});




}
/// @nodoc
class __$CodeRequestCopyWithImpl<$Res>
    implements _$CodeRequestCopyWith<$Res> {
  __$CodeRequestCopyWithImpl(this._self, this._then);

  final _CodeRequest _self;
  final $Res Function(_CodeRequest) _then;

/// Create a copy of CodeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(_CodeRequest(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RecoveryCodesResponse {

 List<String> get codes;
/// Create a copy of RecoveryCodesResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecoveryCodesResponseCopyWith<RecoveryCodesResponse> get copyWith => _$RecoveryCodesResponseCopyWithImpl<RecoveryCodesResponse>(this as RecoveryCodesResponse, _$identity);

  /// Serializes this RecoveryCodesResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecoveryCodesResponse&&const DeepCollectionEquality().equals(other.codes, codes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(codes));

@override
String toString() {
  return 'RecoveryCodesResponse(codes: $codes)';
}


}

/// @nodoc
abstract mixin class $RecoveryCodesResponseCopyWith<$Res>  {
  factory $RecoveryCodesResponseCopyWith(RecoveryCodesResponse value, $Res Function(RecoveryCodesResponse) _then) = _$RecoveryCodesResponseCopyWithImpl;
@useResult
$Res call({
 List<String> codes
});




}
/// @nodoc
class _$RecoveryCodesResponseCopyWithImpl<$Res>
    implements $RecoveryCodesResponseCopyWith<$Res> {
  _$RecoveryCodesResponseCopyWithImpl(this._self, this._then);

  final RecoveryCodesResponse _self;
  final $Res Function(RecoveryCodesResponse) _then;

/// Create a copy of RecoveryCodesResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? codes = null,}) {
  return _then(_self.copyWith(
codes: null == codes ? _self.codes : codes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RecoveryCodesResponse].
extension RecoveryCodesResponsePatterns on RecoveryCodesResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecoveryCodesResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecoveryCodesResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecoveryCodesResponse value)  $default,){
final _that = this;
switch (_that) {
case _RecoveryCodesResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecoveryCodesResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RecoveryCodesResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> codes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecoveryCodesResponse() when $default != null:
return $default(_that.codes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> codes)  $default,) {final _that = this;
switch (_that) {
case _RecoveryCodesResponse():
return $default(_that.codes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> codes)?  $default,) {final _that = this;
switch (_that) {
case _RecoveryCodesResponse() when $default != null:
return $default(_that.codes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecoveryCodesResponse implements RecoveryCodesResponse {
  const _RecoveryCodesResponse({required final  List<String> codes}): _codes = codes;
  factory _RecoveryCodesResponse.fromJson(Map<String, dynamic> json) => _$RecoveryCodesResponseFromJson(json);

 final  List<String> _codes;
@override List<String> get codes {
  if (_codes is EqualUnmodifiableListView) return _codes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_codes);
}


/// Create a copy of RecoveryCodesResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecoveryCodesResponseCopyWith<_RecoveryCodesResponse> get copyWith => __$RecoveryCodesResponseCopyWithImpl<_RecoveryCodesResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecoveryCodesResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecoveryCodesResponse&&const DeepCollectionEquality().equals(other._codes, _codes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_codes));

@override
String toString() {
  return 'RecoveryCodesResponse(codes: $codes)';
}


}

/// @nodoc
abstract mixin class _$RecoveryCodesResponseCopyWith<$Res> implements $RecoveryCodesResponseCopyWith<$Res> {
  factory _$RecoveryCodesResponseCopyWith(_RecoveryCodesResponse value, $Res Function(_RecoveryCodesResponse) _then) = __$RecoveryCodesResponseCopyWithImpl;
@override @useResult
$Res call({
 List<String> codes
});




}
/// @nodoc
class __$RecoveryCodesResponseCopyWithImpl<$Res>
    implements _$RecoveryCodesResponseCopyWith<$Res> {
  __$RecoveryCodesResponseCopyWithImpl(this._self, this._then);

  final _RecoveryCodesResponse _self;
  final $Res Function(_RecoveryCodesResponse) _then;

/// Create a copy of RecoveryCodesResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? codes = null,}) {
  return _then(_RecoveryCodesResponse(
codes: null == codes ? _self._codes : codes // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ChangePasswordRequest {

 String get currentPassword; String get newPassword;
/// Create a copy of ChangePasswordRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangePasswordRequestCopyWith<ChangePasswordRequest> get copyWith => _$ChangePasswordRequestCopyWithImpl<ChangePasswordRequest>(this as ChangePasswordRequest, _$identity);

  /// Serializes this ChangePasswordRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangePasswordRequest&&(identical(other.currentPassword, currentPassword) || other.currentPassword == currentPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPassword,newPassword);

@override
String toString() {
  return 'ChangePasswordRequest(currentPassword: $currentPassword, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class $ChangePasswordRequestCopyWith<$Res>  {
  factory $ChangePasswordRequestCopyWith(ChangePasswordRequest value, $Res Function(ChangePasswordRequest) _then) = _$ChangePasswordRequestCopyWithImpl;
@useResult
$Res call({
 String currentPassword, String newPassword
});




}
/// @nodoc
class _$ChangePasswordRequestCopyWithImpl<$Res>
    implements $ChangePasswordRequestCopyWith<$Res> {
  _$ChangePasswordRequestCopyWithImpl(this._self, this._then);

  final ChangePasswordRequest _self;
  final $Res Function(ChangePasswordRequest) _then;

/// Create a copy of ChangePasswordRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPassword = null,Object? newPassword = null,}) {
  return _then(_self.copyWith(
currentPassword: null == currentPassword ? _self.currentPassword : currentPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChangePasswordRequest].
extension ChangePasswordRequestPatterns on ChangePasswordRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChangePasswordRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChangePasswordRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChangePasswordRequest value)  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChangePasswordRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ChangePasswordRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String currentPassword,  String newPassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChangePasswordRequest() when $default != null:
return $default(_that.currentPassword,_that.newPassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String currentPassword,  String newPassword)  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordRequest():
return $default(_that.currentPassword,_that.newPassword);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String currentPassword,  String newPassword)?  $default,) {final _that = this;
switch (_that) {
case _ChangePasswordRequest() when $default != null:
return $default(_that.currentPassword,_that.newPassword);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChangePasswordRequest implements ChangePasswordRequest {
  const _ChangePasswordRequest({required this.currentPassword, required this.newPassword});
  factory _ChangePasswordRequest.fromJson(Map<String, dynamic> json) => _$ChangePasswordRequestFromJson(json);

@override final  String currentPassword;
@override final  String newPassword;

/// Create a copy of ChangePasswordRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChangePasswordRequestCopyWith<_ChangePasswordRequest> get copyWith => __$ChangePasswordRequestCopyWithImpl<_ChangePasswordRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChangePasswordRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangePasswordRequest&&(identical(other.currentPassword, currentPassword) || other.currentPassword == currentPassword)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPassword,newPassword);

@override
String toString() {
  return 'ChangePasswordRequest(currentPassword: $currentPassword, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class _$ChangePasswordRequestCopyWith<$Res> implements $ChangePasswordRequestCopyWith<$Res> {
  factory _$ChangePasswordRequestCopyWith(_ChangePasswordRequest value, $Res Function(_ChangePasswordRequest) _then) = __$ChangePasswordRequestCopyWithImpl;
@override @useResult
$Res call({
 String currentPassword, String newPassword
});




}
/// @nodoc
class __$ChangePasswordRequestCopyWithImpl<$Res>
    implements _$ChangePasswordRequestCopyWith<$Res> {
  __$ChangePasswordRequestCopyWithImpl(this._self, this._then);

  final _ChangePasswordRequest _self;
  final $Res Function(_ChangePasswordRequest) _then;

/// Create a copy of ChangePasswordRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPassword = null,Object? newPassword = null,}) {
  return _then(_ChangePasswordRequest(
currentPassword: null == currentPassword ? _self.currentPassword : currentPassword // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UserSummary {

 String get id; String get email; String get displayName; UserStatus get status; List<String> get roles; bool get totpEnabled; DateTime? get lastLoginAt; DateTime get createdAt;
/// Create a copy of UserSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSummaryCopyWith<UserSummary> get copyWith => _$UserSummaryCopyWithImpl<UserSummary>(this as UserSummary, _$identity);

  /// Serializes this UserSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.roles, roles)&&(identical(other.totpEnabled, totpEnabled) || other.totpEnabled == totpEnabled)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,status,const DeepCollectionEquality().hash(roles),totpEnabled,lastLoginAt,createdAt);

@override
String toString() {
  return 'UserSummary(id: $id, email: $email, displayName: $displayName, status: $status, roles: $roles, totpEnabled: $totpEnabled, lastLoginAt: $lastLoginAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UserSummaryCopyWith<$Res>  {
  factory $UserSummaryCopyWith(UserSummary value, $Res Function(UserSummary) _then) = _$UserSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String email, String displayName, UserStatus status, List<String> roles, bool totpEnabled, DateTime? lastLoginAt, DateTime createdAt
});




}
/// @nodoc
class _$UserSummaryCopyWithImpl<$Res>
    implements $UserSummaryCopyWith<$Res> {
  _$UserSummaryCopyWithImpl(this._self, this._then);

  final UserSummary _self;
  final $Res Function(UserSummary) _then;

/// Create a copy of UserSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? status = null,Object? roles = null,Object? totpEnabled = null,Object? lastLoginAt = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,totpEnabled: null == totpEnabled ? _self.totpEnabled : totpEnabled // ignore: cast_nullable_to_non_nullable
as bool,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSummary].
extension UserSummaryPatterns on UserSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSummary value)  $default,){
final _that = this;
switch (_that) {
case _UserSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSummary value)?  $default,){
final _that = this;
switch (_that) {
case _UserSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email,  String displayName,  UserStatus status,  List<String> roles,  bool totpEnabled,  DateTime? lastLoginAt,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSummary() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.status,_that.roles,_that.totpEnabled,_that.lastLoginAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email,  String displayName,  UserStatus status,  List<String> roles,  bool totpEnabled,  DateTime? lastLoginAt,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _UserSummary():
return $default(_that.id,_that.email,_that.displayName,_that.status,_that.roles,_that.totpEnabled,_that.lastLoginAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email,  String displayName,  UserStatus status,  List<String> roles,  bool totpEnabled,  DateTime? lastLoginAt,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UserSummary() when $default != null:
return $default(_that.id,_that.email,_that.displayName,_that.status,_that.roles,_that.totpEnabled,_that.lastLoginAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSummary implements UserSummary {
  const _UserSummary({required this.id, required this.email, required this.displayName, required this.status, required final  List<String> roles, required this.totpEnabled, this.lastLoginAt, required this.createdAt}): _roles = roles;
  factory _UserSummary.fromJson(Map<String, dynamic> json) => _$UserSummaryFromJson(json);

@override final  String id;
@override final  String email;
@override final  String displayName;
@override final  UserStatus status;
 final  List<String> _roles;
@override List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

@override final  bool totpEnabled;
@override final  DateTime? lastLoginAt;
@override final  DateTime createdAt;

/// Create a copy of UserSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSummaryCopyWith<_UserSummary> get copyWith => __$UserSummaryCopyWithImpl<_UserSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._roles, _roles)&&(identical(other.totpEnabled, totpEnabled) || other.totpEnabled == totpEnabled)&&(identical(other.lastLoginAt, lastLoginAt) || other.lastLoginAt == lastLoginAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,displayName,status,const DeepCollectionEquality().hash(_roles),totpEnabled,lastLoginAt,createdAt);

@override
String toString() {
  return 'UserSummary(id: $id, email: $email, displayName: $displayName, status: $status, roles: $roles, totpEnabled: $totpEnabled, lastLoginAt: $lastLoginAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UserSummaryCopyWith<$Res> implements $UserSummaryCopyWith<$Res> {
  factory _$UserSummaryCopyWith(_UserSummary value, $Res Function(_UserSummary) _then) = __$UserSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String email, String displayName, UserStatus status, List<String> roles, bool totpEnabled, DateTime? lastLoginAt, DateTime createdAt
});




}
/// @nodoc
class __$UserSummaryCopyWithImpl<$Res>
    implements _$UserSummaryCopyWith<$Res> {
  __$UserSummaryCopyWithImpl(this._self, this._then);

  final _UserSummary _self;
  final $Res Function(_UserSummary) _then;

/// Create a copy of UserSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? displayName = null,Object? status = null,Object? roles = null,Object? totpEnabled = null,Object? lastLoginAt = freezed,Object? createdAt = null,}) {
  return _then(_UserSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,totpEnabled: null == totpEnabled ? _self.totpEnabled : totpEnabled // ignore: cast_nullable_to_non_nullable
as bool,lastLoginAt: freezed == lastLoginAt ? _self.lastLoginAt : lastLoginAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$CreateUserRequest {

 String get email; String get displayName; String get password; List<String> get roles;
/// Create a copy of CreateUserRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateUserRequestCopyWith<CreateUserRequest> get copyWith => _$CreateUserRequestCopyWithImpl<CreateUserRequest>(this as CreateUserRequest, _$identity);

  /// Serializes this CreateUserRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateUserRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.password, password) || other.password == password)&&const DeepCollectionEquality().equals(other.roles, roles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,displayName,password,const DeepCollectionEquality().hash(roles));

@override
String toString() {
  return 'CreateUserRequest(email: $email, displayName: $displayName, password: $password, roles: $roles)';
}


}

/// @nodoc
abstract mixin class $CreateUserRequestCopyWith<$Res>  {
  factory $CreateUserRequestCopyWith(CreateUserRequest value, $Res Function(CreateUserRequest) _then) = _$CreateUserRequestCopyWithImpl;
@useResult
$Res call({
 String email, String displayName, String password, List<String> roles
});




}
/// @nodoc
class _$CreateUserRequestCopyWithImpl<$Res>
    implements $CreateUserRequestCopyWith<$Res> {
  _$CreateUserRequestCopyWithImpl(this._self, this._then);

  final CreateUserRequest _self;
  final $Res Function(CreateUserRequest) _then;

/// Create a copy of CreateUserRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? displayName = null,Object? password = null,Object? roles = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateUserRequest].
extension CreateUserRequestPatterns on CreateUserRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateUserRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateUserRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateUserRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateUserRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateUserRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateUserRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String displayName,  String password,  List<String> roles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateUserRequest() when $default != null:
return $default(_that.email,_that.displayName,_that.password,_that.roles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String displayName,  String password,  List<String> roles)  $default,) {final _that = this;
switch (_that) {
case _CreateUserRequest():
return $default(_that.email,_that.displayName,_that.password,_that.roles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String displayName,  String password,  List<String> roles)?  $default,) {final _that = this;
switch (_that) {
case _CreateUserRequest() when $default != null:
return $default(_that.email,_that.displayName,_that.password,_that.roles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateUserRequest implements CreateUserRequest {
  const _CreateUserRequest({required this.email, required this.displayName, required this.password, required final  List<String> roles}): _roles = roles;
  factory _CreateUserRequest.fromJson(Map<String, dynamic> json) => _$CreateUserRequestFromJson(json);

@override final  String email;
@override final  String displayName;
@override final  String password;
 final  List<String> _roles;
@override List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}


/// Create a copy of CreateUserRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateUserRequestCopyWith<_CreateUserRequest> get copyWith => __$CreateUserRequestCopyWithImpl<_CreateUserRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateUserRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateUserRequest&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.password, password) || other.password == password)&&const DeepCollectionEquality().equals(other._roles, _roles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,displayName,password,const DeepCollectionEquality().hash(_roles));

@override
String toString() {
  return 'CreateUserRequest(email: $email, displayName: $displayName, password: $password, roles: $roles)';
}


}

/// @nodoc
abstract mixin class _$CreateUserRequestCopyWith<$Res> implements $CreateUserRequestCopyWith<$Res> {
  factory _$CreateUserRequestCopyWith(_CreateUserRequest value, $Res Function(_CreateUserRequest) _then) = __$CreateUserRequestCopyWithImpl;
@override @useResult
$Res call({
 String email, String displayName, String password, List<String> roles
});




}
/// @nodoc
class __$CreateUserRequestCopyWithImpl<$Res>
    implements _$CreateUserRequestCopyWith<$Res> {
  __$CreateUserRequestCopyWithImpl(this._self, this._then);

  final _CreateUserRequest _self;
  final $Res Function(_CreateUserRequest) _then;

/// Create a copy of CreateUserRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? displayName = null,Object? password = null,Object? roles = null,}) {
  return _then(_CreateUserRequest(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$UpdateUserRequest {

 String? get displayName; UserStatus? get status; List<String>? get roles;
/// Create a copy of UpdateUserRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateUserRequestCopyWith<UpdateUserRequest> get copyWith => _$UpdateUserRequestCopyWithImpl<UpdateUserRequest>(this as UpdateUserRequest, _$identity);

  /// Serializes this UpdateUserRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateUserRequest&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.roles, roles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,status,const DeepCollectionEquality().hash(roles));

@override
String toString() {
  return 'UpdateUserRequest(displayName: $displayName, status: $status, roles: $roles)';
}


}

/// @nodoc
abstract mixin class $UpdateUserRequestCopyWith<$Res>  {
  factory $UpdateUserRequestCopyWith(UpdateUserRequest value, $Res Function(UpdateUserRequest) _then) = _$UpdateUserRequestCopyWithImpl;
@useResult
$Res call({
 String? displayName, UserStatus? status, List<String>? roles
});




}
/// @nodoc
class _$UpdateUserRequestCopyWithImpl<$Res>
    implements $UpdateUserRequestCopyWith<$Res> {
  _$UpdateUserRequestCopyWithImpl(this._self, this._then);

  final UpdateUserRequest _self;
  final $Res Function(UpdateUserRequest) _then;

/// Create a copy of UpdateUserRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = freezed,Object? status = freezed,Object? roles = freezed,}) {
  return _then(_self.copyWith(
displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus?,roles: freezed == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [UpdateUserRequest].
extension UpdateUserRequestPatterns on UpdateUserRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UpdateUserRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UpdateUserRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UpdateUserRequest value)  $default,){
final _that = this;
switch (_that) {
case _UpdateUserRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UpdateUserRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UpdateUserRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? displayName,  UserStatus? status,  List<String>? roles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UpdateUserRequest() when $default != null:
return $default(_that.displayName,_that.status,_that.roles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? displayName,  UserStatus? status,  List<String>? roles)  $default,) {final _that = this;
switch (_that) {
case _UpdateUserRequest():
return $default(_that.displayName,_that.status,_that.roles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? displayName,  UserStatus? status,  List<String>? roles)?  $default,) {final _that = this;
switch (_that) {
case _UpdateUserRequest() when $default != null:
return $default(_that.displayName,_that.status,_that.roles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UpdateUserRequest implements UpdateUserRequest {
  const _UpdateUserRequest({this.displayName, this.status, final  List<String>? roles}): _roles = roles;
  factory _UpdateUserRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserRequestFromJson(json);

@override final  String? displayName;
@override final  UserStatus? status;
 final  List<String>? _roles;
@override List<String>? get roles {
  final value = _roles;
  if (value == null) return null;
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of UpdateUserRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdateUserRequestCopyWith<_UpdateUserRequest> get copyWith => __$UpdateUserRequestCopyWithImpl<_UpdateUserRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UpdateUserRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdateUserRequest&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._roles, _roles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,displayName,status,const DeepCollectionEquality().hash(_roles));

@override
String toString() {
  return 'UpdateUserRequest(displayName: $displayName, status: $status, roles: $roles)';
}


}

/// @nodoc
abstract mixin class _$UpdateUserRequestCopyWith<$Res> implements $UpdateUserRequestCopyWith<$Res> {
  factory _$UpdateUserRequestCopyWith(_UpdateUserRequest value, $Res Function(_UpdateUserRequest) _then) = __$UpdateUserRequestCopyWithImpl;
@override @useResult
$Res call({
 String? displayName, UserStatus? status, List<String>? roles
});




}
/// @nodoc
class __$UpdateUserRequestCopyWithImpl<$Res>
    implements _$UpdateUserRequestCopyWith<$Res> {
  __$UpdateUserRequestCopyWithImpl(this._self, this._then);

  final _UpdateUserRequest _self;
  final $Res Function(_UpdateUserRequest) _then;

/// Create a copy of UpdateUserRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = freezed,Object? status = freezed,Object? roles = freezed,}) {
  return _then(_UpdateUserRequest(
displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UserStatus?,roles: freezed == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$RoleInfo {

 String get id; String get key; String get name; String? get description; bool get isSystem; List<String> get permissions;
/// Create a copy of RoleInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoleInfoCopyWith<RoleInfo> get copyWith => _$RoleInfoCopyWithImpl<RoleInfo>(this as RoleInfo, _$identity);

  /// Serializes this RoleInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoleInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.isSystem, isSystem) || other.isSystem == isSystem)&&const DeepCollectionEquality().equals(other.permissions, permissions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,key,name,description,isSystem,const DeepCollectionEquality().hash(permissions));

@override
String toString() {
  return 'RoleInfo(id: $id, key: $key, name: $name, description: $description, isSystem: $isSystem, permissions: $permissions)';
}


}

/// @nodoc
abstract mixin class $RoleInfoCopyWith<$Res>  {
  factory $RoleInfoCopyWith(RoleInfo value, $Res Function(RoleInfo) _then) = _$RoleInfoCopyWithImpl;
@useResult
$Res call({
 String id, String key, String name, String? description, bool isSystem, List<String> permissions
});




}
/// @nodoc
class _$RoleInfoCopyWithImpl<$Res>
    implements $RoleInfoCopyWith<$Res> {
  _$RoleInfoCopyWithImpl(this._self, this._then);

  final RoleInfo _self;
  final $Res Function(RoleInfo) _then;

/// Create a copy of RoleInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? key = null,Object? name = null,Object? description = freezed,Object? isSystem = null,Object? permissions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isSystem: null == isSystem ? _self.isSystem : isSystem // ignore: cast_nullable_to_non_nullable
as bool,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [RoleInfo].
extension RoleInfoPatterns on RoleInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoleInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoleInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoleInfo value)  $default,){
final _that = this;
switch (_that) {
case _RoleInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoleInfo value)?  $default,){
final _that = this;
switch (_that) {
case _RoleInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String key,  String name,  String? description,  bool isSystem,  List<String> permissions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoleInfo() when $default != null:
return $default(_that.id,_that.key,_that.name,_that.description,_that.isSystem,_that.permissions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String key,  String name,  String? description,  bool isSystem,  List<String> permissions)  $default,) {final _that = this;
switch (_that) {
case _RoleInfo():
return $default(_that.id,_that.key,_that.name,_that.description,_that.isSystem,_that.permissions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String key,  String name,  String? description,  bool isSystem,  List<String> permissions)?  $default,) {final _that = this;
switch (_that) {
case _RoleInfo() when $default != null:
return $default(_that.id,_that.key,_that.name,_that.description,_that.isSystem,_that.permissions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoleInfo implements RoleInfo {
  const _RoleInfo({required this.id, required this.key, required this.name, this.description, required this.isSystem, required final  List<String> permissions}): _permissions = permissions;
  factory _RoleInfo.fromJson(Map<String, dynamic> json) => _$RoleInfoFromJson(json);

@override final  String id;
@override final  String key;
@override final  String name;
@override final  String? description;
@override final  bool isSystem;
 final  List<String> _permissions;
@override List<String> get permissions {
  if (_permissions is EqualUnmodifiableListView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_permissions);
}


/// Create a copy of RoleInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoleInfoCopyWith<_RoleInfo> get copyWith => __$RoleInfoCopyWithImpl<_RoleInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoleInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoleInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.isSystem, isSystem) || other.isSystem == isSystem)&&const DeepCollectionEquality().equals(other._permissions, _permissions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,key,name,description,isSystem,const DeepCollectionEquality().hash(_permissions));

@override
String toString() {
  return 'RoleInfo(id: $id, key: $key, name: $name, description: $description, isSystem: $isSystem, permissions: $permissions)';
}


}

/// @nodoc
abstract mixin class _$RoleInfoCopyWith<$Res> implements $RoleInfoCopyWith<$Res> {
  factory _$RoleInfoCopyWith(_RoleInfo value, $Res Function(_RoleInfo) _then) = __$RoleInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String key, String name, String? description, bool isSystem, List<String> permissions
});




}
/// @nodoc
class __$RoleInfoCopyWithImpl<$Res>
    implements _$RoleInfoCopyWith<$Res> {
  __$RoleInfoCopyWithImpl(this._self, this._then);

  final _RoleInfo _self;
  final $Res Function(_RoleInfo) _then;

/// Create a copy of RoleInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? key = null,Object? name = null,Object? description = freezed,Object? isSystem = null,Object? permissions = null,}) {
  return _then(_RoleInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isSystem: null == isSystem ? _self.isSystem : isSystem // ignore: cast_nullable_to_non_nullable
as bool,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
