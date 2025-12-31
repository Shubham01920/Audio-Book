import 'package:flutter/material.dart';

/// App color palette - Modern themes with true black dark mode
class AppColors {
  AppColors._();

  // Primary Brand Colors
  static const Color primary = Color(0xFF7C3AED); // Vibrant purple
  static const Color primaryLight = Color(0xFFA78BFA);
  static const Color primaryDark = Color(0xFF5B21B6);

  // Secondary Accent
  static const Color secondary = Color(0xFFF59E0B); // Warm amber
  static const Color secondaryLight = Color(0xFFFBBF24);
  static const Color secondaryDark = Color(0xFFD97706);

  // ═══════════════════════════════════════════════════════════
  // 🌙 DARK THEME - True Black OLED-friendly
  // ═══════════════════════════════════════════════════════════
  static const Color backgroundDark = Color(0xFF000000); // Pure black
  static const Color surfaceDark = Color(0xFF0A0A0A); // Near black
  static const Color cardDark = Color(0xFF121212); // Material dark
  static const Color elevatedDark = Color(0xFF1E1E1E); // Elevated surface

  // ═══════════════════════════════════════════════════════════
  // ☀️ LIGHT THEME - Modern & Clean with subtle tints
  // ═══════════════════════════════════════════════════════════
  static const Color backgroundLight = Color(0xFFFAFAFC); // Soft off-white
  static const Color surfaceLight = Color(0xFFFFFFFF); // Pure white
  static const Color cardLight = Color(0xFFF5F3FF); // Purple tinted card
  static const Color elevatedLight = Color(0xFFEDE9FE); // Light purple tint

  // Text Colors - Dark Theme
  static const Color textPrimaryDark = Color(0xFFFFFFFF); // Pure white
  static const Color textSecondaryDark = Color(0xFFB3B3B3); // Soft gray
  static const Color textTertiaryDark = Color(0xFF808080); // Medium gray

  // Text Colors - Light Theme
  static const Color textPrimaryLight = Color(0xFF1A1A2E); // Deep navy
  static const Color textSecondaryLight = Color(0xFF6B7280); // Slate gray
  static const Color textTertiaryLight = Color(0xFF9CA3AF); // Light slate

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Player Colors - Dark
  static const Color playerBackground = Color(0xFF0A0A0A);
  static const Color progressActive = Color(0xFF7C3AED);
  static const Color progressBuffer = Color(0xFF3F3F5A);
  static const Color progressInactive = Color(0xFF1E1E1E);

  // Bookmark Highlight Colors
  static const Color highlightYellow = Color(0xFFFDE047);
  static const Color highlightBlue = Color(0xFF60A5FA);
  static const Color highlightGreen = Color(0xFF4ADE80);
  static const Color highlightPink = Color(0xFFF472B6);
  static const Color highlightOrange = Color(0xFFFB923C);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF6366F1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [backgroundDark, surfaceDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient playerGradient = LinearGradient(
    colors: [Color(0xFF0A0A0A), Color(0xFF000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Light mode gradient
  static const LinearGradient lightGradient = LinearGradient(
    colors: [backgroundLight, surfaceLight],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
