// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connector_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FieldMapping {

/// Champ Voyaj (nom du schéma).
 String get target;/// Chemin dans l'enregistrement source (`adresse.ville`, `tags.0`).
 String? get source; String get transform;/// Valeur fixe (quand [source] est vide).
 Object? get constant;
/// Create a copy of FieldMapping
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldMappingCopyWith<FieldMapping> get copyWith => _$FieldMappingCopyWithImpl<FieldMapping>(this as FieldMapping, _$identity);

  /// Serializes this FieldMapping to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldMapping&&(identical(other.target, target) || other.target == target)&&(identical(other.source, source) || other.source == source)&&(identical(other.transform, transform) || other.transform == transform)&&const DeepCollectionEquality().equals(other.constant, constant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target,source,transform,const DeepCollectionEquality().hash(constant));

@override
String toString() {
  return 'FieldMapping(target: $target, source: $source, transform: $transform, constant: $constant)';
}


}

/// @nodoc
abstract mixin class $FieldMappingCopyWith<$Res>  {
  factory $FieldMappingCopyWith(FieldMapping value, $Res Function(FieldMapping) _then) = _$FieldMappingCopyWithImpl;
@useResult
$Res call({
 String target, String? source, String transform, Object? constant
});




}
/// @nodoc
class _$FieldMappingCopyWithImpl<$Res>
    implements $FieldMappingCopyWith<$Res> {
  _$FieldMappingCopyWithImpl(this._self, this._then);

  final FieldMapping _self;
  final $Res Function(FieldMapping) _then;

/// Create a copy of FieldMapping
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? target = null,Object? source = freezed,Object? transform = null,Object? constant = freezed,}) {
  return _then(_self.copyWith(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,transform: null == transform ? _self.transform : transform // ignore: cast_nullable_to_non_nullable
as String,constant: freezed == constant ? _self.constant : constant ,
  ));
}

}


/// Adds pattern-matching-related methods to [FieldMapping].
extension FieldMappingPatterns on FieldMapping {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FieldMapping value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FieldMapping() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FieldMapping value)  $default,){
final _that = this;
switch (_that) {
case _FieldMapping():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FieldMapping value)?  $default,){
final _that = this;
switch (_that) {
case _FieldMapping() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String target,  String? source,  String transform,  Object? constant)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldMapping() when $default != null:
return $default(_that.target,_that.source,_that.transform,_that.constant);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String target,  String? source,  String transform,  Object? constant)  $default,) {final _that = this;
switch (_that) {
case _FieldMapping():
return $default(_that.target,_that.source,_that.transform,_that.constant);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String target,  String? source,  String transform,  Object? constant)?  $default,) {final _that = this;
switch (_that) {
case _FieldMapping() when $default != null:
return $default(_that.target,_that.source,_that.transform,_that.constant);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FieldMapping implements FieldMapping {
  const _FieldMapping({required this.target, this.source, this.transform = 'none', this.constant});
  factory _FieldMapping.fromJson(Map<String, dynamic> json) => _$FieldMappingFromJson(json);

/// Champ Voyaj (nom du schéma).
@override final  String target;
/// Chemin dans l'enregistrement source (`adresse.ville`, `tags.0`).
@override final  String? source;
@override@JsonKey() final  String transform;
/// Valeur fixe (quand [source] est vide).
@override final  Object? constant;

/// Create a copy of FieldMapping
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldMappingCopyWith<_FieldMapping> get copyWith => __$FieldMappingCopyWithImpl<_FieldMapping>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FieldMappingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldMapping&&(identical(other.target, target) || other.target == target)&&(identical(other.source, source) || other.source == source)&&(identical(other.transform, transform) || other.transform == transform)&&const DeepCollectionEquality().equals(other.constant, constant));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,target,source,transform,const DeepCollectionEquality().hash(constant));

@override
String toString() {
  return 'FieldMapping(target: $target, source: $source, transform: $transform, constant: $constant)';
}


}

/// @nodoc
abstract mixin class _$FieldMappingCopyWith<$Res> implements $FieldMappingCopyWith<$Res> {
  factory _$FieldMappingCopyWith(_FieldMapping value, $Res Function(_FieldMapping) _then) = __$FieldMappingCopyWithImpl;
@override @useResult
$Res call({
 String target, String? source, String transform, Object? constant
});




}
/// @nodoc
class __$FieldMappingCopyWithImpl<$Res>
    implements _$FieldMappingCopyWith<$Res> {
  __$FieldMappingCopyWithImpl(this._self, this._then);

  final _FieldMapping _self;
  final $Res Function(_FieldMapping) _then;

/// Create a copy of FieldMapping
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? target = null,Object? source = freezed,Object? transform = null,Object? constant = freezed,}) {
  return _then(_FieldMapping(
target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,transform: null == transform ? _self.transform : transform // ignore: cast_nullable_to_non_nullable
as String,constant: freezed == constant ? _self.constant : constant ,
  ));
}


}


/// @nodoc
mixin _$OrganisationLookup {

/// Chemin de la valeur dans la source.
 String get source;/// Champ de l'organisation comparé (`siren`, `siret`, `insee_code`,
/// `name`, `email`).
 String get field;
/// Create a copy of OrganisationLookup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrganisationLookupCopyWith<OrganisationLookup> get copyWith => _$OrganisationLookupCopyWithImpl<OrganisationLookup>(this as OrganisationLookup, _$identity);

  /// Serializes this OrganisationLookup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrganisationLookup&&(identical(other.source, source) || other.source == source)&&(identical(other.field, field) || other.field == field));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,field);

@override
String toString() {
  return 'OrganisationLookup(source: $source, field: $field)';
}


}

