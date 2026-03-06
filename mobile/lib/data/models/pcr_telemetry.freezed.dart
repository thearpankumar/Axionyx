// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pcr_telemetry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PCRTelemetry {

 DeviceState get state; int get uptime; List<double> get temperature; List<double> get setpoint; PCRPhase get currentPhase; int get cycleNumber; int get totalCycles; int get phaseTimeRemaining; int get totalTimeRemaining; double get progress; PCRProgram? get program; PCRMetrics? get metrics; List<String> get errors;
/// Create a copy of PCRTelemetry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PCRTelemetryCopyWith<PCRTelemetry> get copyWith => _$PCRTelemetryCopyWithImpl<PCRTelemetry>(this as PCRTelemetry, _$identity);

  /// Serializes this PCRTelemetry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PCRTelemetry&&(identical(other.state, state) || other.state == state)&&(identical(other.uptime, uptime) || other.uptime == uptime)&&const DeepCollectionEquality().equals(other.temperature, temperature)&&const DeepCollectionEquality().equals(other.setpoint, setpoint)&&(identical(other.currentPhase, currentPhase) || other.currentPhase == currentPhase)&&(identical(other.cycleNumber, cycleNumber) || other.cycleNumber == cycleNumber)&&(identical(other.totalCycles, totalCycles) || other.totalCycles == totalCycles)&&(identical(other.phaseTimeRemaining, phaseTimeRemaining) || other.phaseTimeRemaining == phaseTimeRemaining)&&(identical(other.totalTimeRemaining, totalTimeRemaining) || other.totalTimeRemaining == totalTimeRemaining)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.program, program) || other.program == program)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&const DeepCollectionEquality().equals(other.errors, errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,state,uptime,const DeepCollectionEquality().hash(temperature),const DeepCollectionEquality().hash(setpoint),currentPhase,cycleNumber,totalCycles,phaseTimeRemaining,totalTimeRemaining,progress,program,metrics,const DeepCollectionEquality().hash(errors));

@override
String toString() {
  return 'PCRTelemetry(state: $state, uptime: $uptime, temperature: $temperature, setpoint: $setpoint, currentPhase: $currentPhase, cycleNumber: $cycleNumber, totalCycles: $totalCycles, phaseTimeRemaining: $phaseTimeRemaining, totalTimeRemaining: $totalTimeRemaining, progress: $progress, program: $program, metrics: $metrics, errors: $errors)';
}


}

