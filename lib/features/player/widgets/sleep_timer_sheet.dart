// =============================================================================
// SLEEP TIMER SHEET - Sleep Timer Controls (Matching Reference Design)
// =============================================================================
// Bottom sheet for setting sleep timer with:
// - Preset time buttons in 2x3 grid (neumorphic)
// - Custom time slider
// - Timer preview
// - Reset and Set Timer buttons
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class SleepTimerSheet extends StatefulWidget {
  const SleepTimerSheet({super.key});

  @override
  State<SleepTimerSheet> createState() => _SleepTimerSheetState();
}

class _SleepTimerSheetState extends State<SleepTimerSheet> {
  String? _selectedOption = '30min';
  double _customMinutes = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Spacing.radiusXl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: Spacing.md),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: Spacing.xl),

          // SLEEP TIMER header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: Text(
              'SLEEP TIMER',
              style: AppTypography.overline.copyWith(
                letterSpacing: 2,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: Spacing.lg),

          // Preset buttons grid
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: _buildPresetGrid(),
          ),
          const SizedBox(height: Spacing.xl),

          // CUSTOM TIME SLIDER header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: Text(
              'CUSTOM TIME SLIDER',
              style: AppTypography.overline.copyWith(
                letterSpacing: 1.5,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: Spacing.md),

          // Custom slider section
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: _buildCustomSlider(),
          ),
          const SizedBox(height: Spacing.xl),

          // TIMER PREVIEW header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: Text(
              'TIMER PREVIEW',
              style: AppTypography.overline.copyWith(
                letterSpacing: 1.5,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: Spacing.md),

          // Timer preview section
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: _buildTimerPreview(),
          ),
          const SizedBox(height: Spacing.xl),

          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: _buildActionButtons(),
          ),
          const SizedBox(height: Spacing.md),
        ],
      ),
    );
  }

  Widget _buildPresetGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildPresetButton('15 min', '15min')),
            const SizedBox(width: Spacing.md),
            Expanded(child: _buildPresetButton('30 min', '30min')),
          ],
        ),
        const SizedBox(height: Spacing.md),
        Row(
          children: [
            Expanded(
              child: _buildPresetButton(
                '45 min (Default)',
                '45min',
                isDefault: true,
              ),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(child: _buildPresetButton('1 hour', '1hr')),
          ],
        ),
        const SizedBox(height: Spacing.md),
        Row(
          children: [
            Expanded(child: _buildPresetButton('End of chapter', 'chapter')),
            const SizedBox(width: Spacing.md),
            Expanded(child: _buildPresetButton('Custom', 'custom')),
          ],
        ),
      ],
    );
  }

  Widget _buildPresetButton(
    String label,
    String value, {
    bool isDefault = false,
  }) {
    final isSelected = _selectedOption == value;

    return GestureDetector(
      onTap: () => setState(() {
        _selectedOption = value;
        if (value == '15min') _customMinutes = 15;
        if (value == '30min') _customMinutes = 30;
        if (value == '45min') _customMinutes = 45;
        if (value == '1hr') _customMinutes = 60;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: Spacing.md),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondary : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          boxShadow: isSelected
              ? [GlowStyles.accentGlow]
              : [
                  // Neumorphic shadows for unselected
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.8),
                    blurRadius: 6,
                    offset: const Offset(-3, -3),
                  ),
                  BoxShadow(
                    color: AppColors.darkShadowLight.withValues(alpha: 0.12),
                    blurRadius: 6,
                    offset: const Offset(3, 3),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomSlider() {
    return Container(
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        boxShadow: [
          // Neumorphic inset effect
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.9),
            blurRadius: 8,
            offset: const Offset(-4, -4),
          ),
          BoxShadow(
            color: AppColors.darkShadowLight.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Custom Time', style: AppTypography.bodyMedium),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.xs,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.secondary),
                  borderRadius: BorderRadius.circular(Spacing.radiusSm),
                ),
                child: Text(
                  '${_customMinutes.toInt()} min',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.md),

          // Slider
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 6,
              activeTrackColor: AppColors.secondary,
              inactiveTrackColor: AppColors.border,
              thumbColor: AppColors.secondary,
              overlayColor: AppColors.secondary.withValues(alpha: 0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            ),
            child: Slider(
              value: _customMinutes,
              min: 5,
              max: 120,
              divisions: 23,
              onChanged: (value) => setState(() {
                _customMinutes = value;
                _selectedOption = 'custom';
              }),
            ),
          ),

          // Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '5 MIN',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textHint,
                ),
              ),
              Text(
                'DEFAULT',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '2 HRS',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimerPreview() {
    return Container(
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.9),
            blurRadius: 8,
            offset: const Offset(-4, -4),
          ),
          BoxShadow(
            color: AppColors.darkShadowLight.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Moon icon with glow
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              boxShadow: [GlowStyles.accentGlowSubtle],
            ),
            child: const Icon(
              Icons.bedtime,
              color: AppColors.secondary,
              size: 24,
            ),
          ),
          const SizedBox(width: Spacing.md),

          // Timer info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sleep in ${_customMinutes.toInt()} minutes',
                  style: AppTypography.labelMedium,
                ),
                const SizedBox(height: 4),
                // Visual timer bar
                Row(
                  children: List.generate(
                    12,
                    (i) => Container(
                      width: 4,
                      height: i < (_customMinutes / 10).ceil() ? 16 : 8,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: i < (_customMinutes / 10).ceil()
                            ? AppColors.secondary.withValues(alpha: 0.8)
                            : AppColors.secondary.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // Reset button - neumorphic
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() {
              _selectedOption = '30min';
              _customMinutes = 30;
            }),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Spacing.md),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.9),
                    blurRadius: 6,
                    offset: const Offset(-3, -3),
                  ),
                  BoxShadow(
                    color: AppColors.darkShadowLight.withValues(alpha: 0.12),
                    blurRadius: 6,
                    offset: const Offset(3, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Reset',
                  style: AppTypography.buttonMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: Spacing.md),

        // Set Timer button with glow
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Spacing.md),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                boxShadow: [GlowStyles.accentGlow],
              ),
              child: Center(
                child: Text(
                  'Set Timer',
                  style: AppTypography.buttonMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
