/// API endpoint constants for Axionyx devices
class ApiEndpoints {
  // Base paths
  static const String apiVersion = 'v1';
  static const String apiBasePath = '/api/$apiVersion';

  // Device endpoints
  static const String deviceInfo = '$apiBasePath/device/info';
  static const String deviceStatus = '$apiBasePath/device/status';
  static const String deviceStart = '$apiBasePath/device/start';
  static const String deviceStop = '$apiBasePath/device/stop';
  static const String devicePause = '$apiBasePath/device/pause';
  static const String deviceResume = '$apiBasePath/device/resume';
  static const String deviceSetpoint = '$apiBasePath/device/setpoint';

  // PCR program endpoints
  static const String programTemplates =
      '$apiBasePath/device/program/templates';
  static const String programValidate = '$apiBasePath/device/program/validate';

  // Incubator protocol endpoints
  static const String protocolTemplates =
      '$apiBasePath/device/protocol/templates';
  static const String protocolStart = '$apiBasePath/device/protocol/start';
  static const String protocolStop = '$apiBasePath/device/protocol/stop';
  static const String protocolPause = '$apiBasePath/device/protocol/pause';
  static const String protocolResume = '$apiBasePath/device/protocol/resume';
  static const String protocolNextStage =
      '$apiBasePath/device/protocol/next-stage';

  // Alarm endpoints
  static const String alarms = '$apiBasePath/device/alarms';
  static const String alarmsAcknowledge =
      '$apiBasePath/device/alarms/acknowledge';
  static const String alarmsAcknowledgeAll =
      '$apiBasePath/device/alarms/acknowledge-all';
  static const String alarmsHistory = '$apiBasePath/device/alarms/history';

  // WiFi endpoints
  static const String wifiStatus = '$apiBasePath/wifi/status';
  static const String wifiConfigure = '$apiBasePath/wifi/configure';

  // Config endpoints
  static const String config = '$apiBasePath/config';
  static const String configFactoryReset = '$apiBasePath/config/factory-reset';

  // WebSocket path
  static const int websocketPort = 81;

  /// Build complete URL for HTTP endpoint
  static String buildHttpUrl(String host, String endpoint, {int port = 80}) {
    return 'http://$host:$port$endpoint';
  }

  /// Build WebSocket URL
  static String buildWebSocketUrl(String host, {int port = 81}) {
    return 'ws://$host:$port';
  }
}
