// =============================================================================
// ACCESSIBILITY SCREEN - Accessibility Settings
// =============================================================================
// Accessibility options with:
// - Text size and contrast
// - Playback accessibility
// - Visual/audio aids
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';

class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  double _textScale = 1.0;
  bool _highContrast = false;
  bool _reduceMotion = false;
  bool _boldText = false;
  bool _screenReader = false;
  bool _hapticFeedback = true;
  String _colorBlindMode = 'none';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(Spacing.screenHorizontal),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: Spacing.md),
                    Text('Accessibility', style: AppTypography.h4),
                  ],
                ),
              ),

              // Vision
              _buildSectionHeader('VISION'),
              _buildTextScaleSlider(),
              const SizedBox(height: Spacing.sm),
              _buildToggle(
                'High Contrast',
                'Increase color contrast',
                _highContrast,
                (v) => setState(() => _highContrast = v),
              ),
              _buildToggle(
                'Bold Text',
                'Make text bolder',
                _boldText,
                (v) => setState(() => _boldText = v),
              ),
              _buildColorBlindSelector(),
              const SizedBox(height: Spacing.lg),

              // Motion & Interaction
              _buildSectionHeader('MOTION & INTERACTION'),
              _buildToggle(
                'Reduce Motion',
                'Minimize animations',
                _reduceMotion,
                (v) => setState(() => _reduceMotion = v),
              ),
              _buildToggle(
                'Haptic Feedback',
                'Vibration feedback',
                _hapticFeedback,
                (v) => setState(() => _hapticFeedback = v),
              ),
              const SizedBox(height: Spacing.lg),

              // Screen Reader
              _buildSectionHeader('ASSISTIVE TECHNOLOGY'),
              _buildToggle(
                'Screen Reader Support',
                'Optimize for screen readers',
                _screenReader,
                (v) => setState(() => _screenReader = v),
              ),
              const SizedBox(height: Spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.screenHorizontal,
        vertical: Spacing.sm,
      ),
      child: Text(
        title,
        style: AppTypography.overline.copyWith(
          color: AppColors.textHint,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildTextScaleSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Text Size', style: AppTypography.labelMedium),
            const SizedBox(height: Spacing.md),
            Row(
              children: [
                Text('A', style: AppTypography.labelSmall),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: AppColors.border,
                      thumbColor: AppColors.primary,
                    ),
                    child: Slider(
                      value: _textScale,
                      min: 0.8,
                      max: 1.6,
                      divisions: 4,
                      onChanged: (v) => setState(() => _textScale = v),
                    ),
                  ),
                ),
                Text('A', style: AppTypography.h4),
              ],
            ),
            Center(
              child: Text(
                '${(_textScale * 100).toInt()}%',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggle(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.screenHorizontal,
        vertical: Spacing.xs,
      ),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.labelMedium),
                  Text(
                    subtitle,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primary,
              activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorBlindSelector() {
    final modes = ['none', 'protanopia', 'deuteranopia', 'tritanopia'];
    final labels = ['None', 'Red-Green', 'Green-Yellow', 'Blue-Yellow'];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.screenHorizontal,
        vertical: Spacing.xs,
      ),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Color Blind Mode', style: AppTypography.labelMedium),
            const SizedBox(height: Spacing.md),
            Wrap(
              spacing: Spacing.sm,
              children: List.generate(modes.length, (i) {
                final isSelected = _colorBlindMode == modes[i];
                return GestureDetector(
                  onTap: () => setState(() => _colorBlindMode = modes[i]),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.md,
                      vertical: Spacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(Spacing.radiusFull),
                      border: isSelected
                          ? null
                          : Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      labels[i],
                      style: AppTypography.labelSmall.copyWith(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
