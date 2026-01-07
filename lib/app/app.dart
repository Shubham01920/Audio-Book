// =============================================================================
// APP - Main Application Configuration
// =============================================================================
// Entry point wrapper that configures MaterialApp with theme and routing.
//
// NAVIGATION RELATIONSHIPS:
// - Used by: main.dart
// - Dependencies: app_theme.dart, routes.dart
// =============================================================================

import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import 'routes.dart';

/// Main application widget.
///
/// Configures the entire app with theme, routing, and global settings.
class AudiobookApp extends StatelessWidget {
  const AudiobookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App metadata
      title: 'Audiobook',
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light, // Start with light mode
      // Navigation
      initialRoute: Routes.splash,
      onGenerateRoute: AppRouter.generateRoute,

      // Localization (to be added later)
      // localizationsDelegates: [...],
      // supportedLocales: [...],

      // Builder for global overlays and error handling
      builder: (context, child) {
        // Apply global text scaling limits
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(
              MediaQuery.of(context).textScaler.scale(1.0).clamp(0.8, 1.3),
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