/// @nodoc
abstract mixin class $OrganisationLookupCopyWith<$Res>  {
  factory $OrganisationLookupCopyWith(OrganisationLookup value, $Res Function(OrganisationLookup) _then) = _$OrganisationLookupCopyWithImpl;
@useResult
$Res call({
 String source, String field
});




}
/// @nodoc
class _$OrganisationLookupCopyWithImpl<$Res>
    implements $OrganisationLookupCopyWith<$Res> {
  _$OrganisationLookupCopyWithImpl(this._self, this._then);

  final OrganisationLookup _self;
  final $Res Function(OrganisationLookup) _then;

/// Create a copy of OrganisationLookup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? source = null,Object? field = null,}) {
  return _then(_self.copyWith(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OrganisationLookup].
extension OrganisationLookupPatterns on OrganisationLookup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OrganisationLookup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OrganisationLookup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OrganisationLookup value)  $default,){
final _that = this;
switch (_that) {
case _OrganisationLookup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OrganisationLookup value)?  $default,){
final _that = this;
switch (_that) {
case _OrganisationLookup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String source,  String field)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OrganisationLookup() when $default != null:
return $default(_that.source,_that.field);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String source,  String field)  $default,) {final _that = this;
switch (_that) {
case _OrganisationLookup():
return $default(_that.source,_that.field);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String source,  String field)?  $default,) {final _that = this;
switch (_that) {
case _OrganisationLookup() when $default != null:
return $default(_that.source,_that.field);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OrganisationLookup implements OrganisationLookup {
  const _OrganisationLookup({required this.source, this.field = 'siren'});
  factory _OrganisationLookup.fromJson(Map<String, dynamic> json) => _$OrganisationLookupFromJson(json);

/// Chemin de la valeur dans la source.
@override final  String source;
/// Champ de l'organisation comparé (`siren`, `siret`, `insee_code`,
/// `name`, `email`).
@override@JsonKey() final  String field;

/// Create a copy of OrganisationLookup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OrganisationLookupCopyWith<_OrganisationLookup> get copyWith => __$OrganisationLookupCopyWithImpl<_OrganisationLookup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OrganisationLookupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OrganisationLookup&&(identical(other.source, source) || other.source == source)&&(identical(other.field, field) || other.field == field));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,source,field);

@override
String toString() {
  return 'OrganisationLookup(source: $source, field: $field)';
}


}

/// @nodoc
abstract mixin class _$OrganisationLookupCopyWith<$Res> implements $OrganisationLookupCopyWith<$Res> {
  factory _$OrganisationLookupCopyWith(_OrganisationLookup value, $Res Function(_OrganisationLookup) _then) = __$OrganisationLookupCopyWithImpl;
@override @useResult
$Res call({
 String source, String field
});




}
/// @nodoc
class __$OrganisationLookupCopyWithImpl<$Res>
    implements _$OrganisationLookupCopyWith<$Res> {
  __$OrganisationLookupCopyWithImpl(this._self, this._then);

  final _OrganisationLookup _self;
  final $Res Function(_OrganisationLookup) _then;

/// Create a copy of OrganisationLookup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? source = null,Object? field = null,}) {
  return _then(_OrganisationLookup(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String,field: null == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ConnectorMapping {

 String get entity;/// Chemin de l'identifiant stable dans la source.
 String get refPath; List<FieldMapping> get fields;/// Valeurs posées seulement à la création (ex. statut).
 Map<String, Object?> get defaults;/// Champ de rapprochement avec une fiche existante.
 String? get matchField; OrganisationLookup? get organisationLookup;
/// Create a copy of ConnectorMapping
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectorMappingCopyWith<ConnectorMapping> get copyWith => _$ConnectorMappingCopyWithImpl<ConnectorMapping>(this as ConnectorMapping, _$identity);

  /// Serializes this ConnectorMapping to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectorMapping&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.refPath, refPath) || other.refPath == refPath)&&const DeepCollectionEquality().equals(other.fields, fields)&&const DeepCollectionEquality().equals(other.defaults, defaults)&&(identical(other.matchField, matchField) || other.matchField == matchField)&&(identical(other.organisationLookup, organisationLookup) || other.organisationLookup == organisationLookup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entity,refPath,const DeepCollectionEquality().hash(fields),const DeepCollectionEquality().hash(defaults),matchField,organisationLookup);

@override
String toString() {
  return 'ConnectorMapping(entity: $entity, refPath: $refPath, fields: $fields, defaults: $defaults, matchField: $matchField, organisationLookup: $organisationLookup)';
}


}

/// @nodoc
abstract mixin class $ConnectorMappingCopyWith<$Res>  {
  factory $ConnectorMappingCopyWith(ConnectorMapping value, $Res Function(ConnectorMapping) _then) = _$ConnectorMappingCopyWithImpl;
@useResult
$Res call({
 String entity, String refPath, List<FieldMapping> fields, Map<String, Object?> defaults, String? matchField, OrganisationLookup? organisationLookup
});


$OrganisationLookupCopyWith<$Res>? get organisationLookup;

}
/// @nodoc
class _$ConnectorMappingCopyWithImpl<$Res>
    implements $ConnectorMappingCopyWith<$Res> {
  _$ConnectorMappingCopyWithImpl(this._self, this._then);

  final ConnectorMapping _self;
  final $Res Function(ConnectorMapping) _then;

/// Create a copy of ConnectorMapping
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entity = null,Object? refPath = null,Object? fields = null,Object? defaults = null,Object? matchField = freezed,Object? organisationLookup = freezed,}) {
  return _then(_self.copyWith(
entity: null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String,refPath: null == refPath ? _self.refPath : refPath // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<FieldMapping>,defaults: null == defaults ? _self.defaults : defaults // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,matchField: freezed == matchField ? _self.matchField : matchField // ignore: cast_nullable_to_non_nullable
as String?,organisationLookup: freezed == organisationLookup ? _self.organisationLookup : organisationLookup // ignore: cast_nullable_to_non_nullable
as OrganisationLookup?,
  ));
}
/// Create a copy of ConnectorMapping
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganisationLookupCopyWith<$Res>? get organisationLookup {
    if (_self.organisationLookup == null) {
    return null;
  }

  return $OrganisationLookupCopyWith<$Res>(_self.organisationLookup!, (value) {
    return _then(_self.copyWith(organisationLookup: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConnectorMapping].
extension ConnectorMappingPatterns on ConnectorMapping {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectorMapping value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectorMapping() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectorMapping value)  $default,){
final _that = this;
switch (_that) {
case _ConnectorMapping():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectorMapping value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectorMapping() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String entity,  String refPath,  List<FieldMapping> fields,  Map<String, Object?> defaults,  String? matchField,  OrganisationLookup? organisationLookup)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectorMapping() when $default != null:
return $default(_that.entity,_that.refPath,_that.fields,_that.defaults,_that.matchField,_that.organisationLookup);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String entity,  String refPath,  List<FieldMapping> fields,  Map<String, Object?> defaults,  String? matchField,  OrganisationLookup? organisationLookup)  $default,) {final _that = this;
switch (_that) {
case _ConnectorMapping():
return $default(_that.entity,_that.refPath,_that.fields,_that.defaults,_that.matchField,_that.organisationLookup);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String entity,  String refPath,  List<FieldMapping> fields,  Map<String, Object?> defaults,  String? matchField,  OrganisationLookup? organisationLookup)?  $default,) {final _that = this;
switch (_that) {
case _ConnectorMapping() when $default != null:
return $default(_that.entity,_that.refPath,_that.fields,_that.defaults,_that.matchField,_that.organisationLookup);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConnectorMapping implements ConnectorMapping {
  const _ConnectorMapping({this.entity = 'organisations', this.refPath = 'id', final  List<FieldMapping> fields = const [], final  Map<String, Object?> defaults = const {}, this.matchField, this.organisationLookup}): _fields = fields,_defaults = defaults;
  factory _ConnectorMapping.fromJson(Map<String, dynamic> json) => _$ConnectorMappingFromJson(json);

@override@JsonKey() final  String entity;
/// Chemin de l'identifiant stable dans la source.
@override@JsonKey() final  String refPath;
 final  List<FieldMapping> _fields;
@override@JsonKey() List<FieldMapping> get fields {
  if (_fields is EqualUnmodifiableListView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fields);
}

/// Valeurs posées seulement à la création (ex. statut).
 final  Map<String, Object?> _defaults;
/// Valeurs posées seulement à la création (ex. statut).
@override@JsonKey() Map<String, Object?> get defaults {
  if (_defaults is EqualUnmodifiableMapView) return _defaults;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_defaults);
}

/// Champ de rapprochement avec une fiche existante.
@override final  String? matchField;
@override final  OrganisationLookup? organisationLookup;

/// Create a copy of ConnectorMapping
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectorMappingCopyWith<_ConnectorMapping> get copyWith => __$ConnectorMappingCopyWithImpl<_ConnectorMapping>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConnectorMappingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectorMapping&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.refPath, refPath) || other.refPath == refPath)&&const DeepCollectionEquality().equals(other._fields, _fields)&&const DeepCollectionEquality().equals(other._defaults, _defaults)&&(identical(other.matchField, matchField) || other.matchField == matchField)&&(identical(other.organisationLookup, organisationLookup) || other.organisationLookup == organisationLookup));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entity,refPath,const DeepCollectionEquality().hash(_fields),const DeepCollectionEquality().hash(_defaults),matchField,organisationLookup);

@override
String toString() {
  return 'ConnectorMapping(entity: $entity, refPath: $refPath, fields: $fields, defaults: $defaults, matchField: $matchField, organisationLookup: $organisationLookup)';
}


}

/// @nodoc
abstract mixin class _$ConnectorMappingCopyWith<$Res> implements $ConnectorMappingCopyWith<$Res> {
  factory _$ConnectorMappingCopyWith(_ConnectorMapping value, $Res Function(_ConnectorMapping) _then) = __$ConnectorMappingCopyWithImpl;
@override @useResult
$Res call({
 String entity, String refPath, List<FieldMapping> fields, Map<String, Object?> defaults, String? matchField, OrganisationLookup? organisationLookup
});


@override $OrganisationLookupCopyWith<$Res>? get organisationLookup;

}
/// @nodoc
class __$ConnectorMappingCopyWithImpl<$Res>
    implements _$ConnectorMappingCopyWith<$Res> {
  __$ConnectorMappingCopyWithImpl(this._self, this._then);

  final _ConnectorMapping _self;
  final $Res Function(_ConnectorMapping) _then;

/// Create a copy of ConnectorMapping
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entity = null,Object? refPath = null,Object? fields = null,Object? defaults = null,Object? matchField = freezed,Object? organisationLookup = freezed,}) {
  return _then(_ConnectorMapping(
entity: null == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String,refPath: null == refPath ? _self.refPath : refPath // ignore: cast_nullable_to_non_nullable
as String,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<FieldMapping>,defaults: null == defaults ? _self._defaults : defaults // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,matchField: freezed == matchField ? _self.matchField : matchField // ignore: cast_nullable_to_non_nullable
as String?,organisationLookup: freezed == organisationLookup ? _self.organisationLookup : organisationLookup // ignore: cast_nullable_to_non_nullable
as OrganisationLookup?,
  ));
}

/// Create a copy of ConnectorMapping
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OrganisationLookupCopyWith<$Res>? get organisationLookup {
    if (_self.organisationLookup == null) {
    return null;
  }

  return $OrganisationLookupCopyWith<$Res>(_self.organisationLookup!, (value) {
    return _then(_self.copyWith(organisationLookup: value));
  });
}
}


/// @nodoc
mixin _$ConnectorRun {

 String get id; String get connectorId;/// `manual`, `schedule` ou `webhook`.
 String get trigger;/// `running`, `succeeded` ou `failed`.
 String get status; DateTime get startedAt; DateTime? get finishedAt; int get fetched; int get created; int get updated; int get unchanged; int get rejected;/// Premiers rejets : « référence : motif ».
 List<String> get problems; String? get error;
/// Create a copy of ConnectorRun
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectorRunCopyWith<ConnectorRun> get copyWith => _$ConnectorRunCopyWithImpl<ConnectorRun>(this as ConnectorRun, _$identity);

  /// Serializes this ConnectorRun to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectorRun&&(identical(other.id, id) || other.id == id)&&(identical(other.connectorId, connectorId) || other.connectorId == connectorId)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.fetched, fetched) || other.fetched == fetched)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.unchanged, unchanged) || other.unchanged == unchanged)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&const DeepCollectionEquality().equals(other.problems, problems)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,connectorId,trigger,status,startedAt,finishedAt,fetched,created,updated,unchanged,rejected,const DeepCollectionEquality().hash(problems),error);

@override
String toString() {
  return 'ConnectorRun(id: $id, connectorId: $connectorId, trigger: $trigger, status: $status, startedAt: $startedAt, finishedAt: $finishedAt, fetched: $fetched, created: $created, updated: $updated, unchanged: $unchanged, rejected: $rejected, problems: $problems, error: $error)';
}


}

/// @nodoc
abstract mixin class $ConnectorRunCopyWith<$Res>  {
  factory $ConnectorRunCopyWith(ConnectorRun value, $Res Function(ConnectorRun) _then) = _$ConnectorRunCopyWithImpl;
@useResult
$Res call({
 String id, String connectorId, String trigger, String status, DateTime startedAt, DateTime? finishedAt, int fetched, int created, int updated, int unchanged, int rejected, List<String> problems, String? error
});




}
/// @nodoc
class _$ConnectorRunCopyWithImpl<$Res>
    implements $ConnectorRunCopyWith<$Res> {
  _$ConnectorRunCopyWithImpl(this._self, this._then);

  final ConnectorRun _self;
  final $Res Function(ConnectorRun) _then;

/// Create a copy of ConnectorRun
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? connectorId = null,Object? trigger = null,Object? status = null,Object? startedAt = null,Object? finishedAt = freezed,Object? fetched = null,Object? created = null,Object? updated = null,Object? unchanged = null,Object? rejected = null,Object? problems = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,connectorId: null == connectorId ? _self.connectorId : connectorId // ignore: cast_nullable_to_non_nullable
as String,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fetched: null == fetched ? _self.fetched : fetched // ignore: cast_nullable_to_non_nullable
as int,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as int,unchanged: null == unchanged ? _self.unchanged : unchanged // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,problems: null == problems ? _self.problems : problems // ignore: cast_nullable_to_non_nullable
as List<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConnectorRun].
extension ConnectorRunPatterns on ConnectorRun {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectorRun value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectorRun() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectorRun value)  $default,){
final _that = this;
switch (_that) {
case _ConnectorRun():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectorRun value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectorRun() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String connectorId,  String trigger,  String status,  DateTime startedAt,  DateTime? finishedAt,  int fetched,  int created,  int updated,  int unchanged,  int rejected,  List<String> problems,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectorRun() when $default != null:
return $default(_that.id,_that.connectorId,_that.trigger,_that.status,_that.startedAt,_that.finishedAt,_that.fetched,_that.created,_that.updated,_that.unchanged,_that.rejected,_that.problems,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String connectorId,  String trigger,  String status,  DateTime startedAt,  DateTime? finishedAt,  int fetched,  int created,  int updated,  int unchanged,  int rejected,  List<String> problems,  String? error)  $default,) {final _that = this;
switch (_that) {
case _ConnectorRun():
return $default(_that.id,_that.connectorId,_that.trigger,_that.status,_that.startedAt,_that.finishedAt,_that.fetched,_that.created,_that.updated,_that.unchanged,_that.rejected,_that.problems,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String connectorId,  String trigger,  String status,  DateTime startedAt,  DateTime? finishedAt,  int fetched,  int created,  int updated,  int unchanged,  int rejected,  List<String> problems,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _ConnectorRun() when $default != null:
return $default(_that.id,_that.connectorId,_that.trigger,_that.status,_that.startedAt,_that.finishedAt,_that.fetched,_that.created,_that.updated,_that.unchanged,_that.rejected,_that.problems,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConnectorRun implements ConnectorRun {
  const _ConnectorRun({required this.id, required this.connectorId, required this.trigger, required this.status, required this.startedAt, this.finishedAt, this.fetched = 0, this.created = 0, this.updated = 0, this.unchanged = 0, this.rejected = 0, final  List<String> problems = const [], this.error}): _problems = problems;
  factory _ConnectorRun.fromJson(Map<String, dynamic> json) => _$ConnectorRunFromJson(json);

@override final  String id;
@override final  String connectorId;
/// `manual`, `schedule` ou `webhook`.
@override final  String trigger;
/// `running`, `succeeded` ou `failed`.
@override final  String status;
@override final  DateTime startedAt;
@override final  DateTime? finishedAt;
@override@JsonKey() final  int fetched;
@override@JsonKey() final  int created;
@override@JsonKey() final  int updated;
@override@JsonKey() final  int unchanged;
@override@JsonKey() final  int rejected;
/// Premiers rejets : « référence : motif ».
 final  List<String> _problems;
/// Premiers rejets : « référence : motif ».
@override@JsonKey() List<String> get problems {
  if (_problems is EqualUnmodifiableListView) return _problems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_problems);
}

@override final  String? error;

/// Create a copy of ConnectorRun
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectorRunCopyWith<_ConnectorRun> get copyWith => __$ConnectorRunCopyWithImpl<_ConnectorRun>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConnectorRunToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectorRun&&(identical(other.id, id) || other.id == id)&&(identical(other.connectorId, connectorId) || other.connectorId == connectorId)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.status, status) || other.status == status)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.fetched, fetched) || other.fetched == fetched)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.unchanged, unchanged) || other.unchanged == unchanged)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&const DeepCollectionEquality().equals(other._problems, _problems)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,connectorId,trigger,status,startedAt,finishedAt,fetched,created,updated,unchanged,rejected,const DeepCollectionEquality().hash(_problems),error);

