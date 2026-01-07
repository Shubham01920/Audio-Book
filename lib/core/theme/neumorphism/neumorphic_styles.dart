// =============================================================================
// NEUMORPHIC STYLES - Reusable Neumorphism Decorations
// =============================================================================
// This file provides factory methods for creating neumorphic box decorations.
// Neumorphism uses subtle shadows to create a soft, extruded appearance.
//
// DESIGN PRINCIPLES:
// - Raised: Element appears to push out of the surface (convex)
// - Pressed: Element appears pushed into the surface (concave/inset)
// - Flat: Subtle depth for background elements
//
// NAVIGATION RELATIONSHIPS:
// - Used by: All neumorphic widgets (NeuContainer, NeuButton, NeuCard, etc.)
// - Dependencies: app_colors.dart, spacing.dart
// =============================================================================

import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../../constants/spacing.dart';

/// Enum to define neumorphic style variants
enum NeuStyle {
  /// Raised/convex - appears to push out (default for buttons, cards)
  raised,

  /// Pressed/concave - appears pushed in (active states, inputs)
  pressed,

  /// Flat - subtle depth (background elements)
  flat,
}

/// Enum to define neumorphic intensity levels
enum NeuIntensity {
  /// Light shadows - subtle effect
  light,

  /// Medium shadows - standard effect (default)
  medium,

  /// Strong shadows - pronounced effect
  strong,
}

/// Factory class for creating neumorphic decorations.
///
/// Usage:
/// ```dart
/// Container(
///   decoration: NeuDecoration.raised(),
///   child: Text('Hello'),
/// )
/// ```
class NeuDecoration {
  // Private constructor
  NeuDecoration._();

  // ===========================================================================
  // RAISED STYLE (Convex - Element pushes out)
  // ===========================================================================