/// @nodoc
abstract mixin class $PCRTelemetryCopyWith<$Res>  {
  factory $PCRTelemetryCopyWith(PCRTelemetry value, $Res Function(PCRTelemetry) _then) = _$PCRTelemetryCopyWithImpl;
@useResult
$Res call({
 DeviceState state, int uptime, List<double> temperature, List<double> setpoint, PCRPhase currentPhase, int cycleNumber, int totalCycles, int phaseTimeRemaining, int totalTimeRemaining, double progress, PCRProgram? program, PCRMetrics? metrics, List<String> errors
});


$PCRProgramCopyWith<$Res>? get program;$PCRMetricsCopyWith<$Res>? get metrics;

}
/// @nodoc
class _$PCRTelemetryCopyWithImpl<$Res>
    implements $PCRTelemetryCopyWith<$Res> {
  _$PCRTelemetryCopyWithImpl(this._self, this._then);

  final PCRTelemetry _self;
  final $Res Function(PCRTelemetry) _then;

/// Create a copy of PCRTelemetry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? uptime = null,Object? temperature = null,Object? setpoint = null,Object? currentPhase = null,Object? cycleNumber = null,Object? totalCycles = null,Object? phaseTimeRemaining = null,Object? totalTimeRemaining = null,Object? progress = null,Object? program = freezed,Object? metrics = freezed,Object? errors = null,}) {
  return _then(_self.copyWith(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as DeviceState,uptime: null == uptime ? _self.uptime : uptime // ignore: cast_nullable_to_non_nullable
as int,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as List<double>,setpoint: null == setpoint ? _self.setpoint : setpoint // ignore: cast_nullable_to_non_nullable
as List<double>,currentPhase: null == currentPhase ? _self.currentPhase : currentPhase // ignore: cast_nullable_to_non_nullable
as PCRPhase,cycleNumber: null == cycleNumber ? _self.cycleNumber : cycleNumber // ignore: cast_nullable_to_non_nullable
as int,totalCycles: null == totalCycles ? _self.totalCycles : totalCycles // ignore: cast_nullable_to_non_nullable
as int,phaseTimeRemaining: null == phaseTimeRemaining ? _self.phaseTimeRemaining : phaseTimeRemaining // ignore: cast_nullable_to_non_nullable
as int,totalTimeRemaining: null == totalTimeRemaining ? _self.totalTimeRemaining : totalTimeRemaining // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,program: freezed == program ? _self.program : program // ignore: cast_nullable_to_non_nullable
as PCRProgram?,metrics: freezed == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as PCRMetrics?,errors: null == errors ? _self.errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of PCRTelemetry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PCRProgramCopyWith<$Res>? get program {
    if (_self.program == null) {
    return null;
  }

  return $PCRProgramCopyWith<$Res>(_self.program!, (value) {
    return _then(_self.copyWith(program: value));
  });
}/// Create a copy of PCRTelemetry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PCRMetricsCopyWith<$Res>? get metrics {
    if (_self.metrics == null) {
    return null;
  }

  return $PCRMetricsCopyWith<$Res>(_self.metrics!, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [PCRTelemetry].
extension PCRTelemetryPatterns on PCRTelemetry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PCRTelemetry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PCRTelemetry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PCRTelemetry value)  $default,){
final _that = this;
switch (_that) {
case _PCRTelemetry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PCRTelemetry value)?  $default,){
final _that = this;
switch (_that) {
case _PCRTelemetry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DeviceState state,  int uptime,  List<double> temperature,  List<double> setpoint,  PCRPhase currentPhase,  int cycleNumber,  int totalCycles,  int phaseTimeRemaining,  int totalTimeRemaining,  double progress,  PCRProgram? program,  PCRMetrics? metrics,  List<String> errors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PCRTelemetry() when $default != null:
return $default(_that.state,_that.uptime,_that.temperature,_that.setpoint,_that.currentPhase,_that.cycleNumber,_that.totalCycles,_that.phaseTimeRemaining,_that.totalTimeRemaining,_that.progress,_that.program,_that.metrics,_that.errors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DeviceState state,  int uptime,  List<double> temperature,  List<double> setpoint,  PCRPhase currentPhase,  int cycleNumber,  int totalCycles,  int phaseTimeRemaining,  int totalTimeRemaining,  double progress,  PCRProgram? program,  PCRMetrics? metrics,  List<String> errors)  $default,) {final _that = this;
switch (_that) {
case _PCRTelemetry():
return $default(_that.state,_that.uptime,_that.temperature,_that.setpoint,_that.currentPhase,_that.cycleNumber,_that.totalCycles,_that.phaseTimeRemaining,_that.totalTimeRemaining,_that.progress,_that.program,_that.metrics,_that.errors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DeviceState state,  int uptime,  List<double> temperature,  List<double> setpoint,  PCRPhase currentPhase,  int cycleNumber,  int totalCycles,  int phaseTimeRemaining,  int totalTimeRemaining,  double progress,  PCRProgram? program,  PCRMetrics? metrics,  List<String> errors)?  $default,) {final _that = this;
switch (_that) {
case _PCRTelemetry() when $default != null:
return $default(_that.state,_that.uptime,_that.temperature,_that.setpoint,_that.currentPhase,_that.cycleNumber,_that.totalCycles,_that.phaseTimeRemaining,_that.totalTimeRemaining,_that.progress,_that.program,_that.metrics,_that.errors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PCRTelemetry implements PCRTelemetry {
  const _PCRTelemetry({required this.state, required this.uptime, required final  List<double> temperature, required final  List<double> setpoint, required this.currentPhase, required this.cycleNumber, required this.totalCycles, required this.phaseTimeRemaining, required this.totalTimeRemaining, required this.progress, this.program, this.metrics, final  List<String> errors = const []}): _temperature = temperature,_setpoint = setpoint,_errors = errors;
  factory _PCRTelemetry.fromJson(Map<String, dynamic> json) => _$PCRTelemetryFromJson(json);

@override final  DeviceState state;
@override final  int uptime;
 final  List<double> _temperature;
@override List<double> get temperature {
  if (_temperature is EqualUnmodifiableListView) return _temperature;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_temperature);
}

 final  List<double> _setpoint;
@override List<double> get setpoint {
  if (_setpoint is EqualUnmodifiableListView) return _setpoint;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_setpoint);
}

@override final  PCRPhase currentPhase;
@override final  int cycleNumber;
@override final  int totalCycles;
@override final  int phaseTimeRemaining;
@override final  int totalTimeRemaining;
@override final  double progress;
@override final  PCRProgram? program;
@override final  PCRMetrics? metrics;
 final  List<String> _errors;
@override@JsonKey() List<String> get errors {
  if (_errors is EqualUnmodifiableListView) return _errors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_errors);
}


/// Create a copy of PCRTelemetry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PCRTelemetryCopyWith<_PCRTelemetry> get copyWith => __$PCRTelemetryCopyWithImpl<_PCRTelemetry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PCRTelemetryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PCRTelemetry&&(identical(other.state, state) || other.state == state)&&(identical(other.uptime, uptime) || other.uptime == uptime)&&const DeepCollectionEquality().equals(other._temperature, _temperature)&&const DeepCollectionEquality().equals(other._setpoint, _setpoint)&&(identical(other.currentPhase, currentPhase) || other.currentPhase == currentPhase)&&(identical(other.cycleNumber, cycleNumber) || other.cycleNumber == cycleNumber)&&(identical(other.totalCycles, totalCycles) || other.totalCycles == totalCycles)&&(identical(other.phaseTimeRemaining, phaseTimeRemaining) || other.phaseTimeRemaining == phaseTimeRemaining)&&(identical(other.totalTimeRemaining, totalTimeRemaining) || other.totalTimeRemaining == totalTimeRemaining)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.program, program) || other.program == program)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&const DeepCollectionEquality().equals(other._errors, _errors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,state,uptime,const DeepCollectionEquality().hash(_temperature),const DeepCollectionEquality().hash(_setpoint),currentPhase,cycleNumber,totalCycles,phaseTimeRemaining,totalTimeRemaining,progress,program,metrics,const DeepCollectionEquality().hash(_errors));

@override
String toString() {
  return 'PCRTelemetry(state: $state, uptime: $uptime, temperature: $temperature, setpoint: $setpoint, currentPhase: $currentPhase, cycleNumber: $cycleNumber, totalCycles: $totalCycles, phaseTimeRemaining: $phaseTimeRemaining, totalTimeRemaining: $totalTimeRemaining, progress: $progress, program: $program, metrics: $metrics, errors: $errors)';
}


}

/// @nodoc
abstract mixin class _$PCRTelemetryCopyWith<$Res> implements $PCRTelemetryCopyWith<$Res> {
  factory _$PCRTelemetryCopyWith(_PCRTelemetry value, $Res Function(_PCRTelemetry) _then) = __$PCRTelemetryCopyWithImpl;
@override @useResult
$Res call({
 DeviceState state, int uptime, List<double> temperature, List<double> setpoint, PCRPhase currentPhase, int cycleNumber, int totalCycles, int phaseTimeRemaining, int totalTimeRemaining, double progress, PCRProgram? program, PCRMetrics? metrics, List<String> errors
});


@override $PCRProgramCopyWith<$Res>? get program;@override $PCRMetricsCopyWith<$Res>? get metrics;

}
/// @nodoc
class __$PCRTelemetryCopyWithImpl<$Res>
    implements _$PCRTelemetryCopyWith<$Res> {
  __$PCRTelemetryCopyWithImpl(this._self, this._then);

  final _PCRTelemetry _self;
  final $Res Function(_PCRTelemetry) _then;

/// Create a copy of PCRTelemetry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? uptime = null,Object? temperature = null,Object? setpoint = null,Object? currentPhase = null,Object? cycleNumber = null,Object? totalCycles = null,Object? phaseTimeRemaining = null,Object? totalTimeRemaining = null,Object? progress = null,Object? program = freezed,Object? metrics = freezed,Object? errors = null,}) {
  return _then(_PCRTelemetry(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as DeviceState,uptime: null == uptime ? _self.uptime : uptime // ignore: cast_nullable_to_non_nullable
as int,temperature: null == temperature ? _self._temperature : temperature // ignore: cast_nullable_to_non_nullable
as List<double>,setpoint: null == setpoint ? _self._setpoint : setpoint // ignore: cast_nullable_to_non_nullable
as List<double>,currentPhase: null == currentPhase ? _self.currentPhase : currentPhase // ignore: cast_nullable_to_non_nullable
as PCRPhase,cycleNumber: null == cycleNumber ? _self.cycleNumber : cycleNumber // ignore: cast_nullable_to_non_nullable
as int,totalCycles: null == totalCycles ? _self.totalCycles : totalCycles // ignore: cast_nullable_to_non_nullable
as int,phaseTimeRemaining: null == phaseTimeRemaining ? _self.phaseTimeRemaining : phaseTimeRemaining // ignore: cast_nullable_to_non_nullable
as int,totalTimeRemaining: null == totalTimeRemaining ? _self.totalTimeRemaining : totalTimeRemaining // ignore: cast_nullable_to_non_nullable
as int,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,program: freezed == program ? _self.program : program // ignore: cast_nullable_to_non_nullable
as PCRProgram?,metrics: freezed == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as PCRMetrics?,errors: null == errors ? _self._errors : errors // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of PCRTelemetry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PCRProgramCopyWith<$Res>? get program {
    if (_self.program == null) {
    return null;
  }

  return $PCRProgramCopyWith<$Res>(_self.program!, (value) {
    return _then(_self.copyWith(program: value));
  });
}/// Create a copy of PCRTelemetry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PCRMetricsCopyWith<$Res>? get metrics {
    if (_self.metrics == null) {
    return null;
  }

  return $PCRMetricsCopyWith<$Res>(_self.metrics!, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// @nodoc
mixin _$PCRProgram {

 String get type; int get cycles; double get denatureTemp; int get denatureTime; double get annealTemp; int get annealTime; double get extendTemp; int get extendTime; bool get twoStepEnabled; double? get annealExtendTemp; int? get annealExtendTime; HotStartConfig? get hotStart; TouchdownConfig? get touchdown; GradientConfig? get gradient;
/// Create a copy of PCRProgram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PCRProgramCopyWith<PCRProgram> get copyWith => _$PCRProgramCopyWithImpl<PCRProgram>(this as PCRProgram, _$identity);

  /// Serializes this PCRProgram to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PCRProgram&&(identical(other.type, type) || other.type == type)&&(identical(other.cycles, cycles) || other.cycles == cycles)&&(identical(other.denatureTemp, denatureTemp) || other.denatureTemp == denatureTemp)&&(identical(other.denatureTime, denatureTime) || other.denatureTime == denatureTime)&&(identical(other.annealTemp, annealTemp) || other.annealTemp == annealTemp)&&(identical(other.annealTime, annealTime) || other.annealTime == annealTime)&&(identical(other.extendTemp, extendTemp) || other.extendTemp == extendTemp)&&(identical(other.extendTime, extendTime) || other.extendTime == extendTime)&&(identical(other.twoStepEnabled, twoStepEnabled) || other.twoStepEnabled == twoStepEnabled)&&(identical(other.annealExtendTemp, annealExtendTemp) || other.annealExtendTemp == annealExtendTemp)&&(identical(other.annealExtendTime, annealExtendTime) || other.annealExtendTime == annealExtendTime)&&(identical(other.hotStart, hotStart) || other.hotStart == hotStart)&&(identical(other.touchdown, touchdown) || other.touchdown == touchdown)&&(identical(other.gradient, gradient) || other.gradient == gradient));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,cycles,denatureTemp,denatureTime,annealTemp,annealTime,extendTemp,extendTime,twoStepEnabled,annealExtendTemp,annealExtendTime,hotStart,touchdown,gradient);

@override
String toString() {
  return 'PCRProgram(type: $type, cycles: $cycles, denatureTemp: $denatureTemp, denatureTime: $denatureTime, annealTemp: $annealTemp, annealTime: $annealTime, extendTemp: $extendTemp, extendTime: $extendTime, twoStepEnabled: $twoStepEnabled, annealExtendTemp: $annealExtendTemp, annealExtendTime: $annealExtendTime, hotStart: $hotStart, touchdown: $touchdown, gradient: $gradient)';
}


}

/// @nodoc
abstract mixin class $PCRProgramCopyWith<$Res>  {
  factory $PCRProgramCopyWith(PCRProgram value, $Res Function(PCRProgram) _then) = _$PCRProgramCopyWithImpl;
@useResult
$Res call({
 String type, int cycles, double denatureTemp, int denatureTime, double annealTemp, int annealTime, double extendTemp, int extendTime, bool twoStepEnabled, double? annealExtendTemp, int? annealExtendTime, HotStartConfig? hotStart, TouchdownConfig? touchdown, GradientConfig? gradient
});


$HotStartConfigCopyWith<$Res>? get hotStart;$TouchdownConfigCopyWith<$Res>? get touchdown;$GradientConfigCopyWith<$Res>? get gradient;

}
/// @nodoc
class _$PCRProgramCopyWithImpl<$Res>
    implements $PCRProgramCopyWith<$Res> {
  _$PCRProgramCopyWithImpl(this._self, this._then);

  final PCRProgram _self;
  final $Res Function(PCRProgram) _then;

/// Create a copy of PCRProgram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? cycles = null,Object? denatureTemp = null,Object? denatureTime = null,Object? annealTemp = null,Object? annealTime = null,Object? extendTemp = null,Object? extendTime = null,Object? twoStepEnabled = null,Object? annealExtendTemp = freezed,Object? annealExtendTime = freezed,Object? hotStart = freezed,Object? touchdown = freezed,Object? gradient = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,cycles: null == cycles ? _self.cycles : cycles // ignore: cast_nullable_to_non_nullable
as int,denatureTemp: null == denatureTemp ? _self.denatureTemp : denatureTemp // ignore: cast_nullable_to_non_nullable
as double,denatureTime: null == denatureTime ? _self.denatureTime : denatureTime // ignore: cast_nullable_to_non_nullable
as int,annealTemp: null == annealTemp ? _self.annealTemp : annealTemp // ignore: cast_nullable_to_non_nullable
as double,annealTime: null == annealTime ? _self.annealTime : annealTime // ignore: cast_nullable_to_non_nullable
as int,extendTemp: null == extendTemp ? _self.extendTemp : extendTemp // ignore: cast_nullable_to_non_nullable
as double,extendTime: null == extendTime ? _self.extendTime : extendTime // ignore: cast_nullable_to_non_nullable
as int,twoStepEnabled: null == twoStepEnabled ? _self.twoStepEnabled : twoStepEnabled // ignore: cast_nullable_to_non_nullable
as bool,annealExtendTemp: freezed == annealExtendTemp ? _self.annealExtendTemp : annealExtendTemp // ignore: cast_nullable_to_non_nullable
as double?,annealExtendTime: freezed == annealExtendTime ? _self.annealExtendTime : annealExtendTime // ignore: cast_nullable_to_non_nullable
as int?,hotStart: freezed == hotStart ? _self.hotStart : hotStart // ignore: cast_nullable_to_non_nullable
as HotStartConfig?,touchdown: freezed == touchdown ? _self.touchdown : touchdown // ignore: cast_nullable_to_non_nullable
as TouchdownConfig?,gradient: freezed == gradient ? _self.gradient : gradient // ignore: cast_nullable_to_non_nullable
as GradientConfig?,
  ));
}
/// Create a copy of PCRProgram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HotStartConfigCopyWith<$Res>? get hotStart {
    if (_self.hotStart == null) {
    return null;
  }

  return $HotStartConfigCopyWith<$Res>(_self.hotStart!, (value) {
    return _then(_self.copyWith(hotStart: value));
  });
}/// Create a copy of PCRProgram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TouchdownConfigCopyWith<$Res>? get touchdown {
    if (_self.touchdown == null) {
    return null;
  }

  return $TouchdownConfigCopyWith<$Res>(_self.touchdown!, (value) {
    return _then(_self.copyWith(touchdown: value));
  });
}/// Create a copy of PCRProgram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GradientConfigCopyWith<$Res>? get gradient {
    if (_self.gradient == null) {
    return null;
  }

  return $GradientConfigCopyWith<$Res>(_self.gradient!, (value) {
    return _then(_self.copyWith(gradient: value));
  });
}
}


/// Adds pattern-matching-related methods to [PCRProgram].
extension PCRProgramPatterns on PCRProgram {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PCRProgram value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PCRProgram() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PCRProgram value)  $default,){
final _that = this;
switch (_that) {
case _PCRProgram():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PCRProgram value)?  $default,){
final _that = this;
switch (_that) {
case _PCRProgram() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  int cycles,  double denatureTemp,  int denatureTime,  double annealTemp,  int annealTime,  double extendTemp,  int extendTime,  bool twoStepEnabled,  double? annealExtendTemp,  int? annealExtendTime,  HotStartConfig? hotStart,  TouchdownConfig? touchdown,  GradientConfig? gradient)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PCRProgram() when $default != null:
return $default(_that.type,_that.cycles,_that.denatureTemp,_that.denatureTime,_that.annealTemp,_that.annealTime,_that.extendTemp,_that.extendTime,_that.twoStepEnabled,_that.annealExtendTemp,_that.annealExtendTime,_that.hotStart,_that.touchdown,_that.gradient);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  int cycles,  double denatureTemp,  int denatureTime,  double annealTemp,  int annealTime,  double extendTemp,  int extendTime,  bool twoStepEnabled,  double? annealExtendTemp,  int? annealExtendTime,  HotStartConfig? hotStart,  TouchdownConfig? touchdown,  GradientConfig? gradient)  $default,) {final _that = this;
switch (_that) {
case _PCRProgram():
return $default(_that.type,_that.cycles,_that.denatureTemp,_that.denatureTime,_that.annealTemp,_that.annealTime,_that.extendTemp,_that.extendTime,_that.twoStepEnabled,_that.annealExtendTemp,_that.annealExtendTime,_that.hotStart,_that.touchdown,_that.gradient);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  int cycles,  double denatureTemp,  int denatureTime,  double annealTemp,  int annealTime,  double extendTemp,  int extendTime,  bool twoStepEnabled,  double? annealExtendTemp,  int? annealExtendTime,  HotStartConfig? hotStart,  TouchdownConfig? touchdown,  GradientConfig? gradient)?  $default,) {final _that = this;
switch (_that) {
case _PCRProgram() when $default != null:
return $default(_that.type,_that.cycles,_that.denatureTemp,_that.denatureTime,_that.annealTemp,_that.annealTime,_that.extendTemp,_that.extendTime,_that.twoStepEnabled,_that.annealExtendTemp,_that.annealExtendTime,_that.hotStart,_that.touchdown,_that.gradient);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PCRProgram implements PCRProgram {
  const _PCRProgram({required this.type, required this.cycles, required this.denatureTemp, required this.denatureTime, required this.annealTemp, required this.annealTime, required this.extendTemp, required this.extendTime, this.twoStepEnabled = false, this.annealExtendTemp, this.annealExtendTime, this.hotStart, this.touchdown, this.gradient});
  factory _PCRProgram.fromJson(Map<String, dynamic> json) => _$PCRProgramFromJson(json);

@override final  String type;
@override final  int cycles;
@override final  double denatureTemp;
@override final  int denatureTime;
@override final  double annealTemp;
@override final  int annealTime;
@override final  double extendTemp;
@override final  int extendTime;
@override@JsonKey() final  bool twoStepEnabled;
@override final  double? annealExtendTemp;
@override final  int? annealExtendTime;
@override final  HotStartConfig? hotStart;
@override final  TouchdownConfig? touchdown;
@override final  GradientConfig? gradient;

/// Create a copy of PCRProgram
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PCRProgramCopyWith<_PCRProgram> get copyWith => __$PCRProgramCopyWithImpl<_PCRProgram>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PCRProgramToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PCRProgram&&(identical(other.type, type) || other.type == type)&&(identical(other.cycles, cycles) || other.cycles == cycles)&&(identical(other.denatureTemp, denatureTemp) || other.denatureTemp == denatureTemp)&&(identical(other.denatureTime, denatureTime) || other.denatureTime == denatureTime)&&(identical(other.annealTemp, annealTemp) || other.annealTemp == annealTemp)&&(identical(other.annealTime, annealTime) || other.annealTime == annealTime)&&(identical(other.extendTemp, extendTemp) || other.extendTemp == extendTemp)&&(identical(other.extendTime, extendTime) || other.extendTime == extendTime)&&(identical(other.twoStepEnabled, twoStepEnabled) || other.twoStepEnabled == twoStepEnabled)&&(identical(other.annealExtendTemp, annealExtendTemp) || other.annealExtendTemp == annealExtendTemp)&&(identical(other.annealExtendTime, annealExtendTime) || other.annealExtendTime == annealExtendTime)&&(identical(other.hotStart, hotStart) || other.hotStart == hotStart)&&(identical(other.touchdown, touchdown) || other.touchdown == touchdown)&&(identical(other.gradient, gradient) || other.gradient == gradient));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,cycles,denatureTemp,denatureTime,annealTemp,annealTime,extendTemp,extendTime,twoStepEnabled,annealExtendTemp,annealExtendTime,hotStart,touchdown,gradient);

@override
String toString() {
  return 'PCRProgram(type: $type, cycles: $cycles, denatureTemp: $denatureTemp, denatureTime: $denatureTime, annealTemp: $annealTemp, annealTime: $annealTime, extendTemp: $extendTemp, extendTime: $extendTime, twoStepEnabled: $twoStepEnabled, annealExtendTemp: $annealExtendTemp, annealExtendTime: $annealExtendTime, hotStart: $hotStart, touchdown: $touchdown, gradient: $gradient)';
}


}

