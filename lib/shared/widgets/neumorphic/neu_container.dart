// =============================================================================
// NEU CONTAINER - Base Neumorphic Container Widget
// =============================================================================
// A foundational container widget with neumorphic styling.
// Use as a building block for other neumorphic components.
//
// NAVIGATION RELATIONSHIPS:
// - Used by: NeuCard, NeuButton, and screen layouts
// - Dependencies: neumorphic_styles.dart, spacing.dart
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../core/constants/spacing.dart';

/// A container widget with neumorphic styling.
///
/// Provides raised, pressed, and flat neumorphic appearances.
///
/// Example:
/// ```dart
/// NeuContainer(
///   style: NeuStyle.raised,
///   child: Text('Hello'),
/// )
/// ```
class NeuContainer extends StatelessWidget {
  /// The child widget to display inside the container
  final Widget? child;

  /// Neumorphic style variant (raised, pressed, flat)
  final NeuStyle style;

  /// Shadow intensity level
  final NeuIntensity intensity;

  /// Container padding
  final EdgeInsetsGeometry? padding;

  /// Container margin
  final EdgeInsetsGeometry? margin;

  /// Border radius (defaults to 16px for neumorphic look)
  final double borderRadius;

  /// Container width
  final double? width;

  /// Container height
  final double? height;

  /// Custom background color (overrides theme)
  final Color? color;

  /// Alignment of child within container
  final AlignmentGeometry? alignment;

  /// Whether to use circular shape instead of rounded rectangle
  final bool isCircular;

  const NeuContainer({
    super.key,
    this.child,
    this.style = NeuStyle.raised,
    this.intensity = NeuIntensity.medium,
    this.padding,
    this.margin,
    this.borderRadius = Spacing.radiusLg,
    this.width,
    this.height,
    this.color,
    this.alignment,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if dark mode
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Get appropriate decoration based on style
    BoxDecoration decoration;

    if (isCircular) {
      decoration = NeuDecoration.circular(
        color: color,
        style: style,
        intensity: intensity,
        isDark: isDark,
      );
    } else {
      switch (style) {
        case NeuStyle.raised:
          decoration = NeuDecoration.raised(
            color: color,
            radius: borderRadius,
            intensity: intensity,
            isDark: isDark,
          );
        case NeuStyle.pressed:
          decoration = NeuDecoration.pressed(
            color: color,
            radius: borderRadius,
            intensity: intensity,
            isDark: isDark,
          );
        case NeuStyle.flat:
          decoration = NeuDecoration.flat(
            color: color,
            radius: borderRadius,
            isDark: isDark,
          );
      }
    }

    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment,
      decoration: decoration,
      child: child,
    );
  }
}

/// A neumorphic container with animation support.
///
/// Smoothly transitions between raised and pressed states.
class AnimatedNeuContainer extends StatelessWidget {
  final Widget? child;
  final NeuStyle style;
  final NeuIntensity intensity;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double? width;
  final double? height;
  final Color? color;
  final Duration duration;
  final Curve curve;

  const AnimatedNeuContainer({
    super.key,
    this.child,
    this.style = NeuStyle.raised,
    this.intensity = NeuIntensity.medium,
    this.padding,
    this.margin,
    this.borderRadius = Spacing.radiusLg,
    this.width,
    this.height,
    this.color,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    BoxDecoration decoration;
    switch (style) {
      case NeuStyle.raised:
        decoration = NeuDecoration.raised(
          color: color,
          radius: borderRadius,
          intensity: intensity,
          isDark: isDark,
        );
      case NeuStyle.pressed:
        decoration = NeuDecoration.pressed(
          color: color,
          radius: borderRadius,
          intensity: intensity,
          isDark: isDark,
        );
      case NeuStyle.flat:
        decoration = NeuDecoration.flat(
          color: color,
          radius: borderRadius,
          isDark: isDark,
        );
    }

    return AnimatedContainer(
      duration: duration,
      curve: curve,
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: child,
    );
  }
}
