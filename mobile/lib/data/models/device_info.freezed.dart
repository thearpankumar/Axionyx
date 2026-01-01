// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) {
  return _DeviceInfo.fromJson(json);
}

/// @nodoc
mixin _$DeviceInfo {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DeviceType get type => throw _privateConstructorUsedError;
  String get host => throw _privateConstructorUsedError;
  int get httpPort => throw _privateConstructorUsedError;
  int get websocketPort => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  String? get serial => throw _privateConstructorUsedError;
  String? get mac => throw _privateConstructorUsedError;
  bool get isConnected => throw _privateConstructorUsedError;
  DateTime? get lastSeen => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceInfoCopyWith<DeviceInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceInfoCopyWith<$Res> {
  factory $DeviceInfoCopyWith(
          DeviceInfo value, $Res Function(DeviceInfo) then) =
      _$DeviceInfoCopyWithImpl<$Res, DeviceInfo>;
  @useResult
  $Res call(
      {String id,
      String name,
      DeviceType type,
      String host,
      int httpPort,
      int websocketPort,
      String? version,
      String? serial,
      String? mac,
      bool isConnected,
      DateTime? lastSeen});
}

/// @nodoc
class _$DeviceInfoCopyWithImpl<$Res, $Val extends DeviceInfo>
    implements $DeviceInfoCopyWith<$Res> {
  _$DeviceInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? host = null,
    Object? httpPort = null,
    Object? websocketPort = null,
    Object? version = freezed,
    Object? serial = freezed,
    Object? mac = freezed,
    Object? isConnected = null,
    Object? lastSeen = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DeviceType,
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      httpPort: null == httpPort
          ? _value.httpPort
          : httpPort // ignore: cast_nullable_to_non_nullable
              as int,
      websocketPort: null == websocketPort
          ? _value.websocketPort
          : websocketPort // ignore: cast_nullable_to_non_nullable
              as int,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      serial: freezed == serial
          ? _value.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String?,
      mac: freezed == mac
          ? _value.mac
          : mac // ignore: cast_nullable_to_non_nullable
              as String?,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceInfoImplCopyWith<$Res>
    implements $DeviceInfoCopyWith<$Res> {
  factory _$$DeviceInfoImplCopyWith(
          _$DeviceInfoImpl value, $Res Function(_$DeviceInfoImpl) then) =
      __$$DeviceInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      DeviceType type,
      String host,
      int httpPort,
      int websocketPort,
      String? version,
      String? serial,
      String? mac,
      bool isConnected,
      DateTime? lastSeen});
}

/// @nodoc
class __$$DeviceInfoImplCopyWithImpl<$Res>
    extends _$DeviceInfoCopyWithImpl<$Res, _$DeviceInfoImpl>
    implements _$$DeviceInfoImplCopyWith<$Res> {
  __$$DeviceInfoImplCopyWithImpl(
      _$DeviceInfoImpl _value, $Res Function(_$DeviceInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? host = null,
    Object? httpPort = null,
    Object? websocketPort = null,
    Object? version = freezed,
    Object? serial = freezed,
    Object? mac = freezed,
    Object? isConnected = null,
    Object? lastSeen = freezed,
  }) {
    return _then(_$DeviceInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as DeviceType,
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      httpPort: null == httpPort
          ? _value.httpPort
          : httpPort // ignore: cast_nullable_to_non_nullable
              as int,
      websocketPort: null == websocketPort
          ? _value.websocketPort
          : websocketPort // ignore: cast_nullable_to_non_nullable
              as int,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      serial: freezed == serial
          ? _value.serial
          : serial // ignore: cast_nullable_to_non_nullable
              as String?,
      mac: freezed == mac
          ? _value.mac
          : mac // ignore: cast_nullable_to_non_nullable
              as String?,
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: freezed == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceInfoImpl implements _DeviceInfo {
  const _$DeviceInfoImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.host,
      required this.httpPort,
      required this.websocketPort,
      this.version,
      this.serial,
      this.mac,
      this.isConnected = false,
      this.lastSeen});

  factory _$DeviceInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceInfoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final DeviceType type;
  @override
  final String host;
  @override
  final int httpPort;
  @override
  final int websocketPort;
  @override
  final String? version;
  @override
  final String? serial;
  @override
  final String? mac;
  @override
  @JsonKey()
  final bool isConnected;
  @override
  final DateTime? lastSeen;

  @override
  String toString() {
    return 'DeviceInfo(id: $id, name: $name, type: $type, host: $host, httpPort: $httpPort, websocketPort: $websocketPort, version: $version, serial: $serial, mac: $mac, isConnected: $isConnected, lastSeen: $lastSeen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.httpPort, httpPort) ||
                other.httpPort == httpPort) &&
            (identical(other.websocketPort, websocketPort) ||
                other.websocketPort == websocketPort) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.serial, serial) || other.serial == serial) &&
            (identical(other.mac, mac) || other.mac == mac) &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, host, httpPort,
      websocketPort, version, serial, mac, isConnected, lastSeen);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      __$$DeviceInfoImplCopyWithImpl<_$DeviceInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceInfoImplToJson(
      this,
    );
  }
}

abstract class _DeviceInfo implements DeviceInfo {
  const factory _DeviceInfo(
      {required final String id,
      required final String name,
      required final DeviceType type,
      required final String host,
      required final int httpPort,
      required final int websocketPort,
      final String? version,
      final String? serial,
      final String? mac,
      final bool isConnected,
      final DateTime? lastSeen}) = _$DeviceInfoImpl;

  factory _DeviceInfo.fromJson(Map<String, dynamic> json) =
      _$DeviceInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  DeviceType get type;
  @override
  String get host;
  @override
  int get httpPort;
  @override
  int get websocketPort;
  @override
  String? get version;
  @override
  String? get serial;
  @override
  String? get mac;
  @override
  bool get isConnected;
  @override
  DateTime? get lastSeen;
  @override
  @JsonKey(ignore: true)
  _$$DeviceInfoImplCopyWith<_$DeviceInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
