import 'package:freezed_annotation/freezed_annotation.dart';
import '../../core/constants/device_types.dart';

part 'device_info.freezed.dart';
part 'device_info.g.dart';

/// Device information model from mDNS discovery and /api/v1/device/info
@freezed
class DeviceInfo with _$DeviceInfo {
  const factory DeviceInfo({
    required String id,
    required String name,
    required DeviceType type,
    required String host,
    required int httpPort,
    required int websocketPort,
    String? version,
    String? serial,
    String? mac,
    @Default(false) bool isConnected,
    DateTime? lastSeen,
  }) = _DeviceInfo;

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);

  /// Create from mDNS service discovery
  factory DeviceInfo.fromMdns({
    required String name,
    required String host,
    required int httpPort,
    required int websocketPort,
    required Map<String, String> txtRecords,
  }) {
    // Use MAC address as primary ID if available, fallback to device ID or host
    final macAddress = txtRecords['mac'];
    final deviceId = txtRecords['id'];
    final uniqueId = macAddress ?? deviceId ?? host;

    return DeviceInfo(
      id: uniqueId,
      name: txtRecords['name'] ?? name,
      type: DeviceType.fromString(txtRecords['type'] ?? 'DUMMY'),
      host: host,
      httpPort: httpPort,
      websocketPort: websocketPort,
      version: txtRecords['version'],
      serial: txtRecords['serial'],
      mac: macAddress,
      isConnected: true,
      lastSeen: DateTime.now(),
    );
  }
}
