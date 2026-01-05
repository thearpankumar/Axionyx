import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/constants/device_types.dart';

part 'pcr_telemetry.freezed.dart';
part 'pcr_telemetry.g.dart';

/// PCR device telemetry data
@freezed
class PCRTelemetry with _$PCRTelemetry {
  const factory PCRTelemetry({
    required DeviceState state,
    required int uptime,
    required List<double> temperature,
    required List<double> setpoint,
    required PCRPhase currentPhase,
    required int cycleNumber,
    required int totalCycles,
    required int phaseTimeRemaining,
    required int totalTimeRemaining,
    required double progress,
    PCRProgram? program,
    PCRMetrics? metrics,
    @Default([]) List<String> errors,
  }) = _PCRTelemetry;

  factory PCRTelemetry.fromJson(Map<String, dynamic> json) =>
      _$PCRTelemetryFromJson(json);
}

/// PCR program configuration
@freezed
class PCRProgram with _$PCRProgram {
  const factory PCRProgram({
    required String type,
    required int cycles,
    required double denatureTemp,
    required int denatureTime,
    required double annealTemp,
    required int annealTime,
    required double extendTemp,
    required int extendTime,
    @Default(false) bool twoStepEnabled,
    double? annealExtendTemp,
    int? annealExtendTime,
    HotStartConfig? hotStart,
    TouchdownConfig? touchdown,
    GradientConfig? gradient,
  }) = _PCRProgram;

  factory PCRProgram.fromJson(Map<String, dynamic> json) =>
      _$PCRProgramFromJson(json);
}

/// Hot start configuration
@freezed
class HotStartConfig with _$HotStartConfig {
  const factory HotStartConfig({
    required bool enabled,
    required double activationTemp,
    required int activationTime,
  }) = _HotStartConfig;

  factory HotStartConfig.fromJson(Map<String, dynamic> json) =>
      _$HotStartConfigFromJson(json);
}

/// Touchdown PCR configuration
@freezed
class TouchdownConfig with _$TouchdownConfig {
  const factory TouchdownConfig({
    required bool enabled,
    required double startAnnealTemp,
    required double endAnnealTemp,
    required double stepSize,
    required int touchdownCycles,
    required double currentAnnealTemp,
  }) = _TouchdownConfig;

  factory TouchdownConfig.fromJson(Map<String, dynamic> json) =>
      _$TouchdownConfigFromJson(json);
}

/// Gradient PCR configuration
@freezed
class GradientConfig with _$GradientConfig {
  const factory GradientConfig({
    required bool enabled,
    required double tempLow,
    required double tempHigh,
    required int positions,
  }) = _GradientConfig;

  factory GradientConfig.fromJson(Map<String, dynamic> json) =>
      _$GradientConfigFromJson(json);
}

/// PCR metrics
@freezed
class PCRMetrics with _$PCRMetrics {
  const factory PCRMetrics({
    required double currentAnnealTemp,
    required double temperatureStability,
  }) = _PCRMetrics;

  factory PCRMetrics.fromJson(Map<String, dynamic> json) =>
      _$PCRMetricsFromJson(json);
}
