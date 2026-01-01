import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_schemes.dart';
import 'text_styles.dart';

/// Main app theme configuration with Material 3 and glassmorphism support
class AppTheme {
  /// Dark theme (primary mode)
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: AppColorSchemes.darkColorScheme,
        textTheme: AppTextStyles.textTheme,
        fontFamily: AppTextStyles.interFont,

        // App Bar Theme
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleTextStyle:
              AppTextStyles.titleLarge.copyWith(color: Colors.white),
          iconTheme: const IconThemeData(color: Colors.white),
        ),

        // Card Theme
        cardTheme: CardTheme(
          elevation: 4,
          color: AppColorSchemes.darkColorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
        ),

        // Bottom Navigation Bar Theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColorSchemes.darkColorScheme.surface,
          selectedItemColor: AppColorSchemes.secondary,
          unselectedItemColor: Colors.white54,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedLabelStyle: AppTextStyles.labelSmall,
          unselectedLabelStyle: AppTextStyles.labelSmall,
        ),

        // FloatingActionButton Theme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 6,
          highlightElevation: 12,
          backgroundColor: AppColorSchemes.secondary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: AppTextStyles.button,
          ),
        ),

        // Outlined Button Theme
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(
              color: AppColorSchemes.darkColorScheme.outline,
              width: 1.5,
            ),
            textStyle: AppTextStyles.button,
          ),
        ),

        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            textStyle: AppTextStyles.button,
          ),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColorSchemes.darkColorScheme.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColorSchemes.secondary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColorSchemes.error,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColorSchemes.error,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white38,
          ),
          labelStyle: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white70,
          ),
        ),

        // Dialog Theme
        dialogTheme: DialogTheme(
          elevation: 8,
          backgroundColor: AppColorSchemes.darkColorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          titleTextStyle: AppTextStyles.titleLarge.copyWith(
            color: Colors.white,
          ),
          contentTextStyle: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white70,
          ),
        ),

        // Bottom Sheet Theme
        bottomSheetTheme: BottomSheetThemeData(
          elevation: 8,
          backgroundColor: AppColorSchemes.darkColorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAlias,
        ),

        // Snackbar Theme
        snackBarTheme: SnackBarThemeData(
          elevation: 6,
          backgroundColor: const Color(0xFF334155),
          contentTextStyle: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
        ),

        // Divider Theme
        dividerTheme: DividerThemeData(
          color: AppColorSchemes.darkColorScheme.outlineVariant,
          thickness: 1,
          space: 1,
        ),

        // Switch Theme
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColorSchemes.secondary;
            }
            return Colors.white54;
          }),
          trackColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColorSchemes.secondary.withOpacity(0.5);
            }
            return Colors.white24;
          }),
        ),

        // Slider Theme
        sliderTheme: SliderThemeData(
          activeTrackColor: AppColorSchemes.secondary,
          inactiveTrackColor: Colors.white24,
          thumbColor: AppColorSchemes.secondary,
          overlayColor: AppColorSchemes.secondary.withOpacity(0.2),
          valueIndicatorColor: AppColorSchemes.secondary,
          valueIndicatorTextStyle: AppTextStyles.labelSmall.copyWith(
            color: Colors.white,
          ),
        ),

        // Chip Theme
        chipTheme: ChipThemeData(
          backgroundColor: AppColorSchemes.darkColorScheme.surfaceVariant,
          deleteIconColor: Colors.white70,
          disabledColor: Colors.white12,
          selectedColor: AppColorSchemes.secondary,
          secondarySelectedColor: AppColorSchemes.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          labelStyle: AppTextStyles.labelMedium,
          secondaryLabelStyle: AppTextStyles.labelMedium,
          brightness: Brightness.dark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Icon Theme
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 24,
        ),

        // Scaffold Background
        scaffoldBackgroundColor: AppColorSchemes.darkColorScheme.background,
      );

  /// Light theme
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: AppColorSchemes.lightColorScheme,
        textTheme: AppTextStyles.textTheme,
        fontFamily: AppTextStyles.interFont,

        // App Bar Theme
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: false,
          backgroundColor: Colors.transparent,
          foregroundColor: AppColorSchemes.lightColorScheme.onBackground,
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          titleTextStyle: AppTextStyles.titleLarge.copyWith(
            color: AppColorSchemes.lightColorScheme.onBackground,
          ),
          iconTheme: IconThemeData(
            color: AppColorSchemes.lightColorScheme.onBackground,
          ),
        ),

        // Card Theme
        cardTheme: CardTheme(
          elevation: 2,
          color: AppColorSchemes.lightColorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
        ),

        // Bottom Navigation Bar Theme
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColorSchemes.lightColorScheme.surface,
          selectedItemColor: AppColorSchemes.primary,
          unselectedItemColor:
              AppColorSchemes.lightColorScheme.onSurfaceVariant,
          type: BottomNavigationBarType.fixed,
          elevation: 8,
          selectedLabelStyle: AppTextStyles.labelSmall,
          unselectedLabelStyle: AppTextStyles.labelSmall,
        ),

        // FloatingActionButton Theme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 6,
          highlightElevation: 12,
          backgroundColor: AppColorSchemes.secondary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: AppTextStyles.button,
          ),
        ),

        // Outlined Button Theme
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(
              color: AppColorSchemes.lightColorScheme.outline,
              width: 1.5,
            ),
            textStyle: AppTextStyles.button,
          ),
        ),

        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            textStyle: AppTextStyles.button,
          ),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColorSchemes.lightColorScheme.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColorSchemes.secondary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColorSchemes.error,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColorSchemes.error,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColorSchemes.lightColorScheme.onSurfaceVariant
                .withOpacity(0.6),
          ),
          labelStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColorSchemes.lightColorScheme.onSurfaceVariant,
          ),
        ),

        // Dialog Theme
        dialogTheme: DialogTheme(
          elevation: 8,
          backgroundColor: AppColorSchemes.lightColorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          titleTextStyle: AppTextStyles.titleLarge.copyWith(
            color: AppColorSchemes.lightColorScheme.onSurface,
          ),
          contentTextStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColorSchemes.lightColorScheme.onSurfaceVariant,
          ),
        ),

        // Bottom Sheet Theme
        bottomSheetTheme: BottomSheetThemeData(
          elevation: 8,
          backgroundColor: AppColorSchemes.lightColorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAlias,
        ),

        // Snackbar Theme
        snackBarTheme: SnackBarThemeData(
          elevation: 6,
          backgroundColor: const Color(0xFF334155),
          contentTextStyle: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          behavior: SnackBarBehavior.floating,
        ),

        // Divider Theme
        dividerTheme: DividerThemeData(
          color: AppColorSchemes.lightColorScheme.outlineVariant,
          thickness: 1,
          space: 1,
        ),

        // Switch Theme
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColorSchemes.secondary;
            }
            return AppColorSchemes.lightColorScheme.outline;
          }),
          trackColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColorSchemes.secondary.withOpacity(0.5);
            }
            return AppColorSchemes.lightColorScheme.surfaceVariant;
          }),
        ),

        // Slider Theme
        sliderTheme: SliderThemeData(
          activeTrackColor: AppColorSchemes.secondary,
          inactiveTrackColor: AppColorSchemes.lightColorScheme.surfaceVariant,
          thumbColor: AppColorSchemes.secondary,
          overlayColor: AppColorSchemes.secondary.withOpacity(0.2),
          valueIndicatorColor: AppColorSchemes.secondary,
          valueIndicatorTextStyle: AppTextStyles.labelSmall.copyWith(
            color: Colors.white,
          ),
        ),

        // Chip Theme
        chipTheme: ChipThemeData(
          backgroundColor: AppColorSchemes.lightColorScheme.surfaceVariant,
          deleteIconColor: AppColorSchemes.lightColorScheme.onSurfaceVariant,
          disabledColor:
              AppColorSchemes.lightColorScheme.surfaceVariant.withOpacity(0.5),
          selectedColor: AppColorSchemes.secondary,
          secondarySelectedColor: AppColorSchemes.secondary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          labelStyle: AppTextStyles.labelMedium,
          secondaryLabelStyle: AppTextStyles.labelMedium,
          brightness: Brightness.light,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Icon Theme
        iconTheme: IconThemeData(
          color: AppColorSchemes.lightColorScheme.onBackground,
          size: 24,
        ),

        // Scaffold Background
        scaffoldBackgroundColor: AppColorSchemes.lightColorScheme.background,
      );
}