@override
String toString() {
  return 'ConnectorRun(id: $id, connectorId: $connectorId, trigger: $trigger, status: $status, startedAt: $startedAt, finishedAt: $finishedAt, fetched: $fetched, created: $created, updated: $updated, unchanged: $unchanged, rejected: $rejected, problems: $problems, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ConnectorRunCopyWith<$Res> implements $ConnectorRunCopyWith<$Res> {
  factory _$ConnectorRunCopyWith(_ConnectorRun value, $Res Function(_ConnectorRun) _then) = __$ConnectorRunCopyWithImpl;
@override @useResult
$Res call({
 String id, String connectorId, String trigger, String status, DateTime startedAt, DateTime? finishedAt, int fetched, int created, int updated, int unchanged, int rejected, List<String> problems, String? error
});




}
/// @nodoc
class __$ConnectorRunCopyWithImpl<$Res>
    implements _$ConnectorRunCopyWith<$Res> {
  __$ConnectorRunCopyWithImpl(this._self, this._then);

  final _ConnectorRun _self;
  final $Res Function(_ConnectorRun) _then;

/// Create a copy of ConnectorRun
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? connectorId = null,Object? trigger = null,Object? status = null,Object? startedAt = null,Object? finishedAt = freezed,Object? fetched = null,Object? created = null,Object? updated = null,Object? unchanged = null,Object? rejected = null,Object? problems = null,Object? error = freezed,}) {
  return _then(_ConnectorRun(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,connectorId: null == connectorId ? _self.connectorId : connectorId // ignore: cast_nullable_to_non_nullable
as String,trigger: null == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fetched: null == fetched ? _self.fetched : fetched // ignore: cast_nullable_to_non_nullable
as int,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as int,unchanged: null == unchanged ? _self.unchanged : unchanged // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,problems: null == problems ? _self._problems : problems // ignore: cast_nullable_to_non_nullable
as List<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ConnectorInfo {

 String get id; String get name; String get kind; Map<String, Object?> get config; ConnectorMapping get mapping; bool get enabled;/// Import planifié toutes les N minutes (`null` : manuel).
 int? get scheduleMinutes; bool get hasSecret;/// Un jeton de webhook entrant a été généré.
 bool get hasWebhookToken; ConnectorRun? get lastRun;
/// Create a copy of ConnectorInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectorInfoCopyWith<ConnectorInfo> get copyWith => _$ConnectorInfoCopyWithImpl<ConnectorInfo>(this as ConnectorInfo, _$identity);

  /// Serializes this ConnectorInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectorInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other.config, config)&&(identical(other.mapping, mapping) || other.mapping == mapping)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.scheduleMinutes, scheduleMinutes) || other.scheduleMinutes == scheduleMinutes)&&(identical(other.hasSecret, hasSecret) || other.hasSecret == hasSecret)&&(identical(other.hasWebhookToken, hasWebhookToken) || other.hasWebhookToken == hasWebhookToken)&&(identical(other.lastRun, lastRun) || other.lastRun == lastRun));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kind,const DeepCollectionEquality().hash(config),mapping,enabled,scheduleMinutes,hasSecret,hasWebhookToken,lastRun);

@override
String toString() {
  return 'ConnectorInfo(id: $id, name: $name, kind: $kind, config: $config, mapping: $mapping, enabled: $enabled, scheduleMinutes: $scheduleMinutes, hasSecret: $hasSecret, hasWebhookToken: $hasWebhookToken, lastRun: $lastRun)';
}


}

/// @nodoc
abstract mixin class $ConnectorInfoCopyWith<$Res>  {
  factory $ConnectorInfoCopyWith(ConnectorInfo value, $Res Function(ConnectorInfo) _then) = _$ConnectorInfoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String kind, Map<String, Object?> config, ConnectorMapping mapping, bool enabled, int? scheduleMinutes, bool hasSecret, bool hasWebhookToken, ConnectorRun? lastRun
});


$ConnectorMappingCopyWith<$Res> get mapping;$ConnectorRunCopyWith<$Res>? get lastRun;

}
/// @nodoc
class _$ConnectorInfoCopyWithImpl<$Res>
    implements $ConnectorInfoCopyWith<$Res> {
  _$ConnectorInfoCopyWithImpl(this._self, this._then);

  final ConnectorInfo _self;
  final $Res Function(ConnectorInfo) _then;

/// Create a copy of ConnectorInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? config = null,Object? mapping = null,Object? enabled = null,Object? scheduleMinutes = freezed,Object? hasSecret = null,Object? hasWebhookToken = null,Object? lastRun = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,mapping: null == mapping ? _self.mapping : mapping // ignore: cast_nullable_to_non_nullable
as ConnectorMapping,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,scheduleMinutes: freezed == scheduleMinutes ? _self.scheduleMinutes : scheduleMinutes // ignore: cast_nullable_to_non_nullable
as int?,hasSecret: null == hasSecret ? _self.hasSecret : hasSecret // ignore: cast_nullable_to_non_nullable
as bool,hasWebhookToken: null == hasWebhookToken ? _self.hasWebhookToken : hasWebhookToken // ignore: cast_nullable_to_non_nullable
as bool,lastRun: freezed == lastRun ? _self.lastRun : lastRun // ignore: cast_nullable_to_non_nullable
as ConnectorRun?,
  ));
}
/// Create a copy of ConnectorInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectorMappingCopyWith<$Res> get mapping {
  
  return $ConnectorMappingCopyWith<$Res>(_self.mapping, (value) {
    return _then(_self.copyWith(mapping: value));
  });
}/// Create a copy of ConnectorInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectorRunCopyWith<$Res>? get lastRun {
    if (_self.lastRun == null) {
    return null;
  }

  return $ConnectorRunCopyWith<$Res>(_self.lastRun!, (value) {
    return _then(_self.copyWith(lastRun: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConnectorInfo].
extension ConnectorInfoPatterns on ConnectorInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectorInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectorInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectorInfo value)  $default,){
final _that = this;
switch (_that) {
case _ConnectorInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectorInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectorInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String kind,  Map<String, Object?> config,  ConnectorMapping mapping,  bool enabled,  int? scheduleMinutes,  bool hasSecret,  bool hasWebhookToken,  ConnectorRun? lastRun)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectorInfo() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.config,_that.mapping,_that.enabled,_that.scheduleMinutes,_that.hasSecret,_that.hasWebhookToken,_that.lastRun);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String kind,  Map<String, Object?> config,  ConnectorMapping mapping,  bool enabled,  int? scheduleMinutes,  bool hasSecret,  bool hasWebhookToken,  ConnectorRun? lastRun)  $default,) {final _that = this;
switch (_that) {
case _ConnectorInfo():
return $default(_that.id,_that.name,_that.kind,_that.config,_that.mapping,_that.enabled,_that.scheduleMinutes,_that.hasSecret,_that.hasWebhookToken,_that.lastRun);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String kind,  Map<String, Object?> config,  ConnectorMapping mapping,  bool enabled,  int? scheduleMinutes,  bool hasSecret,  bool hasWebhookToken,  ConnectorRun? lastRun)?  $default,) {final _that = this;
switch (_that) {
case _ConnectorInfo() when $default != null:
return $default(_that.id,_that.name,_that.kind,_that.config,_that.mapping,_that.enabled,_that.scheduleMinutes,_that.hasSecret,_that.hasWebhookToken,_that.lastRun);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConnectorInfo implements ConnectorInfo {
  const _ConnectorInfo({required this.id, required this.name, required this.kind, final  Map<String, Object?> config = const {}, this.mapping = const ConnectorMapping(), this.enabled = true, this.scheduleMinutes, this.hasSecret = false, this.hasWebhookToken = false, this.lastRun}): _config = config;
  factory _ConnectorInfo.fromJson(Map<String, dynamic> json) => _$ConnectorInfoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String kind;
 final  Map<String, Object?> _config;
@override@JsonKey() Map<String, Object?> get config {
  if (_config is EqualUnmodifiableMapView) return _config;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_config);
}

@override@JsonKey() final  ConnectorMapping mapping;
@override@JsonKey() final  bool enabled;
/// Import planifié toutes les N minutes (`null` : manuel).
@override final  int? scheduleMinutes;
@override@JsonKey() final  bool hasSecret;
/// Un jeton de webhook entrant a été généré.
@override@JsonKey() final  bool hasWebhookToken;
@override final  ConnectorRun? lastRun;

/// Create a copy of ConnectorInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectorInfoCopyWith<_ConnectorInfo> get copyWith => __$ConnectorInfoCopyWithImpl<_ConnectorInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConnectorInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectorInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other._config, _config)&&(identical(other.mapping, mapping) || other.mapping == mapping)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.scheduleMinutes, scheduleMinutes) || other.scheduleMinutes == scheduleMinutes)&&(identical(other.hasSecret, hasSecret) || other.hasSecret == hasSecret)&&(identical(other.hasWebhookToken, hasWebhookToken) || other.hasWebhookToken == hasWebhookToken)&&(identical(other.lastRun, lastRun) || other.lastRun == lastRun));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,kind,const DeepCollectionEquality().hash(_config),mapping,enabled,scheduleMinutes,hasSecret,hasWebhookToken,lastRun);

@override
String toString() {
  return 'ConnectorInfo(id: $id, name: $name, kind: $kind, config: $config, mapping: $mapping, enabled: $enabled, scheduleMinutes: $scheduleMinutes, hasSecret: $hasSecret, hasWebhookToken: $hasWebhookToken, lastRun: $lastRun)';
}


}

/// @nodoc
abstract mixin class _$ConnectorInfoCopyWith<$Res> implements $ConnectorInfoCopyWith<$Res> {
  factory _$ConnectorInfoCopyWith(_ConnectorInfo value, $Res Function(_ConnectorInfo) _then) = __$ConnectorInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String kind, Map<String, Object?> config, ConnectorMapping mapping, bool enabled, int? scheduleMinutes, bool hasSecret, bool hasWebhookToken, ConnectorRun? lastRun
});


