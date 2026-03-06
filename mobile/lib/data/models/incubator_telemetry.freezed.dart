// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'incubator_telemetry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IncubatorTelemetry {

 DeviceState get state; int get uptime; double get temperature; double get humidity; double get co2Level; double get temperatureSetpoint; double get humiditySetpoint; double get co2Setpoint; double get temperatureError; double get humidityError; double get co2Error; bool get temperatureStable; bool get humidityStable; bool get co2Stable; bool get environmentStable; int get timeStable; RampingStatus get ramping; IncubatorProtocol? get protocol; AlarmStatus? get alarms; bool get doorOpen; List<String> get errors;
/// Create a copy of IncubatorTelemetry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncubatorTelemetryCopyWith<IncubatorTelemetry> get copyWith => _$IncubatorTelemetryCopyWithImpl<IncubatorTelemetry>(this as IncubatorTelemetry, _$identity);

  /// Serializes this IncubatorTelemetry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncubatorTelemetry&&(identical(other.state, state) || other.state == state)&&(identical(other.uptime, uptime) || other.uptime == uptime)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.co2Level, co2Level) || other.co2Level == co2Level)&&(identical(other.temperatureSetpoint, temperatureSetpoint) || other.temperatureSetpoint == temperatureSetpoint)&&(identical(other.humiditySetpoint, humiditySetpoint) || other.humiditySetpoint == humiditySetpoint)&&(identical(other.co2Setpoint, co2Setpoint) || other.co2Setpoint == co2Setpoint)&&(identical(other.temperatureError, temperatureError) || other.temperatureError == temperatureError)&&(identical(other.humidityError, humidityError) || other.humidityError == humidityError)&&(identical(other.co2Error, co2Error) || other.co2Error == co2Error)&&(identical(other.temperatureStable, temperatureStable) || other.temperatureStable == temperatureStable)&&(identical(other.humidityStable, humidityStable) || other.humidityStable == humidityStable)&&(identical(other.co2Stable, co2Stable) || other.co2Stable == co2Stable)&&(identical(other.environmentStable, environmentStable) || other.environmentStable == environmentStable)&&(identical(other.timeStable, timeStable) || other.timeStable == timeStable)&&(identical(other.ramping, ramping) || other.ramping == ramping)&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.alarms, alarms) || other.alarms == alarms)&&(identical(other.doorOpen, doorOpen) || other.doorOpen == doorOpen)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,state,uptime,temperature,humidity,co2Level,temperatureSetpoint,humiditySetpoint,co2Setpoint,temperatureError,humidityError,co2Error,temperatureStable,humidityStable,co2Stable,environmentStable,timeStable,ramping,protocol,alarms,doorOpen,const DeepCollectionEquality().hash(errors)]);

