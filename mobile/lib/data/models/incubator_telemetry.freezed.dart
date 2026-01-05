// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'incubator_telemetry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IncubatorTelemetry _$IncubatorTelemetryFromJson(Map<String, dynamic> json) {
  return _IncubatorTelemetry.fromJson(json);
}

/// @nodoc
mixin _$IncubatorTelemetry {
  DeviceState get state => throw _privateConstructorUsedError;
  int get uptime => throw _privateConstructorUsedError;
  double get temperature => throw _privateConstructorUsedError;
  double get humidity => throw _privateConstructorUsedError;
  double get co2Level => throw _privateConstructorUsedError;
  double get temperatureSetpoint => throw _privateConstructorUsedError;
  double get humiditySetpoint => throw _privateConstructorUsedError;
  double get co2Setpoint => throw _privateConstructorUsedError;
  double get temperatureError => throw _privateConstructorUsedError;
  double get humidityError => throw _privateConstructorUsedError;
  double get co2Error => throw _privateConstructorUsedError;
  bool get temperatureStable => throw _privateConstructorUsedError;
  bool get humidityStable => throw _privateConstructorUsedError;
  bool get co2Stable => throw _privateConstructorUsedError;
  bool get environmentStable => throw _privateConstructorUsedError;
  int get timeStable => throw _privateConstructorUsedError;
  RampingStatus get ramping => throw _privateConstructorUsedError;
  IncubatorProtocol? get protocol => throw _privateConstructorUsedError;
  AlarmStatus? get alarms => throw _privateConstructorUsedError;
  bool get doorOpen => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IncubatorTelemetryCopyWith<IncubatorTelemetry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncubatorTelemetryCopyWith<$Res> {
  factory $IncubatorTelemetryCopyWith(
          IncubatorTelemetry value, $Res Function(IncubatorTelemetry) then) =
      _$IncubatorTelemetryCopyWithImpl<$Res, IncubatorTelemetry>;
  @useResult
  $Res call(
      {DeviceState state,
      int uptime,
      double temperature,
      double humidity,
      double co2Level,
      double temperatureSetpoint,
      double humiditySetpoint,
      double co2Setpoint,
      double temperatureError,
      double humidityError,
      double co2Error,
      bool temperatureStable,
      bool humidityStable,
      bool co2Stable,
      bool environmentStable,
      int timeStable,
      RampingStatus ramping,
      IncubatorProtocol? protocol,
      AlarmStatus? alarms,
      bool doorOpen,
      List<String> errors});

  $RampingStatusCopyWith<$Res> get ramping;
  $IncubatorProtocolCopyWith<$Res>? get protocol;
  $AlarmStatusCopyWith<$Res>? get alarms;
}

/// @nodoc
class _$IncubatorTelemetryCopyWithImpl<$Res, $Val extends IncubatorTelemetry>
    implements $IncubatorTelemetryCopyWith<$Res> {
  _$IncubatorTelemetryCopyWithImpl(this._value, this._then);

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
    Object? humidity = null,
    Object? co2Level = null,
    Object? temperatureSetpoint = null,
    Object? humiditySetpoint = null,
    Object? co2Setpoint = null,
    Object? temperatureError = null,
    Object? humidityError = null,
    Object? co2Error = null,
    Object? temperatureStable = null,
    Object? humidityStable = null,
    Object? co2Stable = null,
    Object? environmentStable = null,
    Object? timeStable = null,
    Object? ramping = null,
    Object? protocol = freezed,
    Object? alarms = freezed,
    Object? doorOpen = null,
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
              as double,
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as double,
      co2Level: null == co2Level
          ? _value.co2Level
          : co2Level // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureSetpoint: null == temperatureSetpoint
          ? _value.temperatureSetpoint
          : temperatureSetpoint // ignore: cast_nullable_to_non_nullable
              as double,
      humiditySetpoint: null == humiditySetpoint
          ? _value.humiditySetpoint
          : humiditySetpoint // ignore: cast_nullable_to_non_nullable
              as double,
      co2Setpoint: null == co2Setpoint
          ? _value.co2Setpoint
          : co2Setpoint // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureError: null == temperatureError
          ? _value.temperatureError
          : temperatureError // ignore: cast_nullable_to_non_nullable
              as double,
      humidityError: null == humidityError
          ? _value.humidityError
          : humidityError // ignore: cast_nullable_to_non_nullable
              as double,
      co2Error: null == co2Error
          ? _value.co2Error
          : co2Error // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureStable: null == temperatureStable
          ? _value.temperatureStable
          : temperatureStable // ignore: cast_nullable_to_non_nullable
              as bool,
      humidityStable: null == humidityStable
          ? _value.humidityStable
          : humidityStable // ignore: cast_nullable_to_non_nullable
              as bool,
      co2Stable: null == co2Stable
          ? _value.co2Stable
          : co2Stable // ignore: cast_nullable_to_non_nullable
              as bool,
      environmentStable: null == environmentStable
          ? _value.environmentStable
          : environmentStable // ignore: cast_nullable_to_non_nullable
              as bool,
      timeStable: null == timeStable
          ? _value.timeStable
          : timeStable // ignore: cast_nullable_to_non_nullable
              as int,
      ramping: null == ramping
          ? _value.ramping
          : ramping // ignore: cast_nullable_to_non_nullable
              as RampingStatus,
      protocol: freezed == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as IncubatorProtocol?,
      alarms: freezed == alarms
          ? _value.alarms
          : alarms // ignore: cast_nullable_to_non_nullable
              as AlarmStatus?,
      doorOpen: null == doorOpen
          ? _value.doorOpen
          : doorOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RampingStatusCopyWith<$Res> get ramping {
    return $RampingStatusCopyWith<$Res>(_value.ramping, (value) {
      return _then(_value.copyWith(ramping: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IncubatorProtocolCopyWith<$Res>? get protocol {
    if (_value.protocol == null) {
      return null;
    }

    return $IncubatorProtocolCopyWith<$Res>(_value.protocol!, (value) {
      return _then(_value.copyWith(protocol: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AlarmStatusCopyWith<$Res>? get alarms {
    if (_value.alarms == null) {
      return null;
    }

    return $AlarmStatusCopyWith<$Res>(_value.alarms!, (value) {
      return _then(_value.copyWith(alarms: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IncubatorTelemetryImplCopyWith<$Res>
    implements $IncubatorTelemetryCopyWith<$Res> {
  factory _$$IncubatorTelemetryImplCopyWith(_$IncubatorTelemetryImpl value,
          $Res Function(_$IncubatorTelemetryImpl) then) =
      __$$IncubatorTelemetryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DeviceState state,
      int uptime,
      double temperature,
      double humidity,
      double co2Level,
      double temperatureSetpoint,
      double humiditySetpoint,
      double co2Setpoint,
      double temperatureError,
      double humidityError,
      double co2Error,
      bool temperatureStable,
      bool humidityStable,
      bool co2Stable,
      bool environmentStable,
      int timeStable,
      RampingStatus ramping,
      IncubatorProtocol? protocol,
      AlarmStatus? alarms,
      bool doorOpen,
      List<String> errors});

  @override
  $RampingStatusCopyWith<$Res> get ramping;
  @override
  $IncubatorProtocolCopyWith<$Res>? get protocol;
  @override
  $AlarmStatusCopyWith<$Res>? get alarms;
}

/// @nodoc
class __$$IncubatorTelemetryImplCopyWithImpl<$Res>
    extends _$IncubatorTelemetryCopyWithImpl<$Res, _$IncubatorTelemetryImpl>
    implements _$$IncubatorTelemetryImplCopyWith<$Res> {
  __$$IncubatorTelemetryImplCopyWithImpl(_$IncubatorTelemetryImpl _value,
      $Res Function(_$IncubatorTelemetryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? uptime = null,
    Object? temperature = null,
    Object? humidity = null,
    Object? co2Level = null,
    Object? temperatureSetpoint = null,
    Object? humiditySetpoint = null,
    Object? co2Setpoint = null,
    Object? temperatureError = null,
    Object? humidityError = null,
    Object? co2Error = null,
    Object? temperatureStable = null,
    Object? humidityStable = null,
    Object? co2Stable = null,
    Object? environmentStable = null,
    Object? timeStable = null,
    Object? ramping = null,
    Object? protocol = freezed,
    Object? alarms = freezed,
    Object? doorOpen = null,
    Object? errors = null,
  }) {
    return _then(_$IncubatorTelemetryImpl(
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
              as double,
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as double,
      co2Level: null == co2Level
          ? _value.co2Level
          : co2Level // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureSetpoint: null == temperatureSetpoint
          ? _value.temperatureSetpoint
          : temperatureSetpoint // ignore: cast_nullable_to_non_nullable
              as double,
      humiditySetpoint: null == humiditySetpoint
          ? _value.humiditySetpoint
          : humiditySetpoint // ignore: cast_nullable_to_non_nullable
              as double,
      co2Setpoint: null == co2Setpoint
          ? _value.co2Setpoint
          : co2Setpoint // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureError: null == temperatureError
          ? _value.temperatureError
          : temperatureError // ignore: cast_nullable_to_non_nullable
              as double,
      humidityError: null == humidityError
          ? _value.humidityError
          : humidityError // ignore: cast_nullable_to_non_nullable
              as double,
      co2Error: null == co2Error
          ? _value.co2Error
          : co2Error // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureStable: null == temperatureStable
          ? _value.temperatureStable
          : temperatureStable // ignore: cast_nullable_to_non_nullable
              as bool,
      humidityStable: null == humidityStable
          ? _value.humidityStable
          : humidityStable // ignore: cast_nullable_to_non_nullable
              as bool,
      co2Stable: null == co2Stable
          ? _value.co2Stable
          : co2Stable // ignore: cast_nullable_to_non_nullable
              as bool,
      environmentStable: null == environmentStable
          ? _value.environmentStable
          : environmentStable // ignore: cast_nullable_to_non_nullable
              as bool,
      timeStable: null == timeStable
          ? _value.timeStable
          : timeStable // ignore: cast_nullable_to_non_nullable
              as int,
      ramping: null == ramping
          ? _value.ramping
          : ramping // ignore: cast_nullable_to_non_nullable
              as RampingStatus,
      protocol: freezed == protocol
          ? _value.protocol
          : protocol // ignore: cast_nullable_to_non_nullable
              as IncubatorProtocol?,
      alarms: freezed == alarms
          ? _value.alarms
          : alarms // ignore: cast_nullable_to_non_nullable
              as AlarmStatus?,
      doorOpen: null == doorOpen
          ? _value.doorOpen
          : doorOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IncubatorTelemetryImpl implements _IncubatorTelemetry {
  const _$IncubatorTelemetryImpl(
      {required this.state,
      required this.uptime,
      required this.temperature,
      required this.humidity,
      required this.co2Level,
      required this.temperatureSetpoint,
      required this.humiditySetpoint,
      required this.co2Setpoint,
      required this.temperatureError,
      required this.humidityError,
      required this.co2Error,
      required this.temperatureStable,
      required this.humidityStable,
      required this.co2Stable,
      required this.environmentStable,
      required this.timeStable,
      required this.ramping,
      this.protocol,
      this.alarms,
      required this.doorOpen,
      final List<String> errors = const []})
      : _errors = errors;

  factory _$IncubatorTelemetryImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncubatorTelemetryImplFromJson(json);

  @override
  final DeviceState state;
  @override
  final int uptime;
  @override
  final double temperature;
  @override
  final double humidity;
  @override
  final double co2Level;
  @override
  final double temperatureSetpoint;
  @override
  final double humiditySetpoint;
  @override
  final double co2Setpoint;
  @override
  final double temperatureError;
  @override
  final double humidityError;
  @override
  final double co2Error;
  @override
  final bool temperatureStable;
  @override
  final bool humidityStable;
  @override
  final bool co2Stable;
  @override
  final bool environmentStable;
  @override
  final int timeStable;
  @override
  final RampingStatus ramping;
  @override
  final IncubatorProtocol? protocol;
  @override
  final AlarmStatus? alarms;
  @override
  final bool doorOpen;
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
    return 'IncubatorTelemetry(state: $state, uptime: $uptime, temperature: $temperature, humidity: $humidity, co2Level: $co2Level, temperatureSetpoint: $temperatureSetpoint, humiditySetpoint: $humiditySetpoint, co2Setpoint: $co2Setpoint, temperatureError: $temperatureError, humidityError: $humidityError, co2Error: $co2Error, temperatureStable: $temperatureStable, humidityStable: $humidityStable, co2Stable: $co2Stable, environmentStable: $environmentStable, timeStable: $timeStable, ramping: $ramping, protocol: $protocol, alarms: $alarms, doorOpen: $doorOpen, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncubatorTelemetryImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.uptime, uptime) || other.uptime == uptime) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.co2Level, co2Level) ||
                other.co2Level == co2Level) &&
            (identical(other.temperatureSetpoint, temperatureSetpoint) ||
                other.temperatureSetpoint == temperatureSetpoint) &&
            (identical(other.humiditySetpoint, humiditySetpoint) ||
                other.humiditySetpoint == humiditySetpoint) &&
            (identical(other.co2Setpoint, co2Setpoint) ||
                other.co2Setpoint == co2Setpoint) &&
            (identical(other.temperatureError, temperatureError) ||
                other.temperatureError == temperatureError) &&
            (identical(other.humidityError, humidityError) ||
                other.humidityError == humidityError) &&
            (identical(other.co2Error, co2Error) ||
                other.co2Error == co2Error) &&
            (identical(other.temperatureStable, temperatureStable) ||
                other.temperatureStable == temperatureStable) &&
            (identical(other.humidityStable, humidityStable) ||
                other.humidityStable == humidityStable) &&
            (identical(other.co2Stable, co2Stable) ||
                other.co2Stable == co2Stable) &&
            (identical(other.environmentStable, environmentStable) ||
                other.environmentStable == environmentStable) &&
            (identical(other.timeStable, timeStable) ||
                other.timeStable == timeStable) &&
            (identical(other.ramping, ramping) || other.ramping == ramping) &&
            (identical(other.protocol, protocol) ||
                other.protocol == protocol) &&
            (identical(other.alarms, alarms) || other.alarms == alarms) &&
            (identical(other.doorOpen, doorOpen) ||
                other.doorOpen == doorOpen) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        state,
        uptime,
        temperature,
        humidity,
        co2Level,
        temperatureSetpoint,
        humiditySetpoint,
        co2Setpoint,
        temperatureError,
        humidityError,
        co2Error,
        temperatureStable,
        humidityStable,
        co2Stable,
        environmentStable,
        timeStable,
        ramping,
        protocol,
        alarms,
        doorOpen,
        const DeepCollectionEquality().hash(_errors)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncubatorTelemetryImplCopyWith<_$IncubatorTelemetryImpl> get copyWith =>
      __$$IncubatorTelemetryImplCopyWithImpl<_$IncubatorTelemetryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncubatorTelemetryImplToJson(
      this,
    );
  }
}

abstract class _IncubatorTelemetry implements IncubatorTelemetry {
  const factory _IncubatorTelemetry(
      {required final DeviceState state,
      required final int uptime,
      required final double temperature,
      required final double humidity,
      required final double co2Level,
      required final double temperatureSetpoint,
      required final double humiditySetpoint,
      required final double co2Setpoint,
      required final double temperatureError,
      required final double humidityError,
      required final double co2Error,
      required final bool temperatureStable,
      required final bool humidityStable,
      required final bool co2Stable,
      required final bool environmentStable,
      required final int timeStable,
      required final RampingStatus ramping,
      final IncubatorProtocol? protocol,
      final AlarmStatus? alarms,
      required final bool doorOpen,
      final List<String> errors}) = _$IncubatorTelemetryImpl;

  factory _IncubatorTelemetry.fromJson(Map<String, dynamic> json) =
      _$IncubatorTelemetryImpl.fromJson;

  @override
  DeviceState get state;
  @override
  int get uptime;
  @override
  double get temperature;
  @override
  double get humidity;
  @override
  double get co2Level;
  @override
  double get temperatureSetpoint;
  @override
  double get humiditySetpoint;
  @override
  double get co2Setpoint;
  @override
  double get temperatureError;
  @override
  double get humidityError;
  @override
  double get co2Error;
  @override
  bool get temperatureStable;
  @override
  bool get humidityStable;
  @override
  bool get co2Stable;
  @override
  bool get environmentStable;
  @override
  int get timeStable;
  @override
  RampingStatus get ramping;
  @override
  IncubatorProtocol? get protocol;
  @override
  AlarmStatus? get alarms;
  @override
  bool get doorOpen;
  @override
  List<String> get errors;
  @override
  @JsonKey(ignore: true)
  _$$IncubatorTelemetryImplCopyWith<_$IncubatorTelemetryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RampingStatus _$RampingStatusFromJson(Map<String, dynamic> json) {
  return _RampingStatus.fromJson(json);
}

/// @nodoc
mixin _$RampingStatus {
  bool get temperature => throw _privateConstructorUsedError;
  bool get humidity => throw _privateConstructorUsedError;
  bool get co2 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RampingStatusCopyWith<RampingStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RampingStatusCopyWith<$Res> {
  factory $RampingStatusCopyWith(
          RampingStatus value, $Res Function(RampingStatus) then) =
      _$RampingStatusCopyWithImpl<$Res, RampingStatus>;
  @useResult
  $Res call({bool temperature, bool humidity, bool co2});
}

/// @nodoc
class _$RampingStatusCopyWithImpl<$Res, $Val extends RampingStatus>
    implements $RampingStatusCopyWith<$Res> {
  _$RampingStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temperature = null,
    Object? humidity = null,
    Object? co2 = null,
  }) {
    return _then(_value.copyWith(
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as bool,
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as bool,
      co2: null == co2
          ? _value.co2
          : co2 // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RampingStatusImplCopyWith<$Res>
    implements $RampingStatusCopyWith<$Res> {
  factory _$$RampingStatusImplCopyWith(
          _$RampingStatusImpl value, $Res Function(_$RampingStatusImpl) then) =
      __$$RampingStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool temperature, bool humidity, bool co2});
}

/// @nodoc
class __$$RampingStatusImplCopyWithImpl<$Res>
    extends _$RampingStatusCopyWithImpl<$Res, _$RampingStatusImpl>
    implements _$$RampingStatusImplCopyWith<$Res> {
  __$$RampingStatusImplCopyWithImpl(
      _$RampingStatusImpl _value, $Res Function(_$RampingStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temperature = null,
    Object? humidity = null,
    Object? co2 = null,
  }) {
    return _then(_$RampingStatusImpl(
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as bool,
      humidity: null == humidity
          ? _value.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as bool,
      co2: null == co2
          ? _value.co2
          : co2 // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RampingStatusImpl implements _RampingStatus {
  const _$RampingStatusImpl(
      {required this.temperature, required this.humidity, required this.co2});

  factory _$RampingStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$RampingStatusImplFromJson(json);

  @override
  final bool temperature;
  @override
  final bool humidity;
  @override
  final bool co2;

  @override
  String toString() {
    return 'RampingStatus(temperature: $temperature, humidity: $humidity, co2: $co2)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RampingStatusImpl &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.co2, co2) || other.co2 == co2));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, temperature, humidity, co2);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RampingStatusImplCopyWith<_$RampingStatusImpl> get copyWith =>
      __$$RampingStatusImplCopyWithImpl<_$RampingStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RampingStatusImplToJson(
      this,
    );
  }
}

abstract class _RampingStatus implements RampingStatus {
  const factory _RampingStatus(
      {required final bool temperature,
      required final bool humidity,
      required final bool co2}) = _$RampingStatusImpl;

  factory _RampingStatus.fromJson(Map<String, dynamic> json) =
      _$RampingStatusImpl.fromJson;

  @override
  bool get temperature;
  @override
  bool get humidity;
  @override
  bool get co2;
  @override
  @JsonKey(ignore: true)
  _$$RampingStatusImplCopyWith<_$RampingStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IncubatorProtocol _$IncubatorProtocolFromJson(Map<String, dynamic> json) {
  return _IncubatorProtocol.fromJson(json);
}

/// @nodoc
mixin _$IncubatorProtocol {
  ProtocolState get state => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  int get currentStage => throw _privateConstructorUsedError;
  int get totalStages => throw _privateConstructorUsedError;
  String get stageName => throw _privateConstructorUsedError;
  int get stageTimeRemaining => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IncubatorProtocolCopyWith<IncubatorProtocol> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IncubatorProtocolCopyWith<$Res> {
  factory $IncubatorProtocolCopyWith(
          IncubatorProtocol value, $Res Function(IncubatorProtocol) then) =
      _$IncubatorProtocolCopyWithImpl<$Res, IncubatorProtocol>;
  @useResult
  $Res call(
      {ProtocolState state,
      String name,
      int type,
      int currentStage,
      int totalStages,
      String stageName,
      int stageTimeRemaining,
      double progress});
}

/// @nodoc
class _$IncubatorProtocolCopyWithImpl<$Res, $Val extends IncubatorProtocol>
    implements $IncubatorProtocolCopyWith<$Res> {
  _$IncubatorProtocolCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? name = null,
    Object? type = null,
    Object? currentStage = null,
    Object? totalStages = null,
    Object? stageName = null,
    Object? stageTimeRemaining = null,
    Object? progress = null,
  }) {
    return _then(_value.copyWith(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ProtocolState,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      currentStage: null == currentStage
          ? _value.currentStage
          : currentStage // ignore: cast_nullable_to_non_nullable
              as int,
      totalStages: null == totalStages
          ? _value.totalStages
          : totalStages // ignore: cast_nullable_to_non_nullable
              as int,
      stageName: null == stageName
          ? _value.stageName
          : stageName // ignore: cast_nullable_to_non_nullable
              as String,
      stageTimeRemaining: null == stageTimeRemaining
          ? _value.stageTimeRemaining
          : stageTimeRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IncubatorProtocolImplCopyWith<$Res>
    implements $IncubatorProtocolCopyWith<$Res> {
  factory _$$IncubatorProtocolImplCopyWith(_$IncubatorProtocolImpl value,
          $Res Function(_$IncubatorProtocolImpl) then) =
      __$$IncubatorProtocolImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProtocolState state,
      String name,
      int type,
      int currentStage,
      int totalStages,
      String stageName,
      int stageTimeRemaining,
      double progress});
}

/// @nodoc
class __$$IncubatorProtocolImplCopyWithImpl<$Res>
    extends _$IncubatorProtocolCopyWithImpl<$Res, _$IncubatorProtocolImpl>
    implements _$$IncubatorProtocolImplCopyWith<$Res> {
  __$$IncubatorProtocolImplCopyWithImpl(_$IncubatorProtocolImpl _value,
      $Res Function(_$IncubatorProtocolImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? name = null,
    Object? type = null,
    Object? currentStage = null,
    Object? totalStages = null,
    Object? stageName = null,
    Object? stageTimeRemaining = null,
    Object? progress = null,
  }) {
    return _then(_$IncubatorProtocolImpl(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ProtocolState,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      currentStage: null == currentStage
          ? _value.currentStage
          : currentStage // ignore: cast_nullable_to_non_nullable
              as int,
      totalStages: null == totalStages
          ? _value.totalStages
          : totalStages // ignore: cast_nullable_to_non_nullable
              as int,
      stageName: null == stageName
          ? _value.stageName
          : stageName // ignore: cast_nullable_to_non_nullable
              as String,
      stageTimeRemaining: null == stageTimeRemaining
          ? _value.stageTimeRemaining
          : stageTimeRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IncubatorProtocolImpl implements _IncubatorProtocol {
  const _$IncubatorProtocolImpl(
      {required this.state,
      required this.name,
      required this.type,
      required this.currentStage,
      required this.totalStages,
      required this.stageName,
      required this.stageTimeRemaining,
      required this.progress});

  factory _$IncubatorProtocolImpl.fromJson(Map<String, dynamic> json) =>
      _$$IncubatorProtocolImplFromJson(json);

  @override
  final ProtocolState state;
  @override
  final String name;
  @override
  final int type;
  @override
  final int currentStage;
  @override
  final int totalStages;
  @override
  final String stageName;
  @override
  final int stageTimeRemaining;
  @override
  final double progress;

  @override
  String toString() {
    return 'IncubatorProtocol(state: $state, name: $name, type: $type, currentStage: $currentStage, totalStages: $totalStages, stageName: $stageName, stageTimeRemaining: $stageTimeRemaining, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IncubatorProtocolImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.currentStage, currentStage) ||
                other.currentStage == currentStage) &&
            (identical(other.totalStages, totalStages) ||
                other.totalStages == totalStages) &&
            (identical(other.stageName, stageName) ||
                other.stageName == stageName) &&
            (identical(other.stageTimeRemaining, stageTimeRemaining) ||
                other.stageTimeRemaining == stageTimeRemaining) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, state, name, type, currentStage,
      totalStages, stageName, stageTimeRemaining, progress);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IncubatorProtocolImplCopyWith<_$IncubatorProtocolImpl> get copyWith =>
      __$$IncubatorProtocolImplCopyWithImpl<_$IncubatorProtocolImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IncubatorProtocolImplToJson(
      this,
    );
  }
}

abstract class _IncubatorProtocol implements IncubatorProtocol {
  const factory _IncubatorProtocol(
      {required final ProtocolState state,
      required final String name,
      required final int type,
      required final int currentStage,
      required final int totalStages,
      required final String stageName,
      required final int stageTimeRemaining,
      required final double progress}) = _$IncubatorProtocolImpl;

  factory _IncubatorProtocol.fromJson(Map<String, dynamic> json) =
      _$IncubatorProtocolImpl.fromJson;

  @override
  ProtocolState get state;
  @override
  String get name;
  @override
  int get type;
  @override
  int get currentStage;
  @override
  int get totalStages;
  @override
  String get stageName;
  @override
  int get stageTimeRemaining;
  @override
  double get progress;
  @override
  @JsonKey(ignore: true)
  _$$IncubatorProtocolImplCopyWith<_$IncubatorProtocolImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AlarmStatus _$AlarmStatusFromJson(Map<String, dynamic> json) {
  return _AlarmStatus.fromJson(json);
}

/// @nodoc
mixin _$AlarmStatus {
  int get activeCount => throw _privateConstructorUsedError;
  bool get hasCritical => throw _privateConstructorUsedError;
  List<AlarmData> get active => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlarmStatusCopyWith<AlarmStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmStatusCopyWith<$Res> {
  factory $AlarmStatusCopyWith(
          AlarmStatus value, $Res Function(AlarmStatus) then) =
      _$AlarmStatusCopyWithImpl<$Res, AlarmStatus>;
  @useResult
  $Res call({int activeCount, bool hasCritical, List<AlarmData> active});
}

/// @nodoc
class _$AlarmStatusCopyWithImpl<$Res, $Val extends AlarmStatus>
    implements $AlarmStatusCopyWith<$Res> {
  _$AlarmStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeCount = null,
    Object? hasCritical = null,
    Object? active = null,
  }) {
    return _then(_value.copyWith(
      activeCount: null == activeCount
          ? _value.activeCount
          : activeCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasCritical: null == hasCritical
          ? _value.hasCritical
          : hasCritical // ignore: cast_nullable_to_non_nullable
              as bool,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as List<AlarmData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmStatusImplCopyWith<$Res>
    implements $AlarmStatusCopyWith<$Res> {
  factory _$$AlarmStatusImplCopyWith(
          _$AlarmStatusImpl value, $Res Function(_$AlarmStatusImpl) then) =
      __$$AlarmStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int activeCount, bool hasCritical, List<AlarmData> active});
}

/// @nodoc
class __$$AlarmStatusImplCopyWithImpl<$Res>
    extends _$AlarmStatusCopyWithImpl<$Res, _$AlarmStatusImpl>
    implements _$$AlarmStatusImplCopyWith<$Res> {
  __$$AlarmStatusImplCopyWithImpl(
      _$AlarmStatusImpl _value, $Res Function(_$AlarmStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeCount = null,
    Object? hasCritical = null,
    Object? active = null,
  }) {
    return _then(_$AlarmStatusImpl(
      activeCount: null == activeCount
          ? _value.activeCount
          : activeCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasCritical: null == hasCritical
          ? _value.hasCritical
          : hasCritical // ignore: cast_nullable_to_non_nullable
              as bool,
      active: null == active
          ? _value._active
          : active // ignore: cast_nullable_to_non_nullable
              as List<AlarmData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlarmStatusImpl implements _AlarmStatus {
  const _$AlarmStatusImpl(
      {required this.activeCount,
      required this.hasCritical,
      required final List<AlarmData> active})
      : _active = active;

  factory _$AlarmStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlarmStatusImplFromJson(json);

  @override
  final int activeCount;
  @override
  final bool hasCritical;
  final List<AlarmData> _active;
  @override
  List<AlarmData> get active {
    if (_active is EqualUnmodifiableListView) return _active;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_active);
  }

  @override
  String toString() {
    return 'AlarmStatus(activeCount: $activeCount, hasCritical: $hasCritical, active: $active)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmStatusImpl &&
            (identical(other.activeCount, activeCount) ||
                other.activeCount == activeCount) &&
            (identical(other.hasCritical, hasCritical) ||
                other.hasCritical == hasCritical) &&
            const DeepCollectionEquality().equals(other._active, _active));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, activeCount, hasCritical,
      const DeepCollectionEquality().hash(_active));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmStatusImplCopyWith<_$AlarmStatusImpl> get copyWith =>
      __$$AlarmStatusImplCopyWithImpl<_$AlarmStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlarmStatusImplToJson(
      this,
    );
  }
}

abstract class _AlarmStatus implements AlarmStatus {
  const factory _AlarmStatus(
      {required final int activeCount,
      required final bool hasCritical,
      required final List<AlarmData> active}) = _$AlarmStatusImpl;

  factory _AlarmStatus.fromJson(Map<String, dynamic> json) =
      _$AlarmStatusImpl.fromJson;

  @override
  int get activeCount;
  @override
  bool get hasCritical;
  @override
  List<AlarmData> get active;
  @override
  @JsonKey(ignore: true)
  _$$AlarmStatusImplCopyWith<_$AlarmStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AlarmData _$AlarmDataFromJson(Map<String, dynamic> json) {
  return _AlarmData.fromJson(json);
}

/// @nodoc
mixin _$AlarmData {
  AlarmType get type => throw _privateConstructorUsedError;
  AlarmSeverity get severity => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  int get timestamp => throw _privateConstructorUsedError;
  bool get acknowledged => throw _privateConstructorUsedError;
  double get currentValue => throw _privateConstructorUsedError;
  double get threshold => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlarmDataCopyWith<AlarmData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmDataCopyWith<$Res> {
  factory $AlarmDataCopyWith(AlarmData value, $Res Function(AlarmData) then) =
      _$AlarmDataCopyWithImpl<$Res, AlarmData>;
  @useResult
  $Res call(
      {AlarmType type,
      AlarmSeverity severity,
      String message,
      int timestamp,
      bool acknowledged,
      double currentValue,
      double threshold});
}

/// @nodoc
class _$AlarmDataCopyWithImpl<$Res, $Val extends AlarmData>
    implements $AlarmDataCopyWith<$Res> {
  _$AlarmDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? severity = null,
    Object? message = null,
    Object? timestamp = null,
    Object? acknowledged = null,
    Object? currentValue = null,
    Object? threshold = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AlarmType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as AlarmSeverity,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      acknowledged: null == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double,
      threshold: null == threshold
          ? _value.threshold
          : threshold // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AlarmDataImplCopyWith<$Res>
    implements $AlarmDataCopyWith<$Res> {
  factory _$$AlarmDataImplCopyWith(
          _$AlarmDataImpl value, $Res Function(_$AlarmDataImpl) then) =
      __$$AlarmDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AlarmType type,
      AlarmSeverity severity,
      String message,
      int timestamp,
      bool acknowledged,
      double currentValue,
      double threshold});
}

/// @nodoc
class __$$AlarmDataImplCopyWithImpl<$Res>
    extends _$AlarmDataCopyWithImpl<$Res, _$AlarmDataImpl>
    implements _$$AlarmDataImplCopyWith<$Res> {
  __$$AlarmDataImplCopyWithImpl(
      _$AlarmDataImpl _value, $Res Function(_$AlarmDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? severity = null,
    Object? message = null,
    Object? timestamp = null,
    Object? acknowledged = null,
    Object? currentValue = null,
    Object? threshold = null,
  }) {
    return _then(_$AlarmDataImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AlarmType,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as AlarmSeverity,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as int,
      acknowledged: null == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double,
      threshold: null == threshold
          ? _value.threshold
          : threshold // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AlarmDataImpl implements _AlarmData {
  const _$AlarmDataImpl(
      {required this.type,
      required this.severity,
      required this.message,
      required this.timestamp,
      required this.acknowledged,
      required this.currentValue,
      required this.threshold});

  factory _$AlarmDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AlarmDataImplFromJson(json);

  @override
  final AlarmType type;
  @override
  final AlarmSeverity severity;
  @override
  final String message;
  @override
  final int timestamp;
  @override
  final bool acknowledged;
  @override
  final double currentValue;
  @override
  final double threshold;

  @override
  String toString() {
    return 'AlarmData(type: $type, severity: $severity, message: $message, timestamp: $timestamp, acknowledged: $acknowledged, currentValue: $currentValue, threshold: $threshold)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlarmDataImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.acknowledged, acknowledged) ||
                other.acknowledged == acknowledged) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.threshold, threshold) ||
                other.threshold == threshold));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, severity, message,
      timestamp, acknowledged, currentValue, threshold);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AlarmDataImplCopyWith<_$AlarmDataImpl> get copyWith =>
      __$$AlarmDataImplCopyWithImpl<_$AlarmDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AlarmDataImplToJson(
      this,
    );
  }
}

abstract class _AlarmData implements AlarmData {
  const factory _AlarmData(
      {required final AlarmType type,
      required final AlarmSeverity severity,
      required final String message,
      required final int timestamp,
      required final bool acknowledged,
      required final double currentValue,
      required final double threshold}) = _$AlarmDataImpl;

  factory _AlarmData.fromJson(Map<String, dynamic> json) =
      _$AlarmDataImpl.fromJson;

  @override
  AlarmType get type;
  @override
  AlarmSeverity get severity;
  @override
  String get message;
  @override
  int get timestamp;
  @override
  bool get acknowledged;
  @override
  double get currentValue;
  @override
  double get threshold;
  @override
  @JsonKey(ignore: true)
  _$$AlarmDataImplCopyWith<_$AlarmDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
