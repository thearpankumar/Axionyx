import 'package:flutter/material.dart';

/// Typography styles for Axionyx Mobile App
/// Uses Inter for headings/body and JetBrains Mono for monospace readings
class AppTextStyles {
  // Font Families
  static const String interFont = 'Inter';
  static const String jetBrainsMonoFont = 'JetBrainsMono';

  // Display Styles (Extra Large Headlines)
  static const TextStyle displayLarge = TextStyle(
    fontFamily: interFont,
    fontSize: 57,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    height: 1.12,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: interFont,
    fontSize: 45,
    fontWeight: FontWeight.w700,
    height: 1.16,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: interFont,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.22,
  );

  // Headline Styles
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: interFont,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: interFont,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.29,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: interFont,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.33,
  );

  // Title Styles
  static const TextStyle titleLarge = TextStyle(
    fontFamily: interFont,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.27,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: interFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: interFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.33,
  );

  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: interFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: interFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: interFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // Label Styles
  static const TextStyle labelLarge = TextStyle(
    fontFamily: interFont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: interFont,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.33,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: interFont,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.45,
  );

  // Monospace Styles (for temperature readings, cycle counts, etc.)
  static const TextStyle monoLarge = TextStyle(
    fontFamily: jetBrainsMonoFont,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.33,
  );

  static const TextStyle monoMedium = TextStyle(
    fontFamily: jetBrainsMonoFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.33,
  );

  static const TextStyle monoSmall = TextStyle(
    fontFamily: jetBrainsMonoFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.43,
  );

  // Special Use Cases
  static const TextStyle button = TextStyle(
    fontFamily: interFont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.4,
    height: 1.43,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: interFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: interFont,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    height: 1.6,
  );

  /// Create TextTheme for Material Design
  static TextTheme get textTheme => const TextTheme(
        displayLarge: displayLarge,
        displayMedium: displayMedium,
        displaySmall: displaySmall,
        headlineLarge: headlineLarge,
        headlineMedium: headlineMedium,
        headlineSmall: headlineSmall,
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: titleSmall,
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        labelLarge: labelLarge,
        labelMedium: labelMedium,
        labelSmall: labelSmall,
      );

  /// Get temperature reading style (monospace, large)
  static TextStyle getTemperatureStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: jetBrainsMonoFont,
      fontSize: fontSize ?? 32,
      fontWeight: fontWeight ?? FontWeight.w700,
      letterSpacing: 0,
      height: 1.2,
      color: color,
    );
  }

  /// Get cycle count style (monospace, medium)
  static TextStyle getCycleCountStyle({
    double? fontSize,
    Color? color,
  }) {
    return TextStyle(
      fontFamily: jetBrainsMonoFont,
      fontSize: fontSize ?? 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.3,
      color: color,
    );
  }

  /// Get status badge style
  static TextStyle getStatusBadgeStyle({Color? color}) {
    return TextStyle(
      fontFamily: interFont,
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.8,
      height: 1.27,
      color: color ?? Colors.white,
    );
  }
}
