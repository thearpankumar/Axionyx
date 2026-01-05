import '../models/device_info.dart';
import '../../services/api/api_client.dart';
import '../../services/api/device_api.dart';
import '../../services/api/program_api.dart';
import '../../core/constants/api_endpoints.dart';

/// Repository for device data operations
class DeviceRepository {
  final DeviceInfo deviceInfo;
  late final ApiClient _apiClient;
  late final DeviceApi deviceApi;
  late final ProgramApi programApi;

  DeviceRepository(this.deviceInfo, {Function()? onConnectionError}) {
    final baseUrl = ApiEndpoints.buildHttpUrl(
      deviceInfo.host,
      '',
      port: deviceInfo.httpPort,
    );
    _apiClient =
        ApiClient(baseUrl: baseUrl, onConnectionError: onConnectionError);
    deviceApi = DeviceApi(_apiClient);
    programApi = ProgramApi(_apiClient);
  }

  /// Get device information
  Future<Map<String, dynamic>> getDeviceInfo() => deviceApi.getDeviceInfo();

  /// Get device status
  Future<Map<String, dynamic>> getDeviceStatus() => deviceApi.getDeviceStatus();

  /// Start device
  Future<void> startDevice(Map<String, dynamic> params) =>
      deviceApi.startDevice(params);

  /// Stop device
  Future<void> stopDevice() => deviceApi.stopDevice();

  /// Pause device
  Future<void> pauseDevice() => deviceApi.pauseDevice();

  /// Resume device
  Future<void> resumeDevice() => deviceApi.resumeDevice();

  /// Set setpoint
  Future<void> setSetpoint(int zone, double temperature) =>
      deviceApi.setSetpoint(zone: zone, temperature: temperature);

  /// Get program templates
  Future<List<dynamic>> getProgramTemplates() =>
      programApi.getProgramTemplates();

  /// Get protocol templates
  Future<List<dynamic>> getProtocolTemplates() =>
      programApi.getProtocolTemplates();

  /// Start protocol
  Future<void> startProtocol(Map<String, dynamic> protocol) =>
      programApi.startProtocol(protocol);

  /// Get alarms
  Future<Map<String, dynamic>> getAlarms() => programApi.getAlarms();

  /// Acknowledge alarm
  Future<void> acknowledgeAlarm(int index) =>
      programApi.acknowledgeAlarm(index);

  /// Acknowledge all alarms
  Future<void> acknowledgeAllAlarms() => programApi.acknowledgeAllAlarms();

  /// Factory reset device
  Future<void> factoryReset() => deviceApi.factoryReset();
}