@override $ConnectorMappingCopyWith<$Res> get mapping;@override $ConnectorRunCopyWith<$Res>? get lastRun;

}
/// @nodoc
class __$ConnectorInfoCopyWithImpl<$Res>
    implements _$ConnectorInfoCopyWith<$Res> {
  __$ConnectorInfoCopyWithImpl(this._self, this._then);

  final _ConnectorInfo _self;
  final $Res Function(_ConnectorInfo) _then;

/// Create a copy of ConnectorInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? kind = null,Object? config = null,Object? mapping = null,Object? enabled = null,Object? scheduleMinutes = freezed,Object? hasSecret = null,Object? hasWebhookToken = null,Object? lastRun = freezed,}) {
  return _then(_ConnectorInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,config: null == config ? _self._config : config // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,mapping: null == mapping ? _self.mapping : mapping // ignore: cast_nullable_to_non_nullable
as ConnectorMapping,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,scheduleMinutes: freezed == scheduleMinutes ? _self.scheduleMinutes : scheduleMinutes // ignore: cast_nullable_to_non_nullable
as int?,hasSecret: null == hasSecret ? _self.hasSecret : hasSecret // ignore: cast_nullable_to_non_nullable
as bool,hasWebhookToken: null == hasWebhookToken ? _self.hasWebhookToken : hasWebhookToken // ignore: cast_nullable_to_non_nullable
as bool,lastRun: freezed == lastRun ? _self.lastRun : lastRun // ignore: cast_nullable_to_non_nullable
as ConnectorRun?,
  ));
}

