// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmailAccountInfo {

 String get id; EmailProvider get provider; String get address; String? get displayName; bool get enabled; DateTime? get lastSyncAt; String? get lastError;
/// Create a copy of EmailAccountInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailAccountInfoCopyWith<EmailAccountInfo> get copyWith => _$EmailAccountInfoCopyWithImpl<EmailAccountInfo>(this as EmailAccountInfo, _$identity);

  /// Serializes this EmailAccountInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailAccountInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.address, address) || other.address == address)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.lastSyncAt, lastSyncAt) || other.lastSyncAt == lastSyncAt)&&(identical(other.lastError, lastError) || other.lastError == lastError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,provider,address,displayName,enabled,lastSyncAt,lastError);

@override
String toString() {
  return 'EmailAccountInfo(id: $id, provider: $provider, address: $address, displayName: $displayName, enabled: $enabled, lastSyncAt: $lastSyncAt, lastError: $lastError)';
}


}

/// @nodoc
abstract mixin class $EmailAccountInfoCopyWith<$Res>  {
  factory $EmailAccountInfoCopyWith(EmailAccountInfo value, $Res Function(EmailAccountInfo) _then) = _$EmailAccountInfoCopyWithImpl;
@useResult
$Res call({
 String id, EmailProvider provider, String address, String? displayName, bool enabled, DateTime? lastSyncAt, String? lastError
});




}
/// @nodoc
class _$EmailAccountInfoCopyWithImpl<$Res>
    implements $EmailAccountInfoCopyWith<$Res> {
  _$EmailAccountInfoCopyWithImpl(this._self, this._then);

  final EmailAccountInfo _self;
  final $Res Function(EmailAccountInfo) _then;

/// Create a copy of EmailAccountInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? provider = null,Object? address = null,Object? displayName = freezed,Object? enabled = null,Object? lastSyncAt = freezed,Object? lastError = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as EmailProvider,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,lastSyncAt: freezed == lastSyncAt ? _self.lastSyncAt : lastSyncAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailAccountInfo].
extension EmailAccountInfoPatterns on EmailAccountInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailAccountInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailAccountInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailAccountInfo value)  $default,){
final _that = this;
switch (_that) {
case _EmailAccountInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailAccountInfo value)?  $default,){
final _that = this;
switch (_that) {
case _EmailAccountInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  EmailProvider provider,  String address,  String? displayName,  bool enabled,  DateTime? lastSyncAt,  String? lastError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailAccountInfo() when $default != null:
return $default(_that.id,_that.provider,_that.address,_that.displayName,_that.enabled,_that.lastSyncAt,_that.lastError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  EmailProvider provider,  String address,  String? displayName,  bool enabled,  DateTime? lastSyncAt,  String? lastError)  $default,) {final _that = this;
switch (_that) {
case _EmailAccountInfo():
return $default(_that.id,_that.provider,_that.address,_that.displayName,_that.enabled,_that.lastSyncAt,_that.lastError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  EmailProvider provider,  String address,  String? displayName,  bool enabled,  DateTime? lastSyncAt,  String? lastError)?  $default,) {final _that = this;
switch (_that) {
case _EmailAccountInfo() when $default != null:
return $default(_that.id,_that.provider,_that.address,_that.displayName,_that.enabled,_that.lastSyncAt,_that.lastError);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmailAccountInfo implements EmailAccountInfo {
  const _EmailAccountInfo({required this.id, required this.provider, required this.address, this.displayName, required this.enabled, this.lastSyncAt, this.lastError});
  factory _EmailAccountInfo.fromJson(Map<String, dynamic> json) => _$EmailAccountInfoFromJson(json);

@override final  String id;
@override final  EmailProvider provider;
@override final  String address;
@override final  String? displayName;
@override final  bool enabled;
@override final  DateTime? lastSyncAt;
@override final  String? lastError;

/// Create a copy of EmailAccountInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailAccountInfoCopyWith<_EmailAccountInfo> get copyWith => __$EmailAccountInfoCopyWithImpl<_EmailAccountInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmailAccountInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailAccountInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.address, address) || other.address == address)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.lastSyncAt, lastSyncAt) || other.lastSyncAt == lastSyncAt)&&(identical(other.lastError, lastError) || other.lastError == lastError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,provider,address,displayName,enabled,lastSyncAt,lastError);

@override
String toString() {
  return 'EmailAccountInfo(id: $id, provider: $provider, address: $address, displayName: $displayName, enabled: $enabled, lastSyncAt: $lastSyncAt, lastError: $lastError)';
}


}

/// @nodoc
abstract mixin class _$EmailAccountInfoCopyWith<$Res> implements $EmailAccountInfoCopyWith<$Res> {
  factory _$EmailAccountInfoCopyWith(_EmailAccountInfo value, $Res Function(_EmailAccountInfo) _then) = __$EmailAccountInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, EmailProvider provider, String address, String? displayName, bool enabled, DateTime? lastSyncAt, String? lastError
});




}
/// @nodoc
class __$EmailAccountInfoCopyWithImpl<$Res>
    implements _$EmailAccountInfoCopyWith<$Res> {
  __$EmailAccountInfoCopyWithImpl(this._self, this._then);

  final _EmailAccountInfo _self;
  final $Res Function(_EmailAccountInfo) _then;

/// Create a copy of EmailAccountInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? provider = null,Object? address = null,Object? displayName = freezed,Object? enabled = null,Object? lastSyncAt = freezed,Object? lastError = freezed,}) {
  return _then(_EmailAccountInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as EmailProvider,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,lastSyncAt: freezed == lastSyncAt ? _self.lastSyncAt : lastSyncAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CreateImapAccountRequest {

 String get address; String? get displayName; String get imapHost; int get imapPort; bool get imapTls; String get smtpHost; int get smtpPort; SmtpSecurity get smtpSecurity; String get username; String get password;
/// Create a copy of CreateImapAccountRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateImapAccountRequestCopyWith<CreateImapAccountRequest> get copyWith => _$CreateImapAccountRequestCopyWithImpl<CreateImapAccountRequest>(this as CreateImapAccountRequest, _$identity);

  /// Serializes this CreateImapAccountRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateImapAccountRequest&&(identical(other.address, address) || other.address == address)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.imapHost, imapHost) || other.imapHost == imapHost)&&(identical(other.imapPort, imapPort) || other.imapPort == imapPort)&&(identical(other.imapTls, imapTls) || other.imapTls == imapTls)&&(identical(other.smtpHost, smtpHost) || other.smtpHost == smtpHost)&&(identical(other.smtpPort, smtpPort) || other.smtpPort == smtpPort)&&(identical(other.smtpSecurity, smtpSecurity) || other.smtpSecurity == smtpSecurity)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,displayName,imapHost,imapPort,imapTls,smtpHost,smtpPort,smtpSecurity,username,password);

@override
String toString() {
  return 'CreateImapAccountRequest(address: $address, displayName: $displayName, imapHost: $imapHost, imapPort: $imapPort, imapTls: $imapTls, smtpHost: $smtpHost, smtpPort: $smtpPort, smtpSecurity: $smtpSecurity, username: $username, password: $password)';
}


}

/// @nodoc
abstract mixin class $CreateImapAccountRequestCopyWith<$Res>  {
  factory $CreateImapAccountRequestCopyWith(CreateImapAccountRequest value, $Res Function(CreateImapAccountRequest) _then) = _$CreateImapAccountRequestCopyWithImpl;
@useResult
$Res call({
 String address, String? displayName, String imapHost, int imapPort, bool imapTls, String smtpHost, int smtpPort, SmtpSecurity smtpSecurity, String username, String password
});




}
/// @nodoc
class _$CreateImapAccountRequestCopyWithImpl<$Res>
    implements $CreateImapAccountRequestCopyWith<$Res> {
  _$CreateImapAccountRequestCopyWithImpl(this._self, this._then);

  final CreateImapAccountRequest _self;
  final $Res Function(CreateImapAccountRequest) _then;

/// Create a copy of CreateImapAccountRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? displayName = freezed,Object? imapHost = null,Object? imapPort = null,Object? imapTls = null,Object? smtpHost = null,Object? smtpPort = null,Object? smtpSecurity = null,Object? username = null,Object? password = null,}) {
  return _then(_self.copyWith(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,imapHost: null == imapHost ? _self.imapHost : imapHost // ignore: cast_nullable_to_non_nullable
as String,imapPort: null == imapPort ? _self.imapPort : imapPort // ignore: cast_nullable_to_non_nullable
as int,imapTls: null == imapTls ? _self.imapTls : imapTls // ignore: cast_nullable_to_non_nullable
as bool,smtpHost: null == smtpHost ? _self.smtpHost : smtpHost // ignore: cast_nullable_to_non_nullable
as String,smtpPort: null == smtpPort ? _self.smtpPort : smtpPort // ignore: cast_nullable_to_non_nullable
as int,smtpSecurity: null == smtpSecurity ? _self.smtpSecurity : smtpSecurity // ignore: cast_nullable_to_non_nullable
as SmtpSecurity,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateImapAccountRequest].
extension CreateImapAccountRequestPatterns on CreateImapAccountRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateImapAccountRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateImapAccountRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateImapAccountRequest value)  $default,){
final _that = this;
switch (_that) {
case _CreateImapAccountRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateImapAccountRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CreateImapAccountRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String address,  String? displayName,  String imapHost,  int imapPort,  bool imapTls,  String smtpHost,  int smtpPort,  SmtpSecurity smtpSecurity,  String username,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateImapAccountRequest() when $default != null:
return $default(_that.address,_that.displayName,_that.imapHost,_that.imapPort,_that.imapTls,_that.smtpHost,_that.smtpPort,_that.smtpSecurity,_that.username,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String address,  String? displayName,  String imapHost,  int imapPort,  bool imapTls,  String smtpHost,  int smtpPort,  SmtpSecurity smtpSecurity,  String username,  String password)  $default,) {final _that = this;
switch (_that) {
case _CreateImapAccountRequest():
return $default(_that.address,_that.displayName,_that.imapHost,_that.imapPort,_that.imapTls,_that.smtpHost,_that.smtpPort,_that.smtpSecurity,_that.username,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String address,  String? displayName,  String imapHost,  int imapPort,  bool imapTls,  String smtpHost,  int smtpPort,  SmtpSecurity smtpSecurity,  String username,  String password)?  $default,) {final _that = this;
switch (_that) {
case _CreateImapAccountRequest() when $default != null:
return $default(_that.address,_that.displayName,_that.imapHost,_that.imapPort,_that.imapTls,_that.smtpHost,_that.smtpPort,_that.smtpSecurity,_that.username,_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateImapAccountRequest implements CreateImapAccountRequest {
  const _CreateImapAccountRequest({required this.address, this.displayName, required this.imapHost, this.imapPort = 993, this.imapTls = true, required this.smtpHost, this.smtpPort = 465, this.smtpSecurity = SmtpSecurity.tls, required this.username, required this.password});
  factory _CreateImapAccountRequest.fromJson(Map<String, dynamic> json) => _$CreateImapAccountRequestFromJson(json);

@override final  String address;
@override final  String? displayName;
@override final  String imapHost;
@override@JsonKey() final  int imapPort;
@override@JsonKey() final  bool imapTls;
@override final  String smtpHost;
@override@JsonKey() final  int smtpPort;
@override@JsonKey() final  SmtpSecurity smtpSecurity;
@override final  String username;
@override final  String password;

/// Create a copy of CreateImapAccountRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateImapAccountRequestCopyWith<_CreateImapAccountRequest> get copyWith => __$CreateImapAccountRequestCopyWithImpl<_CreateImapAccountRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateImapAccountRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateImapAccountRequest&&(identical(other.address, address) || other.address == address)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.imapHost, imapHost) || other.imapHost == imapHost)&&(identical(other.imapPort, imapPort) || other.imapPort == imapPort)&&(identical(other.imapTls, imapTls) || other.imapTls == imapTls)&&(identical(other.smtpHost, smtpHost) || other.smtpHost == smtpHost)&&(identical(other.smtpPort, smtpPort) || other.smtpPort == smtpPort)&&(identical(other.smtpSecurity, smtpSecurity) || other.smtpSecurity == smtpSecurity)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,displayName,imapHost,imapPort,imapTls,smtpHost,smtpPort,smtpSecurity,username,password);

@override
String toString() {
  return 'CreateImapAccountRequest(address: $address, displayName: $displayName, imapHost: $imapHost, imapPort: $imapPort, imapTls: $imapTls, smtpHost: $smtpHost, smtpPort: $smtpPort, smtpSecurity: $smtpSecurity, username: $username, password: $password)';
}


}

/// @nodoc
abstract mixin class _$CreateImapAccountRequestCopyWith<$Res> implements $CreateImapAccountRequestCopyWith<$Res> {
  factory _$CreateImapAccountRequestCopyWith(_CreateImapAccountRequest value, $Res Function(_CreateImapAccountRequest) _then) = __$CreateImapAccountRequestCopyWithImpl;
@override @useResult
$Res call({
 String address, String? displayName, String imapHost, int imapPort, bool imapTls, String smtpHost, int smtpPort, SmtpSecurity smtpSecurity, String username, String password
});




}
/// @nodoc
class __$CreateImapAccountRequestCopyWithImpl<$Res>
    implements _$CreateImapAccountRequestCopyWith<$Res> {
  __$CreateImapAccountRequestCopyWithImpl(this._self, this._then);

  final _CreateImapAccountRequest _self;
  final $Res Function(_CreateImapAccountRequest) _then;

/// Create a copy of CreateImapAccountRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? displayName = freezed,Object? imapHost = null,Object? imapPort = null,Object? imapTls = null,Object? smtpHost = null,Object? smtpPort = null,Object? smtpSecurity = null,Object? username = null,Object? password = null,}) {
  return _then(_CreateImapAccountRequest(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,imapHost: null == imapHost ? _self.imapHost : imapHost // ignore: cast_nullable_to_non_nullable
as String,imapPort: null == imapPort ? _self.imapPort : imapPort // ignore: cast_nullable_to_non_nullable
as int,imapTls: null == imapTls ? _self.imapTls : imapTls // ignore: cast_nullable_to_non_nullable
as bool,smtpHost: null == smtpHost ? _self.smtpHost : smtpHost // ignore: cast_nullable_to_non_nullable
as String,smtpPort: null == smtpPort ? _self.smtpPort : smtpPort // ignore: cast_nullable_to_non_nullable
as int,smtpSecurity: null == smtpSecurity ? _self.smtpSecurity : smtpSecurity // ignore: cast_nullable_to_non_nullable
as SmtpSecurity,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$OAuthStartResponse {

 String get url;
/// Create a copy of OAuthStartResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OAuthStartResponseCopyWith<OAuthStartResponse> get copyWith => _$OAuthStartResponseCopyWithImpl<OAuthStartResponse>(this as OAuthStartResponse, _$identity);

  /// Serializes this OAuthStartResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OAuthStartResponse&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'OAuthStartResponse(url: $url)';
}


}

/// @nodoc
abstract mixin class $OAuthStartResponseCopyWith<$Res>  {
  factory $OAuthStartResponseCopyWith(OAuthStartResponse value, $Res Function(OAuthStartResponse) _then) = _$OAuthStartResponseCopyWithImpl;
@useResult
$Res call({
 String url
});




}
/// @nodoc
class _$OAuthStartResponseCopyWithImpl<$Res>
    implements $OAuthStartResponseCopyWith<$Res> {
  _$OAuthStartResponseCopyWithImpl(this._self, this._then);

  final OAuthStartResponse _self;
  final $Res Function(OAuthStartResponse) _then;

/// Create a copy of OAuthStartResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OAuthStartResponse].
extension OAuthStartResponsePatterns on OAuthStartResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OAuthStartResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OAuthStartResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OAuthStartResponse value)  $default,){
final _that = this;
switch (_that) {
case _OAuthStartResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OAuthStartResponse value)?  $default,){
final _that = this;
switch (_that) {
case _OAuthStartResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OAuthStartResponse() when $default != null:
return $default(_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url)  $default,) {final _that = this;
switch (_that) {
case _OAuthStartResponse():
return $default(_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url)?  $default,) {final _that = this;
switch (_that) {
case _OAuthStartResponse() when $default != null:
return $default(_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OAuthStartResponse implements OAuthStartResponse {
  const _OAuthStartResponse({required this.url});
  factory _OAuthStartResponse.fromJson(Map<String, dynamic> json) => _$OAuthStartResponseFromJson(json);

@override final  String url;

/// Create a copy of OAuthStartResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OAuthStartResponseCopyWith<_OAuthStartResponse> get copyWith => __$OAuthStartResponseCopyWithImpl<_OAuthStartResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OAuthStartResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OAuthStartResponse&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url);

@override
String toString() {
  return 'OAuthStartResponse(url: $url)';
}


}

/// @nodoc
abstract mixin class _$OAuthStartResponseCopyWith<$Res> implements $OAuthStartResponseCopyWith<$Res> {
  factory _$OAuthStartResponseCopyWith(_OAuthStartResponse value, $Res Function(_OAuthStartResponse) _then) = __$OAuthStartResponseCopyWithImpl;
@override @useResult
$Res call({
 String url
});




}
/// @nodoc
class __$OAuthStartResponseCopyWithImpl<$Res>
    implements _$OAuthStartResponseCopyWith<$Res> {
  __$OAuthStartResponseCopyWithImpl(this._self, this._then);

  final _OAuthStartResponse _self;
  final $Res Function(_OAuthStartResponse) _then;

/// Create a copy of OAuthStartResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,}) {
  return _then(_OAuthStartResponse(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EmailAddress {

 String get address; String? get name;
/// Create a copy of EmailAddress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailAddressCopyWith<EmailAddress> get copyWith => _$EmailAddressCopyWithImpl<EmailAddress>(this as EmailAddress, _$identity);

  /// Serializes this EmailAddress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailAddress&&(identical(other.address, address) || other.address == address)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,name);

@override
String toString() {
  return 'EmailAddress(address: $address, name: $name)';
}


}

/// @nodoc
abstract mixin class $EmailAddressCopyWith<$Res>  {
  factory $EmailAddressCopyWith(EmailAddress value, $Res Function(EmailAddress) _then) = _$EmailAddressCopyWithImpl;
@useResult
$Res call({
 String address, String? name
});




}
/// @nodoc
class _$EmailAddressCopyWithImpl<$Res>
    implements $EmailAddressCopyWith<$Res> {
  _$EmailAddressCopyWithImpl(this._self, this._then);

  final EmailAddress _self;
  final $Res Function(EmailAddress) _then;

/// Create a copy of EmailAddress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? name = freezed,}) {
  return _then(_self.copyWith(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailAddress].
extension EmailAddressPatterns on EmailAddress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailAddress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailAddress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailAddress value)  $default,){
final _that = this;
switch (_that) {
case _EmailAddress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailAddress value)?  $default,){
final _that = this;
switch (_that) {
case _EmailAddress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String address,  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailAddress() when $default != null:
return $default(_that.address,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String address,  String? name)  $default,) {final _that = this;
switch (_that) {
case _EmailAddress():
return $default(_that.address,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String address,  String? name)?  $default,) {final _that = this;
switch (_that) {
case _EmailAddress() when $default != null:
return $default(_that.address,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmailAddress implements EmailAddress {
  const _EmailAddress({required this.address, this.name});
  factory _EmailAddress.fromJson(Map<String, dynamic> json) => _$EmailAddressFromJson(json);

@override final  String address;
@override final  String? name;

/// Create a copy of EmailAddress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailAddressCopyWith<_EmailAddress> get copyWith => __$EmailAddressCopyWithImpl<_EmailAddress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmailAddressToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailAddress&&(identical(other.address, address) || other.address == address)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,name);

@override
String toString() {
  return 'EmailAddress(address: $address, name: $name)';
}


}

/// @nodoc
abstract mixin class _$EmailAddressCopyWith<$Res> implements $EmailAddressCopyWith<$Res> {
  factory _$EmailAddressCopyWith(_EmailAddress value, $Res Function(_EmailAddress) _then) = __$EmailAddressCopyWithImpl;
@override @useResult
$Res call({
 String address, String? name
});




}
/// @nodoc
class __$EmailAddressCopyWithImpl<$Res>
    implements _$EmailAddressCopyWith<$Res> {
  __$EmailAddressCopyWithImpl(this._self, this._then);

  final _EmailAddress _self;
  final $Res Function(_EmailAddress) _then;

/// Create a copy of EmailAddress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? name = freezed,}) {
  return _then(_EmailAddress(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EmailMessage {

 String get id; String get accountId;/// `in` (reçu) ou `out` (envoyé depuis Voyaj).
 String get direction; EmailAddress get from; List<EmailAddress> get to; List<EmailAddress> get cc; String get subject; String get snippet;/// Corps texte (renseigné pour le détail d'un message).
 String? get bodyText; DateTime get sentAt; bool get read; String? get messageId; String? get contactId; String? get organisationId; String? get activityId;
/// Create a copy of EmailMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailMessageCopyWith<EmailMessage> get copyWith => _$EmailMessageCopyWithImpl<EmailMessage>(this as EmailMessage, _$identity);

  /// Serializes this EmailMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.from, from) || other.from == from)&&const DeepCollectionEquality().equals(other.to, to)&&const DeepCollectionEquality().equals(other.cc, cc)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.snippet, snippet) || other.snippet == snippet)&&(identical(other.bodyText, bodyText) || other.bodyText == bodyText)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.read, read) || other.read == read)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.organisationId, organisationId) || other.organisationId == organisationId)&&(identical(other.activityId, activityId) || other.activityId == activityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,direction,from,const DeepCollectionEquality().hash(to),const DeepCollectionEquality().hash(cc),subject,snippet,bodyText,sentAt,read,messageId,contactId,organisationId,activityId);

@override
String toString() {
  return 'EmailMessage(id: $id, accountId: $accountId, direction: $direction, from: $from, to: $to, cc: $cc, subject: $subject, snippet: $snippet, bodyText: $bodyText, sentAt: $sentAt, read: $read, messageId: $messageId, contactId: $contactId, organisationId: $organisationId, activityId: $activityId)';
}


}

/// @nodoc
abstract mixin class $EmailMessageCopyWith<$Res>  {
  factory $EmailMessageCopyWith(EmailMessage value, $Res Function(EmailMessage) _then) = _$EmailMessageCopyWithImpl;
@useResult
$Res call({
 String id, String accountId, String direction, EmailAddress from, List<EmailAddress> to, List<EmailAddress> cc, String subject, String snippet, String? bodyText, DateTime sentAt, bool read, String? messageId, String? contactId, String? organisationId, String? activityId
});


$EmailAddressCopyWith<$Res> get from;

}
/// @nodoc
class _$EmailMessageCopyWithImpl<$Res>
    implements $EmailMessageCopyWith<$Res> {
  _$EmailMessageCopyWithImpl(this._self, this._then);

  final EmailMessage _self;
  final $Res Function(EmailMessage) _then;

/// Create a copy of EmailMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? accountId = null,Object? direction = null,Object? from = null,Object? to = null,Object? cc = null,Object? subject = null,Object? snippet = null,Object? bodyText = freezed,Object? sentAt = null,Object? read = null,Object? messageId = freezed,Object? contactId = freezed,Object? organisationId = freezed,Object? activityId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as EmailAddress,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,cc: null == cc ? _self.cc : cc // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,snippet: null == snippet ? _self.snippet : snippet // ignore: cast_nullable_to_non_nullable
as String,bodyText: freezed == bodyText ? _self.bodyText : bodyText // ignore: cast_nullable_to_non_nullable
as String?,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,messageId: freezed == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String?,contactId: freezed == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String?,organisationId: freezed == organisationId ? _self.organisationId : organisationId // ignore: cast_nullable_to_non_nullable
as String?,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of EmailMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmailAddressCopyWith<$Res> get from {
  
  return $EmailAddressCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}
}


/// Adds pattern-matching-related methods to [EmailMessage].
extension EmailMessagePatterns on EmailMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailMessage value)  $default,){
final _that = this;
switch (_that) {
case _EmailMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailMessage value)?  $default,){
final _that = this;
switch (_that) {
case _EmailMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String accountId,  String direction,  EmailAddress from,  List<EmailAddress> to,  List<EmailAddress> cc,  String subject,  String snippet,  String? bodyText,  DateTime sentAt,  bool read,  String? messageId,  String? contactId,  String? organisationId,  String? activityId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailMessage() when $default != null:
return $default(_that.id,_that.accountId,_that.direction,_that.from,_that.to,_that.cc,_that.subject,_that.snippet,_that.bodyText,_that.sentAt,_that.read,_that.messageId,_that.contactId,_that.organisationId,_that.activityId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String accountId,  String direction,  EmailAddress from,  List<EmailAddress> to,  List<EmailAddress> cc,  String subject,  String snippet,  String? bodyText,  DateTime sentAt,  bool read,  String? messageId,  String? contactId,  String? organisationId,  String? activityId)  $default,) {final _that = this;
switch (_that) {
case _EmailMessage():
return $default(_that.id,_that.accountId,_that.direction,_that.from,_that.to,_that.cc,_that.subject,_that.snippet,_that.bodyText,_that.sentAt,_that.read,_that.messageId,_that.contactId,_that.organisationId,_that.activityId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String accountId,  String direction,  EmailAddress from,  List<EmailAddress> to,  List<EmailAddress> cc,  String subject,  String snippet,  String? bodyText,  DateTime sentAt,  bool read,  String? messageId,  String? contactId,  String? organisationId,  String? activityId)?  $default,) {final _that = this;
switch (_that) {
case _EmailMessage() when $default != null:
return $default(_that.id,_that.accountId,_that.direction,_that.from,_that.to,_that.cc,_that.subject,_that.snippet,_that.bodyText,_that.sentAt,_that.read,_that.messageId,_that.contactId,_that.organisationId,_that.activityId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmailMessage implements EmailMessage {
  const _EmailMessage({required this.id, required this.accountId, required this.direction, required this.from, required final  List<EmailAddress> to, final  List<EmailAddress> cc = const [], required this.subject, required this.snippet, this.bodyText, required this.sentAt, required this.read, this.messageId, this.contactId, this.organisationId, this.activityId}): _to = to,_cc = cc;
  factory _EmailMessage.fromJson(Map<String, dynamic> json) => _$EmailMessageFromJson(json);

@override final  String id;
@override final  String accountId;
/// `in` (reçu) ou `out` (envoyé depuis Voyaj).
@override final  String direction;
@override final  EmailAddress from;
 final  List<EmailAddress> _to;
@override List<EmailAddress> get to {
  if (_to is EqualUnmodifiableListView) return _to;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_to);
}

 final  List<EmailAddress> _cc;
@override@JsonKey() List<EmailAddress> get cc {
  if (_cc is EqualUnmodifiableListView) return _cc;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cc);
}

@override final  String subject;
@override final  String snippet;
/// Corps texte (renseigné pour le détail d'un message).
@override final  String? bodyText;
@override final  DateTime sentAt;
@override final  bool read;
@override final  String? messageId;
@override final  String? contactId;
@override final  String? organisationId;
@override final  String? activityId;

/// Create a copy of EmailMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailMessageCopyWith<_EmailMessage> get copyWith => __$EmailMessageCopyWithImpl<_EmailMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmailMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.from, from) || other.from == from)&&const DeepCollectionEquality().equals(other._to, _to)&&const DeepCollectionEquality().equals(other._cc, _cc)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.snippet, snippet) || other.snippet == snippet)&&(identical(other.bodyText, bodyText) || other.bodyText == bodyText)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.read, read) || other.read == read)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.organisationId, organisationId) || other.organisationId == organisationId)&&(identical(other.activityId, activityId) || other.activityId == activityId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,accountId,direction,from,const DeepCollectionEquality().hash(_to),const DeepCollectionEquality().hash(_cc),subject,snippet,bodyText,sentAt,read,messageId,contactId,organisationId,activityId);

@override
String toString() {
  return 'EmailMessage(id: $id, accountId: $accountId, direction: $direction, from: $from, to: $to, cc: $cc, subject: $subject, snippet: $snippet, bodyText: $bodyText, sentAt: $sentAt, read: $read, messageId: $messageId, contactId: $contactId, organisationId: $organisationId, activityId: $activityId)';
}


}

/// @nodoc
abstract mixin class _$EmailMessageCopyWith<$Res> implements $EmailMessageCopyWith<$Res> {
  factory _$EmailMessageCopyWith(_EmailMessage value, $Res Function(_EmailMessage) _then) = __$EmailMessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String accountId, String direction, EmailAddress from, List<EmailAddress> to, List<EmailAddress> cc, String subject, String snippet, String? bodyText, DateTime sentAt, bool read, String? messageId, String? contactId, String? organisationId, String? activityId
});


@override $EmailAddressCopyWith<$Res> get from;

}
/// @nodoc
class __$EmailMessageCopyWithImpl<$Res>
    implements _$EmailMessageCopyWith<$Res> {
  __$EmailMessageCopyWithImpl(this._self, this._then);

  final _EmailMessage _self;
  final $Res Function(_EmailMessage) _then;

/// Create a copy of EmailMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? accountId = null,Object? direction = null,Object? from = null,Object? to = null,Object? cc = null,Object? subject = null,Object? snippet = null,Object? bodyText = freezed,Object? sentAt = null,Object? read = null,Object? messageId = freezed,Object? contactId = freezed,Object? organisationId = freezed,Object? activityId = freezed,}) {
  return _then(_EmailMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as EmailAddress,to: null == to ? _self._to : to // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,cc: null == cc ? _self._cc : cc // ignore: cast_nullable_to_non_nullable
as List<EmailAddress>,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,snippet: null == snippet ? _self.snippet : snippet // ignore: cast_nullable_to_non_nullable
as String,bodyText: freezed == bodyText ? _self.bodyText : bodyText // ignore: cast_nullable_to_non_nullable
as String?,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,messageId: freezed == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String?,contactId: freezed == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String?,organisationId: freezed == organisationId ? _self.organisationId : organisationId // ignore: cast_nullable_to_non_nullable
as String?,activityId: freezed == activityId ? _self.activityId : activityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of EmailMessage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmailAddressCopyWith<$Res> get from {
  
  return $EmailAddressCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}
}


/// @nodoc
mixin _$SendEmailRequest {

 String get accountId; List<String> get to; List<String> get cc; String get subject; String get body; String? get contactId; String? get organisationId;/// Message auquel on répond (`Message-ID`).
 String? get inReplyTo;
/// Create a copy of SendEmailRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendEmailRequestCopyWith<SendEmailRequest> get copyWith => _$SendEmailRequestCopyWithImpl<SendEmailRequest>(this as SendEmailRequest, _$identity);

  /// Serializes this SendEmailRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendEmailRequest&&(identical(other.accountId, accountId) || other.accountId == accountId)&&const DeepCollectionEquality().equals(other.to, to)&&const DeepCollectionEquality().equals(other.cc, cc)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.body, body) || other.body == body)&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.organisationId, organisationId) || other.organisationId == organisationId)&&(identical(other.inReplyTo, inReplyTo) || other.inReplyTo == inReplyTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountId,const DeepCollectionEquality().hash(to),const DeepCollectionEquality().hash(cc),subject,body,contactId,organisationId,inReplyTo);

@override
String toString() {
  return 'SendEmailRequest(accountId: $accountId, to: $to, cc: $cc, subject: $subject, body: $body, contactId: $contactId, organisationId: $organisationId, inReplyTo: $inReplyTo)';
}


}

/// @nodoc
abstract mixin class $SendEmailRequestCopyWith<$Res>  {
  factory $SendEmailRequestCopyWith(SendEmailRequest value, $Res Function(SendEmailRequest) _then) = _$SendEmailRequestCopyWithImpl;
@useResult
$Res call({
 String accountId, List<String> to, List<String> cc, String subject, String body, String? contactId, String? organisationId, String? inReplyTo
});




}
/// @nodoc
class _$SendEmailRequestCopyWithImpl<$Res>
    implements $SendEmailRequestCopyWith<$Res> {
  _$SendEmailRequestCopyWithImpl(this._self, this._then);

  final SendEmailRequest _self;
  final $Res Function(SendEmailRequest) _then;

/// Create a copy of SendEmailRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accountId = null,Object? to = null,Object? cc = null,Object? subject = null,Object? body = null,Object? contactId = freezed,Object? organisationId = freezed,Object? inReplyTo = freezed,}) {
  return _then(_self.copyWith(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as List<String>,cc: null == cc ? _self.cc : cc // ignore: cast_nullable_to_non_nullable
as List<String>,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,contactId: freezed == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String?,organisationId: freezed == organisationId ? _self.organisationId : organisationId // ignore: cast_nullable_to_non_nullable
as String?,inReplyTo: freezed == inReplyTo ? _self.inReplyTo : inReplyTo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SendEmailRequest].
extension SendEmailRequestPatterns on SendEmailRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendEmailRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendEmailRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendEmailRequest value)  $default,){
final _that = this;
switch (_that) {
case _SendEmailRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendEmailRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SendEmailRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accountId,  List<String> to,  List<String> cc,  String subject,  String body,  String? contactId,  String? organisationId,  String? inReplyTo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendEmailRequest() when $default != null:
return $default(_that.accountId,_that.to,_that.cc,_that.subject,_that.body,_that.contactId,_that.organisationId,_that.inReplyTo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accountId,  List<String> to,  List<String> cc,  String subject,  String body,  String? contactId,  String? organisationId,  String? inReplyTo)  $default,) {final _that = this;
switch (_that) {
case _SendEmailRequest():
return $default(_that.accountId,_that.to,_that.cc,_that.subject,_that.body,_that.contactId,_that.organisationId,_that.inReplyTo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accountId,  List<String> to,  List<String> cc,  String subject,  String body,  String? contactId,  String? organisationId,  String? inReplyTo)?  $default,) {final _that = this;
switch (_that) {
case _SendEmailRequest() when $default != null:
return $default(_that.accountId,_that.to,_that.cc,_that.subject,_that.body,_that.contactId,_that.organisationId,_that.inReplyTo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendEmailRequest implements SendEmailRequest {
  const _SendEmailRequest({required this.accountId, required final  List<String> to, final  List<String> cc = const [], required this.subject, required this.body, this.contactId, this.organisationId, this.inReplyTo}): _to = to,_cc = cc;
  factory _SendEmailRequest.fromJson(Map<String, dynamic> json) => _$SendEmailRequestFromJson(json);

@override final  String accountId;
 final  List<String> _to;
@override List<String> get to {
  if (_to is EqualUnmodifiableListView) return _to;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_to);
}

 final  List<String> _cc;
@override@JsonKey() List<String> get cc {
  if (_cc is EqualUnmodifiableListView) return _cc;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cc);
}

@override final  String subject;
@override final  String body;
@override final  String? contactId;
@override final  String? organisationId;
/// Message auquel on répond (`Message-ID`).
@override final  String? inReplyTo;

/// Create a copy of SendEmailRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendEmailRequestCopyWith<_SendEmailRequest> get copyWith => __$SendEmailRequestCopyWithImpl<_SendEmailRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendEmailRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendEmailRequest&&(identical(other.accountId, accountId) || other.accountId == accountId)&&const DeepCollectionEquality().equals(other._to, _to)&&const DeepCollectionEquality().equals(other._cc, _cc)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.body, body) || other.body == body)&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.organisationId, organisationId) || other.organisationId == organisationId)&&(identical(other.inReplyTo, inReplyTo) || other.inReplyTo == inReplyTo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accountId,const DeepCollectionEquality().hash(_to),const DeepCollectionEquality().hash(_cc),subject,body,contactId,organisationId,inReplyTo);

@override
String toString() {
  return 'SendEmailRequest(accountId: $accountId, to: $to, cc: $cc, subject: $subject, body: $body, contactId: $contactId, organisationId: $organisationId, inReplyTo: $inReplyTo)';
}


}

/// @nodoc
abstract mixin class _$SendEmailRequestCopyWith<$Res> implements $SendEmailRequestCopyWith<$Res> {
  factory _$SendEmailRequestCopyWith(_SendEmailRequest value, $Res Function(_SendEmailRequest) _then) = __$SendEmailRequestCopyWithImpl;
@override @useResult
$Res call({
 String accountId, List<String> to, List<String> cc, String subject, String body, String? contactId, String? organisationId, String? inReplyTo
});




}
/// @nodoc
class __$SendEmailRequestCopyWithImpl<$Res>
    implements _$SendEmailRequestCopyWith<$Res> {
  __$SendEmailRequestCopyWithImpl(this._self, this._then);

  final _SendEmailRequest _self;
  final $Res Function(_SendEmailRequest) _then;

/// Create a copy of SendEmailRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accountId = null,Object? to = null,Object? cc = null,Object? subject = null,Object? body = null,Object? contactId = freezed,Object? organisationId = freezed,Object? inReplyTo = freezed,}) {
  return _then(_SendEmailRequest(
accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self._to : to // ignore: cast_nullable_to_non_nullable
as List<String>,cc: null == cc ? _self._cc : cc // ignore: cast_nullable_to_non_nullable
as List<String>,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,contactId: freezed == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String?,organisationId: freezed == organisationId ? _self.organisationId : organisationId // ignore: cast_nullable_to_non_nullable
as String?,inReplyTo: freezed == inReplyTo ? _self.inReplyTo : inReplyTo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
