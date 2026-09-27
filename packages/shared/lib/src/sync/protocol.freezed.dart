// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'protocol.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SyncOperation {

/// UUID v7 unique : garantit l'idempotence en cas de renvoi.
 String get opId; String get entity; String get entityId;/// Version de l'enregistrement connue localement au moment de
/// l'écriture (0 pour une création).
 int get baseVersion;/// Horodatage HLC de l'écriture (appliqué à tous les champs).
 String get hlc;/// Champs modifiés (clés snake_case), `deleted_at` inclus.
 Map<String, Object?> get fields;
/// Create a copy of SyncOperation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncOperationCopyWith<SyncOperation> get copyWith => _$SyncOperationCopyWithImpl<SyncOperation>(this as SyncOperation, _$identity);

  /// Serializes this SyncOperation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncOperation&&(identical(other.opId, opId) || other.opId == opId)&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.baseVersion, baseVersion) || other.baseVersion == baseVersion)&&(identical(other.hlc, hlc) || other.hlc == hlc)&&const DeepCollectionEquality().equals(other.fields, fields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,opId,entity,entityId,baseVersion,hlc,const DeepCollectionEquality().hash(fields));

@override
String toString() {
  return 'SyncOperation(opId: $opId, entity: $entity, entityId: $entityId, baseVersion: $baseVersion, hlc: $hlc, fields: $fields)';
}


}

