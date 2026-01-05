import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/constants/device_types.dart';

part 'incubator_telemetry.freezed.dart';
part 'incubator_telemetry.g.dart';

/// Incubator device telemetry data
@freezed
class IncubatorTelemetry with _$IncubatorTelemetry {
  const factory IncubatorTelemetry({
    required DeviceState state,
    required int uptime,
    required double temperature,
    required double humidity,
    required double co2Level,
    required double temperatureSetpoint,
    required double humiditySetpoint,
    required double co2Setpoint,
    required double temperatureError,
    required double humidityError,
    required double co2Error,
    required bool temperatureStable,
    required bool humidityStable,
    required bool co2Stable,
    required bool environmentStable,
    required int timeStable,
    required RampingStatus ramping,
    IncubatorProtocol? protocol,
    AlarmStatus? alarms,
    required bool doorOpen,
    @Default([]) List<String> errors,
  }) = _IncubatorTelemetry;

  factory IncubatorTelemetry.fromJson(Map<String, dynamic> json) =>
      _$IncubatorTelemetryFromJson(json);
}

/// Ramping status
@freezed
class RampingStatus with _$RampingStatus {
  const factory RampingStatus({
    required bool temperature,
    required bool humidity,
    required bool co2,
  }) = _RampingStatus;

  factory RampingStatus.fromJson(Map<String, dynamic> json) =>
      _$RampingStatusFromJson(json);
}

/// Incubator protocol
@freezed
class IncubatorProtocol with _$IncubatorProtocol {
  const factory IncubatorProtocol({
    required ProtocolState state,
    required String name,
    required int type,
    required int currentStage,
    required int totalStages,
    required String stageName,
    required int stageTimeRemaining,
    required double progress,
  }) = _IncubatorProtocol;

  factory IncubatorProtocol.fromJson(Map<String, dynamic> json) =>
      _$IncubatorProtocolFromJson(json);
}

/// Alarm status
@freezed
class AlarmStatus with _$AlarmStatus {
  const factory AlarmStatus({
    required int activeCount,
    required bool hasCritical,
    required List<AlarmData> active,
  }) = _AlarmStatus;

  factory AlarmStatus.fromJson(Map<String, dynamic> json) =>
      _$AlarmStatusFromJson(json);
}

/// Individual alarm data
@freezed
class AlarmData with _$AlarmData {
  const factory AlarmData({
    required AlarmType type,
    required AlarmSeverity severity,
    required String message,
    required int timestamp,
    required bool acknowledged,
    required double currentValue,
    required double threshold,
  }) = _AlarmData;

  factory AlarmData.fromJson(Map<String, dynamic> json) =>
      _$AlarmDataFromJson(json);
}
