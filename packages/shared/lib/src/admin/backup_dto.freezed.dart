// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupInfo {

 String get name; DateTime get createdAt;/// `manual`, `schedule` ou `cli`.
 String get trigger; int get databaseBytes;/// Nombre de fichiers joints copiés par cette sauvegarde (les autres
/// l'étaient déjà).
 int get newFiles; int get totalFiles; int get schemaVersion;
/// Create a copy of BackupInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupInfoCopyWith<BackupInfo> get copyWith => _$BackupInfoCopyWithImpl<BackupInfo>(this as BackupInfo, _$identity);

  /// Serializes this BackupInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.databaseBytes, databaseBytes) || other.databaseBytes == databaseBytes)&&(identical(other.newFiles, newFiles) || other.newFiles == newFiles)&&(identical(other.totalFiles, totalFiles) || other.totalFiles == totalFiles)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,createdAt,trigger,databaseBytes,newFiles,totalFiles,schemaVersion);

@override
String toString() {
  return 'BackupInfo(name: $name, createdAt: $createdAt, trigger: $trigger, databaseBytes: $databaseBytes, newFiles: $newFiles, totalFiles: $totalFiles, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class $BackupInfoCopyWith<$Res>  {
  factory $BackupInfoCopyWith(BackupInfo value, $Res Function(BackupInfo) _then) = _$BackupInfoCopyWithImpl;
@useResult
$Res call({
 String name, DateTime createdAt, String trigger, int databaseBytes, int newFiles, int totalFiles, int schemaVersion
});




}
/// @nodoc
class _$BackupInfoCopyWithImpl<$Res>
    implements $BackupInfoCopyWith<$Res> {
  _$BackupInfoCopyWithImpl(this._self, this._then);

  final BackupInfo _self;
  final $Res Function(BackupInfo) _then;

/// Create a copy of BackupInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? createdAt = null,Object? trigger = null,Object? databaseBytes = null,Object? newFiles = null,Object? totalFiles = null,Object? schemaVersion = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as String,databaseBytes: null == databaseBytes ? _self.databaseBytes : databaseBytes // ignore: cast_nullable_to_non_nullable
as int,newFiles: null == newFiles ? _self.newFiles : newFiles // ignore: cast_nullable_to_non_nullable
as int,totalFiles: null == totalFiles ? _self.totalFiles : totalFiles // ignore: cast_nullable_to_non_nullable
as int,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupInfo].
extension BackupInfoPatterns on BackupInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupInfo value)  $default,){
final _that = this;
switch (_that) {
case _BackupInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupInfo value)?  $default,){
final _that = this;
switch (_that) {
case _BackupInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  DateTime createdAt,  String trigger,  int databaseBytes,  int newFiles,  int totalFiles,  int schemaVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupInfo() when $default != null:
return $default(_that.name,_that.createdAt,_that.trigger,_that.databaseBytes,_that.newFiles,_that.totalFiles,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  DateTime createdAt,  String trigger,  int databaseBytes,  int newFiles,  int totalFiles,  int schemaVersion)  $default,) {final _that = this;
switch (_that) {
case _BackupInfo():
return $default(_that.name,_that.createdAt,_that.trigger,_that.databaseBytes,_that.newFiles,_that.totalFiles,_that.schemaVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  DateTime createdAt,  String trigger,  int databaseBytes,  int newFiles,  int totalFiles,  int schemaVersion)?  $default,) {final _that = this;
switch (_that) {
case _BackupInfo() when $default != null:
return $default(_that.name,_that.createdAt,_that.trigger,_that.databaseBytes,_that.newFiles,_that.totalFiles,_that.schemaVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackupInfo implements BackupInfo {
  const _BackupInfo({required this.name, required this.createdAt, required this.trigger, required this.databaseBytes, this.newFiles = 0, this.totalFiles = 0, required this.schemaVersion});
  factory _BackupInfo.fromJson(Map<String, dynamic> json) => _$BackupInfoFromJson(json);

@override final  String name;
@override final  DateTime createdAt;
/// `manual`, `schedule` ou `cli`.
@override final  String trigger;
@override final  int databaseBytes;
/// Nombre de fichiers joints copiés par cette sauvegarde (les autres
/// l'étaient déjà).
@override@JsonKey() final  int newFiles;
@override@JsonKey() final  int totalFiles;
@override final  int schemaVersion;

/// Create a copy of BackupInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupInfoCopyWith<_BackupInfo> get copyWith => __$BackupInfoCopyWithImpl<_BackupInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.databaseBytes, databaseBytes) || other.databaseBytes == databaseBytes)&&(identical(other.newFiles, newFiles) || other.newFiles == newFiles)&&(identical(other.totalFiles, totalFiles) || other.totalFiles == totalFiles)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,createdAt,trigger,databaseBytes,newFiles,totalFiles,schemaVersion);

@override
String toString() {
  return 'BackupInfo(name: $name, createdAt: $createdAt, trigger: $trigger, databaseBytes: $databaseBytes, newFiles: $newFiles, totalFiles: $totalFiles, schemaVersion: $schemaVersion)';
}


}

/// @nodoc
abstract mixin class _$BackupInfoCopyWith<$Res> implements $BackupInfoCopyWith<$Res> {
  factory _$BackupInfoCopyWith(_BackupInfo value, $Res Function(_BackupInfo) _then) = __$BackupInfoCopyWithImpl;
@override @useResult
$Res call({
 String name, DateTime createdAt, String trigger, int databaseBytes, int newFiles, int totalFiles, int schemaVersion
});




}
/// @nodoc
class __$BackupInfoCopyWithImpl<$Res>
    implements _$BackupInfoCopyWith<$Res> {
  __$BackupInfoCopyWithImpl(this._self, this._then);

  final _BackupInfo _self;
  final $Res Function(_BackupInfo) _then;

/// Create a copy of BackupInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? createdAt = null,Object? trigger = null,Object? databaseBytes = null,Object? newFiles = null,Object? totalFiles = null,Object? schemaVersion = null,}) {
  return _then(_BackupInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as String,databaseBytes: null == databaseBytes ? _self.databaseBytes : databaseBytes // ignore: cast_nullable_to_non_nullable
as int,newFiles: null == newFiles ? _self.newFiles : newFiles // ignore: cast_nullable_to_non_nullable
as int,totalFiles: null == totalFiles ? _self.totalFiles : totalFiles // ignore: cast_nullable_to_non_nullable
as int,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$BackupStatus {

 String get directory;/// Heure de la sauvegarde quotidienne (`null` : désactivée).
 int? get hour; int get keepDays; List<BackupInfo> get backups; String? get lastError;
/// Create a copy of BackupStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupStatusCopyWith<BackupStatus> get copyWith => _$BackupStatusCopyWithImpl<BackupStatus>(this as BackupStatus, _$identity);

  /// Serializes this BackupStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupStatus&&(identical(other.directory, directory) || other.directory == directory)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.keepDays, keepDays) || other.keepDays == keepDays)&&const DeepCollectionEquality().equals(other.backups, backups)&&(identical(other.lastError, lastError) || other.lastError == lastError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,directory,hour,keepDays,const DeepCollectionEquality().hash(backups),lastError);

@override
String toString() {
  return 'BackupStatus(directory: $directory, hour: $hour, keepDays: $keepDays, backups: $backups, lastError: $lastError)';
}


}

/// @nodoc
abstract mixin class $BackupStatusCopyWith<$Res>  {
  factory $BackupStatusCopyWith(BackupStatus value, $Res Function(BackupStatus) _then) = _$BackupStatusCopyWithImpl;
@useResult
$Res call({
 String directory, int? hour, int keepDays, List<BackupInfo> backups, String? lastError
});




}
/// @nodoc
class _$BackupStatusCopyWithImpl<$Res>
    implements $BackupStatusCopyWith<$Res> {
  _$BackupStatusCopyWithImpl(this._self, this._then);

  final BackupStatus _self;
  final $Res Function(BackupStatus) _then;

/// Create a copy of BackupStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? directory = null,Object? hour = freezed,Object? keepDays = null,Object? backups = null,Object? lastError = freezed,}) {
  return _then(_self.copyWith(
directory: null == directory ? _self.directory : directory // ignore: cast_nullable_to_non_nullable
as String,hour: freezed == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int?,keepDays: null == keepDays ? _self.keepDays : keepDays // ignore: cast_nullable_to_non_nullable
as int,backups: null == backups ? _self.backups : backups // ignore: cast_nullable_to_non_nullable
as List<BackupInfo>,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupStatus].
extension BackupStatusPatterns on BackupStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupStatus value)  $default,){
final _that = this;
switch (_that) {
case _BackupStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupStatus value)?  $default,){
final _that = this;
switch (_that) {
case _BackupStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String directory,  int? hour,  int keepDays,  List<BackupInfo> backups,  String? lastError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupStatus() when $default != null:
return $default(_that.directory,_that.hour,_that.keepDays,_that.backups,_that.lastError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String directory,  int? hour,  int keepDays,  List<BackupInfo> backups,  String? lastError)  $default,) {final _that = this;
switch (_that) {
case _BackupStatus():
return $default(_that.directory,_that.hour,_that.keepDays,_that.backups,_that.lastError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String directory,  int? hour,  int keepDays,  List<BackupInfo> backups,  String? lastError)?  $default,) {final _that = this;
switch (_that) {
case _BackupStatus() when $default != null:
return $default(_that.directory,_that.hour,_that.keepDays,_that.backups,_that.lastError);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackupStatus implements BackupStatus {
  const _BackupStatus({required this.directory, this.hour, required this.keepDays, final  List<BackupInfo> backups = const [], this.lastError}): _backups = backups;
  factory _BackupStatus.fromJson(Map<String, dynamic> json) => _$BackupStatusFromJson(json);

@override final  String directory;
/// Heure de la sauvegarde quotidienne (`null` : désactivée).
@override final  int? hour;
@override final  int keepDays;
 final  List<BackupInfo> _backups;
@override@JsonKey() List<BackupInfo> get backups {
  if (_backups is EqualUnmodifiableListView) return _backups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_backups);
}

@override final  String? lastError;

/// Create a copy of BackupStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupStatusCopyWith<_BackupStatus> get copyWith => __$BackupStatusCopyWithImpl<_BackupStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupStatus&&(identical(other.directory, directory) || other.directory == directory)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.keepDays, keepDays) || other.keepDays == keepDays)&&const DeepCollectionEquality().equals(other._backups, _backups)&&(identical(other.lastError, lastError) || other.lastError == lastError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,directory,hour,keepDays,const DeepCollectionEquality().hash(_backups),lastError);

@override
String toString() {
  return 'BackupStatus(directory: $directory, hour: $hour, keepDays: $keepDays, backups: $backups, lastError: $lastError)';
}


}

/// @nodoc
abstract mixin class _$BackupStatusCopyWith<$Res> implements $BackupStatusCopyWith<$Res> {
  factory _$BackupStatusCopyWith(_BackupStatus value, $Res Function(_BackupStatus) _then) = __$BackupStatusCopyWithImpl;
@override @useResult
$Res call({
 String directory, int? hour, int keepDays, List<BackupInfo> backups, String? lastError
});




}
/// @nodoc
class __$BackupStatusCopyWithImpl<$Res>
    implements _$BackupStatusCopyWith<$Res> {
  __$BackupStatusCopyWithImpl(this._self, this._then);

  final _BackupStatus _self;
  final $Res Function(_BackupStatus) _then;

/// Create a copy of BackupStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? directory = null,Object? hour = freezed,Object? keepDays = null,Object? backups = null,Object? lastError = freezed,}) {
  return _then(_BackupStatus(
directory: null == directory ? _self.directory : directory // ignore: cast_nullable_to_non_nullable
as String,hour: freezed == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int?,keepDays: null == keepDays ? _self.keepDays : keepDays // ignore: cast_nullable_to_non_nullable
as int,backups: null == backups ? _self._backups : backups // ignore: cast_nullable_to_non_nullable
as List<BackupInfo>,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