@override
String toString() {
  return 'IncubatorTelemetry(state: $state, uptime: $uptime, temperature: $temperature, humidity: $humidity, co2Level: $co2Level, temperatureSetpoint: $temperatureSetpoint, humiditySetpoint: $humiditySetpoint, co2Setpoint: $co2Setpoint, temperatureError: $temperatureError, humidityError: $humidityError, co2Error: $co2Error, temperatureStable: $temperatureStable, humidityStable: $humidityStable, co2Stable: $co2Stable, environmentStable: $environmentStable, timeStable: $timeStable, ramping: $ramping, protocol: $protocol, alarms: $alarms, doorOpen: $doorOpen, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $IncubatorTelemetryCopyWith<$Res>  {
  factory $IncubatorTelemetryCopyWith(IncubatorTelemetry value, $Res Function(IncubatorTelemetry) _then) = _$IncubatorTelemetryCopyWithImpl;
@useResult
$Res call({
 DeviceState state, int uptime, double temperature, double humidity, double co2Level, double temperatureSetpoint, double humiditySetpoint, double co2Setpoint, double temperatureError, double humidityError, double co2Error, bool temperatureStable, bool humidityStable, bool co2Stable, bool environmentStable, int timeStable, RampingStatus ramping, IncubatorProtocol? protocol, AlarmStatus? alarms, bool doorOpen, List<String> errors
});


$RampingStatusCopyWith<$Res> get ramping;$IncubatorProtocolCopyWith<$Res>? get protocol;$AlarmStatusCopyWith<$Res>? get alarms;

}
/// @nodoc
class _$IncubatorTelemetryCopyWithImpl<$Res>
    implements $IncubatorTelemetryCopyWith<$Res> {
  _$IncubatorTelemetryCopyWithImpl(this._self, this._then);

  final IncubatorTelemetry _self;
  final $Res Function(IncubatorTelemetry) _then;

/// Create a copy of IncubatorTelemetry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? uptime = null,Object? temperature = null,Object? humidity = null,Object? co2Level = null,Object? temperatureSetpoint = null,Object? humiditySetpoint = null,Object? co2Setpoint = null,Object? temperatureError = null,Object? humidityError = null,Object? co2Error = null,Object? temperatureStable = null,Object? humidityStable = null,Object? co2Stable = null,Object? environmentStable = null,Object? timeStable = null,Object? ramping = null,Object? protocol = freezed,Object? alarms = freezed,Object? doorOpen = null,Object? errors = null,}) {
  return _then(_self.copyWith(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as DeviceState,uptime: null == uptime ? _self.uptime : uptime // ignore: cast_nullable_to_non_nullable
as int,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double,co2Level: null == co2Level ? _self.co2Level : co2Level // ignore: cast_nullable_to_non_nullable
as double,temperatureSetpoint: null == temperatureSetpoint ? _self.temperatureSetpoint : temperatureSetpoint // ignore: cast_nullable_to_non_nullable
as double,humiditySetpoint: null == humiditySetpoint ? _self.humiditySetpoint : humiditySetpoint // ignore: cast_nullable_to_non_nullable
as double,co2Setpoint: null == co2Setpoint ? _self.co2Setpoint : co2Setpoint // ignore: cast_nullable_to_non_nullable
as double,temperatureError: null == temperatureError ? _self.temperatureError : temperatureError // ignore: cast_nullable_to_non_nullable
as double,humidityError: null == humidityError ? _self.humidityError : humidityError // ignore: cast_nullable_to_non_nullable
as double,co2Error: null == co2Error ? _self.co2Error : co2Error // ignore: cast_nullable_to_non_nullable
as double,temperatureStable: null == temperatureStable ? _self.temperatureStable : temperatureStable // ignore: cast_nullable_to_non_nullable
as bool,humidityStable: null == humidityStable ? _self.humidityStable : humidityStable // ignore: cast_nullable_to_non_nullable
as bool,co2Stable: null == co2Stable ? _self.co2Stable : co2Stable // ignore: cast_nullable_to_non_nullable
as bool,environmentStable: null == environmentStable ? _self.environmentStable : environmentStable // ignore: cast_nullable_to_non_nullable
as bool,timeStable: null == timeStable ? _self.timeStable : timeStable // ignore: cast_nullable_to_non_nullable
as int,ramping: null == ramping ? _self.ramping : ramping // ignore: cast_nullable_to_non_nullable
as RampingStatus,protocol: freezed == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as IncubatorProtocol?,alarms: freezed == alarms ? _self.alarms : alarms // ignore: cast_nullable_to_non_nullable
as AlarmStatus?,doorOpen: null == doorOpen ? _self.doorOpen : doorOpen // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of IncubatorTelemetry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RampingStatusCopyWith<$Res> get ramping {
  
  return $RampingStatusCopyWith<$Res>(_self.ramping, (value) {
    return _then(_self.copyWith(ramping: value));
  });
}/// Create a copy of IncubatorTelemetry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IncubatorProtocolCopyWith<$Res>? get protocol {
    if (_self.protocol == null) {
    return null;
  }

  return $IncubatorProtocolCopyWith<$Res>(_self.protocol!, (value) {
    return _then(_self.copyWith(protocol: value));
  });
}/// Create a copy of IncubatorTelemetry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlarmStatusCopyWith<$Res>? get alarms {
    if (_self.alarms == null) {
    return null;
  }

  return $AlarmStatusCopyWith<$Res>(_self.alarms!, (value) {
    return _then(_self.copyWith(alarms: value));
  });
}
}


