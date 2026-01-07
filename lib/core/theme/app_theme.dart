// =============================================================================
// APP THEME - Main Theme Configuration
// =============================================================================
// This file defines the complete theme for the Audiobook app.
// It configures Material theme with neumorphism-compatible settings.
//
// NAVIGATION RELATIONSHIPS:
// - Used by: app.dart (MaterialApp)
// - Dependencies: app_colors.dart, app_typography.dart
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';
import '../constants/spacing.dart';

/// Main theme configuration for the Audiobook app.
///
/// Provides both light and dark theme variants.
class AppTheme {
  // Private constructor
  AppTheme._();

  // ===========================================================================
  // LIGHT THEME
  // ===========================================================================

  /// Light theme configuration
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryLight,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryLight,
        surface: AppColors.surfaceLight,
        error: AppColors.error,
        onPrimary: AppColors.textOnPrimary,
        onSecondary: AppColors.textOnPrimary,
        onSurface: AppColors.textPrimary,
        onError: AppColors.textOnPrimary,
      ),

      // Scaffold background - neumorphic base color
      scaffoldBackgroundColor: AppColors.backgroundLight,

      // App Bar Theme
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.textPrimary,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: AppTypography.h4,
        iconTheme: IconThemeData(
          color: AppColors.textPrimary,
          size: Spacing.iconMd,
        ),
      ),

      // Bottom Navigation Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundLight,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.iconDefault,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTypography.labelSmall,
        unselectedLabelStyle: AppTypography.labelSmall,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusLg),
        ),
        margin: const EdgeInsets.all(Spacing.sm),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          minimumSize: const Size(double.infinity, Spacing.buttonHeightMd),
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.buttonPaddingH,
            vertical: Spacing.buttonPaddingV,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
          ),
          textStyle: AppTypography.buttonLarge,
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.buttonSmall,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Spacing.inputPaddingH,
          vertical: Spacing.inputPaddingV,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        hintStyle: AppTypography.inputHint,
        labelStyle: AppTypography.labelLarge,
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.textOnPrimary),
        side: const BorderSide(color: AppColors.border, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: Spacing.md,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.iconDefault,
        size: Spacing.iconMd,
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: AppTypography.h1,
        displayMedium: AppTypography.h2,
        displaySmall: AppTypography.h3,
        headlineLarge: AppTypography.h2,
        headlineMedium: AppTypography.h3,
        headlineSmall: AppTypography.h4,
        titleLarge: AppTypography.h4,
        titleMedium: AppTypography.h5,
        titleSmall: AppTypography.h6,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        bodySmall: AppTypography.bodySmall,
        labelLarge: AppTypography.labelLarge,
        labelMedium: AppTypography.labelMedium,
        labelSmall: AppTypography.labelSmall,
      ),
    );
  }

  // ===========================================================================
  // DARK THEME
  // ===========================================================================

  /// Dark theme configuration
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.secondaryDark,
        surface: AppColors.surfaceDark,
        error: AppColors.errorLight,
        onPrimary: AppColors.textOnPrimary,
        onSecondary: AppColors.textOnPrimary,
        onSurface: AppColors.textPrimaryDark,
        onError: AppColors.textOnPrimary,
      ),

      // Scaffold background - neumorphic base color
      scaffoldBackgroundColor: AppColors.backgroundDark,

      // App Bar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: AppColors.textPrimaryDark,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTypography.h4.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.textPrimaryDark,
          size: Spacing.iconMd,
        ),
      ),

      // Bottom Navigation Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundDark,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondaryDark,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusLg),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          minimumSize: const Size(double.infinity, Spacing.buttonHeightMd),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
          ),
          textStyle: AppTypography.buttonLarge,
        ),
      ),

      // Text Theme (Dark mode colors)
      textTheme: TextTheme(
        displayLarge: AppTypography.h1.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        displayMedium: AppTypography.h2.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        displaySmall: AppTypography.h3.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineLarge: AppTypography.h2.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineMedium: AppTypography.h3.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        headlineSmall: AppTypography.h4.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        titleLarge: AppTypography.h4.copyWith(color: AppColors.textPrimaryDark),
        titleMedium: AppTypography.h5.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        titleSmall: AppTypography.h6.copyWith(color: AppColors.textPrimaryDark),
        bodyLarge: AppTypography.bodyLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodyMedium: AppTypography.bodyMedium.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        bodySmall: AppTypography.bodySmall.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        labelLarge: AppTypography.labelLarge.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        labelMedium: AppTypography.labelMedium.copyWith(
          color: AppColors.textSecondaryDark,
        ),
        labelSmall: AppTypography.labelSmall.copyWith(
          color: AppColors.textSecondaryDark,
        ),
      ),
    );
  }
}
