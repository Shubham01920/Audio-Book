// =============================================================================
// NEU BUTTON - Neumorphic Button Widget
// =============================================================================
// A button widget with neumorphic styling and press animations.
// Supports primary, secondary, and outline variants.
//
// NAVIGATION RELATIONSHIPS:
// - Used by: All screens for CTAs and actions
// - Dependencies: neumorphic_styles.dart, app_colors.dart, app_typography.dart
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';

/// Button variant types
enum NeuButtonVariant {
  /// Primary filled button with accent color
  primary,

  /// Secondary button with neumorphic styling
  secondary,

  /// Outline/ghost button
  outline,

  /// Text-only button
  text,
}

/// Button size options
enum NeuButtonSize { small, medium, large }

/// A button widget with neumorphic styling.
///
/// Features smooth press animations and multiple variants.
///
/// Example:
/// ```dart
/// NeuButton(
///   text: 'Create Account',
///   onPressed: () => print('Pressed'),
///   variant: NeuButtonVariant.primary,
/// )
/// ```
class NeuButton extends StatefulWidget {
  /// Button text label
  final String text;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Button variant (primary, secondary, outline, text)
  final NeuButtonVariant variant;

  /// Button size
  final NeuButtonSize size;

  /// Optional leading icon
  final IconData? leadingIcon;

  /// Optional trailing icon
  final IconData? trailingIcon;

  /// Whether button is in loading state
  final bool isLoading;

  /// Whether button takes full width
  final bool fullWidth;

  /// Custom background color (for primary variant)
  final Color? backgroundColor;

  /// Custom text color
  final Color? textColor;

  /// Border radius
  final double borderRadius;

  const NeuButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = NeuButtonVariant.primary,
    this.size = NeuButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.fullWidth = true,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = Spacing.radiusMd,
    int? width,
  });

  @override
  State<NeuButton> createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton> {
  bool _isPressed = false;

  /// Get button height based on size
  double get _height {
    switch (widget.size) {
      case NeuButtonSize.small:
        return Spacing.buttonHeightSm;
      case NeuButtonSize.medium:
        return Spacing.buttonHeightMd;
      case NeuButtonSize.large:
        return Spacing.buttonHeightLg;
    }
  }

  /// Get text style based on size
  TextStyle get _textStyle {
    switch (widget.size) {
      case NeuButtonSize.small:
        return AppTypography.buttonSmall;
      case NeuButtonSize.medium:
        return AppTypography.buttonMedium;
      case NeuButtonSize.large:
        return AppTypography.buttonLarge;
    }
  }

  /// Get icon size based on button size
  double get _iconSize {
    switch (widget.size) {
      case NeuButtonSize.small:
        return 16;
      case NeuButtonSize.medium:
        return 20;
      case NeuButtonSize.large:
        return 24;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDisabled = widget.onPressed == null;

    return GestureDetector(
      onTapDown: isDisabled ? null : (_) => setState(() => _isPressed = true),
      onTapUp: isDisabled ? null : (_) => setState(() => _isPressed = false),
      onTapCancel: isDisabled ? null : () => setState(() => _isPressed = false),
      onTap: widget.isLoading ? null : widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        width: widget.fullWidth ? double.infinity : null,
        height: _height,
        decoration: _getDecoration(isDark, isDisabled),
        child: Center(
          child: widget.isLoading
              ? _buildLoadingIndicator()
              : _buildContent(isDark, isDisabled),
        ),
      ),
    );
  }

  /// Build button decoration based on variant and state
  BoxDecoration _getDecoration(bool isDark, bool isDisabled) {
    switch (widget.variant) {
      case NeuButtonVariant.primary:
        return BoxDecoration(
          color: isDisabled
              ? AppColors.textDisabled
              : (widget.backgroundColor ?? AppColors.primary),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: _isPressed || isDisabled
              ? []
              : [
                  BoxShadow(
                    color: (widget.backgroundColor ?? AppColors.primary)
                        .withValues(alpha: 0.4),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                  ),
                ],
        );

      case NeuButtonVariant.secondary:
        return _isPressed
            ? NeuDecoration.pressed(radius: widget.borderRadius, isDark: isDark)
            : NeuDecoration.raised(
                radius: widget.borderRadius,
                intensity: NeuIntensity.medium,
                isDark: isDark,
              );

      case NeuButtonVariant.outline:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: isDisabled ? AppColors.textDisabled : AppColors.primary,
            width: 2,
          ),
        );

      case NeuButtonVariant.text:
        return BoxDecoration(
          color: _isPressed
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        );
    }
  }

  /// Build button content (icon + text)
  Widget _buildContent(bool isDark, bool isDisabled) {
    final textColor = _getTextColor(isDisabled);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.fullWidth ? Spacing.md : Spacing.lg,
      ),
      child: Row(
        mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.leadingIcon != null) ...[
            Icon(widget.leadingIcon, size: _iconSize, color: textColor),
            const SizedBox(width: Spacing.sm),
          ],
          Text(widget.text, style: _textStyle.copyWith(color: textColor)),
          if (widget.trailingIcon != null) ...[
            const SizedBox(width: Spacing.sm),
            Icon(widget.trailingIcon, size: _iconSize, color: textColor),
          ],
        ],
      ),
    );
  }

  /// Get text color based on variant and state
  Color _getTextColor(bool isDisabled) {
    if (widget.textColor != null) return widget.textColor!;
    if (isDisabled) return AppColors.textDisabled;

    switch (widget.variant) {
      case NeuButtonVariant.primary:
        return AppColors.textOnPrimary;
      case NeuButtonVariant.secondary:
        return AppColors.textPrimary;
      case NeuButtonVariant.outline:
      case NeuButtonVariant.text:
        return AppColors.primary;
    }
  }

  /// Build loading indicator
  Widget _buildLoadingIndicator() {
    final color = widget.variant == NeuButtonVariant.primary
        ? AppColors.textOnPrimary
        : AppColors.primary;

    return SizedBox(
      width: _iconSize,
      height: _iconSize,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}

/// A circular neumorphic icon button
class NeuIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? iconColor;
  final Color? backgroundColor;
  final bool isSelected;

  const NeuIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 48,
    this.iconColor,
    this.backgroundColor,
    this.isSelected = false,
  });

  @override
  State<NeuIconButton> createState() => _NeuIconButtonState();
}

class _NeuIconButtonState extends State<NeuIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isDisabled = widget.onPressed == null;

    return GestureDetector(
      onTapDown: isDisabled ? null : (_) => setState(() => _isPressed = true),
      onTapUp: isDisabled ? null : (_) => setState(() => _isPressed = false),
      onTapCancel: isDisabled ? null : () => setState(() => _isPressed = false),
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.size,
        height: widget.size,
        decoration: NeuDecoration.circular(
          color: widget.backgroundColor,
          style: (_isPressed || widget.isSelected)
              ? NeuStyle.pressed
              : NeuStyle.raised,
          intensity: NeuIntensity.medium,
          isDark: isDark,
        ),
        child: Center(
          child: Icon(
            widget.icon,
            size: widget.size * 0.5,
            color:
                widget.iconColor ??
                (widget.isSelected
                    ? AppColors.primary
                    : (isDisabled
                          ? AppColors.iconDisabled
                          : AppColors.iconDefault)),
          ),
        ),
      ),
    );
  }
}