/// @nodoc
abstract mixin class _$PCRProgramCopyWith<$Res> implements $PCRProgramCopyWith<$Res> {
  factory _$PCRProgramCopyWith(_PCRProgram value, $Res Function(_PCRProgram) _then) = __$PCRProgramCopyWithImpl;
@override @useResult
$Res call({
 String type, int cycles, double denatureTemp, int denatureTime, double annealTemp, int annealTime, double extendTemp, int extendTime, bool twoStepEnabled, double? annealExtendTemp, int? annealExtendTime, HotStartConfig? hotStart, TouchdownConfig? touchdown, GradientConfig? gradient
});


@override $HotStartConfigCopyWith<$Res>? get hotStart;@override $TouchdownConfigCopyWith<$Res>? get touchdown;@override $GradientConfigCopyWith<$Res>? get gradient;

}
/// @nodoc
class __$PCRProgramCopyWithImpl<$Res>
    implements _$PCRProgramCopyWith<$Res> {
  __$PCRProgramCopyWithImpl(this._self, this._then);

  final _PCRProgram _self;
  final $Res Function(_PCRProgram) _then;

/// Create a copy of PCRProgram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? cycles = null,Object? denatureTemp = null,Object? denatureTime = null,Object? annealTemp = null,Object? annealTime = null,Object? extendTemp = null,Object? extendTime = null,Object? twoStepEnabled = null,Object? annealExtendTemp = freezed,Object? annealExtendTime = freezed,Object? hotStart = freezed,Object? touchdown = freezed,Object? gradient = freezed,}) {
  return _then(_PCRProgram(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,cycles: null == cycles ? _self.cycles : cycles // ignore: cast_nullable_to_non_nullable
as int,denatureTemp: null == denatureTemp ? _self.denatureTemp : denatureTemp // ignore: cast_nullable_to_non_nullable
as double,denatureTime: null == denatureTime ? _self.denatureTime : denatureTime // ignore: cast_nullable_to_non_nullable
as int,annealTemp: null == annealTemp ? _self.annealTemp : annealTemp // ignore: cast_nullable_to_non_nullable
as double,annealTime: null == annealTime ? _self.annealTime : annealTime // ignore: cast_nullable_to_non_nullable
as int,extendTemp: null == extendTemp ? _self.extendTemp : extendTemp // ignore: cast_nullable_to_non_nullable
as double,extendTime: null == extendTime ? _self.extendTime : extendTime // ignore: cast_nullable_to_non_nullable
as int,twoStepEnabled: null == twoStepEnabled ? _self.twoStepEnabled : twoStepEnabled // ignore: cast_nullable_to_non_nullable
as bool,annealExtendTemp: freezed == annealExtendTemp ? _self.annealExtendTemp : annealExtendTemp // ignore: cast_nullable_to_non_nullable
as double?,annealExtendTime: freezed == annealExtendTime ? _self.annealExtendTime : annealExtendTime // ignore: cast_nullable_to_non_nullable
as int?,hotStart: freezed == hotStart ? _self.hotStart : hotStart // ignore: cast_nullable_to_non_nullable
as HotStartConfig?,touchdown: freezed == touchdown ? _self.touchdown : touchdown // ignore: cast_nullable_to_non_nullable
as TouchdownConfig?,gradient: freezed == gradient ? _self.gradient : gradient // ignore: cast_nullable_to_non_nullable
as GradientConfig?,
  ));
}

