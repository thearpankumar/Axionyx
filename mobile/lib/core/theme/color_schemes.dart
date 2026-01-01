import 'package:flutter/material.dart';

/// Color schemes for Axionyx Mobile App
/// Implements glassmorphism-friendly color palette with biotech professional theme
class AppColorSchemes {
  // Primary Colors
  static const Color primary =
      Color(0xFF0A2463); // Deep Blue - Science, precision
  static const Color secondary =
      Color(0xFF00C9A7); // Cyan - Technology, innovation
  static const Color accent =
      Color(0xFF7B2CBF); // Electric Purple - Premium, modern

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Device-Specific Accent Colors
  static const Color pcrAccent = Color(0xFFE63946); // Red - heat
  static const Color incubatorAccent = Color(0xFF06D6A0); // Green - life
  static const Color dummyAccent = Color(0xFF457B9D); // Blue - test

  /// Dark Color Scheme (Primary)
  static const ColorScheme darkColorScheme = ColorScheme.dark(
    brightness: Brightness.dark,
    primary: primary,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFF1E3A8A),
    onPrimaryContainer: Color(0xFFDDE8FF),

    secondary: secondary,
    onSecondary: Color(0xFF003828),
    secondaryContainer: Color(0xFF00513B),
    onSecondaryContainer: Color(0xFFB2F1E3),

    tertiary: accent,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFF5A1E8C),
    onTertiaryContainer: Color(0xFFE8D5F7),

    error: error,
    onError: Colors.white,
    errorContainer: Color(0xFF9B1C1C),
    onErrorContainer: Color(0xFFFFDAD6),

    background: Color(0xFF0F172A), // slate-900
    onBackground: Colors.white,

    surface: Color(0xFF1E293B), // slate-800
    onSurface: Colors.white,
    surfaceVariant: Color(0xFF334155), // slate-700
    onSurfaceVariant: Color(0xFFCBD5E1),

    outline: Color(0xFF475569), // slate-600
    outlineVariant: Color(0xFF334155),

    shadow: Colors.black,
    scrim: Colors.black54,

    inverseSurface: Color(0xFFF1F5F9), // slate-100
    onInverseSurface: Color(0xFF1E293B),
    inversePrimary: Color(0xFF3B5998),
  );

  /// Light Color Scheme
  static const ColorScheme lightColorScheme = ColorScheme.light(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFDDE8FF),
    onPrimaryContainer: Color(0xFF001A41),

    secondary: secondary,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFB2F1E3),
    onSecondaryContainer: Color(0xFF002117),

    tertiary: accent,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFE8D5F7),
    onTertiaryContainer: Color(0xFF2E0051),

    error: error,
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    background: Color(0xFFF8FAFC), // slate-50
    onBackground: Color(0xFF1E293B),

    surface: Colors.white,
    onSurface: Color(0xFF1E293B),
    surfaceVariant: Color(0xFFF1F5F9), // slate-100
    onSurfaceVariant: Color(0xFF475569),

    outline: Color(0xFFCBD5E1), // slate-300
    outlineVariant: Color(0xFFE2E8F0), // slate-200

    shadow: Colors.black26,
    scrim: Colors.black54,

    inverseSurface: Color(0xFF1E293B),
    onInverseSurface: Color(0xFFF1F5F9),
    inversePrimary: Color(0xFFB8C9FF),
  );

  /// Glassmorphism overlay colors for dark mode
  static const Color glassDark = Color(0x0DFFFFFF); // White 5%
  static const Color glassDarkStrong = Color(0x1AFFFFFF); // White 10%
  static const Color glassDarkBorder = Color(0x1AFFFFFF); // White 10%

  /// Glassmorphism overlay colors for light mode
  static const Color glassLight = Color(0xB3FFFFFF); // White 70%
  static const Color glassLightStrong = Color(0xCCFFFFFF); // White 80%
  static const Color glassLightBorder = Color(0x33000000); // Black 20%

  /// Get device-specific color
  static Color getDeviceColor(String deviceType) {
    switch (deviceType.toUpperCase()) {
      case 'PCR':
        return pcrAccent;
      case 'INCUBATOR':
        return incubatorAccent;
      case 'DUMMY':
        return dummyAccent;
      default:
        return primary;
    }
  }

  /// Get status color
  static Color getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'RUNNING':
        return success;
      case 'PAUSED':
        return warning;
      case 'ERROR':
      case 'STOPPING':
        return error;
      case 'IDLE':
      case 'COMPLETE':
        return info;
      default:
        return Colors.grey;
    }
  }
}
