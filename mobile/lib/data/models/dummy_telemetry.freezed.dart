// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dummy_telemetry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DummyTelemetry _$DummyTelemetryFromJson(Map<String, dynamic> json) {
  return _DummyTelemetry.fromJson(json);
}

/// @nodoc
mixin _$DummyTelemetry {
  DeviceState get state => throw _privateConstructorUsedError;
  int get uptime => throw _privateConstructorUsedError;
  double get temperature => throw _privateConstructorUsedError;
  double get setpoint => throw _privateConstructorUsedError;
  List<String> get errors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DummyTelemetryCopyWith<DummyTelemetry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DummyTelemetryCopyWith<$Res> {
  factory $DummyTelemetryCopyWith(
          DummyTelemetry value, $Res Function(DummyTelemetry) then) =
      _$DummyTelemetryCopyWithImpl<$Res, DummyTelemetry>;
  @useResult
  $Res call(
      {DeviceState state,
      int uptime,
      double temperature,
      double setpoint,
      List<String> errors});
}

/// @nodoc
class _$DummyTelemetryCopyWithImpl<$Res, $Val extends DummyTelemetry>
    implements $DummyTelemetryCopyWith<$Res> {
  _$DummyTelemetryCopyWithImpl(this._value, this._then);

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
      setpoint: null == setpoint
          ? _value.setpoint
          : setpoint // ignore: cast_nullable_to_non_nullable
              as double,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DummyTelemetryImplCopyWith<$Res>
    implements $DummyTelemetryCopyWith<$Res> {
  factory _$$DummyTelemetryImplCopyWith(_$DummyTelemetryImpl value,
          $Res Function(_$DummyTelemetryImpl) then) =
      __$$DummyTelemetryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DeviceState state,
      int uptime,
      double temperature,
      double setpoint,
      List<String> errors});
}

/// @nodoc
class __$$DummyTelemetryImplCopyWithImpl<$Res>
    extends _$DummyTelemetryCopyWithImpl<$Res, _$DummyTelemetryImpl>
    implements _$$DummyTelemetryImplCopyWith<$Res> {
  __$$DummyTelemetryImplCopyWithImpl(
      _$DummyTelemetryImpl _value, $Res Function(_$DummyTelemetryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? uptime = null,
    Object? temperature = null,
    Object? setpoint = null,
    Object? errors = null,
  }) {
    return _then(_$DummyTelemetryImpl(
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
      setpoint: null == setpoint
          ? _value.setpoint
          : setpoint // ignore: cast_nullable_to_non_nullable
              as double,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DummyTelemetryImpl implements _DummyTelemetry {
  const _$DummyTelemetryImpl(
      {required this.state,
      required this.uptime,
      required this.temperature,
      required this.setpoint,
      final List<String> errors = const []})
      : _errors = errors;

  factory _$DummyTelemetryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DummyTelemetryImplFromJson(json);

  @override
  final DeviceState state;
  @override
  final int uptime;
  @override
  final double temperature;
  @override
  final double setpoint;
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
    return 'DummyTelemetry(state: $state, uptime: $uptime, temperature: $temperature, setpoint: $setpoint, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DummyTelemetryImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.uptime, uptime) || other.uptime == uptime) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.setpoint, setpoint) ||
                other.setpoint == setpoint) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, state, uptime, temperature,
      setpoint, const DeepCollectionEquality().hash(_errors));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DummyTelemetryImplCopyWith<_$DummyTelemetryImpl> get copyWith =>
      __$$DummyTelemetryImplCopyWithImpl<_$DummyTelemetryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DummyTelemetryImplToJson(
      this,
    );
  }
}

abstract class _DummyTelemetry implements DummyTelemetry {
  const factory _DummyTelemetry(
      {required final DeviceState state,
      required final int uptime,
      required final double temperature,
      required final double setpoint,
      final List<String> errors}) = _$DummyTelemetryImpl;

  factory _DummyTelemetry.fromJson(Map<String, dynamic> json) =
      _$DummyTelemetryImpl.fromJson;

  @override
  DeviceState get state;
  @override
  int get uptime;
  @override
  double get temperature;
  @override
  double get setpoint;
  @override
  List<String> get errors;
  @override
  @JsonKey(ignore: true)
  _$$DummyTelemetryImplCopyWith<_$DummyTelemetryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
