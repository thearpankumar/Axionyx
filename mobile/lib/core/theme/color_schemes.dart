import 'package:flutter/material.dart';

/// Color schemes for Axionyx Mobile App
/// Implements glassmorphism-friendly color palette with biotech professional theme
class AppColorSchemes {
  // Primary Colors
  static const Color primary =
      Color(0xFFE63946); // Red - Bio-precision, primary brand
  static const Color secondary = Color(
      0xFFE63946); // Matching red for now for monochromatic look or use secondary if needed
  static const Color accent = Color(0xFF000000); // Black accent

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
    primaryContainer: Color(0xFFC62828),
    onPrimaryContainer: Colors.white,

    secondary: secondary,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFF8B0000),
    onSecondaryContainer: Colors.white,

    tertiary: accent,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFF262626),
    onTertiaryContainer: Colors.white,

    error: error,
    onError: Colors.white,
    errorContainer: Color(0xFF9B1C1C),
    onErrorContainer: Color(0xFFFFDAD6),

    surface: Color(0xFF000000), // Pure Black
    onSurface: Colors.white,
    surfaceContainerHighest: Color(0xFF1A1A1A), // Dark Gray
    onSurfaceVariant: Color(0xFFE5E5E5),

    outline: Color(0xFF333333),
    outlineVariant: Color(0xFF1A1A1A),

    shadow: Colors.black,
    scrim: Colors.black54,

    inverseSurface: Color(0xFFE5E5E5),
    onInverseSurface: Color(0xFF1A1A1A),
    inversePrimary: Color(0xFFE63946),
  );

  /// Light Color Scheme
  static const ColorScheme lightColorScheme = ColorScheme.light(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFFFEBEE),
    onPrimaryContainer: Color(0xFFC62828),

    secondary: secondary,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFFFCDD2),
    onSecondaryContainer: Color(0xFFB71C1C),

    tertiary: accent,
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFF5F5F5),
    onTertiaryContainer: Color(0xFF212121),

    error: error,
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),

    surface: Color(0xFFFFF9C4), // Light Yellow (Yellow 100)
    onSurface: Color(0xFF000000), // Pure Black text on yellow
    surfaceContainerHighest: Color(0xFFF9FBE7), // Lime 50
    onSurfaceVariant: Color(0xFF263238),

    outline: Color(0xFFBDBDBD),
    outlineVariant: Color(0xFFE0E0E0),

    shadow: Colors.black26,
    scrim: Colors.black54,

    inverseSurface: Color(0xFF263238),
    onInverseSurface: Color(0xFFFFF9C4),
    inversePrimary: Color(0xFFFF8A80),
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