/// @nodoc
abstract mixin class $SyncOperationCopyWith<$Res>  {
  factory $SyncOperationCopyWith(SyncOperation value, $Res Function(SyncOperation) _then) = _$SyncOperationCopyWithImpl;
@useResult
$Res call({
 String opId, String entity, String entityId, int baseVersion, String hlc, Map<String, Object?> fields
});




}
/// @nodoc
class _$SyncOperationCopyWithImpl<$Res>
    implements $SyncOperationCopyWith<$Res> {
  _$SyncOperationCopyWithImpl(this._self, this._then);

  final SyncOperation _self;
  final $Res Function(SyncOperation) _then;

/// Create a copy of SyncOperation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? opId = null,Object? entity = null,Object? entityId = null,Object? baseVersion = null,Object? hlc = null,Object? fields = null,}) {
  return _then(_self.copyWith(
opId: null == opId ? _self.opId : opId // ignore: cast_nullable_to_non_nullable
as String,entity: null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,baseVersion: null == baseVersion ? _self.baseVersion : baseVersion // ignore: cast_nullable_to_non_nullable
as int,hlc: null == hlc ? _self.hlc : hlc // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncOperation].
extension SyncOperationPatterns on SyncOperation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncOperation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncOperation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncOperation value)  $default,){
final _that = this;
switch (_that) {
case _SyncOperation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncOperation value)?  $default,){
final _that = this;
switch (_that) {
case _SyncOperation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String opId,  String entity,  String entityId,  int baseVersion,  String hlc,  Map<String, Object?> fields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncOperation() when $default != null:
return $default(_that.opId,_that.entity,_that.entityId,_that.baseVersion,_that.hlc,_that.fields);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String opId,  String entity,  String entityId,  int baseVersion,  String hlc,  Map<String, Object?> fields)  $default,) {final _that = this;
switch (_that) {
case _SyncOperation():
return $default(_that.opId,_that.entity,_that.entityId,_that.baseVersion,_that.hlc,_that.fields);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String opId,  String entity,  String entityId,  int baseVersion,  String hlc,  Map<String, Object?> fields)?  $default,) {final _that = this;
switch (_that) {
case _SyncOperation() when $default != null:
return $default(_that.opId,_that.entity,_that.entityId,_that.baseVersion,_that.hlc,_that.fields);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncOperation implements SyncOperation {
  const _SyncOperation({required this.opId, required this.entity, required this.entityId, required this.baseVersion, required this.hlc, required final  Map<String, Object?> fields}): _fields = fields;
  factory _SyncOperation.fromJson(Map<String, dynamic> json) => _$SyncOperationFromJson(json);

/// UUID v7 unique : garantit l'idempotence en cas de renvoi.
@override final  String opId;
@override final  String entity;
@override final  String entityId;
/// Version de l'enregistrement connue localement au moment de
/// l'écriture (0 pour une création).
@override final  int baseVersion;
/// Horodatage HLC de l'écriture (appliqué à tous les champs).
@override final  String hlc;
/// Champs modifiés (clés snake_case), `deleted_at` inclus.
 final  Map<String, Object?> _fields;
/// Champs modifiés (clés snake_case), `deleted_at` inclus.
@override Map<String, Object?> get fields {
  if (_fields is EqualUnmodifiableMapView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fields);
}


/// Create a copy of SyncOperation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncOperationCopyWith<_SyncOperation> get copyWith => __$SyncOperationCopyWithImpl<_SyncOperation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncOperationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncOperation&&(identical(other.opId, opId) || other.opId == opId)&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.baseVersion, baseVersion) || other.baseVersion == baseVersion)&&(identical(other.hlc, hlc) || other.hlc == hlc)&&const DeepCollectionEquality().equals(other._fields, _fields));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,opId,entity,entityId,baseVersion,hlc,const DeepCollectionEquality().hash(_fields));

@override
String toString() {
  return 'SyncOperation(opId: $opId, entity: $entity, entityId: $entityId, baseVersion: $baseVersion, hlc: $hlc, fields: $fields)';
}


}

/// @nodoc
abstract mixin class _$SyncOperationCopyWith<$Res> implements $SyncOperationCopyWith<$Res> {
  factory _$SyncOperationCopyWith(_SyncOperation value, $Res Function(_SyncOperation) _then) = __$SyncOperationCopyWithImpl;
@override @useResult
$Res call({
 String opId, String entity, String entityId, int baseVersion, String hlc, Map<String, Object?> fields
});




}
/// @nodoc
class __$SyncOperationCopyWithImpl<$Res>
    implements _$SyncOperationCopyWith<$Res> {
  __$SyncOperationCopyWithImpl(this._self, this._then);

  final _SyncOperation _self;
  final $Res Function(_SyncOperation) _then;

/// Create a copy of SyncOperation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? opId = null,Object? entity = null,Object? entityId = null,Object? baseVersion = null,Object? hlc = null,Object? fields = null,}) {
  return _then(_SyncOperation(
opId: null == opId ? _self.opId : opId // ignore: cast_nullable_to_non_nullable
as String,entity: null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,baseVersion: null == baseVersion ? _self.baseVersion : baseVersion // ignore: cast_nullable_to_non_nullable
as int,hlc: null == hlc ? _self.hlc : hlc // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,
  ));
}


}


/// @nodoc
mixin _$PushRequest {

 String get deviceId; List<SyncOperation> get operations;
/// Create a copy of PushRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushRequestCopyWith<PushRequest> get copyWith => _$PushRequestCopyWithImpl<PushRequest>(this as PushRequest, _$identity);

  /// Serializes this PushRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushRequest&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&const DeepCollectionEquality().equals(other.operations, operations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,const DeepCollectionEquality().hash(operations));

@override
String toString() {
  return 'PushRequest(deviceId: $deviceId, operations: $operations)';
}


}

/// @nodoc
abstract mixin class $PushRequestCopyWith<$Res>  {
  factory $PushRequestCopyWith(PushRequest value, $Res Function(PushRequest) _then) = _$PushRequestCopyWithImpl;
@useResult
$Res call({
 String deviceId, List<SyncOperation> operations
});




}
/// @nodoc
class _$PushRequestCopyWithImpl<$Res>
    implements $PushRequestCopyWith<$Res> {
  _$PushRequestCopyWithImpl(this._self, this._then);

  final PushRequest _self;
  final $Res Function(PushRequest) _then;

/// Create a copy of PushRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceId = null,Object? operations = null,}) {
  return _then(_self.copyWith(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,operations: null == operations ? _self.operations : operations // ignore: cast_nullable_to_non_nullable
as List<SyncOperation>,
  ));
}

}


/// Adds pattern-matching-related methods to [PushRequest].
extension PushRequestPatterns on PushRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PushRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PushRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PushRequest value)  $default,){
final _that = this;
switch (_that) {
case _PushRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PushRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PushRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String deviceId,  List<SyncOperation> operations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PushRequest() when $default != null:
return $default(_that.deviceId,_that.operations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String deviceId,  List<SyncOperation> operations)  $default,) {final _that = this;
switch (_that) {
case _PushRequest():
return $default(_that.deviceId,_that.operations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String deviceId,  List<SyncOperation> operations)?  $default,) {final _that = this;
switch (_that) {
case _PushRequest() when $default != null:
return $default(_that.deviceId,_that.operations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PushRequest implements PushRequest {
  const _PushRequest({required this.deviceId, required final  List<SyncOperation> operations}): _operations = operations;
  factory _PushRequest.fromJson(Map<String, dynamic> json) => _$PushRequestFromJson(json);

@override final  String deviceId;
 final  List<SyncOperation> _operations;
@override List<SyncOperation> get operations {
  if (_operations is EqualUnmodifiableListView) return _operations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_operations);
}


/// Create a copy of PushRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushRequestCopyWith<_PushRequest> get copyWith => __$PushRequestCopyWithImpl<_PushRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PushRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PushRequest&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&const DeepCollectionEquality().equals(other._operations, _operations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceId,const DeepCollectionEquality().hash(_operations));

@override
String toString() {
  return 'PushRequest(deviceId: $deviceId, operations: $operations)';
}


}

/// @nodoc
abstract mixin class _$PushRequestCopyWith<$Res> implements $PushRequestCopyWith<$Res> {
  factory _$PushRequestCopyWith(_PushRequest value, $Res Function(_PushRequest) _then) = __$PushRequestCopyWithImpl;
@override @useResult
$Res call({
 String deviceId, List<SyncOperation> operations
});




}
/// @nodoc
class __$PushRequestCopyWithImpl<$Res>
    implements _$PushRequestCopyWith<$Res> {
  __$PushRequestCopyWithImpl(this._self, this._then);

  final _PushRequest _self;
  final $Res Function(_PushRequest) _then;

/// Create a copy of PushRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceId = null,Object? operations = null,}) {
  return _then(_PushRequest(
deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,operations: null == operations ? _self._operations : operations // ignore: cast_nullable_to_non_nullable
as List<SyncOperation>,
  ));
}


}


/// @nodoc
mixin _$OpResult {

 String get opId; OpStatus get status;/// État serveur de l'enregistrement après traitement.
 SyncRecord? get record; int get conflicts; List<ValidationIssue> get issues;
/// Create a copy of OpResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpResultCopyWith<OpResult> get copyWith => _$OpResultCopyWithImpl<OpResult>(this as OpResult, _$identity);

  /// Serializes this OpResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpResult&&(identical(other.opId, opId) || other.opId == opId)&&(identical(other.status, status) || other.status == status)&&(identical(other.record, record) || other.record == record)&&(identical(other.conflicts, conflicts) || other.conflicts == conflicts)&&const DeepCollectionEquality().equals(other.issues, issues));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,opId,status,record,conflicts,const DeepCollectionEquality().hash(issues));

@override
String toString() {
  return 'OpResult(opId: $opId, status: $status, record: $record, conflicts: $conflicts, issues: $issues)';
}


}

/// @nodoc
abstract mixin class $OpResultCopyWith<$Res>  {
  factory $OpResultCopyWith(OpResult value, $Res Function(OpResult) _then) = _$OpResultCopyWithImpl;
@useResult
$Res call({
 String opId, OpStatus status, SyncRecord? record, int conflicts, List<ValidationIssue> issues
});


$SyncRecordCopyWith<$Res>? get record;

}
/// @nodoc
class _$OpResultCopyWithImpl<$Res>
    implements $OpResultCopyWith<$Res> {
  _$OpResultCopyWithImpl(this._self, this._then);

  final OpResult _self;
  final $Res Function(OpResult) _then;

/// Create a copy of OpResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? opId = null,Object? status = null,Object? record = freezed,Object? conflicts = null,Object? issues = null,}) {
  return _then(_self.copyWith(
opId: null == opId ? _self.opId : opId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OpStatus,record: freezed == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as SyncRecord?,conflicts: null == conflicts ? _self.conflicts : conflicts // ignore: cast_nullable_to_non_nullable
as int,issues: null == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as List<ValidationIssue>,
  ));
}
/// Create a copy of OpResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SyncRecordCopyWith<$Res>? get record {
    if (_self.record == null) {
    return null;
  }

  return $SyncRecordCopyWith<$Res>(_self.record!, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}


/// Adds pattern-matching-related methods to [OpResult].
extension OpResultPatterns on OpResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OpResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OpResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OpResult value)  $default,){
final _that = this;
switch (_that) {
case _OpResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OpResult value)?  $default,){
final _that = this;
switch (_that) {
case _OpResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String opId,  OpStatus status,  SyncRecord? record,  int conflicts,  List<ValidationIssue> issues)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OpResult() when $default != null:
return $default(_that.opId,_that.status,_that.record,_that.conflicts,_that.issues);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String opId,  OpStatus status,  SyncRecord? record,  int conflicts,  List<ValidationIssue> issues)  $default,) {final _that = this;
switch (_that) {
case _OpResult():
return $default(_that.opId,_that.status,_that.record,_that.conflicts,_that.issues);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String opId,  OpStatus status,  SyncRecord? record,  int conflicts,  List<ValidationIssue> issues)?  $default,) {final _that = this;
switch (_that) {
case _OpResult() when $default != null:
return $default(_that.opId,_that.status,_that.record,_that.conflicts,_that.issues);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OpResult implements OpResult {
  const _OpResult({required this.opId, required this.status, this.record, this.conflicts = 0, final  List<ValidationIssue> issues = const []}): _issues = issues;
  factory _OpResult.fromJson(Map<String, dynamic> json) => _$OpResultFromJson(json);

@override final  String opId;
@override final  OpStatus status;
/// État serveur de l'enregistrement après traitement.
@override final  SyncRecord? record;
@override@JsonKey() final  int conflicts;
 final  List<ValidationIssue> _issues;
@override@JsonKey() List<ValidationIssue> get issues {
  if (_issues is EqualUnmodifiableListView) return _issues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_issues);
}


/// Create a copy of OpResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OpResultCopyWith<_OpResult> get copyWith => __$OpResultCopyWithImpl<_OpResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OpResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OpResult&&(identical(other.opId, opId) || other.opId == opId)&&(identical(other.status, status) || other.status == status)&&(identical(other.record, record) || other.record == record)&&(identical(other.conflicts, conflicts) || other.conflicts == conflicts)&&const DeepCollectionEquality().equals(other._issues, _issues));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,opId,status,record,conflicts,const DeepCollectionEquality().hash(_issues));

@override
String toString() {
  return 'OpResult(opId: $opId, status: $status, record: $record, conflicts: $conflicts, issues: $issues)';
}


}

/// @nodoc
abstract mixin class _$OpResultCopyWith<$Res> implements $OpResultCopyWith<$Res> {
  factory _$OpResultCopyWith(_OpResult value, $Res Function(_OpResult) _then) = __$OpResultCopyWithImpl;
@override @useResult
$Res call({
 String opId, OpStatus status, SyncRecord? record, int conflicts, List<ValidationIssue> issues
});


@override $SyncRecordCopyWith<$Res>? get record;

}
/// @nodoc
class __$OpResultCopyWithImpl<$Res>
    implements _$OpResultCopyWith<$Res> {
  __$OpResultCopyWithImpl(this._self, this._then);

  final _OpResult _self;
  final $Res Function(_OpResult) _then;

/// Create a copy of OpResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? opId = null,Object? status = null,Object? record = freezed,Object? conflicts = null,Object? issues = null,}) {
  return _then(_OpResult(
opId: null == opId ? _self.opId : opId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OpStatus,record: freezed == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as SyncRecord?,conflicts: null == conflicts ? _self.conflicts : conflicts // ignore: cast_nullable_to_non_nullable
as int,issues: null == issues ? _self._issues : issues // ignore: cast_nullable_to_non_nullable
as List<ValidationIssue>,
  ));
}

/// Create a copy of OpResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SyncRecordCopyWith<$Res>? get record {
    if (_self.record == null) {
    return null;
  }

  return $SyncRecordCopyWith<$Res>(_self.record!, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}


/// @nodoc
mixin _$PushResponse {

 List<OpResult> get results;
/// Create a copy of PushResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushResponseCopyWith<PushResponse> get copyWith => _$PushResponseCopyWithImpl<PushResponse>(this as PushResponse, _$identity);

  /// Serializes this PushResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushResponse&&const DeepCollectionEquality().equals(other.results, results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(results));

@override
String toString() {
  return 'PushResponse(results: $results)';
}


}

/// @nodoc
abstract mixin class $PushResponseCopyWith<$Res>  {
  factory $PushResponseCopyWith(PushResponse value, $Res Function(PushResponse) _then) = _$PushResponseCopyWithImpl;
@useResult
$Res call({
 List<OpResult> results
});




}
/// @nodoc
class _$PushResponseCopyWithImpl<$Res>
    implements $PushResponseCopyWith<$Res> {
  _$PushResponseCopyWithImpl(this._self, this._then);

  final PushResponse _self;
  final $Res Function(PushResponse) _then;

/// Create a copy of PushResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? results = null,}) {
  return _then(_self.copyWith(
results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<OpResult>,
  ));
}

}