/// Create a copy of PCRProgram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HotStartConfigCopyWith<$Res>? get hotStart {
    if (_self.hotStart == null) {
    return null;
  }

  return $HotStartConfigCopyWith<$Res>(_self.hotStart!, (value) {
    return _then(_self.copyWith(hotStart: value));
  });
}/// Create a copy of PCRProgram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TouchdownConfigCopyWith<$Res>? get touchdown {
    if (_self.touchdown == null) {
    return null;
  }

  return $TouchdownConfigCopyWith<$Res>(_self.touchdown!, (value) {
    return _then(_self.copyWith(touchdown: value));
  });
}/// Create a copy of PCRProgram
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GradientConfigCopyWith<$Res>? get gradient {
    if (_self.gradient == null) {
    return null;
  }

  return $GradientConfigCopyWith<$Res>(_self.gradient!, (value) {
    return _then(_self.copyWith(gradient: value));
  });
}
}


/// @nodoc
mixin _$HotStartConfig {

 bool get enabled; double get activationTemp; int get activationTime;
/// Create a copy of HotStartConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HotStartConfigCopyWith<HotStartConfig> get copyWith => _$HotStartConfigCopyWithImpl<HotStartConfig>(this as HotStartConfig, _$identity);

  /// Serializes this HotStartConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HotStartConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.activationTemp, activationTemp) || other.activationTemp == activationTemp)&&(identical(other.activationTime, activationTime) || other.activationTime == activationTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,activationTemp,activationTime);

@override
String toString() {
  return 'HotStartConfig(enabled: $enabled, activationTemp: $activationTemp, activationTime: $activationTime)';
}


}

