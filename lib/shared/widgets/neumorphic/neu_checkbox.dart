// =============================================================================
// NEU CHECKBOX - Neumorphic Checkbox Widget
// =============================================================================
// A checkbox with neumorphic styling for form agreements.
//
// NAVIGATION RELATIONSHIPS:
// - Used by: Login, Sign Up screens for terms and conditions
// - Dependencies: neumorphic_styles.dart, app_colors.dart
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';

/// A checkbox with neumorphic styling.
///
/// Example:
/// ```dart
/// NeuCheckbox(
///   value: _agreed,
///   onChanged: (value) => setState(() => _agreed = value),
///   label: 'I agree to the Terms of Service',
/// )
/// ```
class NeuCheckbox extends StatelessWidget {
  /// Current checkbox value
  final bool value;

  /// Callback when value changes
  final ValueChanged<bool>? onChanged;

  /// Label text
  final String? label;

  /// Rich label with multiple text spans (for links)
  final Widget? richLabel;

  /// Checkbox size
  final double size;

  const NeuCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.label,
    this.richLabel,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: size,
            height: size,
            decoration: value
                ? BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 6,
                      ),
                    ],
                  )
                : NeuDecoration.pressed(
                    radius: 6,
                    intensity: NeuIntensity.light,
                    isDark: isDark,
                  ),
            child: value
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),

          // Spacing
          const SizedBox(width: Spacing.sm),

          // Label
          Expanded(
            child:
                richLabel ??
                Text(
                  label ?? '',
                  style: AppTypography.bodyMedium.copyWith(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textSecondary,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
