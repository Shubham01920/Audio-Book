// =============================================================================
// NEU CARD - Neumorphic Card Widget
// =============================================================================
// A card widget with neumorphic styling for elevated content.
//
// NAVIGATION RELATIONSHIPS:
// - Used by: Book cards, profile cards, info cards throughout the app
// - Dependencies: neumorphic_styles.dart, spacing.dart
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../core/constants/spacing.dart';

/// A card widget with neumorphic raised styling.
///
/// Example:
/// ```dart
/// NeuCard(
///   child: Column(
///     children: [
///       Text('Card Title'),
///       Text('Card content goes here'),
///     ],
///   ),
/// )
/// ```
class NeuCard extends StatelessWidget {
  /// Card content
  final Widget child;

  /// Card padding
  final EdgeInsetsGeometry padding;

  /// Card margin
  final EdgeInsetsGeometry? margin;

  /// Border radius
  final double borderRadius;

  /// Shadow intensity
  final NeuIntensity intensity;

  /// Custom background color
  final Color? color;

  /// Tap callback
  final VoidCallback? onTap;

  const NeuCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(Spacing.cardPadding),
    this.margin,
    this.borderRadius = Spacing.radiusLg,
    this.intensity = NeuIntensity.medium,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final card = Container(
      margin: margin,
      padding: padding,
      decoration: NeuDecoration.raised(
        color: color,
        radius: borderRadius,
        intensity: intensity,
        isDark: isDark,
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: card);
    }

    return card;
  }
}

/// A pressable card that shows pressed state on tap
class NeuPressableCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final NeuIntensity intensity;
  final Color? color;
  final VoidCallback? onTap;

  const NeuPressableCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(Spacing.cardPadding),
    this.margin,
    this.borderRadius = Spacing.radiusLg,
    this.intensity = NeuIntensity.medium,
    this.color,
    this.onTap,
  });

  @override
  State<NeuPressableCard> createState() => _NeuPressableCardState();
}

class _NeuPressableCardState extends State<NeuPressableCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: widget.onTap != null
          ? (_) => setState(() => _isPressed = true)
          : null,
      onTapUp: widget.onTap != null
          ? (_) => setState(() => _isPressed = false)
          : null,
      onTapCancel: widget.onTap != null
          ? () => setState(() => _isPressed = false)
          : null,
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: widget.margin,
        padding: widget.padding,
        decoration: _isPressed
            ? NeuDecoration.pressed(
                color: widget.color,
                radius: widget.borderRadius,
                intensity: widget.intensity,
                isDark: isDark,
              )
            : NeuDecoration.raised(
                color: widget.color,
                radius: widget.borderRadius,
                intensity: widget.intensity,
                isDark: isDark,
              ),
        child: widget.child,
      ),
    );
  }
}
