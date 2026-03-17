// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pcr_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PcrProfile _$PcrProfileFromJson(Map<String, dynamic> json) => _PcrProfile(
  id: json['id'] as String,
  name: json['name'] as String,
  mode: json['mode'] as String,
  cycles: (json['cycles'] as num).toInt(),
  initialDenatureTemp: (json['initialDenatureTemp'] as num).toDouble(),
  initialDenatureTime: (json['initialDenatureTime'] as num).toInt(),
  denatureTemp: (json['denatureTemp'] as num).toDouble(),
  denatureTime: (json['denatureTime'] as num).toInt(),
  annealTemp: (json['annealTemp'] as num?)?.toDouble(),
  annealTime: (json['annealTime'] as num?)?.toInt(),
  extendTemp: (json['extendTemp'] as num?)?.toDouble(),
  extendTime: (json['extendTime'] as num?)?.toInt(),
  annealExtendTemp: (json['annealExtendTemp'] as num?)?.toDouble(),
  annealExtendTime: (json['annealExtendTime'] as num?)?.toInt(),
  finalExtendTemp: (json['finalExtendTemp'] as num).toDouble(),
  finalExtendTime: (json['finalExtendTime'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  isDefault: json['isDefault'] as bool? ?? false,
);

Map<String, dynamic> _$PcrProfileToJson(_PcrProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mode': instance.mode,
      'cycles': instance.cycles,
      'initialDenatureTemp': instance.initialDenatureTemp,
      'initialDenatureTime': instance.initialDenatureTime,
      'denatureTemp': instance.denatureTemp,
      'denatureTime': instance.denatureTime,
      'annealTemp': instance.annealTemp,
      'annealTime': instance.annealTime,
      'extendTemp': instance.extendTemp,
      'extendTime': instance.extendTime,
      'annealExtendTemp': instance.annealExtendTemp,
      'annealExtendTime': instance.annealExtendTime,
      'finalExtendTemp': instance.finalExtendTemp,
      'finalExtendTime': instance.finalExtendTime,
      'createdAt': instance.createdAt.toIso8601String(),
      'isDefault': instance.isDefault,
    };
