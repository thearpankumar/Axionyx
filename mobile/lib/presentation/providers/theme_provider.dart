import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Theme mode notifier with SharedPreferences persistence
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  static const String _keyThemeMode = 'theme_mode';

  ThemeModeNotifier() : super(ThemeMode.dark) {
    _loadThemeMode();
  }

  /// Load theme mode from SharedPreferences
  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeString = prefs.getString(_keyThemeMode);

      if (themeModeString != null) {
        state = _parseThemeMode(themeModeString);
      }
    } catch (e) {
      // Keep default dark mode on error
    }
  }

  /// Set theme mode and persist to SharedPreferences
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyThemeMode, mode.toString());
    } catch (e) {
      // Failed to persist, but state is already updated
    }
  }

  /// Toggle between light and dark modes
  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }

  /// Parse theme mode from string
  ThemeMode _parseThemeMode(String value) {
    switch (value) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        return ThemeMode.dark;
    }
  }
}

/// Provider for theme mode
final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});