  /// Creates a raised neumorphic decoration.
  ///
  /// Use for: Buttons, cards, elevated containers
  ///
  /// [color] - Background color (defaults to neumorphic background)
  /// [radius] - Border radius (defaults to 16px)
  /// [intensity] - Shadow intensity level
  /// [isDark] - Whether to use dark mode colors
  static BoxDecoration raised({
    Color? color,
    double radius = Spacing.radiusLg,
    NeuIntensity intensity = NeuIntensity.medium,
    bool isDark = false,
  }) {
    final bgColor =
        color ?? (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);
    final lightShadow = isDark
        ? AppColors.lightShadowDark
        : AppColors.lightShadowLight;
    final darkShadow = isDark
        ? AppColors.darkShadowDark
        : AppColors.darkShadowLight;

    final offsets = _getOffsets(intensity);
    final blur = _getBlur(intensity);

    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        // Light shadow (top-left)
        BoxShadow(
          color: lightShadow.withValues(alpha: isDark ? 0.1 : 0.8),
          offset: Offset(-offsets, -offsets),
          blurRadius: blur,
          spreadRadius: 0,
        ),
        // Dark shadow (bottom-right)
        BoxShadow(
          color: darkShadow.withValues(alpha: isDark ? 0.5 : 0.3),
          offset: Offset(offsets, offsets),
          blurRadius: blur,
          spreadRadius: 0,
        ),
      ],
    );
  }

  // ===========================================================================
  // PRESSED STYLE (Concave - Element pushed in)
  // ===========================================================================

  /// Creates a pressed/inset neumorphic decoration.
  ///
  /// Use for: Active button states, text inputs, selected items
  ///
  /// Note: Flutter doesn't support inset shadows directly, so we simulate
  /// this effect by inverting the shadow positions and using an inner container.
  ///
  /// [color] - Background color
  /// [radius] - Border radius
  /// [intensity] - Shadow intensity
  /// [isDark] - Dark mode flag
  static BoxDecoration pressed({
    Color? color,
    double radius = Spacing.radiusLg,
    NeuIntensity intensity = NeuIntensity.medium,
    bool isDark = false,
  }) {
    final bgColor =
        color ?? (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);
    final lightShadow = isDark
        ? AppColors.lightShadowDark
        : AppColors.lightShadowLight;
    final darkShadow = isDark
        ? AppColors.darkShadowDark
        : AppColors.darkShadowLight;

    final offsets = _getOffsets(intensity) * 0.6;
    final blur = _getBlur(intensity) * 0.5;

    // For pressed effect, we use a gradient to simulate inner shadow
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          darkShadow.withValues(alpha: isDark ? 0.15 : 0.08),
          bgColor,
          lightShadow.withValues(alpha: isDark ? 0.05 : 0.5),
        ],
        stops: const [0.0, 0.5, 1.0],
      ),
      boxShadow: [
        // Subtle outer shadow for depth
        BoxShadow(
          color: darkShadow.withValues(alpha: 0.1),
          offset: Offset(offsets, offsets),
          blurRadius: blur,
          spreadRadius: -2,
        ),
      ],
    );
  }

  // ===========================================================================
  // FLAT STYLE (Subtle depth)
  // ===========================================================================

  /// Creates a flat neumorphic decoration with subtle depth.
  ///
  /// Use for: Background sections, subtle cards, inactive elements
  ///
  /// [color] - Background color
  /// [radius] - Border radius
  /// [isDark] - Dark mode flag
  static BoxDecoration flat({
    Color? color,
    double radius = Spacing.radiusMd,
    bool isDark = false,
  }) {
    final bgColor =
        color ?? (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);
    final lightShadow = isDark
        ? AppColors.lightShadowDark
        : AppColors.lightShadowLight;
    final darkShadow = isDark
        ? AppColors.darkShadowDark
        : AppColors.darkShadowLight;

    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        BoxShadow(
          color: lightShadow.withValues(alpha: isDark ? 0.05 : 0.5),
          offset: const Offset(-3, -3),
          blurRadius: 6,
        ),
        BoxShadow(
          color: darkShadow.withValues(alpha: isDark ? 0.3 : 0.15),
          offset: const Offset(3, 3),
          blurRadius: 6,
        ),
      ],
    );
  }

  // ===========================================================================
  // CIRCULAR STYLE (For round buttons/icons)
  // ===========================================================================

  /// Creates a circular neumorphic decoration.
  ///
  /// Use for: Icon buttons, avatar containers, FABs
  ///
  /// [color] - Background color
  /// [style] - Raised or pressed
  /// [intensity] - Shadow intensity
  /// [isDark] - Dark mode flag
  static BoxDecoration circular({
    Color? color,
    NeuStyle style = NeuStyle.raised,
    NeuIntensity intensity = NeuIntensity.medium,
    bool isDark = false,
  }) {
    final bgColor =
        color ?? (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);
    final lightShadow = isDark
        ? AppColors.lightShadowDark
        : AppColors.lightShadowLight;
    final darkShadow = isDark
        ? AppColors.darkShadowDark
        : AppColors.darkShadowLight;

    final offsets = _getOffsets(intensity);
    final blur = _getBlur(intensity);

    if (style == NeuStyle.pressed) {
      return BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            darkShadow.withValues(alpha: isDark ? 0.15 : 0.08),
            bgColor,
            lightShadow.withValues(alpha: isDark ? 0.05 : 0.5),
          ],
        ),
      );
    }

    return BoxDecoration(
      color: bgColor,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: lightShadow.withValues(alpha: isDark ? 0.1 : 0.8),
          offset: Offset(-offsets, -offsets),
          blurRadius: blur,
        ),
        BoxShadow(
          color: darkShadow.withValues(alpha: isDark ? 0.5 : 0.3),
          offset: Offset(offsets, offsets),
          blurRadius: blur,
        ),
      ],
    );
  }

  // ===========================================================================
  // HELPER METHODS
  // ===========================================================================

  /// Get shadow offset based on intensity
  static double _getOffsets(NeuIntensity intensity) {
    switch (intensity) {
      case NeuIntensity.light:
        return Spacing.neuOffsetSm;
      case NeuIntensity.medium:
        return Spacing.neuOffset;
      case NeuIntensity.strong:
        return Spacing.neuOffsetLg;
    }
  }

  /// Get blur radius based on intensity
  static double _getBlur(NeuIntensity intensity) {
    switch (intensity) {
      case NeuIntensity.light:
        return Spacing.neuBlurSm;
      case NeuIntensity.medium:
        return Spacing.neuBlur;
      case NeuIntensity.strong:
        return Spacing.neuBlur * 1.5;
    }
  }
}

/// Extension to easily apply neumorphic decorations
extension NeuBoxDecorationExtension on BoxDecoration {
  /// Returns a copy of this decoration with updated color
  BoxDecoration withColor(Color color) {
    return copyWith(color: color);
  }
}
