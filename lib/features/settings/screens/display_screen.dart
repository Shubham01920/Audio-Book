// =============================================================================
// DISPLAY SCREEN - Theme & Appearance Settings
// =============================================================================
// Display and theme customization with:
// - Theme mode toggle (Light/Dark/System)
// - Font size adjustment
// - Book cover display options
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  String _themeMode = 'light';
  double _fontSize = 1.0;
  bool _showCovers = true;
  bool _animations = true;

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
                    Text('Display & Theme', style: AppTypography.h4),
                  ],
                ),
              ),

              // Theme Mode
              _buildSectionHeader('THEME'),
              _buildThemeSelector(),
              const SizedBox(height: Spacing.xl),

              // Font Size
              _buildSectionHeader('TEXT SIZE'),
              _buildFontSizeSlider(),
              const SizedBox(height: Spacing.xl),

              // Display Options
              _buildSectionHeader('DISPLAY OPTIONS'),
              _buildToggleOption(
                'Show Book Covers',
                'Display cover images in lists',
                _showCovers,
                (v) => setState(() => _showCovers = v),
              ),
              _buildToggleOption(
                'Enable Animations',
                'Smooth transitions and effects',
                _animations,
                (v) => setState(() => _animations = v),
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

  Widget _buildThemeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            _buildThemeOption('light', Icons.light_mode, 'Light'),
            const SizedBox(width: Spacing.md),
            _buildThemeOption('dark', Icons.dark_mode, 'Dark'),
            const SizedBox(width: Spacing.md),
            _buildThemeOption('system', Icons.settings_suggest, 'System'),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(String value, IconData icon, String label) {
    final isSelected = _themeMode == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _themeMode = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: Spacing.md),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(Spacing.radiusSm),
            boxShadow: isSelected ? [GlowStyles.primaryGlowSubtle] : null,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
              const SizedBox(height: Spacing.xs),
              Text(
                label,
                style: AppTypography.labelSmall.copyWith(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFontSizeSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Aa', style: AppTypography.bodySmall),
                SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor: AppColors.primary,
                    inactiveTrackColor: AppColors.border,
                    thumbColor: AppColors.primary,
                    overlayColor: AppColors.primary.withValues(alpha: 0.2),
                  ),
                  child: Expanded(
                    child: Slider(
                      value: _fontSize,
                      min: 0.8,
                      max: 1.4,
                      divisions: 3,
                      onChanged: (v) => setState(() => _fontSize = v),
                    ),
                  ),
                ),
                Text('Aa', style: AppTypography.h4),
              ],
            ),
            const SizedBox(height: Spacing.sm),
            // Preview text
            Container(
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.5),
                ),
              ),
              child: Text(
                'The quick brown fox jumps over the lazy dog.',
                style: AppTypography.bodyMedium.copyWith(
                  fontSize: 14 * _fontSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleOption(
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
}
