import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'presentation/screens/home/home_screen.dart';

/// Main application widget
class AxionyxApp extends StatelessWidget {
  const AxionyxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Default to dark mode
      home: const HomeScreen(),
    );
  }
}
