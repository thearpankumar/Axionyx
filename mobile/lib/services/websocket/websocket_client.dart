import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:logger/logger.dart';
import '../../core/constants/app_constants.dart';

/// WebSocket client for real-time telemetry with auto-reconnect
class WebSocketClient {
  final String url;
  final Logger _logger = Logger();

  WebSocketChannel? _channel;
  StreamController<Map<String, dynamic>>? _controller;
  Timer? _pingTimer;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  bool _isDisposed = false;

  WebSocketClient({required this.url});

  /// Stream of telemetry data
  Stream<Map<String, dynamic>> get stream {
    _controller ??= StreamController<Map<String, dynamic>>.broadcast();
    return _controller!.stream;
  }

  /// Connect to WebSocket
  Future<void> connect() async {
    if (_isDisposed) return;

    try {
      _logger.i('Connecting to WebSocket: $url');

      _channel = WebSocketChannel.connect(Uri.parse(url));

      // Listen to messages
      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );

      // Start ping timer
      _startPing();

      _reconnectAttempts = 0;
      _logger.i('WebSocket connected');
    } catch (e) {
      _logger.e('WebSocket connection error: $e');
      _scheduleReconnect();
    }
  }

  /// Handle incoming message
  void _onMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String) as Map<String, dynamic>;
      _controller?.add(data);
    } catch (e) {
      _logger.e('Error parsing WebSocket message: $e');
    }
  }

  /// Handle error
  void _onError(Object? error) {
    _logger.e('WebSocket error: $error');
    _scheduleReconnect();
  }

  /// Handle connection closed
  void _onDone() {
    _logger.w('WebSocket connection closed');
    _scheduleReconnect();
  }

  /// Send message
  void send(Map<String, dynamic> data) {
    if (_channel != null) {
      _channel!.sink.add(jsonEncode(data));
    }
  }

  /// Send ping to keep connection alive
  void _startPing() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(
      AppConstants.websocketPingInterval,
      (_) {
        send({'type': 'ping'});
      },
    );
  }

  /// Schedule reconnection with exponential backoff
  void _scheduleReconnect() {
    if (_isDisposed) return;

    _pingTimer?.cancel();
    _reconnectTimer?.cancel();

    final delay = _calculateReconnectDelay();
    _logger
        .i('Reconnecting in ${delay.inSeconds}s (attempt $_reconnectAttempts)');

    _reconnectTimer = Timer(delay, () {
      _reconnectAttempts++;
      connect();
    });
  }

  /// Calculate reconnect delay with exponential backoff
  Duration _calculateReconnectDelay() {
    final baseDelay = AppConstants.websocketReconnectInitial.inSeconds;
    final maxDelay = AppConstants.websocketReconnectMax.inSeconds;

    final delay = baseDelay * (1 << _reconnectAttempts);
    final cappedDelay = delay > maxDelay ? maxDelay : delay;

    return Duration(seconds: cappedDelay);
  }

  /// Disconnect WebSocket
  Future<void> disconnect() async {
    _logger.i('Disconnecting WebSocket');
    _pingTimer?.cancel();
    _reconnectTimer?.cancel();
    await _channel?.sink.close();
    _channel = null;
  }

  /// Dispose resources
  void dispose() {
    _isDisposed = true;
    disconnect();
    _controller?.close();
    _controller = null;
  }
}
