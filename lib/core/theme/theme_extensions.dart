import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Extension to easily get theme-aware colors
extension ThemeColors on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Background colors
  Color get backgroundColor =>
      isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
  Color get surfaceColor =>
      isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
  Color get cardColor => isDark ? AppColors.cardDark : AppColors.cardLight;
  Color get elevatedColor =>
      isDark ? AppColors.elevatedDark : AppColors.elevatedLight;

  // Text colors
  Color get textPrimary =>
      isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
  Color get textSecondary =>
      isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
  Color get textTertiary =>
      isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight;
}

/// Helper class for theme-aware colors (static access)
class ThemeAwareColors {
  static Color textPrimary(BuildContext context) {
    return context.isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
  }

  static Color textSecondary(BuildContext context) {
    return context.isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
  }

  static Color textTertiary(BuildContext context) {
    return context.isDark
        ? AppColors.textTertiaryDark
        : AppColors.textTertiaryLight;
  }

  static Color background(BuildContext context) {
    return context.isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
  }

  static Color surface(BuildContext context) {
    return context.isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
  }

  static Color card(BuildContext context) {
    return context.isDark ? AppColors.cardDark : AppColors.cardLight;
  }

  static Color elevated(BuildContext context) {
    return context.isDark ? AppColors.elevatedDark : AppColors.elevatedLight;
  }
}
