// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incubator_telemetry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IncubatorTelemetryImpl _$$IncubatorTelemetryImplFromJson(
        Map<String, dynamic> json) =>
    _$IncubatorTelemetryImpl(
      state: $enumDecode(_$DeviceStateEnumMap, json['state']),
      uptime: (json['uptime'] as num).toInt(),
      temperature: (json['temperature'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
      co2Level: (json['co2Level'] as num).toDouble(),
      temperatureSetpoint: (json['temperatureSetpoint'] as num).toDouble(),
      humiditySetpoint: (json['humiditySetpoint'] as num).toDouble(),
      co2Setpoint: (json['co2Setpoint'] as num).toDouble(),
      temperatureError: (json['temperatureError'] as num).toDouble(),
      humidityError: (json['humidityError'] as num).toDouble(),
      co2Error: (json['co2Error'] as num).toDouble(),
      temperatureStable: json['temperatureStable'] as bool,
      humidityStable: json['humidityStable'] as bool,
      co2Stable: json['co2Stable'] as bool,
      environmentStable: json['environmentStable'] as bool,
      timeStable: (json['timeStable'] as num).toInt(),
      ramping: RampingStatus.fromJson(json['ramping'] as Map<String, dynamic>),
      protocol: json['protocol'] == null
          ? null
          : IncubatorProtocol.fromJson(
              json['protocol'] as Map<String, dynamic>),
      alarms: json['alarms'] == null
          ? null
          : AlarmStatus.fromJson(json['alarms'] as Map<String, dynamic>),
      doorOpen: json['doorOpen'] as bool,
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$IncubatorTelemetryImplToJson(
        _$IncubatorTelemetryImpl instance) =>
    <String, dynamic>{
      'state': _$DeviceStateEnumMap[instance.state]!,
      'uptime': instance.uptime,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'co2Level': instance.co2Level,
      'temperatureSetpoint': instance.temperatureSetpoint,
      'humiditySetpoint': instance.humiditySetpoint,
      'co2Setpoint': instance.co2Setpoint,
      'temperatureError': instance.temperatureError,
      'humidityError': instance.humidityError,
      'co2Error': instance.co2Error,
      'temperatureStable': instance.temperatureStable,
      'humidityStable': instance.humidityStable,
      'co2Stable': instance.co2Stable,
      'environmentStable': instance.environmentStable,
      'timeStable': instance.timeStable,
      'ramping': instance.ramping,
      'protocol': instance.protocol,
      'alarms': instance.alarms,
      'doorOpen': instance.doorOpen,
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

_$RampingStatusImpl _$$RampingStatusImplFromJson(Map<String, dynamic> json) =>
    _$RampingStatusImpl(
      temperature: json['temperature'] as bool,
      humidity: json['humidity'] as bool,
      co2: json['co2'] as bool,
    );

Map<String, dynamic> _$$RampingStatusImplToJson(_$RampingStatusImpl instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'co2': instance.co2,
    };

_$IncubatorProtocolImpl _$$IncubatorProtocolImplFromJson(
        Map<String, dynamic> json) =>
    _$IncubatorProtocolImpl(
      state: $enumDecode(_$ProtocolStateEnumMap, json['state']),
      name: json['name'] as String,
      type: (json['type'] as num).toInt(),
      currentStage: (json['currentStage'] as num).toInt(),
      totalStages: (json['totalStages'] as num).toInt(),
      stageName: json['stageName'] as String,
      stageTimeRemaining: (json['stageTimeRemaining'] as num).toInt(),
      progress: (json['progress'] as num).toDouble(),
    );

Map<String, dynamic> _$$IncubatorProtocolImplToJson(
        _$IncubatorProtocolImpl instance) =>
    <String, dynamic>{
      'state': _$ProtocolStateEnumMap[instance.state]!,
      'name': instance.name,
      'type': instance.type,
      'currentStage': instance.currentStage,
      'totalStages': instance.totalStages,
      'stageName': instance.stageName,
      'stageTimeRemaining': instance.stageTimeRemaining,
      'progress': instance.progress,
    };

const _$ProtocolStateEnumMap = {
  ProtocolState.idle: 'idle',
  ProtocolState.preheating: 'preheating',
  ProtocolState.running: 'running',
  ProtocolState.paused: 'paused',
  ProtocolState.complete: 'complete',
};

_$AlarmStatusImpl _$$AlarmStatusImplFromJson(Map<String, dynamic> json) =>
    _$AlarmStatusImpl(
      activeCount: (json['activeCount'] as num).toInt(),
      hasCritical: json['hasCritical'] as bool,
      active: (json['active'] as List<dynamic>)
          .map((e) => AlarmData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AlarmStatusImplToJson(_$AlarmStatusImpl instance) =>
    <String, dynamic>{
      'activeCount': instance.activeCount,
      'hasCritical': instance.hasCritical,
      'active': instance.active,
    };

_$AlarmDataImpl _$$AlarmDataImplFromJson(Map<String, dynamic> json) =>
    _$AlarmDataImpl(
      type: $enumDecode(_$AlarmTypeEnumMap, json['type']),
      severity: $enumDecode(_$AlarmSeverityEnumMap, json['severity']),
      message: json['message'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      acknowledged: json['acknowledged'] as bool,
      currentValue: (json['currentValue'] as num).toDouble(),
      threshold: (json['threshold'] as num).toDouble(),
    );

Map<String, dynamic> _$$AlarmDataImplToJson(_$AlarmDataImpl instance) =>
    <String, dynamic>{
      'type': _$AlarmTypeEnumMap[instance.type]!,
      'severity': _$AlarmSeverityEnumMap[instance.severity]!,
      'message': instance.message,
      'timestamp': instance.timestamp,
      'acknowledged': instance.acknowledged,
      'currentValue': instance.currentValue,
      'threshold': instance.threshold,
    };

const _$AlarmTypeEnumMap = {
  AlarmType.tempHigh: 'tempHigh',
  AlarmType.tempLow: 'tempLow',
  AlarmType.humidityLow: 'humidityLow',
  AlarmType.co2High: 'co2High',
  AlarmType.co2Low: 'co2Low',
  AlarmType.doorOpen: 'doorOpen',
  AlarmType.powerFailure: 'powerFailure',
  AlarmType.sensorFault: 'sensorFault',
};

const _$AlarmSeverityEnumMap = {
  AlarmSeverity.warning: 'warning',
  AlarmSeverity.critical: 'critical',
};
