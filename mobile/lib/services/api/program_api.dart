import 'api_client.dart';
import '../../core/constants/api_endpoints.dart';

/// Program and protocol API service
class ProgramApi {
  final ApiClient _client;

  ProgramApi(this._client);

  // ========== PCR Program Endpoints ==========

  /// Get PCR program templates
  Future<List<dynamic>> getProgramTemplates() async {
    final response = await _client.get(ApiEndpoints.programTemplates);
    return _extractList(response.data);
  }

  /// Validate PCR program
  Future<Map<String, dynamic>> validateProgram(
    Map<String, dynamic> program,
  ) async {
    final response = await _client.post(
      ApiEndpoints.programValidate,
      data: program,
    );
    return response.data as Map<String, dynamic>;
  }

  // ========== Incubator Protocol Endpoints ==========

  /// Get incubator protocol templates
  Future<List<dynamic>> getProtocolTemplates() async {
    final response = await _client.get(ApiEndpoints.protocolTemplates);
    return _extractList(response.data);
  }

  /// Start incubator protocol
  Future<void> startProtocol(Map<String, dynamic> protocol) async {
    await _client.post(
      ApiEndpoints.protocolStart,
      data: protocol,
    );
  }

  /// Stop incubator protocol
  Future<void> stopProtocol() async {
    await _client.post(ApiEndpoints.protocolStop);
  }

  /// Pause incubator protocol
  Future<void> pauseProtocol() async {
    await _client.post(ApiEndpoints.protocolPause);
  }

  /// Resume incubator protocol
  Future<void> resumeProtocol() async {
    await _client.post(ApiEndpoints.protocolResume);
  }

  /// Advance to next protocol stage
  Future<void> nextProtocolStage() async {
    await _client.post(ApiEndpoints.protocolNextStage);
  }

  // ========== Alarm Endpoints ==========

  /// Get active alarms
  Future<Map<String, dynamic>> getAlarms() async {
    final response = await _client.get(ApiEndpoints.alarms);
    return response.data as Map<String, dynamic>;
  }

  /// Acknowledge specific alarm
  Future<void> acknowledgeAlarm(int index) async {
    await _client.post(
      ApiEndpoints.alarmsAcknowledge,
      data: {'index': index},
    );
  }

  /// Acknowledge all alarms
  Future<void> acknowledgeAllAlarms() async {
    await _client.post(ApiEndpoints.alarmsAcknowledgeAll);
  }

  /// Get alarm history
  Future<List<dynamic>> getAlarmHistory() async {
    final response = await _client.get(ApiEndpoints.alarmsHistory);
    return _extractList(response.data);
  }

  /// Helper to safely extract list from response data
  List<dynamic> _extractList(dynamic data) {
    if (data == null) return [];

    if (data is List) {
      return data;
    }

    if (data is Map) {
      // 1. Try common known keys
      final commonKeys = [
        'templates',
        'programs',
        'protocols',
        'history',
        'data',
        'items',
        'list'
      ];

      for (final key in commonKeys) {
        if (data.containsKey(key) && data[key] is List) {
          return data[key] as List;
        }
      }

      // 2. If it's a map and has an 'error' or 'message' key (and no list found above),
      // it might be an error response. We should let it return empty but maybe
      // in the future we'd want to throw.
      // For now, if we find ANY list in the map, return it.
      for (final value in data.values) {
        if (value is List) {
          return value;
        }
      }

      // 3. Special case: if the map itself has properties like 'name', 'type'
      // but is NOT a list, and we are expecting a list, we return empty.

      return [];
    }

    return [];
  }
}
