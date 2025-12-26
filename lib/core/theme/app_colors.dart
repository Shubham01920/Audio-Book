import 'package:flutter/material.dart';

/// App color palette - Premium dark theme with vibrant accents
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

  // Background Colors - Dark Theme
  static const Color backgroundDark = Color(0xFF0F0F1A);
  static const Color surfaceDark = Color(0xFF1A1A2E);
  static const Color cardDark = Color(0xFF252540);
  static const Color elevatedDark = Color(0xFF2D2D4A);

  // Background Colors - Light Theme
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFF1F5F9);
  static const Color elevatedLight = Color(0xFFE2E8F0);

  // Text Colors
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textTertiaryDark = Color(0xFF64748B);

  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color textTertiaryLight = Color(0xFF94A3B8);

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Player Colors
  static const Color playerBackground = Color(0xFF1A1A2E);
  static const Color progressActive = Color(0xFF7C3AED);
  static const Color progressBuffer = Color(0xFF3F3F5A);
  static const Color progressInactive = Color(0xFF2D2D4A);

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
    colors: [Color(0xFF1A1A2E), Color(0xFF0F0F1A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
