import 'api_client.dart';
import '../../core/constants/api_endpoints.dart';

/// Device API service for device control and management
class DeviceApi {
  final ApiClient _client;

  DeviceApi(this._client);

  /// Get device information
  Future<Map<String, dynamic>> getDeviceInfo() async {
    final response = await _client.get(ApiEndpoints.deviceInfo);
    return response.data as Map<String, dynamic>;
  }

  /// Get device status/telemetry
  Future<Map<String, dynamic>> getDeviceStatus() async {
    final response = await _client.get(ApiEndpoints.deviceStatus);
    return response.data as Map<String, dynamic>;
  }

  /// Start device with parameters
  Future<void> startDevice(Map<String, dynamic> params) async {
    await _client.post(
      ApiEndpoints.deviceStart,
      data: params,
    );
  }

  /// Stop device
  Future<void> stopDevice() async {
    await _client.post(ApiEndpoints.deviceStop);
  }

  /// Pause device
  Future<void> pauseDevice() async {
    await _client.post(ApiEndpoints.devicePause);
  }

  /// Resume device
  Future<void> resumeDevice() async {
    await _client.post(ApiEndpoints.deviceResume);
  }

  /// Set temperature setpoint for a zone
  Future<void> setSetpoint({
    required int zone,
    required double temperature,
  }) async {
    await _client.put(
      ApiEndpoints.deviceSetpoint,
      data: {
        'zone': zone,
        'temperature': temperature,
      },
    );
  }

  /// Get WiFi status
  Future<Map<String, dynamic>> getWifiStatus() async {
    final response = await _client.get(ApiEndpoints.wifiStatus);
    return response.data as Map<String, dynamic>;
  }

  /// Configure WiFi
  Future<void> configureWifi({
    required String ssid,
    required String password,
    int mode = 1,
  }) async {
    await _client.post(
      ApiEndpoints.wifiConfigure,
      data: {
        'ssid': ssid,
        'password': password,
        'mode': mode,
      },
    );
  }

  /// Get device configuration
  Future<Map<String, dynamic>> getConfig() async {
    final response = await _client.get(ApiEndpoints.config);
    return response.data as Map<String, dynamic>;
  }

  /// Update device configuration
  Future<void> updateConfig(Map<String, dynamic> config) async {
    await _client.post(
      ApiEndpoints.config,
      data: config,
    );
  }

  /// Factory reset device
  Future<void> factoryReset() async {
    await _client.post(ApiEndpoints.configFactoryReset);
  }
}