/// Create a copy of ConnectorInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectorMappingCopyWith<$Res> get mapping {
  
  return $ConnectorMappingCopyWith<$Res>(_self.mapping, (value) {
    return _then(_self.copyWith(mapping: value));
  });
}/// Create a copy of ConnectorInfo
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectorRunCopyWith<$Res>? get lastRun {
    if (_self.lastRun == null) {
    return null;
  }

  return $ConnectorRunCopyWith<$Res>(_self.lastRun!, (value) {
    return _then(_self.copyWith(lastRun: value));
  });
}
}


/// @nodoc
mixin _$ConnectorInput {

 String get name; String get kind; Map<String, Object?> get config; ConnectorMapping get mapping; bool get enabled; int? get scheduleMinutes;/// Écriture seule : clé d'API, mot de passe ou chaîne de connexion
/// (`null` : inchangé, vide : supprimé).
 String? get secret;
/// Create a copy of ConnectorInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectorInputCopyWith<ConnectorInput> get copyWith => _$ConnectorInputCopyWithImpl<ConnectorInput>(this as ConnectorInput, _$identity);

  /// Serializes this ConnectorInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectorInput&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other.config, config)&&(identical(other.mapping, mapping) || other.mapping == mapping)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.scheduleMinutes, scheduleMinutes) || other.scheduleMinutes == scheduleMinutes)&&(identical(other.secret, secret) || other.secret == secret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,kind,const DeepCollectionEquality().hash(config),mapping,enabled,scheduleMinutes,secret);

@override
String toString() {
  return 'ConnectorInput(name: $name, kind: $kind, config: $config, mapping: $mapping, enabled: $enabled, scheduleMinutes: $scheduleMinutes, secret: $secret)';
}


}