/// @nodoc
abstract mixin class $HotStartConfigCopyWith<$Res>  {
  factory $HotStartConfigCopyWith(HotStartConfig value, $Res Function(HotStartConfig) _then) = _$HotStartConfigCopyWithImpl;
@useResult
$Res call({
 bool enabled, double activationTemp, int activationTime
});




}
/// @nodoc
class _$HotStartConfigCopyWithImpl<$Res>
    implements $HotStartConfigCopyWith<$Res> {
  _$HotStartConfigCopyWithImpl(this._self, this._then);

  final HotStartConfig _self;
  final $Res Function(HotStartConfig) _then;

/// Create a copy of HotStartConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? activationTemp = null,Object? activationTime = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,activationTemp: null == activationTemp ? _self.activationTemp : activationTemp // ignore: cast_nullable_to_non_nullable
as double,activationTime: null == activationTime ? _self.activationTime : activationTime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HotStartConfig].
extension HotStartConfigPatterns on HotStartConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HotStartConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HotStartConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HotStartConfig value)  $default,){
final _that = this;
switch (_that) {
case _HotStartConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HotStartConfig value)?  $default,){
final _that = this;
switch (_that) {
case _HotStartConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  double activationTemp,  int activationTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HotStartConfig() when $default != null:
return $default(_that.enabled,_that.activationTemp,_that.activationTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  double activationTemp,  int activationTime)  $default,) {final _that = this;
switch (_that) {
case _HotStartConfig():
return $default(_that.enabled,_that.activationTemp,_that.activationTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  double activationTemp,  int activationTime)?  $default,) {final _that = this;
switch (_that) {
case _HotStartConfig() when $default != null:
return $default(_that.enabled,_that.activationTemp,_that.activationTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HotStartConfig implements HotStartConfig {
  const _HotStartConfig({required this.enabled, required this.activationTemp, required this.activationTime});
  factory _HotStartConfig.fromJson(Map<String, dynamic> json) => _$HotStartConfigFromJson(json);

@override final  bool enabled;
@override final  double activationTemp;
@override final  int activationTime;

/// Create a copy of HotStartConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HotStartConfigCopyWith<_HotStartConfig> get copyWith => __$HotStartConfigCopyWithImpl<_HotStartConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HotStartConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HotStartConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.activationTemp, activationTemp) || other.activationTemp == activationTemp)&&(identical(other.activationTime, activationTime) || other.activationTime == activationTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,activationTemp,activationTime);

@override
String toString() {
  return 'HotStartConfig(enabled: $enabled, activationTemp: $activationTemp, activationTime: $activationTime)';
}


}

/// @nodoc
abstract mixin class _$HotStartConfigCopyWith<$Res> implements $HotStartConfigCopyWith<$Res> {
  factory _$HotStartConfigCopyWith(_HotStartConfig value, $Res Function(_HotStartConfig) _then) = __$HotStartConfigCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, double activationTemp, int activationTime
});




}
/// @nodoc
class __$HotStartConfigCopyWithImpl<$Res>
    implements _$HotStartConfigCopyWith<$Res> {
  __$HotStartConfigCopyWithImpl(this._self, this._then);

  final _HotStartConfig _self;
  final $Res Function(_HotStartConfig) _then;

/// Create a copy of HotStartConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? activationTemp = null,Object? activationTime = null,}) {
  return _then(_HotStartConfig(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,activationTemp: null == activationTemp ? _self.activationTemp : activationTemp // ignore: cast_nullable_to_non_nullable
as double,activationTime: null == activationTime ? _self.activationTime : activationTime // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TouchdownConfig {

 bool get enabled; double get startAnnealTemp; double get endAnnealTemp; double get stepSize; int get touchdownCycles; double get currentAnnealTemp;
/// Create a copy of TouchdownConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TouchdownConfigCopyWith<TouchdownConfig> get copyWith => _$TouchdownConfigCopyWithImpl<TouchdownConfig>(this as TouchdownConfig, _$identity);

  /// Serializes this TouchdownConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TouchdownConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.startAnnealTemp, startAnnealTemp) || other.startAnnealTemp == startAnnealTemp)&&(identical(other.endAnnealTemp, endAnnealTemp) || other.endAnnealTemp == endAnnealTemp)&&(identical(other.stepSize, stepSize) || other.stepSize == stepSize)&&(identical(other.touchdownCycles, touchdownCycles) || other.touchdownCycles == touchdownCycles)&&(identical(other.currentAnnealTemp, currentAnnealTemp) || other.currentAnnealTemp == currentAnnealTemp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,startAnnealTemp,endAnnealTemp,stepSize,touchdownCycles,currentAnnealTemp);

@override
String toString() {
  return 'TouchdownConfig(enabled: $enabled, startAnnealTemp: $startAnnealTemp, endAnnealTemp: $endAnnealTemp, stepSize: $stepSize, touchdownCycles: $touchdownCycles, currentAnnealTemp: $currentAnnealTemp)';
}


}

/// @nodoc
abstract mixin class $TouchdownConfigCopyWith<$Res>  {
  factory $TouchdownConfigCopyWith(TouchdownConfig value, $Res Function(TouchdownConfig) _then) = _$TouchdownConfigCopyWithImpl;
@useResult
$Res call({
 bool enabled, double startAnnealTemp, double endAnnealTemp, double stepSize, int touchdownCycles, double currentAnnealTemp
});




}
/// @nodoc
class _$TouchdownConfigCopyWithImpl<$Res>
    implements $TouchdownConfigCopyWith<$Res> {
  _$TouchdownConfigCopyWithImpl(this._self, this._then);

  final TouchdownConfig _self;
  final $Res Function(TouchdownConfig) _then;

/// Create a copy of TouchdownConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? startAnnealTemp = null,Object? endAnnealTemp = null,Object? stepSize = null,Object? touchdownCycles = null,Object? currentAnnealTemp = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,startAnnealTemp: null == startAnnealTemp ? _self.startAnnealTemp : startAnnealTemp // ignore: cast_nullable_to_non_nullable
as double,endAnnealTemp: null == endAnnealTemp ? _self.endAnnealTemp : endAnnealTemp // ignore: cast_nullable_to_non_nullable
as double,stepSize: null == stepSize ? _self.stepSize : stepSize // ignore: cast_nullable_to_non_nullable
as double,touchdownCycles: null == touchdownCycles ? _self.touchdownCycles : touchdownCycles // ignore: cast_nullable_to_non_nullable
as int,currentAnnealTemp: null == currentAnnealTemp ? _self.currentAnnealTemp : currentAnnealTemp // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [TouchdownConfig].
extension TouchdownConfigPatterns on TouchdownConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TouchdownConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TouchdownConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TouchdownConfig value)  $default,){
final _that = this;
switch (_that) {
case _TouchdownConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TouchdownConfig value)?  $default,){
final _that = this;
switch (_that) {
case _TouchdownConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  double startAnnealTemp,  double endAnnealTemp,  double stepSize,  int touchdownCycles,  double currentAnnealTemp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TouchdownConfig() when $default != null:
return $default(_that.enabled,_that.startAnnealTemp,_that.endAnnealTemp,_that.stepSize,_that.touchdownCycles,_that.currentAnnealTemp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  double startAnnealTemp,  double endAnnealTemp,  double stepSize,  int touchdownCycles,  double currentAnnealTemp)  $default,) {final _that = this;
switch (_that) {
case _TouchdownConfig():
return $default(_that.enabled,_that.startAnnealTemp,_that.endAnnealTemp,_that.stepSize,_that.touchdownCycles,_that.currentAnnealTemp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  double startAnnealTemp,  double endAnnealTemp,  double stepSize,  int touchdownCycles,  double currentAnnealTemp)?  $default,) {final _that = this;
switch (_that) {
case _TouchdownConfig() when $default != null:
return $default(_that.enabled,_that.startAnnealTemp,_that.endAnnealTemp,_that.stepSize,_that.touchdownCycles,_that.currentAnnealTemp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TouchdownConfig implements TouchdownConfig {
  const _TouchdownConfig({required this.enabled, required this.startAnnealTemp, required this.endAnnealTemp, required this.stepSize, required this.touchdownCycles, required this.currentAnnealTemp});
  factory _TouchdownConfig.fromJson(Map<String, dynamic> json) => _$TouchdownConfigFromJson(json);

@override final  bool enabled;
@override final  double startAnnealTemp;
@override final  double endAnnealTemp;
@override final  double stepSize;
@override final  int touchdownCycles;
@override final  double currentAnnealTemp;

/// Create a copy of TouchdownConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TouchdownConfigCopyWith<_TouchdownConfig> get copyWith => __$TouchdownConfigCopyWithImpl<_TouchdownConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TouchdownConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TouchdownConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.startAnnealTemp, startAnnealTemp) || other.startAnnealTemp == startAnnealTemp)&&(identical(other.endAnnealTemp, endAnnealTemp) || other.endAnnealTemp == endAnnealTemp)&&(identical(other.stepSize, stepSize) || other.stepSize == stepSize)&&(identical(other.touchdownCycles, touchdownCycles) || other.touchdownCycles == touchdownCycles)&&(identical(other.currentAnnealTemp, currentAnnealTemp) || other.currentAnnealTemp == currentAnnealTemp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,startAnnealTemp,endAnnealTemp,stepSize,touchdownCycles,currentAnnealTemp);

@override
String toString() {
  return 'TouchdownConfig(enabled: $enabled, startAnnealTemp: $startAnnealTemp, endAnnealTemp: $endAnnealTemp, stepSize: $stepSize, touchdownCycles: $touchdownCycles, currentAnnealTemp: $currentAnnealTemp)';
}


}

/// @nodoc
abstract mixin class _$TouchdownConfigCopyWith<$Res> implements $TouchdownConfigCopyWith<$Res> {
  factory _$TouchdownConfigCopyWith(_TouchdownConfig value, $Res Function(_TouchdownConfig) _then) = __$TouchdownConfigCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, double startAnnealTemp, double endAnnealTemp, double stepSize, int touchdownCycles, double currentAnnealTemp
});




}
/// @nodoc
class __$TouchdownConfigCopyWithImpl<$Res>
    implements _$TouchdownConfigCopyWith<$Res> {
  __$TouchdownConfigCopyWithImpl(this._self, this._then);

  final _TouchdownConfig _self;
  final $Res Function(_TouchdownConfig) _then;

/// Create a copy of TouchdownConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? startAnnealTemp = null,Object? endAnnealTemp = null,Object? stepSize = null,Object? touchdownCycles = null,Object? currentAnnealTemp = null,}) {
  return _then(_TouchdownConfig(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,startAnnealTemp: null == startAnnealTemp ? _self.startAnnealTemp : startAnnealTemp // ignore: cast_nullable_to_non_nullable
as double,endAnnealTemp: null == endAnnealTemp ? _self.endAnnealTemp : endAnnealTemp // ignore: cast_nullable_to_non_nullable
as double,stepSize: null == stepSize ? _self.stepSize : stepSize // ignore: cast_nullable_to_non_nullable
as double,touchdownCycles: null == touchdownCycles ? _self.touchdownCycles : touchdownCycles // ignore: cast_nullable_to_non_nullable
as int,currentAnnealTemp: null == currentAnnealTemp ? _self.currentAnnealTemp : currentAnnealTemp // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$GradientConfig {

 bool get enabled; double get tempLow; double get tempHigh; int get positions;
/// Create a copy of GradientConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GradientConfigCopyWith<GradientConfig> get copyWith => _$GradientConfigCopyWithImpl<GradientConfig>(this as GradientConfig, _$identity);

  /// Serializes this GradientConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GradientConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.tempLow, tempLow) || other.tempLow == tempLow)&&(identical(other.tempHigh, tempHigh) || other.tempHigh == tempHigh)&&(identical(other.positions, positions) || other.positions == positions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,tempLow,tempHigh,positions);

@override
String toString() {
  return 'GradientConfig(enabled: $enabled, tempLow: $tempLow, tempHigh: $tempHigh, positions: $positions)';
}


}

/// @nodoc
abstract mixin class $GradientConfigCopyWith<$Res>  {
  factory $GradientConfigCopyWith(GradientConfig value, $Res Function(GradientConfig) _then) = _$GradientConfigCopyWithImpl;
@useResult
$Res call({
 bool enabled, double tempLow, double tempHigh, int positions
});




}
/// @nodoc
class _$GradientConfigCopyWithImpl<$Res>
    implements $GradientConfigCopyWith<$Res> {
  _$GradientConfigCopyWithImpl(this._self, this._then);

  final GradientConfig _self;
  final $Res Function(GradientConfig) _then;

/// Create a copy of GradientConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? tempLow = null,Object? tempHigh = null,Object? positions = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,tempLow: null == tempLow ? _self.tempLow : tempLow // ignore: cast_nullable_to_non_nullable
as double,tempHigh: null == tempHigh ? _self.tempHigh : tempHigh // ignore: cast_nullable_to_non_nullable
as double,positions: null == positions ? _self.positions : positions // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GradientConfig].
extension GradientConfigPatterns on GradientConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GradientConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GradientConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GradientConfig value)  $default,){
final _that = this;
switch (_that) {
case _GradientConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GradientConfig value)?  $default,){
final _that = this;
switch (_that) {
case _GradientConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  double tempLow,  double tempHigh,  int positions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GradientConfig() when $default != null:
return $default(_that.enabled,_that.tempLow,_that.tempHigh,_that.positions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  double tempLow,  double tempHigh,  int positions)  $default,) {final _that = this;
switch (_that) {
case _GradientConfig():
return $default(_that.enabled,_that.tempLow,_that.tempHigh,_that.positions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  double tempLow,  double tempHigh,  int positions)?  $default,) {final _that = this;
switch (_that) {
case _GradientConfig() when $default != null:
return $default(_that.enabled,_that.tempLow,_that.tempHigh,_that.positions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GradientConfig implements GradientConfig {
  const _GradientConfig({required this.enabled, required this.tempLow, required this.tempHigh, required this.positions});
  factory _GradientConfig.fromJson(Map<String, dynamic> json) => _$GradientConfigFromJson(json);

@override final  bool enabled;
@override final  double tempLow;
@override final  double tempHigh;
@override final  int positions;

/// Create a copy of GradientConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GradientConfigCopyWith<_GradientConfig> get copyWith => __$GradientConfigCopyWithImpl<_GradientConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GradientConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GradientConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.tempLow, tempLow) || other.tempLow == tempLow)&&(identical(other.tempHigh, tempHigh) || other.tempHigh == tempHigh)&&(identical(other.positions, positions) || other.positions == positions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,tempLow,tempHigh,positions);

@override
String toString() {
  return 'GradientConfig(enabled: $enabled, tempLow: $tempLow, tempHigh: $tempHigh, positions: $positions)';
}


}

/// @nodoc
abstract mixin class _$GradientConfigCopyWith<$Res> implements $GradientConfigCopyWith<$Res> {
  factory _$GradientConfigCopyWith(_GradientConfig value, $Res Function(_GradientConfig) _then) = __$GradientConfigCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, double tempLow, double tempHigh, int positions
});




}
/// @nodoc
class __$GradientConfigCopyWithImpl<$Res>
    implements _$GradientConfigCopyWith<$Res> {
  __$GradientConfigCopyWithImpl(this._self, this._then);

  final _GradientConfig _self;
  final $Res Function(_GradientConfig) _then;

/// Create a copy of GradientConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? tempLow = null,Object? tempHigh = null,Object? positions = null,}) {
  return _then(_GradientConfig(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,tempLow: null == tempLow ? _self.tempLow : tempLow // ignore: cast_nullable_to_non_nullable
as double,tempHigh: null == tempHigh ? _self.tempHigh : tempHigh // ignore: cast_nullable_to_non_nullable
as double,positions: null == positions ? _self.positions : positions // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PCRMetrics {

 double get currentAnnealTemp; double get temperatureStability;
/// Create a copy of PCRMetrics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PCRMetricsCopyWith<PCRMetrics> get copyWith => _$PCRMetricsCopyWithImpl<PCRMetrics>(this as PCRMetrics, _$identity);

  /// Serializes this PCRMetrics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PCRMetrics&&(identical(other.currentAnnealTemp, currentAnnealTemp) || other.currentAnnealTemp == currentAnnealTemp)&&(identical(other.temperatureStability, temperatureStability) || other.temperatureStability == temperatureStability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentAnnealTemp,temperatureStability);

@override
String toString() {
  return 'PCRMetrics(currentAnnealTemp: $currentAnnealTemp, temperatureStability: $temperatureStability)';
}


}

/// @nodoc
abstract mixin class $PCRMetricsCopyWith<$Res>  {
  factory $PCRMetricsCopyWith(PCRMetrics value, $Res Function(PCRMetrics) _then) = _$PCRMetricsCopyWithImpl;
@useResult
$Res call({
 double currentAnnealTemp, double temperatureStability
});




}
/// @nodoc
class _$PCRMetricsCopyWithImpl<$Res>
    implements $PCRMetricsCopyWith<$Res> {
  _$PCRMetricsCopyWithImpl(this._self, this._then);

  final PCRMetrics _self;
  final $Res Function(PCRMetrics) _then;

/// Create a copy of PCRMetrics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentAnnealTemp = null,Object? temperatureStability = null,}) {
  return _then(_self.copyWith(
currentAnnealTemp: null == currentAnnealTemp ? _self.currentAnnealTemp : currentAnnealTemp // ignore: cast_nullable_to_non_nullable
as double,temperatureStability: null == temperatureStability ? _self.temperatureStability : temperatureStability // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [PCRMetrics].
extension PCRMetricsPatterns on PCRMetrics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PCRMetrics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PCRMetrics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PCRMetrics value)  $default,){
final _that = this;
switch (_that) {
case _PCRMetrics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PCRMetrics value)?  $default,){
final _that = this;
switch (_that) {
case _PCRMetrics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double currentAnnealTemp,  double temperatureStability)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PCRMetrics() when $default != null:
return $default(_that.currentAnnealTemp,_that.temperatureStability);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double currentAnnealTemp,  double temperatureStability)  $default,) {final _that = this;
switch (_that) {
case _PCRMetrics():
return $default(_that.currentAnnealTemp,_that.temperatureStability);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double currentAnnealTemp,  double temperatureStability)?  $default,) {final _that = this;
switch (_that) {
case _PCRMetrics() when $default != null:
return $default(_that.currentAnnealTemp,_that.temperatureStability);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PCRMetrics implements PCRMetrics {
  const _PCRMetrics({required this.currentAnnealTemp, required this.temperatureStability});
  factory _PCRMetrics.fromJson(Map<String, dynamic> json) => _$PCRMetricsFromJson(json);

@override final  double currentAnnealTemp;
@override final  double temperatureStability;

/// Create a copy of PCRMetrics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PCRMetricsCopyWith<_PCRMetrics> get copyWith => __$PCRMetricsCopyWithImpl<_PCRMetrics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PCRMetricsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PCRMetrics&&(identical(other.currentAnnealTemp, currentAnnealTemp) || other.currentAnnealTemp == currentAnnealTemp)&&(identical(other.temperatureStability, temperatureStability) || other.temperatureStability == temperatureStability));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentAnnealTemp,temperatureStability);

@override
String toString() {
  return 'PCRMetrics(currentAnnealTemp: $currentAnnealTemp, temperatureStability: $temperatureStability)';
}


}

/// @nodoc
abstract mixin class _$PCRMetricsCopyWith<$Res> implements $PCRMetricsCopyWith<$Res> {
  factory _$PCRMetricsCopyWith(_PCRMetrics value, $Res Function(_PCRMetrics) _then) = __$PCRMetricsCopyWithImpl;
@override @useResult
$Res call({
 double currentAnnealTemp, double temperatureStability
});




}
/// @nodoc
class __$PCRMetricsCopyWithImpl<$Res>
    implements _$PCRMetricsCopyWith<$Res> {
  __$PCRMetricsCopyWithImpl(this._self, this._then);

  final _PCRMetrics _self;
  final $Res Function(_PCRMetrics) _then;

/// Create a copy of PCRMetrics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentAnnealTemp = null,Object? temperatureStability = null,}) {
  return _then(_PCRMetrics(
currentAnnealTemp: null == currentAnnealTemp ? _self.currentAnnealTemp : currentAnnealTemp // ignore: cast_nullable_to_non_nullable
as double,temperatureStability: null == temperatureStability ? _self.temperatureStability : temperatureStability // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
