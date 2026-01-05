import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Settings state class
class SettingsState {
  final bool autoReconnect;
  final bool notificationsEnabled;

  const SettingsState({
    required this.autoReconnect,
    required this.notificationsEnabled,
  });

  SettingsState copyWith({
    bool? autoReconnect,
    bool? notificationsEnabled,
  }) {
    return SettingsState(
      autoReconnect: autoReconnect ?? this.autoReconnect,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

/// Settings notifier with SharedPreferences persistence
class SettingsNotifier extends StateNotifier<SettingsState> {
  static const String _keyAutoReconnect = 'settings_auto_reconnect';
  static const String _keyNotifications = 'settings_notifications';

  SettingsNotifier()
      : super(const SettingsState(
          autoReconnect: true,
          notificationsEnabled: true,
        )) {
    _loadSettings();
  }

  /// Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final autoReconnect = prefs.getBool(_keyAutoReconnect) ?? true;
      final notificationsEnabled = prefs.getBool(_keyNotifications) ?? true;

      state = SettingsState(
        autoReconnect: autoReconnect,
        notificationsEnabled: notificationsEnabled,
      );
    } catch (e) {
      // Keep default values on error
    }
  }

  /// Set auto-reconnect preference
  Future<void> setAutoReconnect(bool value) async {
    state = state.copyWith(autoReconnect: value);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyAutoReconnect, value);
    } catch (e) {
      // Revert on error
      state = state.copyWith(autoReconnect: !value);
    }
  }

  /// Set notifications preference
  Future<void> setNotificationsEnabled(bool value) async {
    state = state.copyWith(notificationsEnabled: value);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyNotifications, value);
    } catch (e) {
      // Revert on error
      state = state.copyWith(notificationsEnabled: !value);
    }
  }
}

/// Provider for settings
final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
