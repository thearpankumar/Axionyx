// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pcr_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PcrProfile {

 String get id; String get name;/// 'standard' or 'twostep'
 String get mode; int get cycles; double get initialDenatureTemp; int get initialDenatureTime; double get denatureTemp; int get denatureTime;// Standard mode fields (null for twostep)
 double? get annealTemp; int? get annealTime; double? get extendTemp; int? get extendTime;// Two-step mode field (null for standard)
 double? get annealExtendTemp; int? get annealExtendTime; double get finalExtendTemp; int get finalExtendTime; DateTime get createdAt; bool get isDefault;
/// Create a copy of PcrProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PcrProfileCopyWith<PcrProfile> get copyWith => _$PcrProfileCopyWithImpl<PcrProfile>(this as PcrProfile, _$identity);

  /// Serializes this PcrProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PcrProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.cycles, cycles) || other.cycles == cycles)&&(identical(other.initialDenatureTemp, initialDenatureTemp) || other.initialDenatureTemp == initialDenatureTemp)&&(identical(other.initialDenatureTime, initialDenatureTime) || other.initialDenatureTime == initialDenatureTime)&&(identical(other.denatureTemp, denatureTemp) || other.denatureTemp == denatureTemp)&&(identical(other.denatureTime, denatureTime) || other.denatureTime == denatureTime)&&(identical(other.annealTemp, annealTemp) || other.annealTemp == annealTemp)&&(identical(other.annealTime, annealTime) || other.annealTime == annealTime)&&(identical(other.extendTemp, extendTemp) || other.extendTemp == extendTemp)&&(identical(other.extendTime, extendTime) || other.extendTime == extendTime)&&(identical(other.annealExtendTemp, annealExtendTemp) || other.annealExtendTemp == annealExtendTemp)&&(identical(other.annealExtendTime, annealExtendTime) || other.annealExtendTime == annealExtendTime)&&(identical(other.finalExtendTemp, finalExtendTemp) || other.finalExtendTemp == finalExtendTemp)&&(identical(other.finalExtendTime, finalExtendTime) || other.finalExtendTime == finalExtendTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,mode,cycles,initialDenatureTemp,initialDenatureTime,denatureTemp,denatureTime,annealTemp,annealTime,extendTemp,extendTime,annealExtendTemp,annealExtendTime,finalExtendTemp,finalExtendTime,createdAt,isDefault);

