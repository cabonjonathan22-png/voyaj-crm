// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiText {

 String get text;
/// Create a copy of AiText
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiTextCopyWith<AiText> get copyWith => _$AiTextCopyWithImpl<AiText>(this as AiText, _$identity);

  /// Serializes this AiText to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiText&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'AiText(text: $text)';
}


}

/// @nodoc
abstract mixin class $AiTextCopyWith<$Res>  {
  factory $AiTextCopyWith(AiText value, $Res Function(AiText) _then) = _$AiTextCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class _$AiTextCopyWithImpl<$Res>
    implements $AiTextCopyWith<$Res> {
  _$AiTextCopyWithImpl(this._self, this._then);

  final AiText _self;
  final $Res Function(AiText) _then;

/// Create a copy of AiText
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AiText].
extension AiTextPatterns on AiText {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiText value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiText() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiText value)  $default,){
final _that = this;
switch (_that) {
case _AiText():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiText value)?  $default,){
final _that = this;
switch (_that) {
case _AiText() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiText() when $default != null:
return $default(_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text)  $default,) {final _that = this;
switch (_that) {
case _AiText():
return $default(_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text)?  $default,) {final _that = this;
switch (_that) {
case _AiText() when $default != null:
return $default(_that.text);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiText implements AiText {
  const _AiText({required this.text});
  factory _AiText.fromJson(Map<String, dynamic> json) => _$AiTextFromJson(json);

@override final  String text;

/// Create a copy of AiText
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiTextCopyWith<_AiText> get copyWith => __$AiTextCopyWithImpl<_AiText>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiTextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiText&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text);

@override
String toString() {
  return 'AiText(text: $text)';
}


}

/// @nodoc
abstract mixin class _$AiTextCopyWith<$Res> implements $AiTextCopyWith<$Res> {
  factory _$AiTextCopyWith(_AiText value, $Res Function(_AiText) _then) = __$AiTextCopyWithImpl;
@override @useResult
$Res call({
 String text
});




}
/// @nodoc
class __$AiTextCopyWithImpl<$Res>
    implements _$AiTextCopyWith<$Res> {
  __$AiTextCopyWithImpl(this._self, this._then);

  final _AiText _self;
  final $Res Function(_AiText) _then;

/// Create a copy of AiText
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(_AiText(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DraftEmailRequest {

 String get contactId;/// Intention de l'email (« relancer sur le devis », « proposer un
/// rendez-vous »…).
 String get instructions;
/// Create a copy of DraftEmailRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DraftEmailRequestCopyWith<DraftEmailRequest> get copyWith => _$DraftEmailRequestCopyWithImpl<DraftEmailRequest>(this as DraftEmailRequest, _$identity);

  /// Serializes this DraftEmailRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DraftEmailRequest&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.instructions, instructions) || other.instructions == instructions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contactId,instructions);

@override
String toString() {
  return 'DraftEmailRequest(contactId: $contactId, instructions: $instructions)';
}


}

/// @nodoc
abstract mixin class $DraftEmailRequestCopyWith<$Res>  {
  factory $DraftEmailRequestCopyWith(DraftEmailRequest value, $Res Function(DraftEmailRequest) _then) = _$DraftEmailRequestCopyWithImpl;
@useResult
$Res call({
 String contactId, String instructions
});




}
/// @nodoc
class _$DraftEmailRequestCopyWithImpl<$Res>
    implements $DraftEmailRequestCopyWith<$Res> {
  _$DraftEmailRequestCopyWithImpl(this._self, this._then);

  final DraftEmailRequest _self;
  final $Res Function(DraftEmailRequest) _then;

/// Create a copy of DraftEmailRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contactId = null,Object? instructions = null,}) {
  return _then(_self.copyWith(
contactId: null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,instructions: null == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DraftEmailRequest].
extension DraftEmailRequestPatterns on DraftEmailRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DraftEmailRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DraftEmailRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DraftEmailRequest value)  $default,){
final _that = this;
switch (_that) {
case _DraftEmailRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DraftEmailRequest value)?  $default,){
final _that = this;
switch (_that) {
case _DraftEmailRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String contactId,  String instructions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DraftEmailRequest() when $default != null:
return $default(_that.contactId,_that.instructions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String contactId,  String instructions)  $default,) {final _that = this;
switch (_that) {
case _DraftEmailRequest():
return $default(_that.contactId,_that.instructions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String contactId,  String instructions)?  $default,) {final _that = this;
switch (_that) {
case _DraftEmailRequest() when $default != null:
return $default(_that.contactId,_that.instructions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DraftEmailRequest implements DraftEmailRequest {
  const _DraftEmailRequest({required this.contactId, required this.instructions});
  factory _DraftEmailRequest.fromJson(Map<String, dynamic> json) => _$DraftEmailRequestFromJson(json);

@override final  String contactId;
/// Intention de l'email (« relancer sur le devis », « proposer un
/// rendez-vous »…).
@override final  String instructions;

/// Create a copy of DraftEmailRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DraftEmailRequestCopyWith<_DraftEmailRequest> get copyWith => __$DraftEmailRequestCopyWithImpl<_DraftEmailRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DraftEmailRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DraftEmailRequest&&(identical(other.contactId, contactId) || other.contactId == contactId)&&(identical(other.instructions, instructions) || other.instructions == instructions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,contactId,instructions);

@override
String toString() {
  return 'DraftEmailRequest(contactId: $contactId, instructions: $instructions)';
}


}

/// @nodoc
abstract mixin class _$DraftEmailRequestCopyWith<$Res> implements $DraftEmailRequestCopyWith<$Res> {
  factory _$DraftEmailRequestCopyWith(_DraftEmailRequest value, $Res Function(_DraftEmailRequest) _then) = __$DraftEmailRequestCopyWithImpl;
@override @useResult
$Res call({
 String contactId, String instructions
});




}
/// @nodoc
class __$DraftEmailRequestCopyWithImpl<$Res>
    implements _$DraftEmailRequestCopyWith<$Res> {
  __$DraftEmailRequestCopyWithImpl(this._self, this._then);

  final _DraftEmailRequest _self;
  final $Res Function(_DraftEmailRequest) _then;

/// Create a copy of DraftEmailRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? contactId = null,Object? instructions = null,}) {
  return _then(_DraftEmailRequest(
contactId: null == contactId ? _self.contactId : contactId // ignore: cast_nullable_to_non_nullable
as String,instructions: null == instructions ? _self.instructions : instructions // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EmailDraft {

 String get subject; String get body;
/// Create a copy of EmailDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailDraftCopyWith<EmailDraft> get copyWith => _$EmailDraftCopyWithImpl<EmailDraft>(this as EmailDraft, _$identity);

  /// Serializes this EmailDraft to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailDraft&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subject,body);

@override
String toString() {
  return 'EmailDraft(subject: $subject, body: $body)';
}


}

/// @nodoc
abstract mixin class $EmailDraftCopyWith<$Res>  {
  factory $EmailDraftCopyWith(EmailDraft value, $Res Function(EmailDraft) _then) = _$EmailDraftCopyWithImpl;
@useResult
$Res call({
 String subject, String body
});




}
/// @nodoc
class _$EmailDraftCopyWithImpl<$Res>
    implements $EmailDraftCopyWith<$Res> {
  _$EmailDraftCopyWithImpl(this._self, this._then);

  final EmailDraft _self;
  final $Res Function(EmailDraft) _then;

/// Create a copy of EmailDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subject = null,Object? body = null,}) {
  return _then(_self.copyWith(
subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailDraft].
extension EmailDraftPatterns on EmailDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailDraft value)  $default,){
final _that = this;
switch (_that) {
case _EmailDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailDraft value)?  $default,){
final _that = this;
switch (_that) {
case _EmailDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String subject,  String body)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailDraft() when $default != null:
return $default(_that.subject,_that.body);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String subject,  String body)  $default,) {final _that = this;
switch (_that) {
case _EmailDraft():
return $default(_that.subject,_that.body);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String subject,  String body)?  $default,) {final _that = this;
switch (_that) {
case _EmailDraft() when $default != null:
return $default(_that.subject,_that.body);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmailDraft implements EmailDraft {
  const _EmailDraft({required this.subject, required this.body});
  factory _EmailDraft.fromJson(Map<String, dynamic> json) => _$EmailDraftFromJson(json);

@override final  String subject;
@override final  String body;

/// Create a copy of EmailDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailDraftCopyWith<_EmailDraft> get copyWith => __$EmailDraftCopyWithImpl<_EmailDraft>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmailDraftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailDraft&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.body, body) || other.body == body));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subject,body);

@override
String toString() {
  return 'EmailDraft(subject: $subject, body: $body)';
}


}

/// @nodoc
abstract mixin class _$EmailDraftCopyWith<$Res> implements $EmailDraftCopyWith<$Res> {
  factory _$EmailDraftCopyWith(_EmailDraft value, $Res Function(_EmailDraft) _then) = __$EmailDraftCopyWithImpl;
@override @useResult
$Res call({
 String subject, String body
});




}
/// @nodoc
class __$EmailDraftCopyWithImpl<$Res>
    implements _$EmailDraftCopyWith<$Res> {
  __$EmailDraftCopyWithImpl(this._self, this._then);

  final _EmailDraft _self;
  final $Res Function(_EmailDraft) _then;

/// Create a copy of EmailDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subject = null,Object? body = null,}) {
  return _then(_EmailDraft(
subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
