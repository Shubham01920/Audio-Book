// =============================================================================
// APP COLORS - Audiobook App Color Palette
// =============================================================================
// This file defines all colors used throughout the application.
// Colors are organized by their purpose and include both light and dark mode variants.
//
// NAVIGATION RELATIONSHIPS:
// - Used by: app_theme.dart, neumorphic_theme.dart, all UI components
// - Dependencies: None (base file)
// =============================================================================

import 'package:flutter/material.dart';

/// Central color palette for the Audiobook app.
///
/// Colors are designed to work with neumorphism design principles,
/// featuring soft, muted tones that allow shadows to create depth.
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ===========================================================================
  // NEUMORPHIC BACKGROUND COLORS
  // ===========================================================================
  // These are the base surface colors for neumorphic elements.
  // Neumorphism works best with soft, muted background colors.

  /// Primary background color for light mode
  /// A soft gray that allows neumorphic shadows to be visible
  static const Color backgroundLight = Color(0xFFE8EEF1);

  /// Primary background color for dark mode
  static const Color backgroundDark = Color(0xFF2D2D3A);

  /// Surface color for cards and elevated elements (light mode)
  static const Color surfaceLight = Color(0xFFE8EEF1);

  /// Surface color for cards and elevated elements (dark mode)
  static const Color surfaceDark = Color(0xFF363648);

  // ===========================================================================
  // NEUMORPHIC SHADOW COLORS (LIGHT MODE)
  // ===========================================================================
  // Neumorphism uses two shadows: a lighter one (top-left) and a darker one (bottom-right)

  /// Light shadow for raised elements (creates highlight effect)
  static const Color lightShadowLight = Color(0xFFFFFFFF);

  /// Dark shadow for raised elements (creates depth)
  static const Color darkShadowLight = Color(0xFFA3B1C6);

  // ===========================================================================
  // NEUMORPHIC SHADOW COLORS (DARK MODE)
  // ===========================================================================

  /// Light shadow for dark mode
  static const Color lightShadowDark = Color(0xFF3D3D4E);

  /// Dark shadow for dark mode
  static const Color darkShadowDark = Color(0xFF1D1D26);

  // ===========================================================================
  // PRIMARY ACCENT COLORS
  // ===========================================================================

  /// Primary accent color - Used for main actions and CTAs
  /// A pleasant blue matching the reference design
  static const Color primary = Color(0xFF4A90D9);

  /// Primary color variants
  static const Color primaryLight = Color(0xFF7AB8FF);
  static const Color primaryDark = Color(0xFF1565A7);

  /// Secondary accent - Used for highlights and secondary actions
  static const Color secondary = Color(0xFF6C63FF);

  /// Secondary variants
  static const Color secondaryLight = Color(0xFF9D95FF);
  static const Color secondaryDark = Color(0xFF3D34CB);

  /// Royal Blue - Rich accent color for primary buttons
  static const Color royalBlue = Color(0xFF4169E1);

  // ===========================================================================
  // SEMANTIC COLORS
  // ===========================================================================

  /// Success state color
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);

  /// Warning state color
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);

  /// Error state color
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFD32F2F);

  /// Info state color
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);

  // ===========================================================================
  // TEXT COLORS
  // ===========================================================================

  /// Primary text color for main content
  static const Color textPrimary = Color(0xFF2D3436);

  /// Secondary text color for less emphasized content
  static const Color textSecondary = Color(0xFF636E72);

  /// Hint/placeholder text color
  static const Color textHint = Color(0xFFB2BEC3);

  /// Disabled text color
  static const Color textDisabled = Color(0xFFDFE6E9);

  /// Text color on primary backgrounds
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  /// Text color for dark mode
  static const Color textPrimaryDark = Color(0xFFF5F6FA);
  static const Color textSecondaryDark = Color(0xFFB2BEC3);

  // ===========================================================================
  // ICON COLORS
  // ===========================================================================

  /// Default icon color
  static const Color iconDefault = Color(0xFF636E72);

  /// Active/selected icon color
  static const Color iconActive = Color(0xFF4A90D9);

  /// Disabled icon color
  static const Color iconDisabled = Color(0xFFB2BEC3);

  // ===========================================================================
  // DIVIDER & BORDER COLORS
  // ===========================================================================

  /// Divider color for light mode
  static const Color divider = Color(0xFFDFE6E9);

  /// Border color for inputs and cards
  static const Color border = Color(0xFFD1D9E0);

  /// Focus border color
  static const Color borderFocus = Color(0xFF4A90D9);

  /// Border color for dark mode
  static const Color borderDark = Color(0xFF4A4A5A);
  // ===========================================================================
  // SOCIAL BUTTON COLORS
  // ===========================================================================

  /// Google brand color
  static const Color google = Color(0xFFDB4437);

  /// Apple brand color (for light backgrounds)
  static const Color apple = Color(0xFF000000);

  /// Facebook brand color
  static const Color facebook = Color(0xFF4267B2);

  // ===========================================================================
  // GRADIENT DEFINITIONS
  // ===========================================================================

  /// Primary button gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primary, primaryLight],
  );

  /// Accent gradient for special elements
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, primary],
  );
}