/// Adds pattern-matching-related methods to [PushResponse].
extension PushResponsePatterns on PushResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PushResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PushResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PushResponse value)  $default,){
final _that = this;
switch (_that) {
case _PushResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PushResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PushResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<OpResult> results)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PushResponse() when $default != null:
return $default(_that.results);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<OpResult> results)  $default,) {final _that = this;
switch (_that) {
case _PushResponse():
return $default(_that.results);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<OpResult> results)?  $default,) {final _that = this;
switch (_that) {
case _PushResponse() when $default != null:
return $default(_that.results);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PushResponse implements PushResponse {
  const _PushResponse({required final  List<OpResult> results}): _results = results;
  factory _PushResponse.fromJson(Map<String, dynamic> json) => _$PushResponseFromJson(json);

 final  List<OpResult> _results;
@override List<OpResult> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}


/// Create a copy of PushResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushResponseCopyWith<_PushResponse> get copyWith => __$PushResponseCopyWithImpl<_PushResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PushResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PushResponse&&const DeepCollectionEquality().equals(other._results, _results));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_results));

@override
String toString() {
  return 'PushResponse(results: $results)';
}


}

/// @nodoc
abstract mixin class _$PushResponseCopyWith<$Res> implements $PushResponseCopyWith<$Res> {
  factory _$PushResponseCopyWith(_PushResponse value, $Res Function(_PushResponse) _then) = __$PushResponseCopyWithImpl;
@override @useResult
$Res call({
 List<OpResult> results
});




}
/// @nodoc
class __$PushResponseCopyWithImpl<$Res>
    implements _$PushResponseCopyWith<$Res> {
  __$PushResponseCopyWithImpl(this._self, this._then);

  final _PushResponse _self;
  final $Res Function(_PushResponse) _then;

/// Create a copy of PushResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? results = null,}) {
  return _then(_PushResponse(
results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<OpResult>,
  ));
}


}


