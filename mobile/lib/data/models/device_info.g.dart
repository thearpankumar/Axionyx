// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => _DeviceInfo(
  id: json['id'] as String,
  name: json['name'] as String,
  type: $enumDecode(_$DeviceTypeEnumMap, json['type']),
  host: json['host'] as String,
  httpPort: (json['httpPort'] as num).toInt(),
  websocketPort: (json['websocketPort'] as num).toInt(),
  version: json['version'] as String?,
  serial: json['serial'] as String?,
  mac: json['mac'] as String?,
  isConnected: json['isConnected'] as bool? ?? false,
  lastSeen: json['lastSeen'] == null
      ? null
      : DateTime.parse(json['lastSeen'] as String),
);

Map<String, dynamic> _$DeviceInfoToJson(_DeviceInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$DeviceTypeEnumMap[instance.type]!,
      'host': instance.host,
      'httpPort': instance.httpPort,
      'websocketPort': instance.websocketPort,
      'version': instance.version,
      'serial': instance.serial,
      'mac': instance.mac,
      'isConnected': instance.isConnected,
      'lastSeen': instance.lastSeen?.toIso8601String(),
    };

const _$DeviceTypeEnumMap = {
  DeviceType.pcr: 'pcr',
  DeviceType.incubator: 'incubator',
};
