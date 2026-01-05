// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dummy_telemetry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DummyTelemetryImpl _$$DummyTelemetryImplFromJson(Map<String, dynamic> json) =>
    _$DummyTelemetryImpl(
      state: $enumDecode(_$DeviceStateEnumMap, json['state']),
      uptime: (json['uptime'] as num).toInt(),
      temperature: (json['temperature'] as num).toDouble(),
      setpoint: (json['setpoint'] as num).toDouble(),
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$DummyTelemetryImplToJson(
        _$DummyTelemetryImpl instance) =>
    <String, dynamic>{
      'state': _$DeviceStateEnumMap[instance.state]!,
      'uptime': instance.uptime,
      'temperature': instance.temperature,
      'setpoint': instance.setpoint,
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
