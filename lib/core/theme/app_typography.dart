// =============================================================================
// APP TYPOGRAPHY - Text Styles for the Audiobook App
// =============================================================================
// This file defines all text styles used throughout the application.
// Consistent typography improves readability and visual hierarchy.
//
// NAVIGATION RELATIONSHIPS:
// - Used by: app_theme.dart, all UI components
// - Dependencies: app_colors.dart
// =============================================================================

import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Typography definitions for the Audiobook app.
///
/// Uses the default system font for clean, native appearance.
/// Text styles are organized by semantic meaning (headings, body, labels).
class AppTypography {
  // Private constructor to prevent instantiation
  AppTypography._();

  // ===========================================================================
  // FONT FAMILY
  // ===========================================================================

  /// Primary font family - Using system default for native feel
  static const String fontFamily = 'SF Pro Display';

  /// Secondary font family for body text
  static const String fontFamilyBody = 'SF Pro Text';

  // ===========================================================================
  // HEADING STYLES
  // ===========================================================================

  /// H1 - Main screen titles
  static const TextStyle h1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  /// H2 - Section titles
  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.3,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  /// H3 - Card titles, subsection headers
  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  /// H4 - List item titles
  static const TextStyle h4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H5 - Small headers
  static const TextStyle h5 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// H6 - Smallest headers
  static const TextStyle h6 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  // ===========================================================================
  // BODY TEXT STYLES
  // ===========================================================================

  /// Body large - Primary body text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.1,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  /// Body medium - Standard body text (default)
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.1,
    height: 1.5,
    color: AppColors.textPrimary,
  );

  /// Body small - Secondary information
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.2,
    height: 1.5,
    color: AppColors.textSecondary,
  );

  // ===========================================================================
  // LABEL STYLES
  // ===========================================================================

  /// Label large - Form labels, prominent captions
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// Label medium - Standard labels
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  /// Label small - Small captions, timestamps
  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  // ===========================================================================
  // BUTTON TEXT STYLES
  // ===========================================================================

  /// Button large - Primary CTA buttons
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.2,
    color: AppColors.textOnPrimary,
  );

  /// Button medium - Secondary buttons
  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    height: 1.2,
    color: AppColors.textOnPrimary,
  );

  /// Button small - Tertiary/text buttons
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    height: 1.2,
    color: AppColors.primary,
  );

  // ===========================================================================
  // SPECIAL STYLES
  // ===========================================================================

  /// Subtitle - Screen subtitles, taglines
  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.1,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  /// Caption - Small supporting text
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.2,
    height: 1.4,
    color: AppColors.textHint,
  );

  /// Overline - All caps labels
  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  /// Input text - Text inside input fields
  static const TextStyle inputText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.1,
    height: 1.4,
    color: AppColors.textPrimary,
  );

  /// Input hint - Placeholder text in inputs
  static const TextStyle inputHint = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.1,
    height: 1.4,
    color: AppColors.textHint,
  );

  /// Link text - Clickable text links
  static const TextStyle link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
    color: AppColors.primary,
    decoration: TextDecoration.none,
  );
}
