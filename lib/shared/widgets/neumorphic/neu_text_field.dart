// =============================================================================
// NEU TEXT FIELD - Neumorphic Text Input Widget
// =============================================================================
// A text input field with neumorphic inset styling.
// Matches the reference design with icon prefix and visibility toggle.
//
// NAVIGATION RELATIONSHIPS:
// - Used by: Login, Sign Up, Search, and form screens
// - Dependencies: neumorphic_styles.dart, app_colors.dart, app_typography.dart
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';

/// A text input field with neumorphic inset styling.
///
/// Features:
/// - Pressed/inset neumorphic appearance
/// - Optional leading icon
/// - Password visibility toggle
/// - Focus states with subtle animations
///
/// Example:
/// ```dart
/// NeuTextField(
///   label: 'Email',
///   hint: 'user@example.com',
///   prefixIcon: Icons.email_outlined,
///   keyboardType: TextInputType.emailAddress,
/// )
/// ```
class NeuTextField extends StatefulWidget {
  /// Label text displayed above the field
  final String? label;

  /// Placeholder text
  final String? hint;

  /// Text controller
  final TextEditingController? controller;

  /// Icon displayed at the start of the field
  final IconData? prefixIcon;

  /// Custom suffix widget (overrides password toggle)
  final Widget? suffix;

  /// Whether this is a password field
  final bool isPassword;

  /// Keyboard type
  final TextInputType keyboardType;

  /// Text input action
  final TextInputAction textInputAction;

  /// Focus node
  final FocusNode? focusNode;

  /// Callback when value changes
  final ValueChanged<String>? onChanged;

  /// Callback when field is submitted
  final ValueChanged<String>? onSubmitted;

  /// Validation function
  final String? Function(String?)? validator;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Maximum lines
  final int maxLines;

  /// Whether field is enabled
  final bool enabled;

  /// Whether to autofocus
  final bool autofocus;

  /// Error text to display
  final String? errorText;

  const NeuTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.suffix,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
    this.enabled = true,
    this.autofocus = false,
    this.errorText,
  });

  @override
  State<NeuTextField> createState() => _NeuTextFieldState();
}

class _NeuTextFieldState extends State<NeuTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_handleFocusChange);
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTypography.labelLarge.copyWith(
              color: hasError ? AppColors.error : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: Spacing.sm),
        ],

        // Input field with neumorphic styling
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.backgroundDark
                : AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
            border: _isFocused
                ? Border.all(color: AppColors.primary, width: 2)
                : hasError
                ? Border.all(color: AppColors.error, width: 1)
                : Border.all(
                    color: isDark
                        ? AppColors.borderDark
                        : AppColors.border.withValues(alpha: 0.5),
                    width: 1,
                  ),
            boxShadow: [
              // Inner shadow - top left (dark)
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.4)
                    : AppColors.darkShadowLight.withValues(alpha: 0.5),
                offset: const Offset(3, 3),
                blurRadius: 6,
              ),
              // Inner shadow - bottom right (light)
              BoxShadow(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.white.withValues(alpha: 0.8),
                offset: const Offset(-3, -3),
                blurRadius: 6,
              ),
              // Subtle inset effect
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.2)
                    : AppColors.darkShadowLight.withValues(alpha: 0.15),
                offset: Offset.zero,
                blurRadius: 4,
                spreadRadius: -2,
              ),
            ],
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            obscureText: widget.isPassword && _obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            inputFormatters: widget.inputFormatters,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            style: AppTypography.inputText.copyWith(
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTypography.inputHint,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Spacing.inputPaddingH,
                vertical: Spacing.inputPaddingV,
              ),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                        left: Spacing.md,
                        right: Spacing.sm,
                      ),
                      child: Icon(
                        widget.prefixIcon,
                        color: _isFocused
                            ? AppColors.primary
                            : AppColors.iconDefault,
                        size: Spacing.iconMd,
                      ),
                    )
                  : null,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 48,
              ),
              suffixIcon: _buildSuffix(),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 48,
                minHeight: 48,
              ),
            ),
          ),
        ),

        // Error text
        if (hasError) ...[
          const SizedBox(height: Spacing.xs),
          Text(
            widget.errorText!,
            style: AppTypography.bodySmall.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }

  /// Build suffix widget (password toggle or custom)
  Widget? _buildSuffix() {
    if (widget.suffix != null) return widget.suffix;

    if (widget.isPassword) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: Spacing.md),
          child: Icon(
            _obscureText
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: AppColors.iconDefault,
            size: Spacing.iconMd,
          ),
        ),
      );
    }

    return null;
  }
}
