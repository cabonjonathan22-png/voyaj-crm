// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'billing_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BillingSettings {

 String get legalName; String? get address; String? get postalCode; String? get city; String? get siren; String? get siret; String? get vatNumber; String? get legalForm; String? get capital; String? get rcs; String? get email; String? get phone; String? get iban; String? get bic; String get paymentTerms; int get paymentDays; int get quoteValidityDays; String get latePenalties; String? get vatExemptionReason; String? get footer;/// Plan de comptes (FEC) : `customer`, `sales`, `bank`, `vat`…
 Map<String, Object?> get accounts; bool get chorusEnabled; bool get chorusSandbox; String? get chorusLogin; String? get pisteClientId;/// Écriture seule : nouveau mot de passe du compte technique Chorus
/// Pro (`null` : inchangé).
 String? get chorusPassword;/// Écriture seule : secret de l'application PISTE (`null` : inchangé).
 String? get pisteClientSecret;/// Lecture seule : identifiants Chorus Pro complets.
 bool get chorusConfigured;
/// Create a copy of BillingSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillingSettingsCopyWith<BillingSettings> get copyWith => _$BillingSettingsCopyWithImpl<BillingSettings>(this as BillingSettings, _$identity);

  /// Serializes this BillingSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillingSettings&&(identical(other.legalName, legalName) || other.legalName == legalName)&&(identical(other.address, address) || other.address == address)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.city, city) || other.city == city)&&(identical(other.siren, siren) || other.siren == siren)&&(identical(other.siret, siret) || other.siret == siret)&&(identical(other.vatNumber, vatNumber) || other.vatNumber == vatNumber)&&(identical(other.legalForm, legalForm) || other.legalForm == legalForm)&&(identical(other.capital, capital) || other.capital == capital)&&(identical(other.rcs, rcs) || other.rcs == rcs)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.iban, iban) || other.iban == iban)&&(identical(other.bic, bic) || other.bic == bic)&&(identical(other.paymentTerms, paymentTerms) || other.paymentTerms == paymentTerms)&&(identical(other.paymentDays, paymentDays) || other.paymentDays == paymentDays)&&(identical(other.quoteValidityDays, quoteValidityDays) || other.quoteValidityDays == quoteValidityDays)&&(identical(other.latePenalties, latePenalties) || other.latePenalties == latePenalties)&&(identical(other.vatExemptionReason, vatExemptionReason) || other.vatExemptionReason == vatExemptionReason)&&(identical(other.footer, footer) || other.footer == footer)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&(identical(other.chorusEnabled, chorusEnabled) || other.chorusEnabled == chorusEnabled)&&(identical(other.chorusSandbox, chorusSandbox) || other.chorusSandbox == chorusSandbox)&&(identical(other.chorusLogin, chorusLogin) || other.chorusLogin == chorusLogin)&&(identical(other.pisteClientId, pisteClientId) || other.pisteClientId == pisteClientId)&&(identical(other.chorusPassword, chorusPassword) || other.chorusPassword == chorusPassword)&&(identical(other.pisteClientSecret, pisteClientSecret) || other.pisteClientSecret == pisteClientSecret)&&(identical(other.chorusConfigured, chorusConfigured) || other.chorusConfigured == chorusConfigured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,legalName,address,postalCode,city,siren,siret,vatNumber,legalForm,capital,rcs,email,phone,iban,bic,paymentTerms,paymentDays,quoteValidityDays,latePenalties,vatExemptionReason,footer,const DeepCollectionEquality().hash(accounts),chorusEnabled,chorusSandbox,chorusLogin,pisteClientId,chorusPassword,pisteClientSecret,chorusConfigured]);

@override
String toString() {
  return 'BillingSettings(legalName: $legalName, address: $address, postalCode: $postalCode, city: $city, siren: $siren, siret: $siret, vatNumber: $vatNumber, legalForm: $legalForm, capital: $capital, rcs: $rcs, email: $email, phone: $phone, iban: $iban, bic: $bic, paymentTerms: $paymentTerms, paymentDays: $paymentDays, quoteValidityDays: $quoteValidityDays, latePenalties: $latePenalties, vatExemptionReason: $vatExemptionReason, footer: $footer, accounts: $accounts, chorusEnabled: $chorusEnabled, chorusSandbox: $chorusSandbox, chorusLogin: $chorusLogin, pisteClientId: $pisteClientId, chorusPassword: $chorusPassword, pisteClientSecret: $pisteClientSecret, chorusConfigured: $chorusConfigured)';
}


}

