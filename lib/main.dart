// =============================================================================
// MAIN - Application Entry Point
// =============================================================================
// The entry point of the Audiobook application.
// Initializes Flutter bindings and runs the app.
//
// NAVIGATION RELATIONSHIPS:
// - Entry point for the entire application
// - Dependencies: app.dart
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/app.dart';

/// Application entry point.
///
/// Initializes Flutter and system UI settings before running the app.
void main() {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations (portrait only for mobile)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Color(0xFFE8EEF1),
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Run the application
  runApp(const AudiobookApp());
}
