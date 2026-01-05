// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pcr_telemetry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PCRTelemetry _$PCRTelemetryFromJson(Map<String, dynamic> json) {
  return _PCRTelemetry.fromJson(json);
}

/// @nodoc
mixin _$PCRTelemetry {
  DeviceState get state => throw _privateConstructorUsedError;
  int get uptime => throw _privateConstructorUsedError;
  List<double> get temperature => throw _privateConstructorUsedError;
  List<double> get setpoint => throw _privateConstructorUsedError;
  PCRPhase get currentPhase => throw _privateConstructorUsedError;
  int get cycleNumber => throw _privateConstructorUsedError;
  int get totalCycles => throw _privateConstructorUsedError;
  int get phaseTimeRemaining => throw _privateConstructorUsedError;
  int get totalTimeRemaining => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;
  PCRProgram? get program => throw _privateConstructorUsedError;
  PCRMetrics? get metrics => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PCRTelemetryCopyWith<PCRTelemetry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PCRTelemetryCopyWith<$Res> {
  factory $PCRTelemetryCopyWith(
          PCRTelemetry value, $Res Function(PCRTelemetry) then) =
      _$PCRTelemetryCopyWithImpl<$Res, PCRTelemetry>;
  @useResult
  $Res call(
      {DeviceState state,
      int uptime,
      List<double> temperature,
      List<double> setpoint,
      PCRPhase currentPhase,
      int cycleNumber,
      int totalCycles,
      int phaseTimeRemaining,
      int totalTimeRemaining,
      double progress,
      PCRProgram? program,
      PCRMetrics? metrics,
      List<String> errors});

  $PCRProgramCopyWith<$Res>? get program;
  $PCRMetricsCopyWith<$Res>? get metrics;
}

/// @nodoc
class _$PCRTelemetryCopyWithImpl<$Res, $Val extends PCRTelemetry>
    implements $PCRTelemetryCopyWith<$Res> {
  _$PCRTelemetryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? uptime = null,
    Object? temperature = null,
    Object? setpoint = null,
    Object? currentPhase = null,
    Object? cycleNumber = null,
    Object? totalCycles = null,
    Object? phaseTimeRemaining = null,
    Object? totalTimeRemaining = null,
    Object? progress = null,
    Object? program = freezed,
    Object? metrics = freezed,
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as DeviceState,
      uptime: null == uptime
          ? _value.uptime
          : uptime // ignore: cast_nullable_to_non_nullable
              as int,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as List<double>,
      setpoint: null == setpoint
          ? _value.setpoint
          : setpoint // ignore: cast_nullable_to_non_nullable
              as List<double>,
      currentPhase: null == currentPhase
          ? _value.currentPhase
          : currentPhase // ignore: cast_nullable_to_non_nullable
              as PCRPhase,
      cycleNumber: null == cycleNumber
          ? _value.cycleNumber
          : cycleNumber // ignore: cast_nullable_to_non_nullable
              as int,
      totalCycles: null == totalCycles
          ? _value.totalCycles
          : totalCycles // ignore: cast_nullable_to_non_nullable
              as int,
      phaseTimeRemaining: null == phaseTimeRemaining
          ? _value.phaseTimeRemaining
          : phaseTimeRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      totalTimeRemaining: null == totalTimeRemaining
          ? _value.totalTimeRemaining
          : totalTimeRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      program: freezed == program
          ? _value.program
          : program // ignore: cast_nullable_to_non_nullable
              as PCRProgram?,
      metrics: freezed == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as PCRMetrics?,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PCRProgramCopyWith<$Res>? get program {
    if (_value.program == null) {
      return null;
    }

    return $PCRProgramCopyWith<$Res>(_value.program!, (value) {
      return _then(_value.copyWith(program: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PCRMetricsCopyWith<$Res>? get metrics {
    if (_value.metrics == null) {
      return null;
    }

    return $PCRMetricsCopyWith<$Res>(_value.metrics!, (value) {
      return _then(_value.copyWith(metrics: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PCRTelemetryImplCopyWith<$Res>
    implements $PCRTelemetryCopyWith<$Res> {
  factory _$$PCRTelemetryImplCopyWith(
          _$PCRTelemetryImpl value, $Res Function(_$PCRTelemetryImpl) then) =
      __$$PCRTelemetryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DeviceState state,
      int uptime,
      List<double> temperature,
      List<double> setpoint,
      PCRPhase currentPhase,
      int cycleNumber,
      int totalCycles,
      int phaseTimeRemaining,
      int totalTimeRemaining,
      double progress,
      PCRProgram? program,
      PCRMetrics? metrics,
      List<String> errors});

  @override
  $PCRProgramCopyWith<$Res>? get program;
  @override
  $PCRMetricsCopyWith<$Res>? get metrics;
}

/// @nodoc
class __$$PCRTelemetryImplCopyWithImpl<$Res>
    extends _$PCRTelemetryCopyWithImpl<$Res, _$PCRTelemetryImpl>
    implements _$$PCRTelemetryImplCopyWith<$Res> {
  __$$PCRTelemetryImplCopyWithImpl(
      _$PCRTelemetryImpl _value, $Res Function(_$PCRTelemetryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? uptime = null,
    Object? temperature = null,
    Object? setpoint = null,
    Object? currentPhase = null,
    Object? cycleNumber = null,
    Object? totalCycles = null,
    Object? phaseTimeRemaining = null,
    Object? totalTimeRemaining = null,
    Object? progress = null,
    Object? program = freezed,
    Object? metrics = freezed,
    Object? errors = null,
  }) {
    return _then(_$PCRTelemetryImpl(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as DeviceState,
      uptime: null == uptime
          ? _value.uptime
          : uptime // ignore: cast_nullable_to_non_nullable
              as int,
      temperature: null == temperature
          ? _value._temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as List<double>,
      setpoint: null == setpoint
          ? _value._setpoint
          : setpoint // ignore: cast_nullable_to_non_nullable
              as List<double>,
      currentPhase: null == currentPhase
          ? _value.currentPhase
          : currentPhase // ignore: cast_nullable_to_non_nullable
              as PCRPhase,
      cycleNumber: null == cycleNumber
          ? _value.cycleNumber
          : cycleNumber // ignore: cast_nullable_to_non_nullable
              as int,
      totalCycles: null == totalCycles
          ? _value.totalCycles
          : totalCycles // ignore: cast_nullable_to_non_nullable
              as int,
      phaseTimeRemaining: null == phaseTimeRemaining
          ? _value.phaseTimeRemaining
          : phaseTimeRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      totalTimeRemaining: null == totalTimeRemaining
          ? _value.totalTimeRemaining
          : totalTimeRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
      program: freezed == program
          ? _value.program
          : program // ignore: cast_nullable_to_non_nullable
              as PCRProgram?,
      metrics: freezed == metrics
          ? _value.metrics
          : metrics // ignore: cast_nullable_to_non_nullable
              as PCRMetrics?,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PCRTelemetryImpl implements _PCRTelemetry {
  const _$PCRTelemetryImpl(
      {required this.state,
      required this.uptime,
      required final List<double> temperature,
      required final List<double> setpoint,
      required this.currentPhase,
      required this.cycleNumber,
      required this.totalCycles,
      required this.phaseTimeRemaining,
      required this.totalTimeRemaining,
      required this.progress,
      this.program,
      this.metrics,
      final List<String> errors = const []})
      : _temperature = temperature,
        _setpoint = setpoint,
        _errors = errors;

  factory _$PCRTelemetryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PCRTelemetryImplFromJson(json);

  @override
  final DeviceState state;
  @override
  final int uptime;
  final List<double> _temperature;
  @override
  List<double> get temperature {
    if (_temperature is EqualUnmodifiableListView) return _temperature;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_temperature);
  }

  final List<double> _setpoint;
  @override
  List<double> get setpoint {
    if (_setpoint is EqualUnmodifiableListView) return _setpoint;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_setpoint);
  }

  @override
  final PCRPhase currentPhase;
  @override
  final int cycleNumber;
  @override
  final int totalCycles;
  @override
  final int phaseTimeRemaining;
  @override
  final int totalTimeRemaining;
  @override
  final double progress;
  @override
  final PCRProgram? program;
  @override
  final PCRMetrics? metrics;
  final List<String> _errors;
  @override
  @JsonKey()
  List<String> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  String toString() {
    return 'PCRTelemetry(state: $state, uptime: $uptime, temperature: $temperature, setpoint: $setpoint, currentPhase: $currentPhase, cycleNumber: $cycleNumber, totalCycles: $totalCycles, phaseTimeRemaining: $phaseTimeRemaining, totalTimeRemaining: $totalTimeRemaining, progress: $progress, program: $program, metrics: $metrics, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PCRTelemetryImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.uptime, uptime) || other.uptime == uptime) &&
            const DeepCollectionEquality()
                .equals(other._temperature, _temperature) &&
            const DeepCollectionEquality().equals(other._setpoint, _setpoint) &&
            (identical(other.currentPhase, currentPhase) ||
                other.currentPhase == currentPhase) &&
            (identical(other.cycleNumber, cycleNumber) ||
                other.cycleNumber == cycleNumber) &&
            (identical(other.totalCycles, totalCycles) ||
                other.totalCycles == totalCycles) &&
            (identical(other.phaseTimeRemaining, phaseTimeRemaining) ||
                other.phaseTimeRemaining == phaseTimeRemaining) &&
            (identical(other.totalTimeRemaining, totalTimeRemaining) ||
                other.totalTimeRemaining == totalTimeRemaining) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.program, program) || other.program == program) &&
            (identical(other.metrics, metrics) || other.metrics == metrics) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      state,
      uptime,
      const DeepCollectionEquality().hash(_temperature),
      const DeepCollectionEquality().hash(_setpoint),
      currentPhase,
      cycleNumber,
      totalCycles,
      phaseTimeRemaining,
      totalTimeRemaining,
      progress,
      program,
      metrics,
      const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PCRTelemetryImplCopyWith<_$PCRTelemetryImpl> get copyWith =>
      __$$PCRTelemetryImplCopyWithImpl<_$PCRTelemetryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PCRTelemetryImplToJson(
      this,
    );
  }
}

abstract class _PCRTelemetry implements PCRTelemetry {
  const factory _PCRTelemetry(
      {required final DeviceState state,
      required final int uptime,
      required final List<double> temperature,
      required final List<double> setpoint,
      required final PCRPhase currentPhase,
      required final int cycleNumber,
      required final int totalCycles,
      required final int phaseTimeRemaining,
      required final int totalTimeRemaining,
      required final double progress,
      final PCRProgram? program,
      final PCRMetrics? metrics,
      final List<String> errors}) = _$PCRTelemetryImpl;

  factory _PCRTelemetry.fromJson(Map<String, dynamic> json) =
      _$PCRTelemetryImpl.fromJson;

  @override
  DeviceState get state;
  @override
  int get uptime;
  @override
  List<double> get temperature;
  @override
  List<double> get setpoint;
  @override
  PCRPhase get currentPhase;
  @override
  int get cycleNumber;
  @override
  int get totalCycles;
  @override
  int get phaseTimeRemaining;
  @override
  int get totalTimeRemaining;
  @override
  double get progress;
  @override
  PCRProgram? get program;
  @override
  PCRMetrics? get metrics;
  @override
  List<String> get errors;
  @override
  @JsonKey(ignore: true)
  _$$PCRTelemetryImplCopyWith<_$PCRTelemetryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PCRProgram _$PCRProgramFromJson(Map<String, dynamic> json) {
  return _PCRProgram.fromJson(json);
}

/// @nodoc
mixin _$PCRProgram {
  String get type => throw _privateConstructorUsedError;
  int get cycles => throw _privateConstructorUsedError;
  double get denatureTemp => throw _privateConstructorUsedError;
  int get denatureTime => throw _privateConstructorUsedError;
  double get annealTemp => throw _privateConstructorUsedError;
  int get annealTime => throw _privateConstructorUsedError;
  double get extendTemp => throw _privateConstructorUsedError;
  int get extendTime => throw _privateConstructorUsedError;
  bool get twoStepEnabled => throw _privateConstructorUsedError;
  double? get annealExtendTemp => throw _privateConstructorUsedError;
  int? get annealExtendTime => throw _privateConstructorUsedError;
  HotStartConfig? get hotStart => throw _privateConstructorUsedError;
  TouchdownConfig? get touchdown => throw _privateConstructorUsedError;
  GradientConfig? get gradient => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PCRProgramCopyWith<PCRProgram> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PCRProgramCopyWith<$Res> {
  factory $PCRProgramCopyWith(
          PCRProgram value, $Res Function(PCRProgram) then) =
      _$PCRProgramCopyWithImpl<$Res, PCRProgram>;
  @useResult
  $Res call(
      {String type,
      int cycles,
      double denatureTemp,
      int denatureTime,
      double annealTemp,
      int annealTime,
      double extendTemp,
      int extendTime,
      bool twoStepEnabled,
      double? annealExtendTemp,
      int? annealExtendTime,
      HotStartConfig? hotStart,
      TouchdownConfig? touchdown,
      GradientConfig? gradient});

  $HotStartConfigCopyWith<$Res>? get hotStart;
  $TouchdownConfigCopyWith<$Res>? get touchdown;
  $GradientConfigCopyWith<$Res>? get gradient;
}

/// @nodoc
class _$PCRProgramCopyWithImpl<$Res, $Val extends PCRProgram>
    implements $PCRProgramCopyWith<$Res> {
  _$PCRProgramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? cycles = null,
    Object? denatureTemp = null,
    Object? denatureTime = null,
    Object? annealTemp = null,
    Object? annealTime = null,
    Object? extendTemp = null,
    Object? extendTime = null,
    Object? twoStepEnabled = null,
    Object? annealExtendTemp = freezed,
    Object? annealExtendTime = freezed,
    Object? hotStart = freezed,
    Object? touchdown = freezed,
    Object? gradient = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      cycles: null == cycles
          ? _value.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      denatureTemp: null == denatureTemp
          ? _value.denatureTemp
          : denatureTemp // ignore: cast_nullable_to_non_nullable
              as double,
      denatureTime: null == denatureTime
          ? _value.denatureTime
          : denatureTime // ignore: cast_nullable_to_non_nullable
              as int,
      annealTemp: null == annealTemp
          ? _value.annealTemp
          : annealTemp // ignore: cast_nullable_to_non_nullable
              as double,
      annealTime: null == annealTime
          ? _value.annealTime
          : annealTime // ignore: cast_nullable_to_non_nullable
              as int,
      extendTemp: null == extendTemp
          ? _value.extendTemp
          : extendTemp // ignore: cast_nullable_to_non_nullable
              as double,
      extendTime: null == extendTime
          ? _value.extendTime
          : extendTime // ignore: cast_nullable_to_non_nullable
              as int,
      twoStepEnabled: null == twoStepEnabled
          ? _value.twoStepEnabled
          : twoStepEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      annealExtendTemp: freezed == annealExtendTemp
          ? _value.annealExtendTemp
          : annealExtendTemp // ignore: cast_nullable_to_non_nullable
              as double?,
      annealExtendTime: freezed == annealExtendTime
          ? _value.annealExtendTime
          : annealExtendTime // ignore: cast_nullable_to_non_nullable
              as int?,
      hotStart: freezed == hotStart
          ? _value.hotStart
          : hotStart // ignore: cast_nullable_to_non_nullable
              as HotStartConfig?,
      touchdown: freezed == touchdown
          ? _value.touchdown
          : touchdown // ignore: cast_nullable_to_non_nullable
              as TouchdownConfig?,
      gradient: freezed == gradient
          ? _value.gradient
          : gradient // ignore: cast_nullable_to_non_nullable
              as GradientConfig?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $HotStartConfigCopyWith<$Res>? get hotStart {
    if (_value.hotStart == null) {
      return null;
    }

    return $HotStartConfigCopyWith<$Res>(_value.hotStart!, (value) {
      return _then(_value.copyWith(hotStart: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TouchdownConfigCopyWith<$Res>? get touchdown {
    if (_value.touchdown == null) {
      return null;
    }

    return $TouchdownConfigCopyWith<$Res>(_value.touchdown!, (value) {
      return _then(_value.copyWith(touchdown: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GradientConfigCopyWith<$Res>? get gradient {
    if (_value.gradient == null) {
      return null;
    }

    return $GradientConfigCopyWith<$Res>(_value.gradient!, (value) {
      return _then(_value.copyWith(gradient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PCRProgramImplCopyWith<$Res>
    implements $PCRProgramCopyWith<$Res> {
  factory _$$PCRProgramImplCopyWith(
          _$PCRProgramImpl value, $Res Function(_$PCRProgramImpl) then) =
      __$$PCRProgramImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      int cycles,
      double denatureTemp,
      int denatureTime,
      double annealTemp,
      int annealTime,
      double extendTemp,
      int extendTime,
      bool twoStepEnabled,
      double? annealExtendTemp,
      int? annealExtendTime,
      HotStartConfig? hotStart,
      TouchdownConfig? touchdown,
      GradientConfig? gradient});

  @override
  $HotStartConfigCopyWith<$Res>? get hotStart;
  @override
  $TouchdownConfigCopyWith<$Res>? get touchdown;
  @override
  $GradientConfigCopyWith<$Res>? get gradient;
}

/// @nodoc
class __$$PCRProgramImplCopyWithImpl<$Res>
    extends _$PCRProgramCopyWithImpl<$Res, _$PCRProgramImpl>
    implements _$$PCRProgramImplCopyWith<$Res> {
  __$$PCRProgramImplCopyWithImpl(
      _$PCRProgramImpl _value, $Res Function(_$PCRProgramImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? cycles = null,
    Object? denatureTemp = null,
    Object? denatureTime = null,
    Object? annealTemp = null,
    Object? annealTime = null,
    Object? extendTemp = null,
    Object? extendTime = null,
    Object? twoStepEnabled = null,
    Object? annealExtendTemp = freezed,
    Object? annealExtendTime = freezed,
    Object? hotStart = freezed,
    Object? touchdown = freezed,
    Object? gradient = freezed,
  }) {
    return _then(_$PCRProgramImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      cycles: null == cycles
          ? _value.cycles
          : cycles // ignore: cast_nullable_to_non_nullable
              as int,
      denatureTemp: null == denatureTemp
          ? _value.denatureTemp
          : denatureTemp // ignore: cast_nullable_to_non_nullable
              as double,
      denatureTime: null == denatureTime
          ? _value.denatureTime
          : denatureTime // ignore: cast_nullable_to_non_nullable
              as int,
      annealTemp: null == annealTemp
          ? _value.annealTemp
          : annealTemp // ignore: cast_nullable_to_non_nullable
              as double,
      annealTime: null == annealTime
          ? _value.annealTime
          : annealTime // ignore: cast_nullable_to_non_nullable
              as int,
      extendTemp: null == extendTemp
          ? _value.extendTemp
          : extendTemp // ignore: cast_nullable_to_non_nullable
              as double,
      extendTime: null == extendTime
          ? _value.extendTime
          : extendTime // ignore: cast_nullable_to_non_nullable
              as int,
      twoStepEnabled: null == twoStepEnabled
          ? _value.twoStepEnabled
          : twoStepEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      annealExtendTemp: freezed == annealExtendTemp
          ? _value.annealExtendTemp
          : annealExtendTemp // ignore: cast_nullable_to_non_nullable
              as double?,
      annealExtendTime: freezed == annealExtendTime
          ? _value.annealExtendTime
          : annealExtendTime // ignore: cast_nullable_to_non_nullable
              as int?,
      hotStart: freezed == hotStart
          ? _value.hotStart
          : hotStart // ignore: cast_nullable_to_non_nullable
              as HotStartConfig?,
      touchdown: freezed == touchdown
          ? _value.touchdown
          : touchdown // ignore: cast_nullable_to_non_nullable
              as TouchdownConfig?,
      gradient: freezed == gradient
          ? _value.gradient
          : gradient // ignore: cast_nullable_to_non_nullable
              as GradientConfig?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PCRProgramImpl implements _PCRProgram {
  const _$PCRProgramImpl(
      {required this.type,
      required this.cycles,
      required this.denatureTemp,
      required this.denatureTime,
      required this.annealTemp,
      required this.annealTime,
      required this.extendTemp,
      required this.extendTime,
      this.twoStepEnabled = false,
      this.annealExtendTemp,
      this.annealExtendTime,
      this.hotStart,
      this.touchdown,
      this.gradient});

  factory _$PCRProgramImpl.fromJson(Map<String, dynamic> json) =>
      _$$PCRProgramImplFromJson(json);

  @override
  final String type;
  @override
  final int cycles;
  @override
  final double denatureTemp;
  @override
  final int denatureTime;
  @override
  final double annealTemp;
  @override
  final int annealTime;
  @override
  final double extendTemp;
  @override
  final int extendTime;
  @override
  @JsonKey()
  final bool twoStepEnabled;
  @override
  final double? annealExtendTemp;
  @override
  final int? annealExtendTime;
  @override
  final HotStartConfig? hotStart;
  @override
  final TouchdownConfig? touchdown;
  @override
  final GradientConfig? gradient;

  @override
  String toString() {
    return 'PCRProgram(type: $type, cycles: $cycles, denatureTemp: $denatureTemp, denatureTime: $denatureTime, annealTemp: $annealTemp, annealTime: $annealTime, extendTemp: $extendTemp, extendTime: $extendTime, twoStepEnabled: $twoStepEnabled, annealExtendTemp: $annealExtendTemp, annealExtendTime: $annealExtendTime, hotStart: $hotStart, touchdown: $touchdown, gradient: $gradient)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PCRProgramImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.cycles, cycles) || other.cycles == cycles) &&
            (identical(other.denatureTemp, denatureTemp) ||
                other.denatureTemp == denatureTemp) &&
            (identical(other.denatureTime, denatureTime) ||
                other.denatureTime == denatureTime) &&
            (identical(other.annealTemp, annealTemp) ||
                other.annealTemp == annealTemp) &&
            (identical(other.annealTime, annealTime) ||
                other.annealTime == annealTime) &&
            (identical(other.extendTemp, extendTemp) ||
                other.extendTemp == extendTemp) &&
            (identical(other.extendTime, extendTime) ||
                other.extendTime == extendTime) &&
            (identical(other.twoStepEnabled, twoStepEnabled) ||
                other.twoStepEnabled == twoStepEnabled) &&
            (identical(other.annealExtendTemp, annealExtendTemp) ||
                other.annealExtendTemp == annealExtendTemp) &&
            (identical(other.annealExtendTime, annealExtendTime) ||
                other.annealExtendTime == annealExtendTime) &&
            (identical(other.hotStart, hotStart) ||
                other.hotStart == hotStart) &&
            (identical(other.touchdown, touchdown) ||
                other.touchdown == touchdown) &&
            (identical(other.gradient, gradient) ||
                other.gradient == gradient));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      cycles,
      denatureTemp,
      denatureTime,
      annealTemp,
      annealTime,
      extendTemp,
      extendTime,
      twoStepEnabled,
      annealExtendTemp,
      annealExtendTime,
      hotStart,
      touchdown,
      gradient);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PCRProgramImplCopyWith<_$PCRProgramImpl> get copyWith =>
      __$$PCRProgramImplCopyWithImpl<_$PCRProgramImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PCRProgramImplToJson(
      this,
    );
  }
}

abstract class _PCRProgram implements PCRProgram {
  const factory _PCRProgram(
      {required final String type,
      required final int cycles,
      required final double denatureTemp,
      required final int denatureTime,
      required final double annealTemp,
      required final int annealTime,
      required final double extendTemp,
      required final int extendTime,
      final bool twoStepEnabled,
      final double? annealExtendTemp,
      final int? annealExtendTime,
      final HotStartConfig? hotStart,
      final TouchdownConfig? touchdown,
      final GradientConfig? gradient}) = _$PCRProgramImpl;

  factory _PCRProgram.fromJson(Map<String, dynamic> json) =
      _$PCRProgramImpl.fromJson;

  @override
  String get type;
  @override
  int get cycles;
  @override
  double get denatureTemp;
  @override
  int get denatureTime;
  @override
  double get annealTemp;
  @override
  int get annealTime;
  @override
  double get extendTemp;
  @override
  int get extendTime;
  @override
  bool get twoStepEnabled;
  @override
  double? get annealExtendTemp;
  @override
  int? get annealExtendTime;
  @override
  HotStartConfig? get hotStart;
  @override
  TouchdownConfig? get touchdown;
  @override
  GradientConfig? get gradient;
  @override
  @JsonKey(ignore: true)
  _$$PCRProgramImplCopyWith<_$PCRProgramImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HotStartConfig _$HotStartConfigFromJson(Map<String, dynamic> json) {
  return _HotStartConfig.fromJson(json);
}

/// @nodoc
mixin _$HotStartConfig {
  bool get enabled => throw _privateConstructorUsedError;
  double get activationTemp => throw _privateConstructorUsedError;
  int get activationTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HotStartConfigCopyWith<HotStartConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HotStartConfigCopyWith<$Res> {
  factory $HotStartConfigCopyWith(
          HotStartConfig value, $Res Function(HotStartConfig) then) =
      _$HotStartConfigCopyWithImpl<$Res, HotStartConfig>;
  @useResult
  $Res call({bool enabled, double activationTemp, int activationTime});
}

/// @nodoc
class _$HotStartConfigCopyWithImpl<$Res, $Val extends HotStartConfig>
    implements $HotStartConfigCopyWith<$Res> {
  _$HotStartConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? activationTemp = null,
    Object? activationTime = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      activationTemp: null == activationTemp
          ? _value.activationTemp
          : activationTemp // ignore: cast_nullable_to_non_nullable
              as double,
      activationTime: null == activationTime
          ? _value.activationTime
          : activationTime // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HotStartConfigImplCopyWith<$Res>
    implements $HotStartConfigCopyWith<$Res> {
  factory _$$HotStartConfigImplCopyWith(_$HotStartConfigImpl value,
          $Res Function(_$HotStartConfigImpl) then) =
      __$$HotStartConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool enabled, double activationTemp, int activationTime});
}

/// @nodoc
class __$$HotStartConfigImplCopyWithImpl<$Res>
    extends _$HotStartConfigCopyWithImpl<$Res, _$HotStartConfigImpl>
    implements _$$HotStartConfigImplCopyWith<$Res> {
  __$$HotStartConfigImplCopyWithImpl(
      _$HotStartConfigImpl _value, $Res Function(_$HotStartConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? activationTemp = null,
    Object? activationTime = null,
  }) {
    return _then(_$HotStartConfigImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      activationTemp: null == activationTemp
          ? _value.activationTemp
          : activationTemp // ignore: cast_nullable_to_non_nullable
              as double,
      activationTime: null == activationTime
          ? _value.activationTime
          : activationTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HotStartConfigImpl implements _HotStartConfig {
  const _$HotStartConfigImpl(
      {required this.enabled,
      required this.activationTemp,
      required this.activationTime});

  factory _$HotStartConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$HotStartConfigImplFromJson(json);

  @override
  final bool enabled;
  @override
  final double activationTemp;
  @override
  final int activationTime;

  @override
  String toString() {
    return 'HotStartConfig(enabled: $enabled, activationTemp: $activationTemp, activationTime: $activationTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HotStartConfigImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.activationTemp, activationTemp) ||
                other.activationTemp == activationTemp) &&
            (identical(other.activationTime, activationTime) ||
                other.activationTime == activationTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, enabled, activationTemp, activationTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HotStartConfigImplCopyWith<_$HotStartConfigImpl> get copyWith =>
      __$$HotStartConfigImplCopyWithImpl<_$HotStartConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HotStartConfigImplToJson(
      this,
    );
  }
}

abstract class _HotStartConfig implements HotStartConfig {
  const factory _HotStartConfig(
      {required final bool enabled,
      required final double activationTemp,
      required final int activationTime}) = _$HotStartConfigImpl;

  factory _HotStartConfig.fromJson(Map<String, dynamic> json) =
      _$HotStartConfigImpl.fromJson;

  @override
  bool get enabled;
  @override
  double get activationTemp;
  @override
  int get activationTime;
  @override
  @JsonKey(ignore: true)
  _$$HotStartConfigImplCopyWith<_$HotStartConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TouchdownConfig _$TouchdownConfigFromJson(Map<String, dynamic> json) {
  return _TouchdownConfig.fromJson(json);
}

/// @nodoc
mixin _$TouchdownConfig {
  bool get enabled => throw _privateConstructorUsedError;
  double get startAnnealTemp => throw _privateConstructorUsedError;
  double get endAnnealTemp => throw _privateConstructorUsedError;
  double get stepSize => throw _privateConstructorUsedError;
  int get touchdownCycles => throw _privateConstructorUsedError;
  double get currentAnnealTemp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TouchdownConfigCopyWith<TouchdownConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TouchdownConfigCopyWith<$Res> {
  factory $TouchdownConfigCopyWith(
          TouchdownConfig value, $Res Function(TouchdownConfig) then) =
      _$TouchdownConfigCopyWithImpl<$Res, TouchdownConfig>;
  @useResult
  $Res call(
      {bool enabled,
      double startAnnealTemp,
      double endAnnealTemp,
      double stepSize,
      int touchdownCycles,
      double currentAnnealTemp});
}

/// @nodoc
class _$TouchdownConfigCopyWithImpl<$Res, $Val extends TouchdownConfig>
    implements $TouchdownConfigCopyWith<$Res> {
  _$TouchdownConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? startAnnealTemp = null,
    Object? endAnnealTemp = null,
    Object? stepSize = null,
    Object? touchdownCycles = null,
    Object? currentAnnealTemp = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      startAnnealTemp: null == startAnnealTemp
          ? _value.startAnnealTemp
          : startAnnealTemp // ignore: cast_nullable_to_non_nullable
              as double,
      endAnnealTemp: null == endAnnealTemp
          ? _value.endAnnealTemp
          : endAnnealTemp // ignore: cast_nullable_to_non_nullable
              as double,
      stepSize: null == stepSize
          ? _value.stepSize
          : stepSize // ignore: cast_nullable_to_non_nullable
              as double,
      touchdownCycles: null == touchdownCycles
          ? _value.touchdownCycles
          : touchdownCycles // ignore: cast_nullable_to_non_nullable
              as int,
      currentAnnealTemp: null == currentAnnealTemp
          ? _value.currentAnnealTemp
          : currentAnnealTemp // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TouchdownConfigImplCopyWith<$Res>
    implements $TouchdownConfigCopyWith<$Res> {
  factory _$$TouchdownConfigImplCopyWith(_$TouchdownConfigImpl value,
          $Res Function(_$TouchdownConfigImpl) then) =
      __$$TouchdownConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool enabled,
      double startAnnealTemp,
      double endAnnealTemp,
      double stepSize,
      int touchdownCycles,
      double currentAnnealTemp});
}

/// @nodoc
class __$$TouchdownConfigImplCopyWithImpl<$Res>
    extends _$TouchdownConfigCopyWithImpl<$Res, _$TouchdownConfigImpl>
    implements _$$TouchdownConfigImplCopyWith<$Res> {
  __$$TouchdownConfigImplCopyWithImpl(
      _$TouchdownConfigImpl _value, $Res Function(_$TouchdownConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? startAnnealTemp = null,
    Object? endAnnealTemp = null,
    Object? stepSize = null,
    Object? touchdownCycles = null,
    Object? currentAnnealTemp = null,
  }) {
    return _then(_$TouchdownConfigImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      startAnnealTemp: null == startAnnealTemp
          ? _value.startAnnealTemp
          : startAnnealTemp // ignore: cast_nullable_to_non_nullable
              as double,
      endAnnealTemp: null == endAnnealTemp
          ? _value.endAnnealTemp
          : endAnnealTemp // ignore: cast_nullable_to_non_nullable
              as double,
      stepSize: null == stepSize
          ? _value.stepSize
          : stepSize // ignore: cast_nullable_to_non_nullable
              as double,
      touchdownCycles: null == touchdownCycles
          ? _value.touchdownCycles
          : touchdownCycles // ignore: cast_nullable_to_non_nullable
              as int,
      currentAnnealTemp: null == currentAnnealTemp
          ? _value.currentAnnealTemp
          : currentAnnealTemp // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TouchdownConfigImpl implements _TouchdownConfig {
  const _$TouchdownConfigImpl(
      {required this.enabled,
      required this.startAnnealTemp,
      required this.endAnnealTemp,
      required this.stepSize,
      required this.touchdownCycles,
      required this.currentAnnealTemp});

  factory _$TouchdownConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$TouchdownConfigImplFromJson(json);

  @override
  final bool enabled;
  @override
  final double startAnnealTemp;
  @override
  final double endAnnealTemp;
  @override
  final double stepSize;
  @override
  final int touchdownCycles;
  @override
  final double currentAnnealTemp;

  @override
  String toString() {
    return 'TouchdownConfig(enabled: $enabled, startAnnealTemp: $startAnnealTemp, endAnnealTemp: $endAnnealTemp, stepSize: $stepSize, touchdownCycles: $touchdownCycles, currentAnnealTemp: $currentAnnealTemp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TouchdownConfigImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.startAnnealTemp, startAnnealTemp) ||
                other.startAnnealTemp == startAnnealTemp) &&
            (identical(other.endAnnealTemp, endAnnealTemp) ||
                other.endAnnealTemp == endAnnealTemp) &&
            (identical(other.stepSize, stepSize) ||
                other.stepSize == stepSize) &&
            (identical(other.touchdownCycles, touchdownCycles) ||
                other.touchdownCycles == touchdownCycles) &&
            (identical(other.currentAnnealTemp, currentAnnealTemp) ||
                other.currentAnnealTemp == currentAnnealTemp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, enabled, startAnnealTemp,
      endAnnealTemp, stepSize, touchdownCycles, currentAnnealTemp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TouchdownConfigImplCopyWith<_$TouchdownConfigImpl> get copyWith =>
      __$$TouchdownConfigImplCopyWithImpl<_$TouchdownConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TouchdownConfigImplToJson(
      this,
    );
  }
}

abstract class _TouchdownConfig implements TouchdownConfig {
  const factory _TouchdownConfig(
      {required final bool enabled,
      required final double startAnnealTemp,
      required final double endAnnealTemp,
      required final double stepSize,
      required final int touchdownCycles,
      required final double currentAnnealTemp}) = _$TouchdownConfigImpl;

  factory _TouchdownConfig.fromJson(Map<String, dynamic> json) =
      _$TouchdownConfigImpl.fromJson;

  @override
  bool get enabled;
  @override
  double get startAnnealTemp;
  @override
  double get endAnnealTemp;
  @override
  double get stepSize;
  @override
  int get touchdownCycles;
  @override
  double get currentAnnealTemp;
  @override
  @JsonKey(ignore: true)
  _$$TouchdownConfigImplCopyWith<_$TouchdownConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GradientConfig _$GradientConfigFromJson(Map<String, dynamic> json) {
  return _GradientConfig.fromJson(json);
}

/// @nodoc
mixin _$GradientConfig {
  bool get enabled => throw _privateConstructorUsedError;
  double get tempLow => throw _privateConstructorUsedError;
  double get tempHigh => throw _privateConstructorUsedError;
  int get positions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GradientConfigCopyWith<GradientConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GradientConfigCopyWith<$Res> {
  factory $GradientConfigCopyWith(
          GradientConfig value, $Res Function(GradientConfig) then) =
      _$GradientConfigCopyWithImpl<$Res, GradientConfig>;
  @useResult
  $Res call({bool enabled, double tempLow, double tempHigh, int positions});
}

/// @nodoc
class _$GradientConfigCopyWithImpl<$Res, $Val extends GradientConfig>
    implements $GradientConfigCopyWith<$Res> {
  _$GradientConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? tempLow = null,
    Object? tempHigh = null,
    Object? positions = null,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      tempLow: null == tempLow
          ? _value.tempLow
          : tempLow // ignore: cast_nullable_to_non_nullable
              as double,
      tempHigh: null == tempHigh
          ? _value.tempHigh
          : tempHigh // ignore: cast_nullable_to_non_nullable
              as double,
      positions: null == positions
          ? _value.positions
          : positions // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GradientConfigImplCopyWith<$Res>
    implements $GradientConfigCopyWith<$Res> {
  factory _$$GradientConfigImplCopyWith(_$GradientConfigImpl value,
          $Res Function(_$GradientConfigImpl) then) =
      __$$GradientConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool enabled, double tempLow, double tempHigh, int positions});
}

/// @nodoc
class __$$GradientConfigImplCopyWithImpl<$Res>
    extends _$GradientConfigCopyWithImpl<$Res, _$GradientConfigImpl>
    implements _$$GradientConfigImplCopyWith<$Res> {
  __$$GradientConfigImplCopyWithImpl(
      _$GradientConfigImpl _value, $Res Function(_$GradientConfigImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? tempLow = null,
    Object? tempHigh = null,
    Object? positions = null,
  }) {
    return _then(_$GradientConfigImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      tempLow: null == tempLow
          ? _value.tempLow
          : tempLow // ignore: cast_nullable_to_non_nullable
              as double,
      tempHigh: null == tempHigh
          ? _value.tempHigh
          : tempHigh // ignore: cast_nullable_to_non_nullable
              as double,
      positions: null == positions
          ? _value.positions
          : positions // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GradientConfigImpl implements _GradientConfig {
  const _$GradientConfigImpl(
      {required this.enabled,
      required this.tempLow,
      required this.tempHigh,
      required this.positions});

  factory _$GradientConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$GradientConfigImplFromJson(json);

  @override
  final bool enabled;
  @override
  final double tempLow;
  @override
  final double tempHigh;
  @override
  final int positions;

  @override
  String toString() {
    return 'GradientConfig(enabled: $enabled, tempLow: $tempLow, tempHigh: $tempHigh, positions: $positions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GradientConfigImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.tempLow, tempLow) || other.tempLow == tempLow) &&
            (identical(other.tempHigh, tempHigh) ||
                other.tempHigh == tempHigh) &&
            (identical(other.positions, positions) ||
                other.positions == positions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, enabled, tempLow, tempHigh, positions);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GradientConfigImplCopyWith<_$GradientConfigImpl> get copyWith =>
      __$$GradientConfigImplCopyWithImpl<_$GradientConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GradientConfigImplToJson(
      this,
    );
  }
}

abstract class _GradientConfig implements GradientConfig {
  const factory _GradientConfig(
      {required final bool enabled,
      required final double tempLow,
      required final double tempHigh,
      required final int positions}) = _$GradientConfigImpl;

  factory _GradientConfig.fromJson(Map<String, dynamic> json) =
      _$GradientConfigImpl.fromJson;

  @override
  bool get enabled;
  @override
  double get tempLow;
  @override
  double get tempHigh;
  @override
  int get positions;
  @override
  @JsonKey(ignore: true)
  _$$GradientConfigImplCopyWith<_$GradientConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PCRMetrics _$PCRMetricsFromJson(Map<String, dynamic> json) {
  return _PCRMetrics.fromJson(json);
}

/// @nodoc
mixin _$PCRMetrics {
  double get currentAnnealTemp => throw _privateConstructorUsedError;
  double get temperatureStability => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PCRMetricsCopyWith<PCRMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PCRMetricsCopyWith<$Res> {
  factory $PCRMetricsCopyWith(
          PCRMetrics value, $Res Function(PCRMetrics) then) =
      _$PCRMetricsCopyWithImpl<$Res, PCRMetrics>;
  @useResult
  $Res call({double currentAnnealTemp, double temperatureStability});
}

/// @nodoc
class _$PCRMetricsCopyWithImpl<$Res, $Val extends PCRMetrics>
    implements $PCRMetricsCopyWith<$Res> {
  _$PCRMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAnnealTemp = null,
    Object? temperatureStability = null,
  }) {
    return _then(_value.copyWith(
      currentAnnealTemp: null == currentAnnealTemp
          ? _value.currentAnnealTemp
          : currentAnnealTemp // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureStability: null == temperatureStability
          ? _value.temperatureStability
          : temperatureStability // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PCRMetricsImplCopyWith<$Res>
    implements $PCRMetricsCopyWith<$Res> {
  factory _$$PCRMetricsImplCopyWith(
          _$PCRMetricsImpl value, $Res Function(_$PCRMetricsImpl) then) =
      __$$PCRMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double currentAnnealTemp, double temperatureStability});
}

/// @nodoc
class __$$PCRMetricsImplCopyWithImpl<$Res>
    extends _$PCRMetricsCopyWithImpl<$Res, _$PCRMetricsImpl>
    implements _$$PCRMetricsImplCopyWith<$Res> {
  __$$PCRMetricsImplCopyWithImpl(
      _$PCRMetricsImpl _value, $Res Function(_$PCRMetricsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentAnnealTemp = null,
    Object? temperatureStability = null,
  }) {
    return _then(_$PCRMetricsImpl(
      currentAnnealTemp: null == currentAnnealTemp
          ? _value.currentAnnealTemp
          : currentAnnealTemp // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureStability: null == temperatureStability
          ? _value.temperatureStability
          : temperatureStability // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PCRMetricsImpl implements _PCRMetrics {
  const _$PCRMetricsImpl(
      {required this.currentAnnealTemp, required this.temperatureStability});

  factory _$PCRMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PCRMetricsImplFromJson(json);

  @override
  final double currentAnnealTemp;
  @override
  final double temperatureStability;

  @override
  String toString() {
    return 'PCRMetrics(currentAnnealTemp: $currentAnnealTemp, temperatureStability: $temperatureStability)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PCRMetricsImpl &&
            (identical(other.currentAnnealTemp, currentAnnealTemp) ||
                other.currentAnnealTemp == currentAnnealTemp) &&
            (identical(other.temperatureStability, temperatureStability) ||
                other.temperatureStability == temperatureStability));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, currentAnnealTemp, temperatureStability);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PCRMetricsImplCopyWith<_$PCRMetricsImpl> get copyWith =>
      __$$PCRMetricsImplCopyWithImpl<_$PCRMetricsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PCRMetricsImplToJson(
      this,
    );
  }
}

abstract class _PCRMetrics implements PCRMetrics {
  const factory _PCRMetrics(
      {required final double currentAnnealTemp,
      required final double temperatureStability}) = _$PCRMetricsImpl;

  factory _PCRMetrics.fromJson(Map<String, dynamic> json) =
      _$PCRMetricsImpl.fromJson;

  @override
  double get currentAnnealTemp;
  @override
  double get temperatureStability;
  @override
  @JsonKey(ignore: true)
  _$$PCRMetricsImplCopyWith<_$PCRMetricsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