@override
String toString() {
  return 'PcrProfile(id: $id, name: $name, mode: $mode, cycles: $cycles, initialDenatureTemp: $initialDenatureTemp, initialDenatureTime: $initialDenatureTime, denatureTemp: $denatureTemp, denatureTime: $denatureTime, annealTemp: $annealTemp, annealTime: $annealTime, extendTemp: $extendTemp, extendTime: $extendTime, annealExtendTemp: $annealExtendTemp, annealExtendTime: $annealExtendTime, finalExtendTemp: $finalExtendTemp, finalExtendTime: $finalExtendTime, createdAt: $createdAt, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $PcrProfileCopyWith<$Res>  {
  factory $PcrProfileCopyWith(PcrProfile value, $Res Function(PcrProfile) _then) = _$PcrProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name, String mode, int cycles, double initialDenatureTemp, int initialDenatureTime, double denatureTemp, int denatureTime, double? annealTemp, int? annealTime, double? extendTemp, int? extendTime, double? annealExtendTemp, int? annealExtendTime, double finalExtendTemp, int finalExtendTime, DateTime createdAt, bool isDefault
});




}
/// @nodoc
class _$PcrProfileCopyWithImpl<$Res>
    implements $PcrProfileCopyWith<$Res> {
  _$PcrProfileCopyWithImpl(this._self, this._then);

  final PcrProfile _self;
  final $Res Function(PcrProfile) _then;

/// Create a copy of PcrProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? mode = null,Object? cycles = null,Object? initialDenatureTemp = null,Object? initialDenatureTime = null,Object? denatureTemp = null,Object? denatureTime = null,Object? annealTemp = freezed,Object? annealTime = freezed,Object? extendTemp = freezed,Object? extendTime = freezed,Object? annealExtendTemp = freezed,Object? annealExtendTime = freezed,Object? finalExtendTemp = null,Object? finalExtendTime = null,Object? createdAt = null,Object? isDefault = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,cycles: null == cycles ? _self.cycles : cycles // ignore: cast_nullable_to_non_nullable
as int,initialDenatureTemp: null == initialDenatureTemp ? _self.initialDenatureTemp : initialDenatureTemp // ignore: cast_nullable_to_non_nullable
as double,initialDenatureTime: null == initialDenatureTime ? _self.initialDenatureTime : initialDenatureTime // ignore: cast_nullable_to_non_nullable
as int,denatureTemp: null == denatureTemp ? _self.denatureTemp : denatureTemp // ignore: cast_nullable_to_non_nullable
as double,denatureTime: null == denatureTime ? _self.denatureTime : denatureTime // ignore: cast_nullable_to_non_nullable
as int,annealTemp: freezed == annealTemp ? _self.annealTemp : annealTemp // ignore: cast_nullable_to_non_nullable
as double?,annealTime: freezed == annealTime ? _self.annealTime : annealTime // ignore: cast_nullable_to_non_nullable
as int?,extendTemp: freezed == extendTemp ? _self.extendTemp : extendTemp // ignore: cast_nullable_to_non_nullable
as double?,extendTime: freezed == extendTime ? _self.extendTime : extendTime // ignore: cast_nullable_to_non_nullable
as int?,annealExtendTemp: freezed == annealExtendTemp ? _self.annealExtendTemp : annealExtendTemp // ignore: cast_nullable_to_non_nullable
as double?,annealExtendTime: freezed == annealExtendTime ? _self.annealExtendTime : annealExtendTime // ignore: cast_nullable_to_non_nullable
as int?,finalExtendTemp: null == finalExtendTemp ? _self.finalExtendTemp : finalExtendTemp // ignore: cast_nullable_to_non_nullable
as double,finalExtendTime: null == finalExtendTime ? _self.finalExtendTime : finalExtendTime // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PcrProfile].
extension PcrProfilePatterns on PcrProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PcrProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PcrProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PcrProfile value)  $default,){
final _that = this;
switch (_that) {
case _PcrProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PcrProfile value)?  $default,){
final _that = this;
switch (_that) {
case _PcrProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String mode,  int cycles,  double initialDenatureTemp,  int initialDenatureTime,  double denatureTemp,  int denatureTime,  double? annealTemp,  int? annealTime,  double? extendTemp,  int? extendTime,  double? annealExtendTemp,  int? annealExtendTime,  double finalExtendTemp,  int finalExtendTime,  DateTime createdAt,  bool isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PcrProfile() when $default != null:
return $default(_that.id,_that.name,_that.mode,_that.cycles,_that.initialDenatureTemp,_that.initialDenatureTime,_that.denatureTemp,_that.denatureTime,_that.annealTemp,_that.annealTime,_that.extendTemp,_that.extendTime,_that.annealExtendTemp,_that.annealExtendTime,_that.finalExtendTemp,_that.finalExtendTime,_that.createdAt,_that.isDefault);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String mode,  int cycles,  double initialDenatureTemp,  int initialDenatureTime,  double denatureTemp,  int denatureTime,  double? annealTemp,  int? annealTime,  double? extendTemp,  int? extendTime,  double? annealExtendTemp,  int? annealExtendTime,  double finalExtendTemp,  int finalExtendTime,  DateTime createdAt,  bool isDefault)  $default,) {final _that = this;
switch (_that) {
case _PcrProfile():
return $default(_that.id,_that.name,_that.mode,_that.cycles,_that.initialDenatureTemp,_that.initialDenatureTime,_that.denatureTemp,_that.denatureTime,_that.annealTemp,_that.annealTime,_that.extendTemp,_that.extendTime,_that.annealExtendTemp,_that.annealExtendTime,_that.finalExtendTemp,_that.finalExtendTime,_that.createdAt,_that.isDefault);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String mode,  int cycles,  double initialDenatureTemp,  int initialDenatureTime,  double denatureTemp,  int denatureTime,  double? annealTemp,  int? annealTime,  double? extendTemp,  int? extendTime,  double? annealExtendTemp,  int? annealExtendTime,  double finalExtendTemp,  int finalExtendTime,  DateTime createdAt,  bool isDefault)?  $default,) {final _that = this;
switch (_that) {
case _PcrProfile() when $default != null:
return $default(_that.id,_that.name,_that.mode,_that.cycles,_that.initialDenatureTemp,_that.initialDenatureTime,_that.denatureTemp,_that.denatureTime,_that.annealTemp,_that.annealTime,_that.extendTemp,_that.extendTime,_that.annealExtendTemp,_that.annealExtendTime,_that.finalExtendTemp,_that.finalExtendTime,_that.createdAt,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PcrProfile extends PcrProfile {
  const _PcrProfile({required this.id, required this.name, required this.mode, required this.cycles, required this.initialDenatureTemp, required this.initialDenatureTime, required this.denatureTemp, required this.denatureTime, this.annealTemp, this.annealTime, this.extendTemp, this.extendTime, this.annealExtendTemp, this.annealExtendTime, required this.finalExtendTemp, required this.finalExtendTime, required this.createdAt, this.isDefault = false}): super._();
  factory _PcrProfile.fromJson(Map<String, dynamic> json) => _$PcrProfileFromJson(json);

@override final  String id;
@override final  String name;
/// 'standard' or 'twostep'
@override final  String mode;
@override final  int cycles;
@override final  double initialDenatureTemp;
@override final  int initialDenatureTime;
@override final  double denatureTemp;
@override final  int denatureTime;
// Standard mode fields (null for twostep)
@override final  double? annealTemp;
@override final  int? annealTime;
@override final  double? extendTemp;
@override final  int? extendTime;
// Two-step mode field (null for standard)
@override final  double? annealExtendTemp;
@override final  int? annealExtendTime;
@override final  double finalExtendTemp;
@override final  int finalExtendTime;
@override final  DateTime createdAt;
@override@JsonKey() final  bool isDefault;

/// Create a copy of PcrProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PcrProfileCopyWith<_PcrProfile> get copyWith => __$PcrProfileCopyWithImpl<_PcrProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PcrProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PcrProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.cycles, cycles) || other.cycles == cycles)&&(identical(other.initialDenatureTemp, initialDenatureTemp) || other.initialDenatureTemp == initialDenatureTemp)&&(identical(other.initialDenatureTime, initialDenatureTime) || other.initialDenatureTime == initialDenatureTime)&&(identical(other.denatureTemp, denatureTemp) || other.denatureTemp == denatureTemp)&&(identical(other.denatureTime, denatureTime) || other.denatureTime == denatureTime)&&(identical(other.annealTemp, annealTemp) || other.annealTemp == annealTemp)&&(identical(other.annealTime, annealTime) || other.annealTime == annealTime)&&(identical(other.extendTemp, extendTemp) || other.extendTemp == extendTemp)&&(identical(other.extendTime, extendTime) || other.extendTime == extendTime)&&(identical(other.annealExtendTemp, annealExtendTemp) || other.annealExtendTemp == annealExtendTemp)&&(identical(other.annealExtendTime, annealExtendTime) || other.annealExtendTime == annealExtendTime)&&(identical(other.finalExtendTemp, finalExtendTemp) || other.finalExtendTemp == finalExtendTemp)&&(identical(other.finalExtendTime, finalExtendTime) || other.finalExtendTime == finalExtendTime)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,mode,cycles,initialDenatureTemp,initialDenatureTime,denatureTemp,denatureTime,annealTemp,annealTime,extendTemp,extendTime,annealExtendTemp,annealExtendTime,finalExtendTemp,finalExtendTime,createdAt,isDefault);

@override
String toString() {
  return 'PcrProfile(id: $id, name: $name, mode: $mode, cycles: $cycles, initialDenatureTemp: $initialDenatureTemp, initialDenatureTime: $initialDenatureTime, denatureTemp: $denatureTemp, denatureTime: $denatureTime, annealTemp: $annealTemp, annealTime: $annealTime, extendTemp: $extendTemp, extendTime: $extendTime, annealExtendTemp: $annealExtendTemp, annealExtendTime: $annealExtendTime, finalExtendTemp: $finalExtendTemp, finalExtendTime: $finalExtendTime, createdAt: $createdAt, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$PcrProfileCopyWith<$Res> implements $PcrProfileCopyWith<$Res> {
  factory _$PcrProfileCopyWith(_PcrProfile value, $Res Function(_PcrProfile) _then) = __$PcrProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String mode, int cycles, double initialDenatureTemp, int initialDenatureTime, double denatureTemp, int denatureTime, double? annealTemp, int? annealTime, double? extendTemp, int? extendTime, double? annealExtendTemp, int? annealExtendTime, double finalExtendTemp, int finalExtendTime, DateTime createdAt, bool isDefault
});




}
/// @nodoc
class __$PcrProfileCopyWithImpl<$Res>
    implements _$PcrProfileCopyWith<$Res> {
  __$PcrProfileCopyWithImpl(this._self, this._then);

  final _PcrProfile _self;
  final $Res Function(_PcrProfile) _then;

/// Create a copy of PcrProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? mode = null,Object? cycles = null,Object? initialDenatureTemp = null,Object? initialDenatureTime = null,Object? denatureTemp = null,Object? denatureTime = null,Object? annealTemp = freezed,Object? annealTime = freezed,Object? extendTemp = freezed,Object? extendTime = freezed,Object? annealExtendTemp = freezed,Object? annealExtendTime = freezed,Object? finalExtendTemp = null,Object? finalExtendTime = null,Object? createdAt = null,Object? isDefault = null,}) {
  return _then(_PcrProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,cycles: null == cycles ? _self.cycles : cycles // ignore: cast_nullable_to_non_nullable
as int,initialDenatureTemp: null == initialDenatureTemp ? _self.initialDenatureTemp : initialDenatureTemp // ignore: cast_nullable_to_non_nullable
as double,initialDenatureTime: null == initialDenatureTime ? _self.initialDenatureTime : initialDenatureTime // ignore: cast_nullable_to_non_nullable
as int,denatureTemp: null == denatureTemp ? _self.denatureTemp : denatureTemp // ignore: cast_nullable_to_non_nullable
as double,denatureTime: null == denatureTime ? _self.denatureTime : denatureTime // ignore: cast_nullable_to_non_nullable
as int,annealTemp: freezed == annealTemp ? _self.annealTemp : annealTemp // ignore: cast_nullable_to_non_nullable
as double?,annealTime: freezed == annealTime ? _self.annealTime : annealTime // ignore: cast_nullable_to_non_nullable
as int?,extendTemp: freezed == extendTemp ? _self.extendTemp : extendTemp // ignore: cast_nullable_to_non_nullable
as double?,extendTime: freezed == extendTime ? _self.extendTime : extendTime // ignore: cast_nullable_to_non_nullable
as int?,annealExtendTemp: freezed == annealExtendTemp ? _self.annealExtendTemp : annealExtendTemp // ignore: cast_nullable_to_non_nullable
as double?,annealExtendTime: freezed == annealExtendTime ? _self.annealExtendTime : annealExtendTime // ignore: cast_nullable_to_non_nullable
as int?,finalExtendTemp: null == finalExtendTemp ? _self.finalExtendTemp : finalExtendTemp // ignore: cast_nullable_to_non_nullable
as double,finalExtendTime: null == finalExtendTime ? _self.finalExtendTime : finalExtendTime // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
