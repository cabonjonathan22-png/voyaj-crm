// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signature_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignatureInfo {

 String get id; String get invoiceId; String get signerName; String get signerEmail;/// `ongoing`, `done`, `declined`, `expired`, `canceled` ou `failed`.
 String get status;/// Devis signé (fichier joint).
 String? get signedFileId; String? get error; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of SignatureInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignatureInfoCopyWith<SignatureInfo> get copyWith => _$SignatureInfoCopyWithImpl<SignatureInfo>(this as SignatureInfo, _$identity);

  /// Serializes this SignatureInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignatureInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.signerName, signerName) || other.signerName == signerName)&&(identical(other.signerEmail, signerEmail) || other.signerEmail == signerEmail)&&(identical(other.status, status) || other.status == status)&&(identical(other.signedFileId, signedFileId) || other.signedFileId == signedFileId)&&(identical(other.error, error) || other.error == error)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,invoiceId,signerName,signerEmail,status,signedFileId,error,createdAt,updatedAt);

@override
String toString() {
  return 'SignatureInfo(id: $id, invoiceId: $invoiceId, signerName: $signerName, signerEmail: $signerEmail, status: $status, signedFileId: $signedFileId, error: $error, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SignatureInfoCopyWith<$Res>  {
  factory $SignatureInfoCopyWith(SignatureInfo value, $Res Function(SignatureInfo) _then) = _$SignatureInfoCopyWithImpl;
@useResult
$Res call({
 String id, String invoiceId, String signerName, String signerEmail, String status, String? signedFileId, String? error, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$SignatureInfoCopyWithImpl<$Res>
    implements $SignatureInfoCopyWith<$Res> {
  _$SignatureInfoCopyWithImpl(this._self, this._then);

  final SignatureInfo _self;
  final $Res Function(SignatureInfo) _then;

/// Create a copy of SignatureInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? invoiceId = null,Object? signerName = null,Object? signerEmail = null,Object? status = null,Object? signedFileId = freezed,Object? error = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,signerName: null == signerName ? _self.signerName : signerName // ignore: cast_nullable_to_non_nullable
as String,signerEmail: null == signerEmail ? _self.signerEmail : signerEmail // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,signedFileId: freezed == signedFileId ? _self.signedFileId : signedFileId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [SignatureInfo].
extension SignatureInfoPatterns on SignatureInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignatureInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignatureInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignatureInfo value)  $default,){
final _that = this;
switch (_that) {
case _SignatureInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignatureInfo value)?  $default,){
final _that = this;
switch (_that) {
case _SignatureInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String invoiceId,  String signerName,  String signerEmail,  String status,  String? signedFileId,  String? error,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignatureInfo() when $default != null:
return $default(_that.id,_that.invoiceId,_that.signerName,_that.signerEmail,_that.status,_that.signedFileId,_that.error,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String invoiceId,  String signerName,  String signerEmail,  String status,  String? signedFileId,  String? error,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SignatureInfo():
return $default(_that.id,_that.invoiceId,_that.signerName,_that.signerEmail,_that.status,_that.signedFileId,_that.error,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String invoiceId,  String signerName,  String signerEmail,  String status,  String? signedFileId,  String? error,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SignatureInfo() when $default != null:
return $default(_that.id,_that.invoiceId,_that.signerName,_that.signerEmail,_that.status,_that.signedFileId,_that.error,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignatureInfo implements SignatureInfo {
  const _SignatureInfo({required this.id, required this.invoiceId, required this.signerName, required this.signerEmail, required this.status, this.signedFileId, this.error, required this.createdAt, required this.updatedAt});
  factory _SignatureInfo.fromJson(Map<String, dynamic> json) => _$SignatureInfoFromJson(json);

@override final  String id;
@override final  String invoiceId;
@override final  String signerName;
@override final  String signerEmail;
/// `ongoing`, `done`, `declined`, `expired`, `canceled` ou `failed`.
@override final  String status;
/// Devis signé (fichier joint).
@override final  String? signedFileId;
@override final  String? error;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of SignatureInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignatureInfoCopyWith<_SignatureInfo> get copyWith => __$SignatureInfoCopyWithImpl<_SignatureInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignatureInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignatureInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId)&&(identical(other.signerName, signerName) || other.signerName == signerName)&&(identical(other.signerEmail, signerEmail) || other.signerEmail == signerEmail)&&(identical(other.status, status) || other.status == status)&&(identical(other.signedFileId, signedFileId) || other.signedFileId == signedFileId)&&(identical(other.error, error) || other.error == error)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,invoiceId,signerName,signerEmail,status,signedFileId,error,createdAt,updatedAt);

@override
String toString() {
  return 'SignatureInfo(id: $id, invoiceId: $invoiceId, signerName: $signerName, signerEmail: $signerEmail, status: $status, signedFileId: $signedFileId, error: $error, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SignatureInfoCopyWith<$Res> implements $SignatureInfoCopyWith<$Res> {
  factory _$SignatureInfoCopyWith(_SignatureInfo value, $Res Function(_SignatureInfo) _then) = __$SignatureInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String invoiceId, String signerName, String signerEmail, String status, String? signedFileId, String? error, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$SignatureInfoCopyWithImpl<$Res>
    implements _$SignatureInfoCopyWith<$Res> {
  __$SignatureInfoCopyWithImpl(this._self, this._then);

  final _SignatureInfo _self;
  final $Res Function(_SignatureInfo) _then;

/// Create a copy of SignatureInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? invoiceId = null,Object? signerName = null,Object? signerEmail = null,Object? status = null,Object? signedFileId = freezed,Object? error = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_SignatureInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,invoiceId: null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,signerName: null == signerName ? _self.signerName : signerName // ignore: cast_nullable_to_non_nullable
as String,signerEmail: null == signerEmail ? _self.signerEmail : signerEmail // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,signedFileId: freezed == signedFileId ? _self.signedFileId : signedFileId // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$SendSignatureRequest {

 String get contactId;
/// Create a copy of SendSignatureRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendSignatureRequestCopyWith<SendSignatureRequest> get copyWith => _$SendSignatureRequestCopyWithImpl<SendSignatureRequest>(this as SendSignatureRequest, _$identity);

  /// Serializes this SendSignatureRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendSignatureRequest&&(identical(other.contactId, contactId) || other.contactId == contactId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contactId);

@override
String toString() {
  return 'SendSignatureRequest(contactId: $contactId)';
}


}

/// @nodoc
abstract mixin class $SendSignatureRequestCopyWith<$Res>  {
  factory $SendSignatureRequestCopyWith(SendSignatureRequest value, $Res Function(SendSignatureRequest) _then) = _$SendSignatureRequestCopyWithImpl;
@useResult
$Res call({
 String contactId
});




}
/// @nodoc
class _$SendSignatureRequestCopyWithImpl<$Res>
    implements $SendSignatureRequestCopyWith<$Res> {
  _$SendSignatureRequestCopyWithImpl(this._self, this._then);

  final SendSignatureRequest _self;
  final $Res Function(SendSignatureRequest) _then;

/// Create a copy of SendSignatureRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contactId = null,}) {
  return _then(_self.copyWith(
contactId: null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SendSignatureRequest].
extension SendSignatureRequestPatterns on SendSignatureRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SendSignatureRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SendSignatureRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SendSignatureRequest value)  $default,){
final _that = this;
switch (_that) {
case _SendSignatureRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SendSignatureRequest value)?  $default,){
final _that = this;
switch (_that) {
case _SendSignatureRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String contactId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SendSignatureRequest() when $default != null:
return $default(_that.contactId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String contactId)  $default,) {final _that = this;
switch (_that) {
case _SendSignatureRequest():
return $default(_that.contactId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String contactId)?  $default,) {final _that = this;
switch (_that) {
case _SendSignatureRequest() when $default != null:
return $default(_that.contactId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SendSignatureRequest implements SendSignatureRequest {
  const _SendSignatureRequest({required this.contactId});
  factory _SendSignatureRequest.fromJson(Map<String, dynamic> json) => _$SendSignatureRequestFromJson(json);

@override final  String contactId;

/// Create a copy of SendSignatureRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SendSignatureRequestCopyWith<_SendSignatureRequest> get copyWith => __$SendSignatureRequestCopyWithImpl<_SendSignatureRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SendSignatureRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendSignatureRequest&&(identical(other.contactId, contactId) || other.contactId == contactId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contactId);

@override
String toString() {
  return 'SendSignatureRequest(contactId: $contactId)';
}


}

/// @nodoc
abstract mixin class _$SendSignatureRequestCopyWith<$Res> implements $SendSignatureRequestCopyWith<$Res> {
  factory _$SendSignatureRequestCopyWith(_SendSignatureRequest value, $Res Function(_SendSignatureRequest) _then) = __$SendSignatureRequestCopyWithImpl;
@override @useResult
$Res call({
 String contactId
});




}
/// @nodoc
class __$SendSignatureRequestCopyWithImpl<$Res>
    implements _$SendSignatureRequestCopyWith<$Res> {
  __$SendSignatureRequestCopyWithImpl(this._self, this._then);

  final _SendSignatureRequest _self;
  final $Res Function(_SendSignatureRequest) _then;

/// Create a copy of SendSignatureRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contactId = null,}) {
  return _then(_SendSignatureRequest(
contactId: null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
