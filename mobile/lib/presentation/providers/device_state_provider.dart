import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/device_info.dart';
import '../../data/repositories/device_repository.dart';
import '../../services/websocket/websocket_client.dart';
import '../../core/constants/api_endpoints.dart';
import 'device_discovery_provider.dart';

/// Provider for device repository
final deviceRepositoryProvider = Provider.family<DeviceRepository, DeviceInfo>((
  ref,
  deviceInfo,
) {
  final scanner = ref.read(mdnsScannerProvider);
  return DeviceRepository(
    deviceInfo,
    onConnectionError: () => scanner.healDevice(deviceInfo.id),
  );
});

/// Provider for WebSocket client
final websocketClientProvider = Provider.family<WebSocketClient, DeviceInfo>((
  ref,
  deviceInfo,
) {
  final wsUrl = ApiEndpoints.buildWebSocketUrl(
    deviceInfo.host,
    port: deviceInfo.websocketPort,
  );
  final client = WebSocketClient(url: wsUrl);
  client.connect();
  ref.onDispose(() => client.dispose());
  return client;
});

/// Provider for WebSocket telemetry stream.
/// Seeds with an HTTP status fetch first so the UI never shows a loading
/// spinner indefinitely, then continues with live WebSocket updates.
final telemetryStreamProvider =
    StreamProvider.family<Map<String, dynamic>, DeviceInfo>((
      ref,
      deviceInfo,
    ) async* {
      // Seed immediately via HTTP so the screen renders without waiting for WS
      final repo = ref.read(deviceRepositoryProvider(deviceInfo));
      yield await repo.getDeviceStatus().timeout(const Duration(seconds: 5));

      // Stream live updates from WebSocket.
      // Only pass through telemetry frames — discard pings, pongs, and any
      // other control messages so non-data frames never reach the UI.
      final wsClient = ref.watch(websocketClientProvider(deviceInfo));
      yield* wsClient.stream
          .where(
            (msg) =>
                msg['type'] == 'telemetry' &&
                msg['data'] is Map<String, dynamic>,
          )
          .map((msg) => msg['data'] as Map<String, dynamic>);
    });

/// Provider for current device telemetry (latest value from the WebSocket stream)
final currentTelemetryProvider =
    Provider.family<Map<String, dynamic>?, DeviceInfo>((ref, deviceInfo) {
      return ref.watch(telemetryStreamProvider(deviceInfo)).asData?.value;
    });