/// Adds pattern-matching-related methods to [IncubatorTelemetry].
extension IncubatorTelemetryPatterns on IncubatorTelemetry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncubatorTelemetry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncubatorTelemetry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncubatorTelemetry value)  $default,){
final _that = this;
switch (_that) {
case _IncubatorTelemetry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncubatorTelemetry value)?  $default,){
final _that = this;
switch (_that) {
case _IncubatorTelemetry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DeviceState state,  int uptime,  double temperature,  double humidity,  double co2Level,  double temperatureSetpoint,  double humiditySetpoint,  double co2Setpoint,  double temperatureError,  double humidityError,  double co2Error,  bool temperatureStable,  bool humidityStable,  bool co2Stable,  bool environmentStable,  int timeStable,  RampingStatus ramping,  IncubatorProtocol? protocol,  AlarmStatus? alarms,  bool doorOpen,  List<String> errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncubatorTelemetry() when $default != null:
return $default(_that.state,_that.uptime,_that.temperature,_that.humidity,_that.co2Level,_that.temperatureSetpoint,_that.humiditySetpoint,_that.co2Setpoint,_that.temperatureError,_that.humidityError,_that.co2Error,_that.temperatureStable,_that.humidityStable,_that.co2Stable,_that.environmentStable,_that.timeStable,_that.ramping,_that.protocol,_that.alarms,_that.doorOpen,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DeviceState state,  int uptime,  double temperature,  double humidity,  double co2Level,  double temperatureSetpoint,  double humiditySetpoint,  double co2Setpoint,  double temperatureError,  double humidityError,  double co2Error,  bool temperatureStable,  bool humidityStable,  bool co2Stable,  bool environmentStable,  int timeStable,  RampingStatus ramping,  IncubatorProtocol? protocol,  AlarmStatus? alarms,  bool doorOpen,  List<String> errors)  $default,) {final _that = this;
switch (_that) {
case _IncubatorTelemetry():
return $default(_that.state,_that.uptime,_that.temperature,_that.humidity,_that.co2Level,_that.temperatureSetpoint,_that.humiditySetpoint,_that.co2Setpoint,_that.temperatureError,_that.humidityError,_that.co2Error,_that.temperatureStable,_that.humidityStable,_that.co2Stable,_that.environmentStable,_that.timeStable,_that.ramping,_that.protocol,_that.alarms,_that.doorOpen,_that.errors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DeviceState state,  int uptime,  double temperature,  double humidity,  double co2Level,  double temperatureSetpoint,  double humiditySetpoint,  double co2Setpoint,  double temperatureError,  double humidityError,  double co2Error,  bool temperatureStable,  bool humidityStable,  bool co2Stable,  bool environmentStable,  int timeStable,  RampingStatus ramping,  IncubatorProtocol? protocol,  AlarmStatus? alarms,  bool doorOpen,  List<String> errors)?  $default,) {final _that = this;
switch (_that) {
case _IncubatorTelemetry() when $default != null:
return $default(_that.state,_that.uptime,_that.temperature,_that.humidity,_that.co2Level,_that.temperatureSetpoint,_that.humiditySetpoint,_that.co2Setpoint,_that.temperatureError,_that.humidityError,_that.co2Error,_that.temperatureStable,_that.humidityStable,_that.co2Stable,_that.environmentStable,_that.timeStable,_that.ramping,_that.protocol,_that.alarms,_that.doorOpen,_that.errors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IncubatorTelemetry implements IncubatorTelemetry {
  const _IncubatorTelemetry({required this.state, required this.uptime, required this.temperature, required this.humidity, required this.co2Level, required this.temperatureSetpoint, required this.humiditySetpoint, required this.co2Setpoint, required this.temperatureError, required this.humidityError, required this.co2Error, required this.temperatureStable, required this.humidityStable, required this.co2Stable, required this.environmentStable, required this.timeStable, required this.ramping, this.protocol, this.alarms, required this.doorOpen, final  List<String> errors = const []}): _errors = errors;
  factory _IncubatorTelemetry.fromJson(Map<String, dynamic> json) => _$IncubatorTelemetryFromJson(json);

@override final  DeviceState state;
@override final  int uptime;
@override final  double temperature;
@override final  double humidity;
@override final  double co2Level;
@override final  double temperatureSetpoint;
@override final  double humiditySetpoint;
@override final  double co2Setpoint;
@override final  double temperatureError;
@override final  double humidityError;
@override final  double co2Error;
@override final  bool temperatureStable;
@override final  bool humidityStable;
@override final  bool co2Stable;
@override final  bool environmentStable;
@override final  int timeStable;
@override final  RampingStatus ramping;
@override final  IncubatorProtocol? protocol;
@override final  AlarmStatus? alarms;
@override final  bool doorOpen;
 final  List<String> _errors;
@override@JsonKey() List<String> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}


/// Create a copy of IncubatorTelemetry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncubatorTelemetryCopyWith<_IncubatorTelemetry> get copyWith => __$IncubatorTelemetryCopyWithImpl<_IncubatorTelemetry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IncubatorTelemetryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncubatorTelemetry&&(identical(other.state, state) || other.state == state)&&(identical(other.uptime, uptime) || other.uptime == uptime)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.co2Level, co2Level) || other.co2Level == co2Level)&&(identical(other.temperatureSetpoint, temperatureSetpoint) || other.temperatureSetpoint == temperatureSetpoint)&&(identical(other.humiditySetpoint, humiditySetpoint) || other.humiditySetpoint == humiditySetpoint)&&(identical(other.co2Setpoint, co2Setpoint) || other.co2Setpoint == co2Setpoint)&&(identical(other.temperatureError, temperatureError) || other.temperatureError == temperatureError)&&(identical(other.humidityError, humidityError) || other.humidityError == humidityError)&&(identical(other.co2Error, co2Error) || other.co2Error == co2Error)&&(identical(other.temperatureStable, temperatureStable) || other.temperatureStable == temperatureStable)&&(identical(other.humidityStable, humidityStable) || other.humidityStable == humidityStable)&&(identical(other.co2Stable, co2Stable) || other.co2Stable == co2Stable)&&(identical(other.environmentStable, environmentStable) || other.environmentStable == environmentStable)&&(identical(other.timeStable, timeStable) || other.timeStable == timeStable)&&(identical(other.ramping, ramping) || other.ramping == ramping)&&(identical(other.protocol, protocol) || other.protocol == protocol)&&(identical(other.alarms, alarms) || other.alarms == alarms)&&(identical(other.doorOpen, doorOpen) || other.doorOpen == doorOpen)&&const DeepCollectionEquality().equals(other._errors, _errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,state,uptime,temperature,humidity,co2Level,temperatureSetpoint,humiditySetpoint,co2Setpoint,temperatureError,humidityError,co2Error,temperatureStable,humidityStable,co2Stable,environmentStable,timeStable,ramping,protocol,alarms,doorOpen,const DeepCollectionEquality().hash(_errors)]);

@override
String toString() {
  return 'IncubatorTelemetry(state: $state, uptime: $uptime, temperature: $temperature, humidity: $humidity, co2Level: $co2Level, temperatureSetpoint: $temperatureSetpoint, humiditySetpoint: $humiditySetpoint, co2Setpoint: $co2Setpoint, temperatureError: $temperatureError, humidityError: $humidityError, co2Error: $co2Error, temperatureStable: $temperatureStable, humidityStable: $humidityStable, co2Stable: $co2Stable, environmentStable: $environmentStable, timeStable: $timeStable, ramping: $ramping, protocol: $protocol, alarms: $alarms, doorOpen: $doorOpen, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$IncubatorTelemetryCopyWith<$Res> implements $IncubatorTelemetryCopyWith<$Res> {
  factory _$IncubatorTelemetryCopyWith(_IncubatorTelemetry value, $Res Function(_IncubatorTelemetry) _then) = __$IncubatorTelemetryCopyWithImpl;
@override @useResult
$Res call({
 DeviceState state, int uptime, double temperature, double humidity, double co2Level, double temperatureSetpoint, double humiditySetpoint, double co2Setpoint, double temperatureError, double humidityError, double co2Error, bool temperatureStable, bool humidityStable, bool co2Stable, bool environmentStable, int timeStable, RampingStatus ramping, IncubatorProtocol? protocol, AlarmStatus? alarms, bool doorOpen, List<String> errors
});


@override $RampingStatusCopyWith<$Res> get ramping;@override $IncubatorProtocolCopyWith<$Res>? get protocol;@override $AlarmStatusCopyWith<$Res>? get alarms;

}
/// @nodoc
class __$IncubatorTelemetryCopyWithImpl<$Res>
    implements _$IncubatorTelemetryCopyWith<$Res> {
  __$IncubatorTelemetryCopyWithImpl(this._self, this._then);

  final _IncubatorTelemetry _self;
  final $Res Function(_IncubatorTelemetry) _then;

/// Create a copy of IncubatorTelemetry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? uptime = null,Object? temperature = null,Object? humidity = null,Object? co2Level = null,Object? temperatureSetpoint = null,Object? humiditySetpoint = null,Object? co2Setpoint = null,Object? temperatureError = null,Object? humidityError = null,Object? co2Error = null,Object? temperatureStable = null,Object? humidityStable = null,Object? co2Stable = null,Object? environmentStable = null,Object? timeStable = null,Object? ramping = null,Object? protocol = freezed,Object? alarms = freezed,Object? doorOpen = null,Object? errors = null,}) {
  return _then(_IncubatorTelemetry(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as DeviceState,uptime: null == uptime ? _self.uptime : uptime // ignore: cast_nullable_to_non_nullable
as int,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as double,co2Level: null == co2Level ? _self.co2Level : co2Level // ignore: cast_nullable_to_non_nullable
as double,temperatureSetpoint: null == temperatureSetpoint ? _self.temperatureSetpoint : temperatureSetpoint // ignore: cast_nullable_to_non_nullable
as double,humiditySetpoint: null == humiditySetpoint ? _self.humiditySetpoint : humiditySetpoint // ignore: cast_nullable_to_non_nullable
as double,co2Setpoint: null == co2Setpoint ? _self.co2Setpoint : co2Setpoint // ignore: cast_nullable_to_non_nullable
as double,temperatureError: null == temperatureError ? _self.temperatureError : temperatureError // ignore: cast_nullable_to_non_nullable
as double,humidityError: null == humidityError ? _self.humidityError : humidityError // ignore: cast_nullable_to_non_nullable
as double,co2Error: null == co2Error ? _self.co2Error : co2Error // ignore: cast_nullable_to_non_nullable
as double,temperatureStable: null == temperatureStable ? _self.temperatureStable : temperatureStable // ignore: cast_nullable_to_non_nullable
as bool,humidityStable: null == humidityStable ? _self.humidityStable : humidityStable // ignore: cast_nullable_to_non_nullable
as bool,co2Stable: null == co2Stable ? _self.co2Stable : co2Stable // ignore: cast_nullable_to_non_nullable
as bool,environmentStable: null == environmentStable ? _self.environmentStable : environmentStable // ignore: cast_nullable_to_non_nullable
as bool,timeStable: null == timeStable ? _self.timeStable : timeStable // ignore: cast_nullable_to_non_nullable
as int,ramping: null == ramping ? _self.ramping : ramping // ignore: cast_nullable_to_non_nullable
as RampingStatus,protocol: freezed == protocol ? _self.protocol : protocol // ignore: cast_nullable_to_non_nullable
as IncubatorProtocol?,alarms: freezed == alarms ? _self.alarms : alarms // ignore: cast_nullable_to_non_nullable
as AlarmStatus?,doorOpen: null == doorOpen ? _self.doorOpen : doorOpen // ignore: cast_nullable_to_non_nullable
as bool,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of IncubatorTelemetry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RampingStatusCopyWith<$Res> get ramping {
  
  return $RampingStatusCopyWith<$Res>(_self.ramping, (value) {
    return _then(_self.copyWith(ramping: value));
  });
}/// Create a copy of IncubatorTelemetry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IncubatorProtocolCopyWith<$Res>? get protocol {
    if (_self.protocol == null) {
    return null;
  }

  return $IncubatorProtocolCopyWith<$Res>(_self.protocol!, (value) {
    return _then(_self.copyWith(protocol: value));
  });
}/// Create a copy of IncubatorTelemetry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AlarmStatusCopyWith<$Res>? get alarms {
    if (_self.alarms == null) {
    return null;
  }

  return $AlarmStatusCopyWith<$Res>(_self.alarms!, (value) {
    return _then(_self.copyWith(alarms: value));
  });
}
}


/// @nodoc
mixin _$RampingStatus {

 bool get temperature; bool get humidity; bool get co2;
/// Create a copy of RampingStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RampingStatusCopyWith<RampingStatus> get copyWith => _$RampingStatusCopyWithImpl<RampingStatus>(this as RampingStatus, _$identity);

  /// Serializes this RampingStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RampingStatus&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.co2, co2) || other.co2 == co2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,temperature,humidity,co2);

@override
String toString() {
  return 'RampingStatus(temperature: $temperature, humidity: $humidity, co2: $co2)';
}


}

/// @nodoc
abstract mixin class $RampingStatusCopyWith<$Res>  {
  factory $RampingStatusCopyWith(RampingStatus value, $Res Function(RampingStatus) _then) = _$RampingStatusCopyWithImpl;
@useResult
$Res call({
 bool temperature, bool humidity, bool co2
});




}
/// @nodoc
class _$RampingStatusCopyWithImpl<$Res>
    implements $RampingStatusCopyWith<$Res> {
  _$RampingStatusCopyWithImpl(this._self, this._then);

  final RampingStatus _self;
  final $Res Function(RampingStatus) _then;

/// Create a copy of RampingStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? temperature = null,Object? humidity = null,Object? co2 = null,}) {
  return _then(_self.copyWith(
temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as bool,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as bool,co2: null == co2 ? _self.co2 : co2 // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RampingStatus].
extension RampingStatusPatterns on RampingStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RampingStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RampingStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RampingStatus value)  $default,){
final _that = this;
switch (_that) {
case _RampingStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RampingStatus value)?  $default,){
final _that = this;
switch (_that) {
case _RampingStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool temperature,  bool humidity,  bool co2)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RampingStatus() when $default != null:
return $default(_that.temperature,_that.humidity,_that.co2);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool temperature,  bool humidity,  bool co2)  $default,) {final _that = this;
switch (_that) {
case _RampingStatus():
return $default(_that.temperature,_that.humidity,_that.co2);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool temperature,  bool humidity,  bool co2)?  $default,) {final _that = this;
switch (_that) {
case _RampingStatus() when $default != null:
return $default(_that.temperature,_that.humidity,_that.co2);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RampingStatus implements RampingStatus {
  const _RampingStatus({required this.temperature, required this.humidity, required this.co2});
  factory _RampingStatus.fromJson(Map<String, dynamic> json) => _$RampingStatusFromJson(json);

@override final  bool temperature;
@override final  bool humidity;
@override final  bool co2;

/// Create a copy of RampingStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RampingStatusCopyWith<_RampingStatus> get copyWith => __$RampingStatusCopyWithImpl<_RampingStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RampingStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RampingStatus&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.co2, co2) || other.co2 == co2));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,temperature,humidity,co2);

@override
String toString() {
  return 'RampingStatus(temperature: $temperature, humidity: $humidity, co2: $co2)';
}


}

/// @nodoc
abstract mixin class _$RampingStatusCopyWith<$Res> implements $RampingStatusCopyWith<$Res> {
  factory _$RampingStatusCopyWith(_RampingStatus value, $Res Function(_RampingStatus) _then) = __$RampingStatusCopyWithImpl;
@override @useResult
$Res call({
 bool temperature, bool humidity, bool co2
});




}
/// @nodoc
class __$RampingStatusCopyWithImpl<$Res>
    implements _$RampingStatusCopyWith<$Res> {
  __$RampingStatusCopyWithImpl(this._self, this._then);

  final _RampingStatus _self;
  final $Res Function(_RampingStatus) _then;

/// Create a copy of RampingStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? temperature = null,Object? humidity = null,Object? co2 = null,}) {
  return _then(_RampingStatus(
temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as bool,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as bool,co2: null == co2 ? _self.co2 : co2 // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$IncubatorProtocol {

 ProtocolState get state; String get name; int get type; int get currentStage; int get totalStages; String get stageName; int get stageTimeRemaining; double get progress;
/// Create a copy of IncubatorProtocol
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IncubatorProtocolCopyWith<IncubatorProtocol> get copyWith => _$IncubatorProtocolCopyWithImpl<IncubatorProtocol>(this as IncubatorProtocol, _$identity);

  /// Serializes this IncubatorProtocol to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IncubatorProtocol&&(identical(other.state, state) || other.state == state)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.currentStage, currentStage) || other.currentStage == currentStage)&&(identical(other.totalStages, totalStages) || other.totalStages == totalStages)&&(identical(other.stageName, stageName) || other.stageName == stageName)&&(identical(other.stageTimeRemaining, stageTimeRemaining) || other.stageTimeRemaining == stageTimeRemaining)&&(identical(other.progress, progress) || other.progress == progress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,state,name,type,currentStage,totalStages,stageName,stageTimeRemaining,progress);

@override
String toString() {
  return 'IncubatorProtocol(state: $state, name: $name, type: $type, currentStage: $currentStage, totalStages: $totalStages, stageName: $stageName, stageTimeRemaining: $stageTimeRemaining, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $IncubatorProtocolCopyWith<$Res>  {
  factory $IncubatorProtocolCopyWith(IncubatorProtocol value, $Res Function(IncubatorProtocol) _then) = _$IncubatorProtocolCopyWithImpl;
@useResult
$Res call({
 ProtocolState state, String name, int type, int currentStage, int totalStages, String stageName, int stageTimeRemaining, double progress
});




}
/// @nodoc
class _$IncubatorProtocolCopyWithImpl<$Res>
    implements $IncubatorProtocolCopyWith<$Res> {
  _$IncubatorProtocolCopyWithImpl(this._self, this._then);

  final IncubatorProtocol _self;
  final $Res Function(IncubatorProtocol) _then;

/// Create a copy of IncubatorProtocol
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? name = null,Object? type = null,Object? currentStage = null,Object? totalStages = null,Object? stageName = null,Object? stageTimeRemaining = null,Object? progress = null,}) {
  return _then(_self.copyWith(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as ProtocolState,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,currentStage: null == currentStage ? _self.currentStage : currentStage // ignore: cast_nullable_to_non_nullable
as int,totalStages: null == totalStages ? _self.totalStages : totalStages // ignore: cast_nullable_to_non_nullable
as int,stageName: null == stageName ? _self.stageName : stageName // ignore: cast_nullable_to_non_nullable
as String,stageTimeRemaining: null == stageTimeRemaining ? _self.stageTimeRemaining : stageTimeRemaining // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [IncubatorProtocol].
extension IncubatorProtocolPatterns on IncubatorProtocol {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IncubatorProtocol value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IncubatorProtocol() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IncubatorProtocol value)  $default,){
final _that = this;
switch (_that) {
case _IncubatorProtocol():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IncubatorProtocol value)?  $default,){
final _that = this;
switch (_that) {
case _IncubatorProtocol() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProtocolState state,  String name,  int type,  int currentStage,  int totalStages,  String stageName,  int stageTimeRemaining,  double progress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IncubatorProtocol() when $default != null:
return $default(_that.state,_that.name,_that.type,_that.currentStage,_that.totalStages,_that.stageName,_that.stageTimeRemaining,_that.progress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProtocolState state,  String name,  int type,  int currentStage,  int totalStages,  String stageName,  int stageTimeRemaining,  double progress)  $default,) {final _that = this;
switch (_that) {
case _IncubatorProtocol():
return $default(_that.state,_that.name,_that.type,_that.currentStage,_that.totalStages,_that.stageName,_that.stageTimeRemaining,_that.progress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProtocolState state,  String name,  int type,  int currentStage,  int totalStages,  String stageName,  int stageTimeRemaining,  double progress)?  $default,) {final _that = this;
switch (_that) {
case _IncubatorProtocol() when $default != null:
return $default(_that.state,_that.name,_that.type,_that.currentStage,_that.totalStages,_that.stageName,_that.stageTimeRemaining,_that.progress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IncubatorProtocol implements IncubatorProtocol {
  const _IncubatorProtocol({required this.state, required this.name, required this.type, required this.currentStage, required this.totalStages, required this.stageName, required this.stageTimeRemaining, required this.progress});
  factory _IncubatorProtocol.fromJson(Map<String, dynamic> json) => _$IncubatorProtocolFromJson(json);

@override final  ProtocolState state;
@override final  String name;
@override final  int type;
@override final  int currentStage;
@override final  int totalStages;
@override final  String stageName;
@override final  int stageTimeRemaining;
@override final  double progress;

/// Create a copy of IncubatorProtocol
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IncubatorProtocolCopyWith<_IncubatorProtocol> get copyWith => __$IncubatorProtocolCopyWithImpl<_IncubatorProtocol>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IncubatorProtocolToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IncubatorProtocol&&(identical(other.state, state) || other.state == state)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.currentStage, currentStage) || other.currentStage == currentStage)&&(identical(other.totalStages, totalStages) || other.totalStages == totalStages)&&(identical(other.stageName, stageName) || other.stageName == stageName)&&(identical(other.stageTimeRemaining, stageTimeRemaining) || other.stageTimeRemaining == stageTimeRemaining)&&(identical(other.progress, progress) || other.progress == progress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,state,name,type,currentStage,totalStages,stageName,stageTimeRemaining,progress);

@override
String toString() {
  return 'IncubatorProtocol(state: $state, name: $name, type: $type, currentStage: $currentStage, totalStages: $totalStages, stageName: $stageName, stageTimeRemaining: $stageTimeRemaining, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$IncubatorProtocolCopyWith<$Res> implements $IncubatorProtocolCopyWith<$Res> {
  factory _$IncubatorProtocolCopyWith(_IncubatorProtocol value, $Res Function(_IncubatorProtocol) _then) = __$IncubatorProtocolCopyWithImpl;
@override @useResult
$Res call({
 ProtocolState state, String name, int type, int currentStage, int totalStages, String stageName, int stageTimeRemaining, double progress
});




}
/// @nodoc
class __$IncubatorProtocolCopyWithImpl<$Res>
    implements _$IncubatorProtocolCopyWith<$Res> {
  __$IncubatorProtocolCopyWithImpl(this._self, this._then);

  final _IncubatorProtocol _self;
  final $Res Function(_IncubatorProtocol) _then;

/// Create a copy of IncubatorProtocol
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? name = null,Object? type = null,Object? currentStage = null,Object? totalStages = null,Object? stageName = null,Object? stageTimeRemaining = null,Object? progress = null,}) {
  return _then(_IncubatorProtocol(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as ProtocolState,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int,currentStage: null == currentStage ? _self.currentStage : currentStage // ignore: cast_nullable_to_non_nullable
as int,totalStages: null == totalStages ? _self.totalStages : totalStages // ignore: cast_nullable_to_non_nullable
as int,stageName: null == stageName ? _self.stageName : stageName // ignore: cast_nullable_to_non_nullable
as String,stageTimeRemaining: null == stageTimeRemaining ? _self.stageTimeRemaining : stageTimeRemaining // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$AlarmStatus {

 int get activeCount; bool get hasCritical; List<AlarmData> get active;
/// Create a copy of AlarmStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlarmStatusCopyWith<AlarmStatus> get copyWith => _$AlarmStatusCopyWithImpl<AlarmStatus>(this as AlarmStatus, _$identity);

  /// Serializes this AlarmStatus to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlarmStatus&&(identical(other.activeCount, activeCount) || other.activeCount == activeCount)&&(identical(other.hasCritical, hasCritical) || other.hasCritical == hasCritical)&&const DeepCollectionEquality().equals(other.active, active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activeCount,hasCritical,const DeepCollectionEquality().hash(active));

@override
String toString() {
  return 'AlarmStatus(activeCount: $activeCount, hasCritical: $hasCritical, active: $active)';
}


}

/// @nodoc
abstract mixin class $AlarmStatusCopyWith<$Res>  {
  factory $AlarmStatusCopyWith(AlarmStatus value, $Res Function(AlarmStatus) _then) = _$AlarmStatusCopyWithImpl;
@useResult
$Res call({
 int activeCount, bool hasCritical, List<AlarmData> active
});




}
/// @nodoc
class _$AlarmStatusCopyWithImpl<$Res>
    implements $AlarmStatusCopyWith<$Res> {
  _$AlarmStatusCopyWithImpl(this._self, this._then);

  final AlarmStatus _self;
  final $Res Function(AlarmStatus) _then;

/// Create a copy of AlarmStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeCount = null,Object? hasCritical = null,Object? active = null,}) {
  return _then(_self.copyWith(
activeCount: null == activeCount ? _self.activeCount : activeCount // ignore: cast_nullable_to_non_nullable
as int,hasCritical: null == hasCritical ? _self.hasCritical : hasCritical // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self.active : active // ignore: cast_nullable_to_non_nullable
as List<AlarmData>,
  ));
}

}


/// Adds pattern-matching-related methods to [AlarmStatus].
extension AlarmStatusPatterns on AlarmStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlarmStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlarmStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlarmStatus value)  $default,){
final _that = this;
switch (_that) {
case _AlarmStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlarmStatus value)?  $default,){
final _that = this;
switch (_that) {
case _AlarmStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int activeCount,  bool hasCritical,  List<AlarmData> active)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlarmStatus() when $default != null:
return $default(_that.activeCount,_that.hasCritical,_that.active);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int activeCount,  bool hasCritical,  List<AlarmData> active)  $default,) {final _that = this;
switch (_that) {
case _AlarmStatus():
return $default(_that.activeCount,_that.hasCritical,_that.active);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int activeCount,  bool hasCritical,  List<AlarmData> active)?  $default,) {final _that = this;
switch (_that) {
case _AlarmStatus() when $default != null:
return $default(_that.activeCount,_that.hasCritical,_that.active);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlarmStatus implements AlarmStatus {
  const _AlarmStatus({required this.activeCount, required this.hasCritical, required final  List<AlarmData> active}): _active = active;
  factory _AlarmStatus.fromJson(Map<String, dynamic> json) => _$AlarmStatusFromJson(json);

@override final  int activeCount;
@override final  bool hasCritical;
 final  List<AlarmData> _active;
@override List<AlarmData> get active {
  if (_active is EqualUnmodifiableListView) return _active;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_active);
}


/// Create a copy of AlarmStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlarmStatusCopyWith<_AlarmStatus> get copyWith => __$AlarmStatusCopyWithImpl<_AlarmStatus>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlarmStatusToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlarmStatus&&(identical(other.activeCount, activeCount) || other.activeCount == activeCount)&&(identical(other.hasCritical, hasCritical) || other.hasCritical == hasCritical)&&const DeepCollectionEquality().equals(other._active, _active));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activeCount,hasCritical,const DeepCollectionEquality().hash(_active));

@override
String toString() {
  return 'AlarmStatus(activeCount: $activeCount, hasCritical: $hasCritical, active: $active)';
}


}

/// @nodoc
abstract mixin class _$AlarmStatusCopyWith<$Res> implements $AlarmStatusCopyWith<$Res> {
  factory _$AlarmStatusCopyWith(_AlarmStatus value, $Res Function(_AlarmStatus) _then) = __$AlarmStatusCopyWithImpl;
@override @useResult
$Res call({
 int activeCount, bool hasCritical, List<AlarmData> active
});




}
/// @nodoc
class __$AlarmStatusCopyWithImpl<$Res>
    implements _$AlarmStatusCopyWith<$Res> {
  __$AlarmStatusCopyWithImpl(this._self, this._then);

  final _AlarmStatus _self;
  final $Res Function(_AlarmStatus) _then;

/// Create a copy of AlarmStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeCount = null,Object? hasCritical = null,Object? active = null,}) {
  return _then(_AlarmStatus(
activeCount: null == activeCount ? _self.activeCount : activeCount // ignore: cast_nullable_to_non_nullable
as int,hasCritical: null == hasCritical ? _self.hasCritical : hasCritical // ignore: cast_nullable_to_non_nullable
as bool,active: null == active ? _self._active : active // ignore: cast_nullable_to_non_nullable
as List<AlarmData>,
  ));
}


}


/// @nodoc
mixin _$AlarmData {

 AlarmType get type; AlarmSeverity get severity; String get message; int get timestamp; bool get acknowledged; double get currentValue; double get threshold;
/// Create a copy of AlarmData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlarmDataCopyWith<AlarmData> get copyWith => _$AlarmDataCopyWithImpl<AlarmData>(this as AlarmData, _$identity);

  /// Serializes this AlarmData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlarmData&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.message, message) || other.message == message)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.threshold, threshold) || other.threshold == threshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,severity,message,timestamp,acknowledged,currentValue,threshold);

@override
String toString() {
  return 'AlarmData(type: $type, severity: $severity, message: $message, timestamp: $timestamp, acknowledged: $acknowledged, currentValue: $currentValue, threshold: $threshold)';
}


}

/// @nodoc
abstract mixin class $AlarmDataCopyWith<$Res>  {
  factory $AlarmDataCopyWith(AlarmData value, $Res Function(AlarmData) _then) = _$AlarmDataCopyWithImpl;
@useResult
$Res call({
 AlarmType type, AlarmSeverity severity, String message, int timestamp, bool acknowledged, double currentValue, double threshold
});




}
/// @nodoc
class _$AlarmDataCopyWithImpl<$Res>
    implements $AlarmDataCopyWith<$Res> {
  _$AlarmDataCopyWithImpl(this._self, this._then);

  final AlarmData _self;
  final $Res Function(AlarmData) _then;

/// Create a copy of AlarmData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? severity = null,Object? message = null,Object? timestamp = null,Object? acknowledged = null,Object? currentValue = null,Object? threshold = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AlarmType,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as AlarmSeverity,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,acknowledged: null == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as bool,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AlarmData].
extension AlarmDataPatterns on AlarmData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlarmData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlarmData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlarmData value)  $default,){
final _that = this;
switch (_that) {
case _AlarmData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlarmData value)?  $default,){
final _that = this;
switch (_that) {
case _AlarmData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AlarmType type,  AlarmSeverity severity,  String message,  int timestamp,  bool acknowledged,  double currentValue,  double threshold)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlarmData() when $default != null:
return $default(_that.type,_that.severity,_that.message,_that.timestamp,_that.acknowledged,_that.currentValue,_that.threshold);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AlarmType type,  AlarmSeverity severity,  String message,  int timestamp,  bool acknowledged,  double currentValue,  double threshold)  $default,) {final _that = this;
switch (_that) {
case _AlarmData():
return $default(_that.type,_that.severity,_that.message,_that.timestamp,_that.acknowledged,_that.currentValue,_that.threshold);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AlarmType type,  AlarmSeverity severity,  String message,  int timestamp,  bool acknowledged,  double currentValue,  double threshold)?  $default,) {final _that = this;
switch (_that) {
case _AlarmData() when $default != null:
return $default(_that.type,_that.severity,_that.message,_that.timestamp,_that.acknowledged,_that.currentValue,_that.threshold);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AlarmData implements AlarmData {
  const _AlarmData({required this.type, required this.severity, required this.message, required this.timestamp, required this.acknowledged, required this.currentValue, required this.threshold});
  factory _AlarmData.fromJson(Map<String, dynamic> json) => _$AlarmDataFromJson(json);

@override final  AlarmType type;
@override final  AlarmSeverity severity;
@override final  String message;
@override final  int timestamp;
@override final  bool acknowledged;
@override final  double currentValue;
@override final  double threshold;

/// Create a copy of AlarmData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlarmDataCopyWith<_AlarmData> get copyWith => __$AlarmDataCopyWithImpl<_AlarmData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AlarmDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlarmData&&(identical(other.type, type) || other.type == type)&&(identical(other.severity, severity) || other.severity == severity)&&(identical(other.message, message) || other.message == message)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.acknowledged, acknowledged) || other.acknowledged == acknowledged)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.threshold, threshold) || other.threshold == threshold));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,severity,message,timestamp,acknowledged,currentValue,threshold);

@override
String toString() {
  return 'AlarmData(type: $type, severity: $severity, message: $message, timestamp: $timestamp, acknowledged: $acknowledged, currentValue: $currentValue, threshold: $threshold)';
}


}

/// @nodoc
abstract mixin class _$AlarmDataCopyWith<$Res> implements $AlarmDataCopyWith<$Res> {
  factory _$AlarmDataCopyWith(_AlarmData value, $Res Function(_AlarmData) _then) = __$AlarmDataCopyWithImpl;
@override @useResult
$Res call({
 AlarmType type, AlarmSeverity severity, String message, int timestamp, bool acknowledged, double currentValue, double threshold
});




}
/// @nodoc
class __$AlarmDataCopyWithImpl<$Res>
    implements _$AlarmDataCopyWith<$Res> {
  __$AlarmDataCopyWithImpl(this._self, this._then);

  final _AlarmData _self;
  final $Res Function(_AlarmData) _then;

/// Create a copy of AlarmData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? severity = null,Object? message = null,Object? timestamp = null,Object? acknowledged = null,Object? currentValue = null,Object? threshold = null,}) {
  return _then(_AlarmData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AlarmType,severity: null == severity ? _self.severity : severity // ignore: cast_nullable_to_non_nullable
as AlarmSeverity,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as int,acknowledged: null == acknowledged ? _self.acknowledged : acknowledged // ignore: cast_nullable_to_non_nullable
as bool,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,threshold: null == threshold ? _self.threshold : threshold // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
