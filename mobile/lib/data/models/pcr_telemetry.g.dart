// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pcr_telemetry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PCRTelemetryImpl _$$PCRTelemetryImplFromJson(Map<String, dynamic> json) =>
    _$PCRTelemetryImpl(
      state: $enumDecode(_$DeviceStateEnumMap, json['state']),
      uptime: (json['uptime'] as num).toInt(),
      temperature: (json['temperature'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      setpoint: (json['setpoint'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      currentPhase: $enumDecode(_$PCRPhaseEnumMap, json['currentPhase']),
      cycleNumber: (json['cycleNumber'] as num).toInt(),
      totalCycles: (json['totalCycles'] as num).toInt(),
      phaseTimeRemaining: (json['phaseTimeRemaining'] as num).toInt(),
      totalTimeRemaining: (json['totalTimeRemaining'] as num).toInt(),
      progress: (json['progress'] as num).toDouble(),
      program: json['program'] == null
          ? null
          : PCRProgram.fromJson(json['program'] as Map<String, dynamic>),
      metrics: json['metrics'] == null
          ? null
          : PCRMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PCRTelemetryImplToJson(_$PCRTelemetryImpl instance) =>
    <String, dynamic>{
      'state': _$DeviceStateEnumMap[instance.state]!,
      'uptime': instance.uptime,
      'temperature': instance.temperature,
      'setpoint': instance.setpoint,
      'currentPhase': _$PCRPhaseEnumMap[instance.currentPhase]!,
      'cycleNumber': instance.cycleNumber,
      'totalCycles': instance.totalCycles,
      'phaseTimeRemaining': instance.phaseTimeRemaining,
      'totalTimeRemaining': instance.totalTimeRemaining,
      'progress': instance.progress,
      'program': instance.program,
      'metrics': instance.metrics,
      'errors': instance.errors,
    };

const _$DeviceStateEnumMap = {
  DeviceState.idle: 'idle',
  DeviceState.starting: 'starting',
  DeviceState.running: 'running',
  DeviceState.paused: 'paused',
  DeviceState.stopping: 'stopping',
  DeviceState.error: 'error',
  DeviceState.complete: 'complete',
};

const _$PCRPhaseEnumMap = {
  PCRPhase.idle: 'idle',
  PCRPhase.hotStart: 'hotStart',
  PCRPhase.initialDenature: 'initialDenature',
  PCRPhase.denature: 'denature',
  PCRPhase.anneal: 'anneal',
  PCRPhase.extend: 'extend',
  PCRPhase.annealExtend: 'annealExtend',
  PCRPhase.finalExtend: 'finalExtend',
  PCRPhase.hold: 'hold',
  PCRPhase.complete: 'complete',
};

_$PCRProgramImpl _$$PCRProgramImplFromJson(Map<String, dynamic> json) =>
    _$PCRProgramImpl(
      type: json['type'] as String,
      cycles: (json['cycles'] as num).toInt(),
      denatureTemp: (json['denatureTemp'] as num).toDouble(),
      denatureTime: (json['denatureTime'] as num).toInt(),
      annealTemp: (json['annealTemp'] as num).toDouble(),
      annealTime: (json['annealTime'] as num).toInt(),
      extendTemp: (json['extendTemp'] as num).toDouble(),
      extendTime: (json['extendTime'] as num).toInt(),
      twoStepEnabled: json['twoStepEnabled'] as bool? ?? false,
      annealExtendTemp: (json['annealExtendTemp'] as num?)?.toDouble(),
      annealExtendTime: (json['annealExtendTime'] as num?)?.toInt(),
      hotStart: json['hotStart'] == null
          ? null
          : HotStartConfig.fromJson(json['hotStart'] as Map<String, dynamic>),
      touchdown: json['touchdown'] == null
          ? null
          : TouchdownConfig.fromJson(json['touchdown'] as Map<String, dynamic>),
      gradient: json['gradient'] == null
          ? null
          : GradientConfig.fromJson(json['gradient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PCRProgramImplToJson(_$PCRProgramImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'cycles': instance.cycles,
      'denatureTemp': instance.denatureTemp,
      'denatureTime': instance.denatureTime,
      'annealTemp': instance.annealTemp,
      'annealTime': instance.annealTime,
      'extendTemp': instance.extendTemp,
      'extendTime': instance.extendTime,
      'twoStepEnabled': instance.twoStepEnabled,
      'annealExtendTemp': instance.annealExtendTemp,
      'annealExtendTime': instance.annealExtendTime,
      'hotStart': instance.hotStart,
      'touchdown': instance.touchdown,
      'gradient': instance.gradient,
    };

_$HotStartConfigImpl _$$HotStartConfigImplFromJson(Map<String, dynamic> json) =>
    _$HotStartConfigImpl(
      enabled: json['enabled'] as bool,
      activationTemp: (json['activationTemp'] as num).toDouble(),
      activationTime: (json['activationTime'] as num).toInt(),
    );

Map<String, dynamic> _$$HotStartConfigImplToJson(
        _$HotStartConfigImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'activationTemp': instance.activationTemp,
      'activationTime': instance.activationTime,
    };

_$TouchdownConfigImpl _$$TouchdownConfigImplFromJson(
        Map<String, dynamic> json) =>
    _$TouchdownConfigImpl(
      enabled: json['enabled'] as bool,
      startAnnealTemp: (json['startAnnealTemp'] as num).toDouble(),
      endAnnealTemp: (json['endAnnealTemp'] as num).toDouble(),
      stepSize: (json['stepSize'] as num).toDouble(),
      touchdownCycles: (json['touchdownCycles'] as num).toInt(),
      currentAnnealTemp: (json['currentAnnealTemp'] as num).toDouble(),
    );

Map<String, dynamic> _$$TouchdownConfigImplToJson(
        _$TouchdownConfigImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'startAnnealTemp': instance.startAnnealTemp,
      'endAnnealTemp': instance.endAnnealTemp,
      'stepSize': instance.stepSize,
      'touchdownCycles': instance.touchdownCycles,
      'currentAnnealTemp': instance.currentAnnealTemp,
    };

_$GradientConfigImpl _$$GradientConfigImplFromJson(Map<String, dynamic> json) =>
    _$GradientConfigImpl(
      enabled: json['enabled'] as bool,
      tempLow: (json['tempLow'] as num).toDouble(),
      tempHigh: (json['tempHigh'] as num).toDouble(),
      positions: (json['positions'] as num).toInt(),
    );

Map<String, dynamic> _$$GradientConfigImplToJson(
        _$GradientConfigImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'tempLow': instance.tempLow,
      'tempHigh': instance.tempHigh,
      'positions': instance.positions,
    };

_$PCRMetricsImpl _$$PCRMetricsImplFromJson(Map<String, dynamic> json) =>
    _$PCRMetricsImpl(
      currentAnnealTemp: (json['currentAnnealTemp'] as num).toDouble(),
      temperatureStability: (json['temperatureStability'] as num).toDouble(),
    );

Map<String, dynamic> _$$PCRMetricsImplToJson(_$PCRMetricsImpl instance) =>
    <String, dynamic>{
      'currentAnnealTemp': instance.currentAnnealTemp,
      'temperatureStability': instance.temperatureStability,
    };
