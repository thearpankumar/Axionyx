import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/constants/device_types.dart';

part 'dummy_telemetry.freezed.dart';
part 'dummy_telemetry.g.dart';

/// Dummy device telemetry data
@freezed
class DummyTelemetry with _$DummyTelemetry {
  const factory DummyTelemetry({
    required DeviceState state,
    required int uptime,
    required double temperature,
    required double setpoint,
    @Default([]) List<String> errors,
  }) = _DummyTelemetry;

  factory DummyTelemetry.fromJson(Map<String, dynamic> json) =>
      _$DummyTelemetryFromJson(json);
}