/// @nodoc
abstract mixin class $BillingSettingsCopyWith<$Res>  {
  factory $BillingSettingsCopyWith(BillingSettings value, $Res Function(BillingSettings) _then) = _$BillingSettingsCopyWithImpl;
@useResult
$Res call({
 String legalName, String? address, String? postalCode, String? city, String? siren, String? siret, String? vatNumber, String? legalForm, String? capital, String? rcs, String? email, String? phone, String? iban, String? bic, String paymentTerms, int paymentDays, int quoteValidityDays, String latePenalties, String? vatExemptionReason, String? footer, Map<String, Object?> accounts, bool chorusEnabled, bool chorusSandbox, String? chorusLogin, String? pisteClientId, String? chorusPassword, String? pisteClientSecret, bool chorusConfigured
});




}
/// @nodoc
class _$BillingSettingsCopyWithImpl<$Res>
    implements $BillingSettingsCopyWith<$Res> {
  _$BillingSettingsCopyWithImpl(this._self, this._then);

  final BillingSettings _self;
  final $Res Function(BillingSettings) _then;

/// Create a copy of BillingSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? legalName = null,Object? address = freezed,Object? postalCode = freezed,Object? city = freezed,Object? siren = freezed,Object? siret = freezed,Object? vatNumber = freezed,Object? legalForm = freezed,Object? capital = freezed,Object? rcs = freezed,Object? email = freezed,Object? phone = freezed,Object? iban = freezed,Object? bic = freezed,Object? paymentTerms = null,Object? paymentDays = null,Object? quoteValidityDays = null,Object? latePenalties = null,Object? vatExemptionReason = freezed,Object? footer = freezed,Object? accounts = null,Object? chorusEnabled = null,Object? chorusSandbox = null,Object? chorusLogin = freezed,Object? pisteClientId = freezed,Object? chorusPassword = freezed,Object? pisteClientSecret = freezed,Object? chorusConfigured = null,}) {
  return _then(_self.copyWith(
legalName: null == legalName ? _self.legalName : legalName // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,siren: freezed == siren ? _self.siren : siren // ignore: cast_nullable_to_non_nullable
as String?,siret: freezed == siret ? _self.siret : siret // ignore: cast_nullable_to_non_nullable
as String?,vatNumber: freezed == vatNumber ? _self.vatNumber : vatNumber // ignore: cast_nullable_to_non_nullable
as String?,legalForm: freezed == legalForm ? _self.legalForm : legalForm // ignore: cast_nullable_to_non_nullable
as String?,capital: freezed == capital ? _self.capital : capital // ignore: cast_nullable_to_non_nullable
as String?,rcs: freezed == rcs ? _self.rcs : rcs // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,iban: freezed == iban ? _self.iban : iban // ignore: cast_nullable_to_non_nullable
as String?,bic: freezed == bic ? _self.bic : bic // ignore: cast_nullable_to_non_nullable
as String?,paymentTerms: null == paymentTerms ? _self.paymentTerms : paymentTerms // ignore: cast_nullable_to_non_nullable
as String,paymentDays: null == paymentDays ? _self.paymentDays : paymentDays // ignore: cast_nullable_to_non_nullable
as int,quoteValidityDays: null == quoteValidityDays ? _self.quoteValidityDays : quoteValidityDays // ignore: cast_nullable_to_non_nullable
as int,latePenalties: null == latePenalties ? _self.latePenalties : latePenalties // ignore: cast_nullable_to_non_nullable
as String,vatExemptionReason: freezed == vatExemptionReason ? _self.vatExemptionReason : vatExemptionReason // ignore: cast_nullable_to_non_nullable
as String?,footer: freezed == footer ? _self.footer : footer // ignore: cast_nullable_to_non_nullable
as String?,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,chorusEnabled: null == chorusEnabled ? _self.chorusEnabled : chorusEnabled // ignore: cast_nullable_to_non_nullable
as bool,chorusSandbox: null == chorusSandbox ? _self.chorusSandbox : chorusSandbox // ignore: cast_nullable_to_non_nullable
as bool,chorusLogin: freezed == chorusLogin ? _self.chorusLogin : chorusLogin // ignore: cast_nullable_to_non_nullable
as String?,pisteClientId: freezed == pisteClientId ? _self.pisteClientId : pisteClientId // ignore: cast_nullable_to_non_nullable
as String?,chorusPassword: freezed == chorusPassword ? _self.chorusPassword : chorusPassword // ignore: cast_nullable_to_non_nullable
as String?,pisteClientSecret: freezed == pisteClientSecret ? _self.pisteClientSecret : pisteClientSecret // ignore: cast_nullable_to_non_nullable
as String?,chorusConfigured: null == chorusConfigured ? _self.chorusConfigured : chorusConfigured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [BillingSettings].
extension BillingSettingsPatterns on BillingSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillingSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillingSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillingSettings value)  $default,){
final _that = this;
switch (_that) {
case _BillingSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillingSettings value)?  $default,){
final _that = this;
switch (_that) {
case _BillingSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String legalName,  String? address,  String? postalCode,  String? city,  String? siren,  String? siret,  String? vatNumber,  String? legalForm,  String? capital,  String? rcs,  String? email,  String? phone,  String? iban,  String? bic,  String paymentTerms,  int paymentDays,  int quoteValidityDays,  String latePenalties,  String? vatExemptionReason,  String? footer,  Map<String, Object?> accounts,  bool chorusEnabled,  bool chorusSandbox,  String? chorusLogin,  String? pisteClientId,  String? chorusPassword,  String? pisteClientSecret,  bool chorusConfigured)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillingSettings() when $default != null:
return $default(_that.legalName,_that.address,_that.postalCode,_that.city,_that.siren,_that.siret,_that.vatNumber,_that.legalForm,_that.capital,_that.rcs,_that.email,_that.phone,_that.iban,_that.bic,_that.paymentTerms,_that.paymentDays,_that.quoteValidityDays,_that.latePenalties,_that.vatExemptionReason,_that.footer,_that.accounts,_that.chorusEnabled,_that.chorusSandbox,_that.chorusLogin,_that.pisteClientId,_that.chorusPassword,_that.pisteClientSecret,_that.chorusConfigured);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String legalName,  String? address,  String? postalCode,  String? city,  String? siren,  String? siret,  String? vatNumber,  String? legalForm,  String? capital,  String? rcs,  String? email,  String? phone,  String? iban,  String? bic,  String paymentTerms,  int paymentDays,  int quoteValidityDays,  String latePenalties,  String? vatExemptionReason,  String? footer,  Map<String, Object?> accounts,  bool chorusEnabled,  bool chorusSandbox,  String? chorusLogin,  String? pisteClientId,  String? chorusPassword,  String? pisteClientSecret,  bool chorusConfigured)  $default,) {final _that = this;
switch (_that) {
case _BillingSettings():
return $default(_that.legalName,_that.address,_that.postalCode,_that.city,_that.siren,_that.siret,_that.vatNumber,_that.legalForm,_that.capital,_that.rcs,_that.email,_that.phone,_that.iban,_that.bic,_that.paymentTerms,_that.paymentDays,_that.quoteValidityDays,_that.latePenalties,_that.vatExemptionReason,_that.footer,_that.accounts,_that.chorusEnabled,_that.chorusSandbox,_that.chorusLogin,_that.pisteClientId,_that.chorusPassword,_that.pisteClientSecret,_that.chorusConfigured);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String legalName,  String? address,  String? postalCode,  String? city,  String? siren,  String? siret,  String? vatNumber,  String? legalForm,  String? capital,  String? rcs,  String? email,  String? phone,  String? iban,  String? bic,  String paymentTerms,  int paymentDays,  int quoteValidityDays,  String latePenalties,  String? vatExemptionReason,  String? footer,  Map<String, Object?> accounts,  bool chorusEnabled,  bool chorusSandbox,  String? chorusLogin,  String? pisteClientId,  String? chorusPassword,  String? pisteClientSecret,  bool chorusConfigured)?  $default,) {final _that = this;
switch (_that) {
case _BillingSettings() when $default != null:
return $default(_that.legalName,_that.address,_that.postalCode,_that.city,_that.siren,_that.siret,_that.vatNumber,_that.legalForm,_that.capital,_that.rcs,_that.email,_that.phone,_that.iban,_that.bic,_that.paymentTerms,_that.paymentDays,_that.quoteValidityDays,_that.latePenalties,_that.vatExemptionReason,_that.footer,_that.accounts,_that.chorusEnabled,_that.chorusSandbox,_that.chorusLogin,_that.pisteClientId,_that.chorusPassword,_that.pisteClientSecret,_that.chorusConfigured);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BillingSettings implements BillingSettings {
  const _BillingSettings({this.legalName = '', this.address, this.postalCode, this.city, this.siren, this.siret, this.vatNumber, this.legalForm, this.capital, this.rcs, this.email, this.phone, this.iban, this.bic, this.paymentTerms = 'Paiement à 30 jours par virement', this.paymentDays = 30, this.quoteValidityDays = 30, this.latePenalties = defaultLatePenalties, this.vatExemptionReason, this.footer, final  Map<String, Object?> accounts = const {}, this.chorusEnabled = false, this.chorusSandbox = true, this.chorusLogin, this.pisteClientId, this.chorusPassword, this.pisteClientSecret, this.chorusConfigured = false}): _accounts = accounts;
  factory _BillingSettings.fromJson(Map<String, dynamic> json) => _$BillingSettingsFromJson(json);

@override@JsonKey() final  String legalName;
@override final  String? address;
@override final  String? postalCode;
@override final  String? city;
@override final  String? siren;
@override final  String? siret;
@override final  String? vatNumber;
@override final  String? legalForm;
@override final  String? capital;
@override final  String? rcs;
@override final  String? email;
@override final  String? phone;
@override final  String? iban;
@override final  String? bic;
@override@JsonKey() final  String paymentTerms;
@override@JsonKey() final  int paymentDays;
@override@JsonKey() final  int quoteValidityDays;
@override@JsonKey() final  String latePenalties;
@override final  String? vatExemptionReason;
@override final  String? footer;
/// Plan de comptes (FEC) : `customer`, `sales`, `bank`, `vat`…
 final  Map<String, Object?> _accounts;
/// Plan de comptes (FEC) : `customer`, `sales`, `bank`, `vat`…
@override@JsonKey() Map<String, Object?> get accounts {
  if (_accounts is EqualUnmodifiableMapView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_accounts);
}

@override@JsonKey() final  bool chorusEnabled;
@override@JsonKey() final  bool chorusSandbox;
@override final  String? chorusLogin;
@override final  String? pisteClientId;
/// Écriture seule : nouveau mot de passe du compte technique Chorus
/// Pro (`null` : inchangé).
@override final  String? chorusPassword;
/// Écriture seule : secret de l'application PISTE (`null` : inchangé).
@override final  String? pisteClientSecret;
/// Lecture seule : identifiants Chorus Pro complets.
@override@JsonKey() final  bool chorusConfigured;

/// Create a copy of BillingSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillingSettingsCopyWith<_BillingSettings> get copyWith => __$BillingSettingsCopyWithImpl<_BillingSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BillingSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillingSettings&&(identical(other.legalName, legalName) || other.legalName == legalName)&&(identical(other.address, address) || other.address == address)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.city, city) || other.city == city)&&(identical(other.siren, siren) || other.siren == siren)&&(identical(other.siret, siret) || other.siret == siret)&&(identical(other.vatNumber, vatNumber) || other.vatNumber == vatNumber)&&(identical(other.legalForm, legalForm) || other.legalForm == legalForm)&&(identical(other.capital, capital) || other.capital == capital)&&(identical(other.rcs, rcs) || other.rcs == rcs)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.iban, iban) || other.iban == iban)&&(identical(other.bic, bic) || other.bic == bic)&&(identical(other.paymentTerms, paymentTerms) || other.paymentTerms == paymentTerms)&&(identical(other.paymentDays, paymentDays) || other.paymentDays == paymentDays)&&(identical(other.quoteValidityDays, quoteValidityDays) || other.quoteValidityDays == quoteValidityDays)&&(identical(other.latePenalties, latePenalties) || other.latePenalties == latePenalties)&&(identical(other.vatExemptionReason, vatExemptionReason) || other.vatExemptionReason == vatExemptionReason)&&(identical(other.footer, footer) || other.footer == footer)&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&(identical(other.chorusEnabled, chorusEnabled) || other.chorusEnabled == chorusEnabled)&&(identical(other.chorusSandbox, chorusSandbox) || other.chorusSandbox == chorusSandbox)&&(identical(other.chorusLogin, chorusLogin) || other.chorusLogin == chorusLogin)&&(identical(other.pisteClientId, pisteClientId) || other.pisteClientId == pisteClientId)&&(identical(other.chorusPassword, chorusPassword) || other.chorusPassword == chorusPassword)&&(identical(other.pisteClientSecret, pisteClientSecret) || other.pisteClientSecret == pisteClientSecret)&&(identical(other.chorusConfigured, chorusConfigured) || other.chorusConfigured == chorusConfigured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,legalName,address,postalCode,city,siren,siret,vatNumber,legalForm,capital,rcs,email,phone,iban,bic,paymentTerms,paymentDays,quoteValidityDays,latePenalties,vatExemptionReason,footer,const DeepCollectionEquality().hash(_accounts),chorusEnabled,chorusSandbox,chorusLogin,pisteClientId,chorusPassword,pisteClientSecret,chorusConfigured]);

@override
String toString() {
  return 'BillingSettings(legalName: $legalName, address: $address, postalCode: $postalCode, city: $city, siren: $siren, siret: $siret, vatNumber: $vatNumber, legalForm: $legalForm, capital: $capital, rcs: $rcs, email: $email, phone: $phone, iban: $iban, bic: $bic, paymentTerms: $paymentTerms, paymentDays: $paymentDays, quoteValidityDays: $quoteValidityDays, latePenalties: $latePenalties, vatExemptionReason: $vatExemptionReason, footer: $footer, accounts: $accounts, chorusEnabled: $chorusEnabled, chorusSandbox: $chorusSandbox, chorusLogin: $chorusLogin, pisteClientId: $pisteClientId, chorusPassword: $chorusPassword, pisteClientSecret: $pisteClientSecret, chorusConfigured: $chorusConfigured)';
}


}

/// @nodoc
abstract mixin class _$BillingSettingsCopyWith<$Res> implements $BillingSettingsCopyWith<$Res> {
  factory _$BillingSettingsCopyWith(_BillingSettings value, $Res Function(_BillingSettings) _then) = __$BillingSettingsCopyWithImpl;
@override @useResult
$Res call({
 String legalName, String? address, String? postalCode, String? city, String? siren, String? siret, String? vatNumber, String? legalForm, String? capital, String? rcs, String? email, String? phone, String? iban, String? bic, String paymentTerms, int paymentDays, int quoteValidityDays, String latePenalties, String? vatExemptionReason, String? footer, Map<String, Object?> accounts, bool chorusEnabled, bool chorusSandbox, String? chorusLogin, String? pisteClientId, String? chorusPassword, String? pisteClientSecret, bool chorusConfigured
});




}
/// @nodoc
class __$BillingSettingsCopyWithImpl<$Res>
    implements _$BillingSettingsCopyWith<$Res> {
  __$BillingSettingsCopyWithImpl(this._self, this._then);

  final _BillingSettings _self;
  final $Res Function(_BillingSettings) _then;

/// Create a copy of BillingSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? legalName = null,Object? address = freezed,Object? postalCode = freezed,Object? city = freezed,Object? siren = freezed,Object? siret = freezed,Object? vatNumber = freezed,Object? legalForm = freezed,Object? capital = freezed,Object? rcs = freezed,Object? email = freezed,Object? phone = freezed,Object? iban = freezed,Object? bic = freezed,Object? paymentTerms = null,Object? paymentDays = null,Object? quoteValidityDays = null,Object? latePenalties = null,Object? vatExemptionReason = freezed,Object? footer = freezed,Object? accounts = null,Object? chorusEnabled = null,Object? chorusSandbox = null,Object? chorusLogin = freezed,Object? pisteClientId = freezed,Object? chorusPassword = freezed,Object? pisteClientSecret = freezed,Object? chorusConfigured = null,}) {
  return _then(_BillingSettings(
legalName: null == legalName ? _self.legalName : legalName // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,siren: freezed == siren ? _self.siren : siren // ignore: cast_nullable_to_non_nullable
as String?,siret: freezed == siret ? _self.siret : siret // ignore: cast_nullable_to_non_nullable
as String?,vatNumber: freezed == vatNumber ? _self.vatNumber : vatNumber // ignore: cast_nullable_to_non_nullable
as String?,legalForm: freezed == legalForm ? _self.legalForm : legalForm // ignore: cast_nullable_to_non_nullable
as String?,capital: freezed == capital ? _self.capital : capital // ignore: cast_nullable_to_non_nullable
as String?,rcs: freezed == rcs ? _self.rcs : rcs // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,iban: freezed == iban ? _self.iban : iban // ignore: cast_nullable_to_non_nullable
as String?,bic: freezed == bic ? _self.bic : bic // ignore: cast_nullable_to_non_nullable
as String?,paymentTerms: null == paymentTerms ? _self.paymentTerms : paymentTerms // ignore: cast_nullable_to_non_nullable
as String,paymentDays: null == paymentDays ? _self.paymentDays : paymentDays // ignore: cast_nullable_to_non_nullable
as int,quoteValidityDays: null == quoteValidityDays ? _self.quoteValidityDays : quoteValidityDays // ignore: cast_nullable_to_non_nullable
as int,latePenalties: null == latePenalties ? _self.latePenalties : latePenalties // ignore: cast_nullable_to_non_nullable
as String,vatExemptionReason: freezed == vatExemptionReason ? _self.vatExemptionReason : vatExemptionReason // ignore: cast_nullable_to_non_nullable
as String?,footer: freezed == footer ? _self.footer : footer // ignore: cast_nullable_to_non_nullable
as String?,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>,chorusEnabled: null == chorusEnabled ? _self.chorusEnabled : chorusEnabled // ignore: cast_nullable_to_non_nullable
as bool,chorusSandbox: null == chorusSandbox ? _self.chorusSandbox : chorusSandbox // ignore: cast_nullable_to_non_nullable
as bool,chorusLogin: freezed == chorusLogin ? _self.chorusLogin : chorusLogin // ignore: cast_nullable_to_non_nullable
as String?,pisteClientId: freezed == pisteClientId ? _self.pisteClientId : pisteClientId // ignore: cast_nullable_to_non_nullable
as String?,chorusPassword: freezed == chorusPassword ? _self.chorusPassword : chorusPassword // ignore: cast_nullable_to_non_nullable
as String?,pisteClientSecret: freezed == pisteClientSecret ? _self.pisteClientSecret : pisteClientSecret // ignore: cast_nullable_to_non_nullable
as String?,chorusConfigured: null == chorusConfigured ? _self.chorusConfigured : chorusConfigured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$VatReportRow {

 int get rate; int get baseCents; int get vatCents;
/// Create a copy of VatReportRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VatReportRowCopyWith<VatReportRow> get copyWith => _$VatReportRowCopyWithImpl<VatReportRow>(this as VatReportRow, _$identity);

  /// Serializes this VatReportRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VatReportRow&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.baseCents, baseCents) || other.baseCents == baseCents)&&(identical(other.vatCents, vatCents) || other.vatCents == vatCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rate,baseCents,vatCents);

@override
String toString() {
  return 'VatReportRow(rate: $rate, baseCents: $baseCents, vatCents: $vatCents)';
}


}

/// @nodoc
abstract mixin class $VatReportRowCopyWith<$Res>  {
  factory $VatReportRowCopyWith(VatReportRow value, $Res Function(VatReportRow) _then) = _$VatReportRowCopyWithImpl;
@useResult
$Res call({
 int rate, int baseCents, int vatCents
});




}
/// @nodoc
class _$VatReportRowCopyWithImpl<$Res>
    implements $VatReportRowCopyWith<$Res> {
  _$VatReportRowCopyWithImpl(this._self, this._then);

  final VatReportRow _self;
  final $Res Function(VatReportRow) _then;

/// Create a copy of VatReportRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rate = null,Object? baseCents = null,Object? vatCents = null,}) {
  return _then(_self.copyWith(
rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as int,baseCents: null == baseCents ? _self.baseCents : baseCents // ignore: cast_nullable_to_non_nullable
as int,vatCents: null == vatCents ? _self.vatCents : vatCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [VatReportRow].
extension VatReportRowPatterns on VatReportRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VatReportRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VatReportRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VatReportRow value)  $default,){
final _that = this;
switch (_that) {
case _VatReportRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VatReportRow value)?  $default,){
final _that = this;
switch (_that) {
case _VatReportRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int rate,  int baseCents,  int vatCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VatReportRow() when $default != null:
return $default(_that.rate,_that.baseCents,_that.vatCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int rate,  int baseCents,  int vatCents)  $default,) {final _that = this;
switch (_that) {
case _VatReportRow():
return $default(_that.rate,_that.baseCents,_that.vatCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int rate,  int baseCents,  int vatCents)?  $default,) {final _that = this;
switch (_that) {
case _VatReportRow() when $default != null:
return $default(_that.rate,_that.baseCents,_that.vatCents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VatReportRow implements VatReportRow {
  const _VatReportRow({required this.rate, required this.baseCents, required this.vatCents});
  factory _VatReportRow.fromJson(Map<String, dynamic> json) => _$VatReportRowFromJson(json);

@override final  int rate;
@override final  int baseCents;
@override final  int vatCents;

/// Create a copy of VatReportRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VatReportRowCopyWith<_VatReportRow> get copyWith => __$VatReportRowCopyWithImpl<_VatReportRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VatReportRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VatReportRow&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.baseCents, baseCents) || other.baseCents == baseCents)&&(identical(other.vatCents, vatCents) || other.vatCents == vatCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rate,baseCents,vatCents);

@override
String toString() {
  return 'VatReportRow(rate: $rate, baseCents: $baseCents, vatCents: $vatCents)';
}


}

/// @nodoc
abstract mixin class _$VatReportRowCopyWith<$Res> implements $VatReportRowCopyWith<$Res> {
  factory _$VatReportRowCopyWith(_VatReportRow value, $Res Function(_VatReportRow) _then) = __$VatReportRowCopyWithImpl;
@override @useResult
$Res call({
 int rate, int baseCents, int vatCents
});




}
/// @nodoc
class __$VatReportRowCopyWithImpl<$Res>
    implements _$VatReportRowCopyWith<$Res> {
  __$VatReportRowCopyWithImpl(this._self, this._then);

  final _VatReportRow _self;
  final $Res Function(_VatReportRow) _then;

/// Create a copy of VatReportRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rate = null,Object? baseCents = null,Object? vatCents = null,}) {
  return _then(_VatReportRow(
rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as int,baseCents: null == baseCents ? _self.baseCents : baseCents // ignore: cast_nullable_to_non_nullable
as int,vatCents: null == vatCents ? _self.vatCents : vatCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$VatReport {

 DateTime get from; DateTime get to; List<VatReportRow> get debits; List<VatReportRow> get receipts;
/// Create a copy of VatReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VatReportCopyWith<VatReport> get copyWith => _$VatReportCopyWithImpl<VatReport>(this as VatReport, _$identity);

  /// Serializes this VatReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VatReport&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&const DeepCollectionEquality().equals(other.debits, debits)&&const DeepCollectionEquality().equals(other.receipts, receipts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,const DeepCollectionEquality().hash(debits),const DeepCollectionEquality().hash(receipts));

@override
String toString() {
  return 'VatReport(from: $from, to: $to, debits: $debits, receipts: $receipts)';
}


}

/// @nodoc
abstract mixin class $VatReportCopyWith<$Res>  {
  factory $VatReportCopyWith(VatReport value, $Res Function(VatReport) _then) = _$VatReportCopyWithImpl;
@useResult
$Res call({
 DateTime from, DateTime to, List<VatReportRow> debits, List<VatReportRow> receipts
});




}
/// @nodoc
class _$VatReportCopyWithImpl<$Res>
    implements $VatReportCopyWith<$Res> {
  _$VatReportCopyWithImpl(this._self, this._then);

  final VatReport _self;
  final $Res Function(VatReport) _then;

/// Create a copy of VatReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? debits = null,Object? receipts = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,debits: null == debits ? _self.debits : debits // ignore: cast_nullable_to_non_nullable
as List<VatReportRow>,receipts: null == receipts ? _self.receipts : receipts // ignore: cast_nullable_to_non_nullable
as List<VatReportRow>,
  ));
}

}


/// Adds pattern-matching-related methods to [VatReport].
extension VatReportPatterns on VatReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VatReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VatReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VatReport value)  $default,){
final _that = this;
switch (_that) {
case _VatReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VatReport value)?  $default,){
final _that = this;
switch (_that) {
case _VatReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime from,  DateTime to,  List<VatReportRow> debits,  List<VatReportRow> receipts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VatReport() when $default != null:
return $default(_that.from,_that.to,_that.debits,_that.receipts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime from,  DateTime to,  List<VatReportRow> debits,  List<VatReportRow> receipts)  $default,) {final _that = this;
switch (_that) {
case _VatReport():
return $default(_that.from,_that.to,_that.debits,_that.receipts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime from,  DateTime to,  List<VatReportRow> debits,  List<VatReportRow> receipts)?  $default,) {final _that = this;
switch (_that) {
case _VatReport() when $default != null:
return $default(_that.from,_that.to,_that.debits,_that.receipts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VatReport implements VatReport {
  const _VatReport({required this.from, required this.to, required final  List<VatReportRow> debits, required final  List<VatReportRow> receipts}): _debits = debits,_receipts = receipts;
  factory _VatReport.fromJson(Map<String, dynamic> json) => _$VatReportFromJson(json);

@override final  DateTime from;
@override final  DateTime to;
 final  List<VatReportRow> _debits;
@override List<VatReportRow> get debits {
  if (_debits is EqualUnmodifiableListView) return _debits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_debits);
}

 final  List<VatReportRow> _receipts;
@override List<VatReportRow> get receipts {
  if (_receipts is EqualUnmodifiableListView) return _receipts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_receipts);
}


/// Create a copy of VatReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VatReportCopyWith<_VatReport> get copyWith => __$VatReportCopyWithImpl<_VatReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VatReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VatReport&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&const DeepCollectionEquality().equals(other._debits, _debits)&&const DeepCollectionEquality().equals(other._receipts, _receipts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,const DeepCollectionEquality().hash(_debits),const DeepCollectionEquality().hash(_receipts));

@override
String toString() {
  return 'VatReport(from: $from, to: $to, debits: $debits, receipts: $receipts)';
}


}

/// @nodoc
abstract mixin class _$VatReportCopyWith<$Res> implements $VatReportCopyWith<$Res> {
  factory _$VatReportCopyWith(_VatReport value, $Res Function(_VatReport) _then) = __$VatReportCopyWithImpl;
@override @useResult
$Res call({
 DateTime from, DateTime to, List<VatReportRow> debits, List<VatReportRow> receipts
});




}
/// @nodoc
class __$VatReportCopyWithImpl<$Res>
    implements _$VatReportCopyWith<$Res> {
  __$VatReportCopyWithImpl(this._self, this._then);

  final _VatReport _self;
  final $Res Function(_VatReport) _then;

/// Create a copy of VatReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? debits = null,Object? receipts = null,}) {
  return _then(_VatReport(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DateTime,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DateTime,debits: null == debits ? _self._debits : debits // ignore: cast_nullable_to_non_nullable
as List<VatReportRow>,receipts: null == receipts ? _self._receipts : receipts // ignore: cast_nullable_to_non_nullable
as List<VatReportRow>,
  ));
}


}

// dart format on
