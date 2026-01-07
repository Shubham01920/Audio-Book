// =============================================================================
// GLOW STYLES - Solid Glow Effects for UI Elements
// =============================================================================
// Provides glow effects for the 30% solid glow design elements.
// Used alongside neumorphism for a modern, vibrant UI.
//
// USAGE:
// - Add to BoxDecoration boxShadow list
// - Combine with neumorphic containers
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Solid glow effect styles for interactive elements.
///
/// Design ratio: 60% Neumorphism + 30% Solid Glow + 10% Other
class GlowStyles {
  GlowStyles._();

  // ===========================================================================
  // PRIMARY GLOW - For main action buttons and CTAs
  // ===========================================================================

  /// Primary action glow (purple/primary color)
  static BoxShadow get primaryGlow => BoxShadow(
    color: AppColors.primary.withValues(alpha: 0.4),
    blurRadius: 20,
    spreadRadius: 2,
  );

  /// Primary glow - subtle version
  static BoxShadow get primaryGlowSubtle => BoxShadow(
    color: AppColors.primary.withValues(alpha: 0.25),
    blurRadius: 12,
    spreadRadius: 1,
  );

  /// Primary glow - intense version (for hover/press)
  static BoxShadow get primaryGlowIntense => BoxShadow(
    color: AppColors.primary.withValues(alpha: 0.6),
    blurRadius: 24,
    spreadRadius: 4,
  );

  // ===========================================================================
  // SUCCESS GLOW - For completed items, checkmarks, downloads
  // ===========================================================================

  /// Success state glow (green)
  static BoxShadow get successGlow => BoxShadow(
    color: AppColors.success.withValues(alpha: 0.4),
    blurRadius: 16,
    spreadRadius: 2,
  );

  /// Success glow - subtle
  static BoxShadow get successGlowSubtle => BoxShadow(
    color: AppColors.success.withValues(alpha: 0.25),
    blurRadius: 10,
    spreadRadius: 1,
  );

  // ===========================================================================
  // ACCENT GLOW - For secondary actions, highlights
  // ===========================================================================

  /// Accent/secondary glow (teal/cyan)
  static BoxShadow get accentGlow => BoxShadow(
    color: AppColors.secondary.withValues(alpha: 0.4),
    blurRadius: 16,
    spreadRadius: 2,
  );

  /// Accent glow - subtle
  static BoxShadow get accentGlowSubtle => BoxShadow(
    color: AppColors.secondary.withValues(alpha: 0.25),
    blurRadius: 10,
    spreadRadius: 1,
  );

  // ===========================================================================
  // WARNING / GOLD GLOW - For premium, stars, badges
  // ===========================================================================

  /// Warning/gold glow (amber)
  static BoxShadow get warningGlow => BoxShadow(
    color: AppColors.warning.withValues(alpha: 0.4),
    blurRadius: 16,
    spreadRadius: 2,
  );

  /// Gold glow - subtle
  static BoxShadow get goldGlowSubtle => BoxShadow(
    color: const Color(0xFFFFD700).withValues(alpha: 0.3),
    blurRadius: 12,
    spreadRadius: 1,
  );

  // ===========================================================================
  // ERROR GLOW - For errors, delete actions
  // ===========================================================================

  /// Error glow (red)
  static BoxShadow get errorGlow => BoxShadow(
    color: AppColors.error.withValues(alpha: 0.4),
    blurRadius: 16,
    spreadRadius: 2,
  );

  // ===========================================================================
  // CUSTOM COLOR GLOW - For genre/category colors
  // ===========================================================================

  /// Create a glow with custom color
  static BoxShadow colorGlow(Color color, {double intensity = 0.4}) =>
      BoxShadow(
        color: color.withValues(alpha: intensity),
        blurRadius: 16,
        spreadRadius: 2,
      );

  /// Create a subtle glow with custom color
  static BoxShadow colorGlowSubtle(Color color) => BoxShadow(
    color: color.withValues(alpha: 0.25),
    blurRadius: 10,
    spreadRadius: 1,
  );

  // ===========================================================================
  // PLAYING INDICATOR GLOW - Pulsing effect for now playing
  // ===========================================================================

  /// Active/playing indicator glow
  static BoxShadow get playingGlow => BoxShadow(
    color: AppColors.primary.withValues(alpha: 0.5),
    blurRadius: 24,
    spreadRadius: 4,
  );

  // ===========================================================================
  // GLOW DECORATIONS - Complete BoxDecoration with glow
  // ===========================================================================

  /// Circular button with primary glow
  static BoxDecoration primaryButtonGlow({
    Color? backgroundColor,
    bool isPressed = false,
  }) => BoxDecoration(
    color: backgroundColor ?? AppColors.primary,
    shape: BoxShape.circle,
    boxShadow: [if (!isPressed) primaryGlow, if (isPressed) primaryGlowSubtle],
  );

  /// Rounded rectangle with glow
  static BoxDecoration glowContainer({
    required Color glowColor,
    Color? backgroundColor,
    double radius = 16,
    double intensity = 0.35,
  }) => BoxDecoration(
    color: backgroundColor ?? Colors.white,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: glowColor.withValues(alpha: intensity),
        blurRadius: 16,
        spreadRadius: 2,
      ),
    ],
  );

  /// Border glow effect (outline glow)
  static BoxDecoration borderGlow({
    required Color glowColor,
    Color? backgroundColor,
    double radius = 16,
  }) => BoxDecoration(
    color: backgroundColor,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: glowColor.withValues(alpha: 0.5), width: 2),
    boxShadow: [
      BoxShadow(
        color: glowColor.withValues(alpha: 0.3),
        blurRadius: 12,
        spreadRadius: 0,
      ),
    ],
  );

  // ===========================================================================
  // QUICK NAV GLOW COLORS - For library quick navigation
  // ===========================================================================

  static BoxShadow get shelvesGlow => colorGlow(Colors.amber);
  static BoxShadow get wishlistGlow => colorGlow(Colors.pink);
  static BoxShadow get statsGlow => colorGlow(Colors.purple);
  static BoxShadow get downloadsGlow => colorGlow(Colors.teal);
}

/// Extension for easy glow application
extension GlowExtension on Widget {
  /// Wrap widget with glow container
  Widget withGlow({
    required Color glowColor,
    double intensity = 0.35,
    double radius = 16,
  }) {
    return Container(
      decoration: GlowStyles.glowContainer(
        glowColor: glowColor,
        radius: radius,
        intensity: intensity,
      ),
      child: this,
    );
  }
}
