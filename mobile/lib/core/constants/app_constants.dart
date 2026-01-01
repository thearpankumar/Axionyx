/// Application-wide constants
class AppConstants {
  // App Info
  static const String appName = 'Axionyx Mobile';
  static const String appVersion = '1.0.0';

  // mDNS Discovery
  static const String mdnsServiceType = '_axionyx._tcp';
  static const Duration mdnsScanDuration = Duration(seconds: 5);
  static const Duration mdnsRescanInterval = Duration(seconds: 30);

  // Network Timeouts
  static const Duration httpTimeout = Duration(seconds: 5);
  static const Duration websocketPingInterval = Duration(seconds: 30);
  static const Duration websocketReconnectInitial = Duration(seconds: 1);
  static const Duration websocketReconnectMax = Duration(seconds: 30);

  // WebSocket
  static const int telemetryUpdateInterval = 1; // seconds
  static const int maxTelemetryDataPoints = 100; // for charts

  // Temperature Ranges
  static const double minTemperature = 4.0;
  static const double maxTemperature = 100.0;
  static const double incubatorMinTemp = 4.0;
  static const double incubatorMaxTemp = 50.0;

  // Humidity Range
  static const double minHumidity = 0.0;
  static const double maxHumidity = 100.0;

  // CO2 Range
  static const double minCO2 = 0.0;
  static const double maxCO2 = 20.0;

  // PCR Ranges
  static const int minCycles = 1;
  static const int maxCycles = 100;
  static const int defaultCycles = 35;

  // UI Constants
  static const double cardBorderRadius = 16.0;
  static const double buttonBorderRadius = 12.0;
  static const double dialogBorderRadius = 20.0;
  static const double iconSize = 24.0;
  static const double iconSizeLarge = 32.0;

  // Animations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  static const Duration shimmerDuration = Duration(milliseconds: 1500);

  // Storage Keys
  static const String themeKey = 'theme_mode';
  static const String devicesKey = 'saved_devices';
  static const String programsKey = 'saved_programs';
  static const String protocolsKey = 'saved_protocols';

  // Glassmorphism
  static const double glassBlurSigma = 10.0;
  static const double glassOpacityDark = 0.05;
  static const double glassOpacityLight = 0.7;

  // Error Messages
  static const String errorNetworkConnection = 'Failed to connect to device';
  static const String errorDeviceNotFound = 'Device not found on network';
  static const String errorTimeout = 'Request timed out';
  static const String errorInvalidResponse = 'Invalid response from device';
  static const String errorPermissionDenied = 'Permission denied';
}