/// @nodoc
mixin _$SyncRecord {

 String get entity; String get id; int get version;/// Position dans le journal des changements (curseur de pull).
 int get seq;/// Champs modifiables + colonnes techniques (clés snake_case, dates
/// ISO 8601 UTC).
 Map<String, Object?> get data; Map<String, FieldStamp> get fieldMeta;
/// Create a copy of SyncRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncRecordCopyWith<SyncRecord> get copyWith => _$SyncRecordCopyWithImpl<SyncRecord>(this as SyncRecord, _$identity);

  /// Serializes this SyncRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncRecord&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.id, id) || other.id == id)&&(identical(other.version, version) || other.version == version)&&(identical(other.seq, seq) || other.seq == seq)&&const DeepCollectionEquality().equals(other.data, data)&&const DeepCollectionEquality().equals(other.fieldMeta, fieldMeta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entity,id,version,seq,const DeepCollectionEquality().hash(data),const DeepCollectionEquality().hash(fieldMeta));

@override
String toString() {
  return 'SyncRecord(entity: $entity, id: $id, version: $version, seq: $seq, data: $data, fieldMeta: $fieldMeta)';
}


}

/// @nodoc
abstract mixin class $SyncRecordCopyWith<$Res>  {
  factory $SyncRecordCopyWith(SyncRecord value, $Res Function(SyncRecord) _then) = _$SyncRecordCopyWithImpl;
@useResult
$Res call({
 String entity, String id, int version, int seq, Map<String, Object?> data, Map<String, FieldStamp> fieldMeta
});




}
/// @nodoc
class _$SyncRecordCopyWithImpl<$Res>
    implements $SyncRecordCopyWith<$Res> {
  _$SyncRecordCopyWithImpl(this._self, this._then);

  final SyncRecord _self;
  final $Res Function(SyncRecord) _then;

/// Create a copy of SyncRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entity = null,Object? id = null,Object? version = null,Object? seq = null,Object? data = null,Object? fieldMeta = null,}) {
  return _then(_self.copyWith(
entity: null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,fieldMeta: null == fieldMeta ? _self.fieldMeta : fieldMeta // ignore: cast_nullable_to_non_nullable
as Map<String, FieldStamp>,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncRecord].
extension SyncRecordPatterns on SyncRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncRecord value)  $default,){
final _that = this;
switch (_that) {
case _SyncRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncRecord value)?  $default,){
final _that = this;
switch (_that) {
case _SyncRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String entity,  String id,  int version,  int seq,  Map<String, Object?> data,  Map<String, FieldStamp> fieldMeta)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncRecord() when $default != null:
return $default(_that.entity,_that.id,_that.version,_that.seq,_that.data,_that.fieldMeta);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String entity,  String id,  int version,  int seq,  Map<String, Object?> data,  Map<String, FieldStamp> fieldMeta)  $default,) {final _that = this;
switch (_that) {
case _SyncRecord():
return $default(_that.entity,_that.id,_that.version,_that.seq,_that.data,_that.fieldMeta);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String entity,  String id,  int version,  int seq,  Map<String, Object?> data,  Map<String, FieldStamp> fieldMeta)?  $default,) {final _that = this;
switch (_that) {
case _SyncRecord() when $default != null:
return $default(_that.entity,_that.id,_that.version,_that.seq,_that.data,_that.fieldMeta);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncRecord implements SyncRecord {
  const _SyncRecord({required this.entity, required this.id, required this.version, required this.seq, required final  Map<String, Object?> data, required final  Map<String, FieldStamp> fieldMeta}): _data = data,_fieldMeta = fieldMeta;
  factory _SyncRecord.fromJson(Map<String, dynamic> json) => _$SyncRecordFromJson(json);

@override final  String entity;
@override final  String id;
@override final  int version;
/// Position dans le journal des changements (curseur de pull).
@override final  int seq;
/// Champs modifiables + colonnes techniques (clés snake_case, dates
/// ISO 8601 UTC).
 final  Map<String, Object?> _data;
/// Champs modifiables + colonnes techniques (clés snake_case, dates
/// ISO 8601 UTC).
@override Map<String, Object?> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}

 final  Map<String, FieldStamp> _fieldMeta;
@override Map<String, FieldStamp> get fieldMeta {
  if (_fieldMeta is EqualUnmodifiableMapView) return _fieldMeta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fieldMeta);
}


/// Create a copy of SyncRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncRecordCopyWith<_SyncRecord> get copyWith => __$SyncRecordCopyWithImpl<_SyncRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncRecord&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.id, id) || other.id == id)&&(identical(other.version, version) || other.version == version)&&(identical(other.seq, seq) || other.seq == seq)&&const DeepCollectionEquality().equals(other._data, _data)&&const DeepCollectionEquality().equals(other._fieldMeta, _fieldMeta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entity,id,version,seq,const DeepCollectionEquality().hash(_data),const DeepCollectionEquality().hash(_fieldMeta));

@override
String toString() {
  return 'SyncRecord(entity: $entity, id: $id, version: $version, seq: $seq, data: $data, fieldMeta: $fieldMeta)';
}


}

/// @nodoc
abstract mixin class _$SyncRecordCopyWith<$Res> implements $SyncRecordCopyWith<$Res> {
  factory _$SyncRecordCopyWith(_SyncRecord value, $Res Function(_SyncRecord) _then) = __$SyncRecordCopyWithImpl;
@override @useResult
$Res call({
 String entity, String id, int version, int seq, Map<String, Object?> data, Map<String, FieldStamp> fieldMeta
});




}
/// @nodoc
class __$SyncRecordCopyWithImpl<$Res>
    implements _$SyncRecordCopyWith<$Res> {
  __$SyncRecordCopyWithImpl(this._self, this._then);

  final _SyncRecord _self;
  final $Res Function(_SyncRecord) _then;

/// Create a copy of SyncRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entity = null,Object? id = null,Object? version = null,Object? seq = null,Object? data = null,Object? fieldMeta = null,}) {
  return _then(_SyncRecord(
entity: null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,seq: null == seq ? _self.seq : seq // ignore: cast_nullable_to_non_nullable
as int,data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,fieldMeta: null == fieldMeta ? _self._fieldMeta : fieldMeta // ignore: cast_nullable_to_non_nullable
as Map<String, FieldStamp>,
  ));
}


}


