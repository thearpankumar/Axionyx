import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/device_info.dart';
import '../../data/repositories/device_repository.dart';
import '../../services/websocket/websocket_client.dart';
import '../../core/constants/api_endpoints.dart';
import 'device_discovery_provider.dart';

/// Provider for device repository
final deviceRepositoryProvider =
    Provider.family<DeviceRepository, DeviceInfo>((ref, deviceInfo) {
  final scanner = ref.read(mdnsScannerProvider);
  return DeviceRepository(
    deviceInfo,
    onConnectionError: () => scanner.healDevice(deviceInfo.id),
  );
});

/// Provider for WebSocket client
final websocketClientProvider =
    Provider.family<WebSocketClient, DeviceInfo>((ref, deviceInfo) {
  final wsUrl = ApiEndpoints.buildWebSocketUrl(
    deviceInfo.host,
    port: deviceInfo.websocketPort,
  );
  final client = WebSocketClient(url: wsUrl);
  client.connect();
  ref.onDispose(() => client.dispose());
  return client;
});

/// Provider for WebSocket telemetry stream
final telemetryStreamProvider =
    StreamProvider.family<Map<String, dynamic>, DeviceInfo>((ref, deviceInfo) {
  final wsClient = ref.watch(websocketClientProvider(deviceInfo));
  return wsClient.stream;
});

/// Provider for current device telemetry
final currentTelemetryProvider =
    StateProvider.family<Map<String, dynamic>?, DeviceInfo>((ref, deviceInfo) {
  return null;
});