/// @nodoc
abstract mixin class $ConnectorInputCopyWith<$Res>  {
  factory $ConnectorInputCopyWith(ConnectorInput value, $Res Function(ConnectorInput) _then) = _$ConnectorInputCopyWithImpl;
@useResult
$Res call({
 String name, String kind, Map<String, Object?> config, ConnectorMapping mapping, bool enabled, int? scheduleMinutes, String? secret
});


$ConnectorMappingCopyWith<$Res> get mapping;

}
/// @nodoc
class _$ConnectorInputCopyWithImpl<$Res>
    implements $ConnectorInputCopyWith<$Res> {
  _$ConnectorInputCopyWithImpl(this._self, this._then);

  final ConnectorInput _self;
  final $Res Function(ConnectorInput) _then;

/// Create a copy of ConnectorInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? kind = null,Object? config = null,Object? mapping = null,Object? enabled = null,Object? scheduleMinutes = freezed,Object? secret = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,config: null == config ? _self.config : config // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,mapping: null == mapping ? _self.mapping : mapping // ignore: cast_nullable_to_non_nullable
as ConnectorMapping,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,scheduleMinutes: freezed == scheduleMinutes ? _self.scheduleMinutes : scheduleMinutes // ignore: cast_nullable_to_non_nullable
as int?,secret: freezed == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ConnectorInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectorMappingCopyWith<$Res> get mapping {
  
  return $ConnectorMappingCopyWith<$Res>(_self.mapping, (value) {
    return _then(_self.copyWith(mapping: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConnectorInput].
extension ConnectorInputPatterns on ConnectorInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectorInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectorInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectorInput value)  $default,){
final _that = this;
switch (_that) {
case _ConnectorInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectorInput value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectorInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String kind,  Map<String, Object?> config,  ConnectorMapping mapping,  bool enabled,  int? scheduleMinutes,  String? secret)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectorInput() when $default != null:
return $default(_that.name,_that.kind,_that.config,_that.mapping,_that.enabled,_that.scheduleMinutes,_that.secret);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String kind,  Map<String, Object?> config,  ConnectorMapping mapping,  bool enabled,  int? scheduleMinutes,  String? secret)  $default,) {final _that = this;
switch (_that) {
case _ConnectorInput():
return $default(_that.name,_that.kind,_that.config,_that.mapping,_that.enabled,_that.scheduleMinutes,_that.secret);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String kind,  Map<String, Object?> config,  ConnectorMapping mapping,  bool enabled,  int? scheduleMinutes,  String? secret)?  $default,) {final _that = this;
switch (_that) {
case _ConnectorInput() when $default != null:
return $default(_that.name,_that.kind,_that.config,_that.mapping,_that.enabled,_that.scheduleMinutes,_that.secret);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConnectorInput implements ConnectorInput {
  const _ConnectorInput({required this.name, required this.kind, final  Map<String, Object?> config = const {}, this.mapping = const ConnectorMapping(), this.enabled = true, this.scheduleMinutes, this.secret}): _config = config;
  factory _ConnectorInput.fromJson(Map<String, dynamic> json) => _$ConnectorInputFromJson(json);

@override final  String name;
@override final  String kind;
 final  Map<String, Object?> _config;
@override@JsonKey() Map<String, Object?> get config {
  if (_config is EqualUnmodifiableMapView) return _config;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_config);
}

@override@JsonKey() final  ConnectorMapping mapping;
@override@JsonKey() final  bool enabled;
@override final  int? scheduleMinutes;
/// Écriture seule : clé d'API, mot de passe ou chaîne de connexion
/// (`null` : inchangé, vide : supprimé).
@override final  String? secret;

/// Create a copy of ConnectorInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectorInputCopyWith<_ConnectorInput> get copyWith => __$ConnectorInputCopyWithImpl<_ConnectorInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConnectorInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectorInput&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other._config, _config)&&(identical(other.mapping, mapping) || other.mapping == mapping)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.scheduleMinutes, scheduleMinutes) || other.scheduleMinutes == scheduleMinutes)&&(identical(other.secret, secret) || other.secret == secret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,kind,const DeepCollectionEquality().hash(_config),mapping,enabled,scheduleMinutes,secret);

@override
String toString() {
  return 'ConnectorInput(name: $name, kind: $kind, config: $config, mapping: $mapping, enabled: $enabled, scheduleMinutes: $scheduleMinutes, secret: $secret)';
}


}

/// @nodoc
abstract mixin class _$ConnectorInputCopyWith<$Res> implements $ConnectorInputCopyWith<$Res> {
  factory _$ConnectorInputCopyWith(_ConnectorInput value, $Res Function(_ConnectorInput) _then) = __$ConnectorInputCopyWithImpl;
@override @useResult
$Res call({
 String name, String kind, Map<String, Object?> config, ConnectorMapping mapping, bool enabled, int? scheduleMinutes, String? secret
});


@override $ConnectorMappingCopyWith<$Res> get mapping;

}
/// @nodoc
class __$ConnectorInputCopyWithImpl<$Res>
    implements _$ConnectorInputCopyWith<$Res> {
  __$ConnectorInputCopyWithImpl(this._self, this._then);

  final _ConnectorInput _self;
  final $Res Function(_ConnectorInput) _then;

/// Create a copy of ConnectorInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? kind = null,Object? config = null,Object? mapping = null,Object? enabled = null,Object? scheduleMinutes = freezed,Object? secret = freezed,}) {
  return _then(_ConnectorInput(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,config: null == config ? _self._config : config // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,mapping: null == mapping ? _self.mapping : mapping // ignore: cast_nullable_to_non_nullable
as ConnectorMapping,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,scheduleMinutes: freezed == scheduleMinutes ? _self.scheduleMinutes : scheduleMinutes // ignore: cast_nullable_to_non_nullable
as int?,secret: freezed == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ConnectorInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectorMappingCopyWith<$Res> get mapping {
  
  return $ConnectorMappingCopyWith<$Res>(_self.mapping, (value) {
    return _then(_self.copyWith(mapping: value));
  });
}
}


/// @nodoc
mixin _$MappedRecord {

 String? get ref; Map<String, Object?> get fields; List<String> get problems;
/// Create a copy of MappedRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MappedRecordCopyWith<MappedRecord> get copyWith => _$MappedRecordCopyWithImpl<MappedRecord>(this as MappedRecord, _$identity);

  /// Serializes this MappedRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MappedRecord&&(identical(other.ref, ref) || other.ref == ref)&&const DeepCollectionEquality().equals(other.fields, fields)&&const DeepCollectionEquality().equals(other.problems, problems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ref,const DeepCollectionEquality().hash(fields),const DeepCollectionEquality().hash(problems));

@override
String toString() {
  return 'MappedRecord(ref: $ref, fields: $fields, problems: $problems)';
}


}

/// @nodoc
abstract mixin class $MappedRecordCopyWith<$Res>  {
  factory $MappedRecordCopyWith(MappedRecord value, $Res Function(MappedRecord) _then) = _$MappedRecordCopyWithImpl;
@useResult
$Res call({
 String? ref, Map<String, Object?> fields, List<String> problems
});




}
/// @nodoc
class _$MappedRecordCopyWithImpl<$Res>
    implements $MappedRecordCopyWith<$Res> {
  _$MappedRecordCopyWithImpl(this._self, this._then);

  final MappedRecord _self;
  final $Res Function(MappedRecord) _then;

/// Create a copy of MappedRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ref = freezed,Object? fields = null,Object? problems = null,}) {
  return _then(_self.copyWith(
ref: freezed == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as String?,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,problems: null == problems ? _self.problems : problems // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [MappedRecord].
extension MappedRecordPatterns on MappedRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MappedRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MappedRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MappedRecord value)  $default,){
final _that = this;
switch (_that) {
case _MappedRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MappedRecord value)?  $default,){
final _that = this;
switch (_that) {
case _MappedRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? ref,  Map<String, Object?> fields,  List<String> problems)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MappedRecord() when $default != null:
return $default(_that.ref,_that.fields,_that.problems);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? ref,  Map<String, Object?> fields,  List<String> problems)  $default,) {final _that = this;
switch (_that) {
case _MappedRecord():
return $default(_that.ref,_that.fields,_that.problems);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? ref,  Map<String, Object?> fields,  List<String> problems)?  $default,) {final _that = this;
switch (_that) {
case _MappedRecord() when $default != null:
return $default(_that.ref,_that.fields,_that.problems);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MappedRecord implements MappedRecord {
  const _MappedRecord({this.ref, final  Map<String, Object?> fields = const {}, final  List<String> problems = const []}): _fields = fields,_problems = problems;
  factory _MappedRecord.fromJson(Map<String, dynamic> json) => _$MappedRecordFromJson(json);

@override final  String? ref;
 final  Map<String, Object?> _fields;
@override@JsonKey() Map<String, Object?> get fields {
  if (_fields is EqualUnmodifiableMapView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_fields);
}

 final  List<String> _problems;
@override@JsonKey() List<String> get problems {
  if (_problems is EqualUnmodifiableListView) return _problems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_problems);
}


/// Create a copy of MappedRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MappedRecordCopyWith<_MappedRecord> get copyWith => __$MappedRecordCopyWithImpl<_MappedRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MappedRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MappedRecord&&(identical(other.ref, ref) || other.ref == ref)&&const DeepCollectionEquality().equals(other._fields, _fields)&&const DeepCollectionEquality().equals(other._problems, _problems));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ref,const DeepCollectionEquality().hash(_fields),const DeepCollectionEquality().hash(_problems));

@override
String toString() {
  return 'MappedRecord(ref: $ref, fields: $fields, problems: $problems)';
}


}

/// @nodoc
abstract mixin class _$MappedRecordCopyWith<$Res> implements $MappedRecordCopyWith<$Res> {
  factory _$MappedRecordCopyWith(_MappedRecord value, $Res Function(_MappedRecord) _then) = __$MappedRecordCopyWithImpl;
@override @useResult
$Res call({
 String? ref, Map<String, Object?> fields, List<String> problems
});




}
/// @nodoc
class __$MappedRecordCopyWithImpl<$Res>
    implements _$MappedRecordCopyWith<$Res> {
  __$MappedRecordCopyWithImpl(this._self, this._then);

  final _MappedRecord _self;
  final $Res Function(_MappedRecord) _then;

/// Create a copy of MappedRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ref = freezed,Object? fields = null,Object? problems = null,}) {
  return _then(_MappedRecord(
ref: freezed == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as String?,fields: null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,problems: null == problems ? _self._problems : problems // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ConnectorPreview {

/// Chemins disponibles (aplatis) dans les enregistrements lus.
 List<String> get paths; List<Map<String, Object?>> get raw; List<MappedRecord> get mapped;
/// Create a copy of ConnectorPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectorPreviewCopyWith<ConnectorPreview> get copyWith => _$ConnectorPreviewCopyWithImpl<ConnectorPreview>(this as ConnectorPreview, _$identity);

  /// Serializes this ConnectorPreview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectorPreview&&const DeepCollectionEquality().equals(other.paths, paths)&&const DeepCollectionEquality().equals(other.raw, raw)&&const DeepCollectionEquality().equals(other.mapped, mapped));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(paths),const DeepCollectionEquality().hash(raw),const DeepCollectionEquality().hash(mapped));

@override
String toString() {
  return 'ConnectorPreview(paths: $paths, raw: $raw, mapped: $mapped)';
}


}

/// @nodoc
abstract mixin class $ConnectorPreviewCopyWith<$Res>  {
  factory $ConnectorPreviewCopyWith(ConnectorPreview value, $Res Function(ConnectorPreview) _then) = _$ConnectorPreviewCopyWithImpl;
@useResult
$Res call({
 List<String> paths, List<Map<String, Object?>> raw, List<MappedRecord> mapped
});




}
/// @nodoc
class _$ConnectorPreviewCopyWithImpl<$Res>
    implements $ConnectorPreviewCopyWith<$Res> {
  _$ConnectorPreviewCopyWithImpl(this._self, this._then);

  final ConnectorPreview _self;
  final $Res Function(ConnectorPreview) _then;

/// Create a copy of ConnectorPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paths = null,Object? raw = null,Object? mapped = null,}) {
  return _then(_self.copyWith(
paths: null == paths ? _self.paths : paths // ignore: cast_nullable_to_non_nullable
as List<String>,raw: null == raw ? _self.raw : raw // ignore: cast_nullable_to_non_nullable
as List<Map<String, Object?>>,mapped: null == mapped ? _self.mapped : mapped // ignore: cast_nullable_to_non_nullable
as List<MappedRecord>,
  ));
}

}


/// Adds pattern-matching-related methods to [ConnectorPreview].
extension ConnectorPreviewPatterns on ConnectorPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectorPreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectorPreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectorPreview value)  $default,){
final _that = this;
switch (_that) {
case _ConnectorPreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectorPreview value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectorPreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> paths,  List<Map<String, Object?>> raw,  List<MappedRecord> mapped)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectorPreview() when $default != null:
return $default(_that.paths,_that.raw,_that.mapped);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> paths,  List<Map<String, Object?>> raw,  List<MappedRecord> mapped)  $default,) {final _that = this;
switch (_that) {
case _ConnectorPreview():
return $default(_that.paths,_that.raw,_that.mapped);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> paths,  List<Map<String, Object?>> raw,  List<MappedRecord> mapped)?  $default,) {final _that = this;
switch (_that) {
case _ConnectorPreview() when $default != null:
return $default(_that.paths,_that.raw,_that.mapped);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConnectorPreview implements ConnectorPreview {
  const _ConnectorPreview({final  List<String> paths = const [], final  List<Map<String, Object?>> raw = const [], final  List<MappedRecord> mapped = const []}): _paths = paths,_raw = raw,_mapped = mapped;
  factory _ConnectorPreview.fromJson(Map<String, dynamic> json) => _$ConnectorPreviewFromJson(json);

/// Chemins disponibles (aplatis) dans les enregistrements lus.
 final  List<String> _paths;
/// Chemins disponibles (aplatis) dans les enregistrements lus.
@override@JsonKey() List<String> get paths {
  if (_paths is EqualUnmodifiableListView) return _paths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paths);
}

 final  List<Map<String, Object?>> _raw;
@override@JsonKey() List<Map<String, Object?>> get raw {
  if (_raw is EqualUnmodifiableListView) return _raw;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_raw);
}

 final  List<MappedRecord> _mapped;
@override@JsonKey() List<MappedRecord> get mapped {
  if (_mapped is EqualUnmodifiableListView) return _mapped;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mapped);
}


/// Create a copy of ConnectorPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectorPreviewCopyWith<_ConnectorPreview> get copyWith => __$ConnectorPreviewCopyWithImpl<_ConnectorPreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConnectorPreviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectorPreview&&const DeepCollectionEquality().equals(other._paths, _paths)&&const DeepCollectionEquality().equals(other._raw, _raw)&&const DeepCollectionEquality().equals(other._mapped, _mapped));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_paths),const DeepCollectionEquality().hash(_raw),const DeepCollectionEquality().hash(_mapped));

@override
String toString() {
  return 'ConnectorPreview(paths: $paths, raw: $raw, mapped: $mapped)';
}


}

/// @nodoc
abstract mixin class _$ConnectorPreviewCopyWith<$Res> implements $ConnectorPreviewCopyWith<$Res> {
  factory _$ConnectorPreviewCopyWith(_ConnectorPreview value, $Res Function(_ConnectorPreview) _then) = __$ConnectorPreviewCopyWithImpl;
@override @useResult
$Res call({
 List<String> paths, List<Map<String, Object?>> raw, List<MappedRecord> mapped
});




}
/// @nodoc
class __$ConnectorPreviewCopyWithImpl<$Res>
    implements _$ConnectorPreviewCopyWith<$Res> {
  __$ConnectorPreviewCopyWithImpl(this._self, this._then);

  final _ConnectorPreview _self;
  final $Res Function(_ConnectorPreview) _then;

/// Create a copy of ConnectorPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paths = null,Object? raw = null,Object? mapped = null,}) {
  return _then(_ConnectorPreview(
paths: null == paths ? _self._paths : paths // ignore: cast_nullable_to_non_nullable
as List<String>,raw: null == raw ? _self._raw : raw // ignore: cast_nullable_to_non_nullable
as List<Map<String, Object?>>,mapped: null == mapped ? _self._mapped : mapped // ignore: cast_nullable_to_non_nullable
as List<MappedRecord>,
  ));
}


}


/// @nodoc
mixin _$WebhookToken {

 String get url; String get token;
/// Create a copy of WebhookToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebhookTokenCopyWith<WebhookToken> get copyWith => _$WebhookTokenCopyWithImpl<WebhookToken>(this as WebhookToken, _$identity);

  /// Serializes this WebhookToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebhookToken&&(identical(other.url, url) || other.url == url)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,token);

@override
String toString() {
  return 'WebhookToken(url: $url, token: $token)';
}


}

/// @nodoc
abstract mixin class $WebhookTokenCopyWith<$Res>  {
  factory $WebhookTokenCopyWith(WebhookToken value, $Res Function(WebhookToken) _then) = _$WebhookTokenCopyWithImpl;
@useResult
$Res call({
 String url, String token
});




}
/// @nodoc
class _$WebhookTokenCopyWithImpl<$Res>
    implements $WebhookTokenCopyWith<$Res> {
  _$WebhookTokenCopyWithImpl(this._self, this._then);

  final WebhookToken _self;
  final $Res Function(WebhookToken) _then;

/// Create a copy of WebhookToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? token = null,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WebhookToken].
extension WebhookTokenPatterns on WebhookToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WebhookToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WebhookToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WebhookToken value)  $default,){
final _that = this;
switch (_that) {
case _WebhookToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WebhookToken value)?  $default,){
final _that = this;
switch (_that) {
case _WebhookToken() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  String token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WebhookToken() when $default != null:
return $default(_that.url,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  String token)  $default,) {final _that = this;
switch (_that) {
case _WebhookToken():
return $default(_that.url,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  String token)?  $default,) {final _that = this;
switch (_that) {
case _WebhookToken() when $default != null:
return $default(_that.url,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WebhookToken implements WebhookToken {
  const _WebhookToken({required this.url, required this.token});
  factory _WebhookToken.fromJson(Map<String, dynamic> json) => _$WebhookTokenFromJson(json);

@override final  String url;
@override final  String token;

/// Create a copy of WebhookToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebhookTokenCopyWith<_WebhookToken> get copyWith => __$WebhookTokenCopyWithImpl<_WebhookToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebhookTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebhookToken&&(identical(other.url, url) || other.url == url)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,token);

@override
String toString() {
  return 'WebhookToken(url: $url, token: $token)';
}


}

/// @nodoc
abstract mixin class _$WebhookTokenCopyWith<$Res> implements $WebhookTokenCopyWith<$Res> {
  factory _$WebhookTokenCopyWith(_WebhookToken value, $Res Function(_WebhookToken) _then) = __$WebhookTokenCopyWithImpl;
@override @useResult
$Res call({
 String url, String token
});




}
/// @nodoc
class __$WebhookTokenCopyWithImpl<$Res>
    implements _$WebhookTokenCopyWith<$Res> {
  __$WebhookTokenCopyWithImpl(this._self, this._then);

  final _WebhookToken _self;
  final $Res Function(_WebhookToken) _then;

/// Create a copy of WebhookToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? token = null,}) {
  return _then(_WebhookToken(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WebhookInfo {

 String get id; String get name; String get url; List<String> get entities; bool get enabled; bool get hasSecret;/// Dernière séquence livrée.
 int get lastSeq; DateTime? get lastDeliveryAt; int? get lastStatus; String? get lastError; int get failures;
/// Create a copy of WebhookInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebhookInfoCopyWith<WebhookInfo> get copyWith => _$WebhookInfoCopyWithImpl<WebhookInfo>(this as WebhookInfo, _$identity);

  /// Serializes this WebhookInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebhookInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.entities, entities)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.hasSecret, hasSecret) || other.hasSecret == hasSecret)&&(identical(other.lastSeq, lastSeq) || other.lastSeq == lastSeq)&&(identical(other.lastDeliveryAt, lastDeliveryAt) || other.lastDeliveryAt == lastDeliveryAt)&&(identical(other.lastStatus, lastStatus) || other.lastStatus == lastStatus)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.failures, failures) || other.failures == failures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,const DeepCollectionEquality().hash(entities),enabled,hasSecret,lastSeq,lastDeliveryAt,lastStatus,lastError,failures);

@override
String toString() {
  return 'WebhookInfo(id: $id, name: $name, url: $url, entities: $entities, enabled: $enabled, hasSecret: $hasSecret, lastSeq: $lastSeq, lastDeliveryAt: $lastDeliveryAt, lastStatus: $lastStatus, lastError: $lastError, failures: $failures)';
}


}

/// @nodoc
abstract mixin class $WebhookInfoCopyWith<$Res>  {
  factory $WebhookInfoCopyWith(WebhookInfo value, $Res Function(WebhookInfo) _then) = _$WebhookInfoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String url, List<String> entities, bool enabled, bool hasSecret, int lastSeq, DateTime? lastDeliveryAt, int? lastStatus, String? lastError, int failures
});




}
/// @nodoc
class _$WebhookInfoCopyWithImpl<$Res>
    implements $WebhookInfoCopyWith<$Res> {
  _$WebhookInfoCopyWithImpl(this._self, this._then);

  final WebhookInfo _self;
  final $Res Function(WebhookInfo) _then;

/// Create a copy of WebhookInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? url = null,Object? entities = null,Object? enabled = null,Object? hasSecret = null,Object? lastSeq = null,Object? lastDeliveryAt = freezed,Object? lastStatus = freezed,Object? lastError = freezed,Object? failures = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,entities: null == entities ? _self.entities : entities // ignore: cast_nullable_to_non_nullable
as List<String>,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,hasSecret: null == hasSecret ? _self.hasSecret : hasSecret // ignore: cast_nullable_to_non_nullable
as bool,lastSeq: null == lastSeq ? _self.lastSeq : lastSeq // ignore: cast_nullable_to_non_nullable
as int,lastDeliveryAt: freezed == lastDeliveryAt ? _self.lastDeliveryAt : lastDeliveryAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastStatus: freezed == lastStatus ? _self.lastStatus : lastStatus // ignore: cast_nullable_to_non_nullable
as int?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,failures: null == failures ? _self.failures : failures // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WebhookInfo].
extension WebhookInfoPatterns on WebhookInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WebhookInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WebhookInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WebhookInfo value)  $default,){
final _that = this;
switch (_that) {
case _WebhookInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WebhookInfo value)?  $default,){
final _that = this;
switch (_that) {
case _WebhookInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String url,  List<String> entities,  bool enabled,  bool hasSecret,  int lastSeq,  DateTime? lastDeliveryAt,  int? lastStatus,  String? lastError,  int failures)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WebhookInfo() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.entities,_that.enabled,_that.hasSecret,_that.lastSeq,_that.lastDeliveryAt,_that.lastStatus,_that.lastError,_that.failures);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String url,  List<String> entities,  bool enabled,  bool hasSecret,  int lastSeq,  DateTime? lastDeliveryAt,  int? lastStatus,  String? lastError,  int failures)  $default,) {final _that = this;
switch (_that) {
case _WebhookInfo():
return $default(_that.id,_that.name,_that.url,_that.entities,_that.enabled,_that.hasSecret,_that.lastSeq,_that.lastDeliveryAt,_that.lastStatus,_that.lastError,_that.failures);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String url,  List<String> entities,  bool enabled,  bool hasSecret,  int lastSeq,  DateTime? lastDeliveryAt,  int? lastStatus,  String? lastError,  int failures)?  $default,) {final _that = this;
switch (_that) {
case _WebhookInfo() when $default != null:
return $default(_that.id,_that.name,_that.url,_that.entities,_that.enabled,_that.hasSecret,_that.lastSeq,_that.lastDeliveryAt,_that.lastStatus,_that.lastError,_that.failures);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WebhookInfo implements WebhookInfo {
  const _WebhookInfo({required this.id, required this.name, required this.url, final  List<String> entities = const [], this.enabled = true, this.hasSecret = false, this.lastSeq = 0, this.lastDeliveryAt, this.lastStatus, this.lastError, this.failures = 0}): _entities = entities;
  factory _WebhookInfo.fromJson(Map<String, dynamic> json) => _$WebhookInfoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String url;
 final  List<String> _entities;
@override@JsonKey() List<String> get entities {
  if (_entities is EqualUnmodifiableListView) return _entities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entities);
}

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool hasSecret;
/// Dernière séquence livrée.
@override@JsonKey() final  int lastSeq;
@override final  DateTime? lastDeliveryAt;
@override final  int? lastStatus;
@override final  String? lastError;
@override@JsonKey() final  int failures;

/// Create a copy of WebhookInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebhookInfoCopyWith<_WebhookInfo> get copyWith => __$WebhookInfoCopyWithImpl<_WebhookInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebhookInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebhookInfo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._entities, _entities)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.hasSecret, hasSecret) || other.hasSecret == hasSecret)&&(identical(other.lastSeq, lastSeq) || other.lastSeq == lastSeq)&&(identical(other.lastDeliveryAt, lastDeliveryAt) || other.lastDeliveryAt == lastDeliveryAt)&&(identical(other.lastStatus, lastStatus) || other.lastStatus == lastStatus)&&(identical(other.lastError, lastError) || other.lastError == lastError)&&(identical(other.failures, failures) || other.failures == failures));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,url,const DeepCollectionEquality().hash(_entities),enabled,hasSecret,lastSeq,lastDeliveryAt,lastStatus,lastError,failures);

@override
String toString() {
  return 'WebhookInfo(id: $id, name: $name, url: $url, entities: $entities, enabled: $enabled, hasSecret: $hasSecret, lastSeq: $lastSeq, lastDeliveryAt: $lastDeliveryAt, lastStatus: $lastStatus, lastError: $lastError, failures: $failures)';
}


}

/// @nodoc
abstract mixin class _$WebhookInfoCopyWith<$Res> implements $WebhookInfoCopyWith<$Res> {
  factory _$WebhookInfoCopyWith(_WebhookInfo value, $Res Function(_WebhookInfo) _then) = __$WebhookInfoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String url, List<String> entities, bool enabled, bool hasSecret, int lastSeq, DateTime? lastDeliveryAt, int? lastStatus, String? lastError, int failures
});




}
/// @nodoc
class __$WebhookInfoCopyWithImpl<$Res>
    implements _$WebhookInfoCopyWith<$Res> {
  __$WebhookInfoCopyWithImpl(this._self, this._then);

  final _WebhookInfo _self;
  final $Res Function(_WebhookInfo) _then;

/// Create a copy of WebhookInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? url = null,Object? entities = null,Object? enabled = null,Object? hasSecret = null,Object? lastSeq = null,Object? lastDeliveryAt = freezed,Object? lastStatus = freezed,Object? lastError = freezed,Object? failures = null,}) {
  return _then(_WebhookInfo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,entities: null == entities ? _self._entities : entities // ignore: cast_nullable_to_non_nullable
as List<String>,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,hasSecret: null == hasSecret ? _self.hasSecret : hasSecret // ignore: cast_nullable_to_non_nullable
as bool,lastSeq: null == lastSeq ? _self.lastSeq : lastSeq // ignore: cast_nullable_to_non_nullable
as int,lastDeliveryAt: freezed == lastDeliveryAt ? _self.lastDeliveryAt : lastDeliveryAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastStatus: freezed == lastStatus ? _self.lastStatus : lastStatus // ignore: cast_nullable_to_non_nullable
as int?,lastError: freezed == lastError ? _self.lastError : lastError // ignore: cast_nullable_to_non_nullable
as String?,failures: null == failures ? _self.failures : failures // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WebhookInput {

 String get name; String get url; List<String> get entities; bool get enabled;/// Écriture seule : secret de signature HMAC (`null` : inchangé).
 String? get secret;
/// Create a copy of WebhookInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WebhookInputCopyWith<WebhookInput> get copyWith => _$WebhookInputCopyWithImpl<WebhookInput>(this as WebhookInput, _$identity);

  /// Serializes this WebhookInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WebhookInput&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.entities, entities)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.secret, secret) || other.secret == secret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url,const DeepCollectionEquality().hash(entities),enabled,secret);

@override
String toString() {
  return 'WebhookInput(name: $name, url: $url, entities: $entities, enabled: $enabled, secret: $secret)';
}


}

/// @nodoc
abstract mixin class $WebhookInputCopyWith<$Res>  {
  factory $WebhookInputCopyWith(WebhookInput value, $Res Function(WebhookInput) _then) = _$WebhookInputCopyWithImpl;
@useResult
$Res call({
 String name, String url, List<String> entities, bool enabled, String? secret
});




}
/// @nodoc
class _$WebhookInputCopyWithImpl<$Res>
    implements $WebhookInputCopyWith<$Res> {
  _$WebhookInputCopyWithImpl(this._self, this._then);

  final WebhookInput _self;
  final $Res Function(WebhookInput) _then;

/// Create a copy of WebhookInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? url = null,Object? entities = null,Object? enabled = null,Object? secret = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,entities: null == entities ? _self.entities : entities // ignore: cast_nullable_to_non_nullable
as List<String>,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,secret: freezed == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WebhookInput].
extension WebhookInputPatterns on WebhookInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WebhookInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WebhookInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WebhookInput value)  $default,){
final _that = this;
switch (_that) {
case _WebhookInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WebhookInput value)?  $default,){
final _that = this;
switch (_that) {
case _WebhookInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String url,  List<String> entities,  bool enabled,  String? secret)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WebhookInput() when $default != null:
return $default(_that.name,_that.url,_that.entities,_that.enabled,_that.secret);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String url,  List<String> entities,  bool enabled,  String? secret)  $default,) {final _that = this;
switch (_that) {
case _WebhookInput():
return $default(_that.name,_that.url,_that.entities,_that.enabled,_that.secret);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String url,  List<String> entities,  bool enabled,  String? secret)?  $default,) {final _that = this;
switch (_that) {
case _WebhookInput() when $default != null:
return $default(_that.name,_that.url,_that.entities,_that.enabled,_that.secret);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WebhookInput implements WebhookInput {
  const _WebhookInput({required this.name, required this.url, final  List<String> entities = const [], this.enabled = true, this.secret}): _entities = entities;
  factory _WebhookInput.fromJson(Map<String, dynamic> json) => _$WebhookInputFromJson(json);

@override final  String name;
@override final  String url;
 final  List<String> _entities;
@override@JsonKey() List<String> get entities {
  if (_entities is EqualUnmodifiableListView) return _entities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entities);
}

@override@JsonKey() final  bool enabled;
/// Écriture seule : secret de signature HMAC (`null` : inchangé).
@override final  String? secret;

/// Create a copy of WebhookInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WebhookInputCopyWith<_WebhookInput> get copyWith => __$WebhookInputCopyWithImpl<_WebhookInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WebhookInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WebhookInput&&(identical(other.name, name) || other.name == name)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._entities, _entities)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.secret, secret) || other.secret == secret));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,url,const DeepCollectionEquality().hash(_entities),enabled,secret);

@override
String toString() {
  return 'WebhookInput(name: $name, url: $url, entities: $entities, enabled: $enabled, secret: $secret)';
}


}

/// @nodoc
abstract mixin class _$WebhookInputCopyWith<$Res> implements $WebhookInputCopyWith<$Res> {
  factory _$WebhookInputCopyWith(_WebhookInput value, $Res Function(_WebhookInput) _then) = __$WebhookInputCopyWithImpl;
@override @useResult
$Res call({
 String name, String url, List<String> entities, bool enabled, String? secret
});




}
/// @nodoc
class __$WebhookInputCopyWithImpl<$Res>
    implements _$WebhookInputCopyWith<$Res> {
  __$WebhookInputCopyWithImpl(this._self, this._then);

  final _WebhookInput _self;
  final $Res Function(_WebhookInput) _then;

/// Create a copy of WebhookInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? url = null,Object? entities = null,Object? enabled = null,Object? secret = freezed,}) {
  return _then(_WebhookInput(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,entities: null == entities ? _self._entities : entities // ignore: cast_nullable_to_non_nullable
as List<String>,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,secret: freezed == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