/// @nodoc
mixin _$PullResponse {

 List<SyncRecord> get records;/// Curseur à renvoyer au prochain pull.
 int get cursor; bool get hasMore;
/// Create a copy of PullResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PullResponseCopyWith<PullResponse> get copyWith => _$PullResponseCopyWithImpl<PullResponse>(this as PullResponse, _$identity);

  /// Serializes this PullResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PullResponse&&const DeepCollectionEquality().equals(other.records, records)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(records),cursor,hasMore);

@override
String toString() {
  return 'PullResponse(records: $records, cursor: $cursor, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $PullResponseCopyWith<$Res>  {
  factory $PullResponseCopyWith(PullResponse value, $Res Function(PullResponse) _then) = _$PullResponseCopyWithImpl;
@useResult
$Res call({
 List<SyncRecord> records, int cursor, bool hasMore
});




}
/// @nodoc
class _$PullResponseCopyWithImpl<$Res>
    implements $PullResponseCopyWith<$Res> {
  _$PullResponseCopyWithImpl(this._self, this._then);

  final PullResponse _self;
  final $Res Function(PullResponse) _then;

/// Create a copy of PullResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? records = null,Object? cursor = null,Object? hasMore = null,}) {
  return _then(_self.copyWith(
records: null == records ? _self.records : records // ignore: cast_nullable_to_non_nullable
as List<SyncRecord>,cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PullResponse].
extension PullResponsePatterns on PullResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PullResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PullResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PullResponse value)  $default,){
final _that = this;
switch (_that) {
case _PullResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PullResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PullResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SyncRecord> records,  int cursor,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PullResponse() when $default != null:
return $default(_that.records,_that.cursor,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SyncRecord> records,  int cursor,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _PullResponse():
return $default(_that.records,_that.cursor,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SyncRecord> records,  int cursor,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _PullResponse() when $default != null:
return $default(_that.records,_that.cursor,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PullResponse implements PullResponse {
  const _PullResponse({required final  List<SyncRecord> records, required this.cursor, required this.hasMore}): _records = records;
  factory _PullResponse.fromJson(Map<String, dynamic> json) => _$PullResponseFromJson(json);

 final  List<SyncRecord> _records;
@override List<SyncRecord> get records {
  if (_records is EqualUnmodifiableListView) return _records;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_records);
}

/// Curseur à renvoyer au prochain pull.
@override final  int cursor;
@override final  bool hasMore;

/// Create a copy of PullResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PullResponseCopyWith<_PullResponse> get copyWith => __$PullResponseCopyWithImpl<_PullResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PullResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PullResponse&&const DeepCollectionEquality().equals(other._records, _records)&&(identical(other.cursor, cursor) || other.cursor == cursor)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_records),cursor,hasMore);

@override
String toString() {
  return 'PullResponse(records: $records, cursor: $cursor, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$PullResponseCopyWith<$Res> implements $PullResponseCopyWith<$Res> {
  factory _$PullResponseCopyWith(_PullResponse value, $Res Function(_PullResponse) _then) = __$PullResponseCopyWithImpl;
@override @useResult
$Res call({
 List<SyncRecord> records, int cursor, bool hasMore
});




}
/// @nodoc
class __$PullResponseCopyWithImpl<$Res>
    implements _$PullResponseCopyWith<$Res> {
  __$PullResponseCopyWithImpl(this._self, this._then);

  final _PullResponse _self;
  final $Res Function(_PullResponse) _then;

/// Create a copy of PullResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? records = null,Object? cursor = null,Object? hasMore = null,}) {
  return _then(_PullResponse(
records: null == records ? _self._records : records // ignore: cast_nullable_to_non_nullable
as List<SyncRecord>,cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SyncConflict {

 String get id; String get entity; String get entityId; String get field; Object? get winningValue; Object? get losingValue; String get winningHlc; String get losingHlc; String? get winnerUserId; String? get winnerName; String? get loserUserId; String? get loserName; DateTime get createdAt; DateTime? get reviewedAt; String? get reviewedBy;
/// Create a copy of SyncConflict
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SyncConflictCopyWith<SyncConflict> get copyWith => _$SyncConflictCopyWithImpl<SyncConflict>(this as SyncConflict, _$identity);

  /// Serializes this SyncConflict to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SyncConflict&&(identical(other.id, id) || other.id == id)&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.field, field) || other.field == field)&&const DeepCollectionEquality().equals(other.winningValue, winningValue)&&const DeepCollectionEquality().equals(other.losingValue, losingValue)&&(identical(other.winningHlc, winningHlc) || other.winningHlc == winningHlc)&&(identical(other.losingHlc, losingHlc) || other.losingHlc == losingHlc)&&(identical(other.winnerUserId, winnerUserId) || other.winnerUserId == winnerUserId)&&(identical(other.winnerName, winnerName) || other.winnerName == winnerName)&&(identical(other.loserUserId, loserUserId) || other.loserUserId == loserUserId)&&(identical(other.loserName, loserName) || other.loserName == loserName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,entity,entityId,field,const DeepCollectionEquality().hash(winningValue),const DeepCollectionEquality().hash(losingValue),winningHlc,losingHlc,winnerUserId,winnerName,loserUserId,loserName,createdAt,reviewedAt,reviewedBy);

@override
String toString() {
  return 'SyncConflict(id: $id, entity: $entity, entityId: $entityId, field: $field, winningValue: $winningValue, losingValue: $losingValue, winningHlc: $winningHlc, losingHlc: $losingHlc, winnerUserId: $winnerUserId, winnerName: $winnerName, loserUserId: $loserUserId, loserName: $loserName, createdAt: $createdAt, reviewedAt: $reviewedAt, reviewedBy: $reviewedBy)';
}


}

/// @nodoc
abstract mixin class $SyncConflictCopyWith<$Res>  {
  factory $SyncConflictCopyWith(SyncConflict value, $Res Function(SyncConflict) _then) = _$SyncConflictCopyWithImpl;
@useResult
$Res call({
 String id, String entity, String entityId, String field, Object? winningValue, Object? losingValue, String winningHlc, String losingHlc, String? winnerUserId, String? winnerName, String? loserUserId, String? loserName, DateTime createdAt, DateTime? reviewedAt, String? reviewedBy
});




}
/// @nodoc
class _$SyncConflictCopyWithImpl<$Res>
    implements $SyncConflictCopyWith<$Res> {
  _$SyncConflictCopyWithImpl(this._self, this._then);

  final SyncConflict _self;
  final $Res Function(SyncConflict) _then;

/// Create a copy of SyncConflict
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? entity = null,Object? entityId = null,Object? field = null,Object? winningValue = freezed,Object? losingValue = freezed,Object? winningHlc = null,Object? losingHlc = null,Object? winnerUserId = freezed,Object? winnerName = freezed,Object? loserUserId = freezed,Object? loserName = freezed,Object? createdAt = null,Object? reviewedAt = freezed,Object? reviewedBy = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,entity: null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,winningValue: freezed == winningValue ? _self.winningValue : winningValue ,losingValue: freezed == losingValue ? _self.losingValue : losingValue ,winningHlc: null == winningHlc ? _self.winningHlc : winningHlc // ignore: cast_nullable_to_non_nullable
as String,losingHlc: null == losingHlc ? _self.losingHlc : losingHlc // ignore: cast_nullable_to_non_nullable
as String,winnerUserId: freezed == winnerUserId ? _self.winnerUserId : winnerUserId // ignore: cast_nullable_to_non_nullable
as String?,winnerName: freezed == winnerName ? _self.winnerName : winnerName // ignore: cast_nullable_to_non_nullable
as String?,loserUserId: freezed == loserUserId ? _self.loserUserId : loserUserId // ignore: cast_nullable_to_non_nullable
as String?,loserName: freezed == loserName ? _self.loserName : loserName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SyncConflict].
extension SyncConflictPatterns on SyncConflict {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SyncConflict value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SyncConflict() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SyncConflict value)  $default,){
final _that = this;
switch (_that) {
case _SyncConflict():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SyncConflict value)?  $default,){
final _that = this;
switch (_that) {
case _SyncConflict() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String entity,  String entityId,  String field,  Object? winningValue,  Object? losingValue,  String winningHlc,  String losingHlc,  String? winnerUserId,  String? winnerName,  String? loserUserId,  String? loserName,  DateTime createdAt,  DateTime? reviewedAt,  String? reviewedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SyncConflict() when $default != null:
return $default(_that.id,_that.entity,_that.entityId,_that.field,_that.winningValue,_that.losingValue,_that.winningHlc,_that.losingHlc,_that.winnerUserId,_that.winnerName,_that.loserUserId,_that.loserName,_that.createdAt,_that.reviewedAt,_that.reviewedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String entity,  String entityId,  String field,  Object? winningValue,  Object? losingValue,  String winningHlc,  String losingHlc,  String? winnerUserId,  String? winnerName,  String? loserUserId,  String? loserName,  DateTime createdAt,  DateTime? reviewedAt,  String? reviewedBy)  $default,) {final _that = this;
switch (_that) {
case _SyncConflict():
return $default(_that.id,_that.entity,_that.entityId,_that.field,_that.winningValue,_that.losingValue,_that.winningHlc,_that.losingHlc,_that.winnerUserId,_that.winnerName,_that.loserUserId,_that.loserName,_that.createdAt,_that.reviewedAt,_that.reviewedBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String entity,  String entityId,  String field,  Object? winningValue,  Object? losingValue,  String winningHlc,  String losingHlc,  String? winnerUserId,  String? winnerName,  String? loserUserId,  String? loserName,  DateTime createdAt,  DateTime? reviewedAt,  String? reviewedBy)?  $default,) {final _that = this;
switch (_that) {
case _SyncConflict() when $default != null:
return $default(_that.id,_that.entity,_that.entityId,_that.field,_that.winningValue,_that.losingValue,_that.winningHlc,_that.losingHlc,_that.winnerUserId,_that.winnerName,_that.loserUserId,_that.loserName,_that.createdAt,_that.reviewedAt,_that.reviewedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SyncConflict implements SyncConflict {
  const _SyncConflict({required this.id, required this.entity, required this.entityId, required this.field, this.winningValue, this.losingValue, required this.winningHlc, required this.losingHlc, this.winnerUserId, this.winnerName, this.loserUserId, this.loserName, required this.createdAt, this.reviewedAt, this.reviewedBy});
  factory _SyncConflict.fromJson(Map<String, dynamic> json) => _$SyncConflictFromJson(json);

@override final  String id;
@override final  String entity;
@override final  String entityId;
@override final  String field;
@override final  Object? winningValue;
@override final  Object? losingValue;
@override final  String winningHlc;
@override final  String losingHlc;
@override final  String? winnerUserId;
@override final  String? winnerName;
@override final  String? loserUserId;
@override final  String? loserName;
@override final  DateTime createdAt;
@override final  DateTime? reviewedAt;
@override final  String? reviewedBy;

/// Create a copy of SyncConflict
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SyncConflictCopyWith<_SyncConflict> get copyWith => __$SyncConflictCopyWithImpl<_SyncConflict>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SyncConflictToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SyncConflict&&(identical(other.id, id) || other.id == id)&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.entityId, entityId) || other.entityId == entityId)&&(identical(other.field, field) || other.field == field)&&const DeepCollectionEquality().equals(other.winningValue, winningValue)&&const DeepCollectionEquality().equals(other.losingValue, losingValue)&&(identical(other.winningHlc, winningHlc) || other.winningHlc == winningHlc)&&(identical(other.losingHlc, losingHlc) || other.losingHlc == losingHlc)&&(identical(other.winnerUserId, winnerUserId) || other.winnerUserId == winnerUserId)&&(identical(other.winnerName, winnerName) || other.winnerName == winnerName)&&(identical(other.loserUserId, loserUserId) || other.loserUserId == loserUserId)&&(identical(other.loserName, loserName) || other.loserName == loserName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,entity,entityId,field,const DeepCollectionEquality().hash(winningValue),const DeepCollectionEquality().hash(losingValue),winningHlc,losingHlc,winnerUserId,winnerName,loserUserId,loserName,createdAt,reviewedAt,reviewedBy);

@override
String toString() {
  return 'SyncConflict(id: $id, entity: $entity, entityId: $entityId, field: $field, winningValue: $winningValue, losingValue: $losingValue, winningHlc: $winningHlc, losingHlc: $losingHlc, winnerUserId: $winnerUserId, winnerName: $winnerName, loserUserId: $loserUserId, loserName: $loserName, createdAt: $createdAt, reviewedAt: $reviewedAt, reviewedBy: $reviewedBy)';
}


}

/// @nodoc
abstract mixin class _$SyncConflictCopyWith<$Res> implements $SyncConflictCopyWith<$Res> {
  factory _$SyncConflictCopyWith(_SyncConflict value, $Res Function(_SyncConflict) _then) = __$SyncConflictCopyWithImpl;
@override @useResult
$Res call({
 String id, String entity, String entityId, String field, Object? winningValue, Object? losingValue, String winningHlc, String losingHlc, String? winnerUserId, String? winnerName, String? loserUserId, String? loserName, DateTime createdAt, DateTime? reviewedAt, String? reviewedBy
});




}
/// @nodoc
class __$SyncConflictCopyWithImpl<$Res>
    implements _$SyncConflictCopyWith<$Res> {
  __$SyncConflictCopyWithImpl(this._self, this._then);

  final _SyncConflict _self;
  final $Res Function(_SyncConflict) _then;

/// Create a copy of SyncConflict
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? entity = null,Object? entityId = null,Object? field = null,Object? winningValue = freezed,Object? losingValue = freezed,Object? winningHlc = null,Object? losingHlc = null,Object? winnerUserId = freezed,Object? winnerName = freezed,Object? loserUserId = freezed,Object? loserName = freezed,Object? createdAt = null,Object? reviewedAt = freezed,Object? reviewedBy = freezed,}) {
  return _then(_SyncConflict(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,entity: null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String,entityId: null == entityId ? _self.entityId : entityId // ignore: cast_nullable_to_non_nullable
as String,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,winningValue: freezed == winningValue ? _self.winningValue : winningValue ,losingValue: freezed == losingValue ? _self.losingValue : losingValue ,winningHlc: null == winningHlc ? _self.winningHlc : winningHlc // ignore: cast_nullable_to_non_nullable
as String,losingHlc: null == losingHlc ? _self.losingHlc : losingHlc // ignore: cast_nullable_to_non_nullable
as String,winnerUserId: freezed == winnerUserId ? _self.winnerUserId : winnerUserId // ignore: cast_nullable_to_non_nullable
as String?,winnerName: freezed == winnerName ? _self.winnerName : winnerName // ignore: cast_nullable_to_non_nullable
as String?,loserUserId: freezed == loserUserId ? _self.loserUserId : loserUserId // ignore: cast_nullable_to_non_nullable
as String?,loserName: freezed == loserName ? _self.loserName : loserName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

ClientMessage _$ClientMessageFromJson(
  Map<String, dynamic> json
) {
    return ClientAuth.fromJson(
      json
    );
}

/// @nodoc
mixin _$ClientMessage {

 String get accessToken; int get protocolVersion;
/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientMessageCopyWith<ClientMessage> get copyWith => _$ClientMessageCopyWithImpl<ClientMessage>(this as ClientMessage, _$identity);

  /// Serializes this ClientMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientMessage&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.protocolVersion, protocolVersion) || other.protocolVersion == protocolVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,protocolVersion);

@override
String toString() {
  return 'ClientMessage(accessToken: $accessToken, protocolVersion: $protocolVersion)';
}


}

/// @nodoc
abstract mixin class $ClientMessageCopyWith<$Res>  {
  factory $ClientMessageCopyWith(ClientMessage value, $Res Function(ClientMessage) _then) = _$ClientMessageCopyWithImpl;
@useResult
$Res call({
 String accessToken, int protocolVersion
});




}
/// @nodoc
class _$ClientMessageCopyWithImpl<$Res>
    implements $ClientMessageCopyWith<$Res> {
  _$ClientMessageCopyWithImpl(this._self, this._then);

  final ClientMessage _self;
  final $Res Function(ClientMessage) _then;

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? protocolVersion = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,protocolVersion: null == protocolVersion ? _self.protocolVersion : protocolVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ClientMessage].
extension ClientMessagePatterns on ClientMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ClientAuth value)?  auth,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ClientAuth() when auth != null:
return auth(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ClientAuth value)  auth,}){
final _that = this;
switch (_that) {
case ClientAuth():
return auth(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ClientAuth value)?  auth,}){
final _that = this;
switch (_that) {
case ClientAuth() when auth != null:
return auth(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String accessToken,  int protocolVersion)?  auth,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ClientAuth() when auth != null:
return auth(_that.accessToken,_that.protocolVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String accessToken,  int protocolVersion)  auth,}) {final _that = this;
switch (_that) {
case ClientAuth():
return auth(_that.accessToken,_that.protocolVersion);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String accessToken,  int protocolVersion)?  auth,}) {final _that = this;
switch (_that) {
case ClientAuth() when auth != null:
return auth(_that.accessToken,_that.protocolVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class ClientAuth implements ClientMessage {
  const ClientAuth({required this.accessToken, required this.protocolVersion});
  factory ClientAuth.fromJson(Map<String, dynamic> json) => _$ClientAuthFromJson(json);

@override final  String accessToken;
@override final  int protocolVersion;

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClientAuthCopyWith<ClientAuth> get copyWith => _$ClientAuthCopyWithImpl<ClientAuth>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClientAuthToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClientAuth&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.protocolVersion, protocolVersion) || other.protocolVersion == protocolVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,protocolVersion);

@override
String toString() {
  return 'ClientMessage.auth(accessToken: $accessToken, protocolVersion: $protocolVersion)';
}


}

/// @nodoc
abstract mixin class $ClientAuthCopyWith<$Res> implements $ClientMessageCopyWith<$Res> {
  factory $ClientAuthCopyWith(ClientAuth value, $Res Function(ClientAuth) _then) = _$ClientAuthCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, int protocolVersion
});




}
/// @nodoc
class _$ClientAuthCopyWithImpl<$Res>
    implements $ClientAuthCopyWith<$Res> {
  _$ClientAuthCopyWithImpl(this._self, this._then);

  final ClientAuth _self;
  final $Res Function(ClientAuth) _then;

/// Create a copy of ClientMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? protocolVersion = null,}) {
  return _then(ClientAuth(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,protocolVersion: null == protocolVersion ? _self.protocolVersion : protocolVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

ServerMessage _$ServerMessageFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'ready':
          return ServerReady.fromJson(
            json
          );
                case 'changes':
          return ServerChanges.fromJson(
            json
          );
                case 'session_revoked':
          return ServerSessionRevoked.fromJson(
            json
          );
                case 'error':
          return ServerError.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'ServerMessage',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$ServerMessage {



  /// Serializes this ServerMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerMessage);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServerMessage()';
}


}

/// @nodoc
class $ServerMessageCopyWith<$Res>  {
$ServerMessageCopyWith(ServerMessage _, $Res Function(ServerMessage) __);
}


/// Adds pattern-matching-related methods to [ServerMessage].
extension ServerMessagePatterns on ServerMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServerReady value)?  ready,TResult Function( ServerChanges value)?  changes,TResult Function( ServerSessionRevoked value)?  sessionRevoked,TResult Function( ServerError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServerReady() when ready != null:
return ready(_that);case ServerChanges() when changes != null:
return changes(_that);case ServerSessionRevoked() when sessionRevoked != null:
return sessionRevoked(_that);case ServerError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServerReady value)  ready,required TResult Function( ServerChanges value)  changes,required TResult Function( ServerSessionRevoked value)  sessionRevoked,required TResult Function( ServerError value)  error,}){
final _that = this;
switch (_that) {
case ServerReady():
return ready(_that);case ServerChanges():
return changes(_that);case ServerSessionRevoked():
return sessionRevoked(_that);case ServerError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServerReady value)?  ready,TResult? Function( ServerChanges value)?  changes,TResult? Function( ServerSessionRevoked value)?  sessionRevoked,TResult? Function( ServerError value)?  error,}){
final _that = this;
switch (_that) {
case ServerReady() when ready != null:
return ready(_that);case ServerChanges() when changes != null:
return changes(_that);case ServerSessionRevoked() when sessionRevoked != null:
return sessionRevoked(_that);case ServerError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int cursor)?  ready,TResult Function( int cursor)?  changes,TResult Function()?  sessionRevoked,TResult Function( String code,  String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServerReady() when ready != null:
return ready(_that.cursor);case ServerChanges() when changes != null:
return changes(_that.cursor);case ServerSessionRevoked() when sessionRevoked != null:
return sessionRevoked();case ServerError() when error != null:
return error(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int cursor)  ready,required TResult Function( int cursor)  changes,required TResult Function()  sessionRevoked,required TResult Function( String code,  String message)  error,}) {final _that = this;
switch (_that) {
case ServerReady():
return ready(_that.cursor);case ServerChanges():
return changes(_that.cursor);case ServerSessionRevoked():
return sessionRevoked();case ServerError():
return error(_that.code,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int cursor)?  ready,TResult? Function( int cursor)?  changes,TResult? Function()?  sessionRevoked,TResult? Function( String code,  String message)?  error,}) {final _that = this;
switch (_that) {
case ServerReady() when ready != null:
return ready(_that.cursor);case ServerChanges() when changes != null:
return changes(_that.cursor);case ServerSessionRevoked() when sessionRevoked != null:
return sessionRevoked();case ServerError() when error != null:
return error(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class ServerReady implements ServerMessage {
  const ServerReady({required this.cursor, final  String? $type}): $type = $type ?? 'ready';
  factory ServerReady.fromJson(Map<String, dynamic> json) => _$ServerReadyFromJson(json);

 final  int cursor;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerReadyCopyWith<ServerReady> get copyWith => _$ServerReadyCopyWithImpl<ServerReady>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerReadyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerReady&&(identical(other.cursor, cursor) || other.cursor == cursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cursor);

@override
String toString() {
  return 'ServerMessage.ready(cursor: $cursor)';
}


}

/// @nodoc
abstract mixin class $ServerReadyCopyWith<$Res> implements $ServerMessageCopyWith<$Res> {
  factory $ServerReadyCopyWith(ServerReady value, $Res Function(ServerReady) _then) = _$ServerReadyCopyWithImpl;
@useResult
$Res call({
 int cursor
});




}
/// @nodoc
class _$ServerReadyCopyWithImpl<$Res>
    implements $ServerReadyCopyWith<$Res> {
  _$ServerReadyCopyWithImpl(this._self, this._then);

  final ServerReady _self;
  final $Res Function(ServerReady) _then;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cursor = null,}) {
  return _then(ServerReady(
cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ServerChanges implements ServerMessage {
  const ServerChanges({required this.cursor, final  String? $type}): $type = $type ?? 'changes';
  factory ServerChanges.fromJson(Map<String, dynamic> json) => _$ServerChangesFromJson(json);

 final  int cursor;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerChangesCopyWith<ServerChanges> get copyWith => _$ServerChangesCopyWithImpl<ServerChanges>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerChangesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerChanges&&(identical(other.cursor, cursor) || other.cursor == cursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cursor);

@override
String toString() {
  return 'ServerMessage.changes(cursor: $cursor)';
}


}

/// @nodoc
abstract mixin class $ServerChangesCopyWith<$Res> implements $ServerMessageCopyWith<$Res> {
  factory $ServerChangesCopyWith(ServerChanges value, $Res Function(ServerChanges) _then) = _$ServerChangesCopyWithImpl;
@useResult
$Res call({
 int cursor
});




}
/// @nodoc
class _$ServerChangesCopyWithImpl<$Res>
    implements $ServerChangesCopyWith<$Res> {
  _$ServerChangesCopyWithImpl(this._self, this._then);

  final ServerChanges _self;
  final $Res Function(ServerChanges) _then;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cursor = null,}) {
  return _then(ServerChanges(
cursor: null == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
@JsonSerializable()

class ServerSessionRevoked implements ServerMessage {
  const ServerSessionRevoked({final  String? $type}): $type = $type ?? 'session_revoked';
  factory ServerSessionRevoked.fromJson(Map<String, dynamic> json) => _$ServerSessionRevokedFromJson(json);



@JsonKey(name: 'type')
final String $type;



@override
Map<String, dynamic> toJson() {
  return _$ServerSessionRevokedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerSessionRevoked);
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServerMessage.sessionRevoked()';
}


}




/// @nodoc
@JsonSerializable()

class ServerError implements ServerMessage {
  const ServerError({required this.code, required this.message, final  String? $type}): $type = $type ?? 'error';
  factory ServerError.fromJson(Map<String, dynamic> json) => _$ServerErrorFromJson(json);

 final  String code;
 final  String message;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerErrorCopyWith<ServerError> get copyWith => _$ServerErrorCopyWithImpl<ServerError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServerErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'ServerMessage.error(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $ServerErrorCopyWith<$Res> implements $ServerMessageCopyWith<$Res> {
  factory $ServerErrorCopyWith(ServerError value, $Res Function(ServerError) _then) = _$ServerErrorCopyWithImpl;
@useResult
$Res call({
 String code, String message
});




}
/// @nodoc
class _$ServerErrorCopyWithImpl<$Res>
    implements $ServerErrorCopyWith<$Res> {
  _$ServerErrorCopyWithImpl(this._self, this._then);

  final ServerError _self;
  final $Res Function(ServerError) _then;

/// Create a copy of ServerMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(ServerError(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
