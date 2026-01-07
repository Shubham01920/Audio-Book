// =============================================================================
// PLAYBACK SETTINGS SCREEN - Audio Playback Preferences
// =============================================================================
// Playback settings with:
// - Default playback speed
// - Skip intervals
// - Sleep timer defaults
// - Auto-play settings
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

class PlaybackSettingsScreen extends StatefulWidget {
  const PlaybackSettingsScreen({super.key});

  @override
  State<PlaybackSettingsScreen> createState() => _PlaybackSettingsScreenState();
}

class _PlaybackSettingsScreenState extends State<PlaybackSettingsScreen> {
  double _defaultSpeed = 1.0;
  int _skipForward = 30;
  int _skipBack = 15;
  bool _autoPlay = true;
  bool _rememberPosition = true;
  bool _continuousPlay = false;

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
                    Text('Playback Settings', style: AppTypography.h4),
                  ],
                ),
              ),

              // Speed
              _buildSectionHeader('DEFAULT SPEED'),
              _buildSpeedSelector(),
              const SizedBox(height: Spacing.lg),

              // Skip Intervals
              _buildSectionHeader('SKIP INTERVALS'),
              _buildSkipSelector(
                'Skip Forward',
                _skipForward,
                (v) => setState(() => _skipForward = v),
              ),
              const SizedBox(height: Spacing.sm),
              _buildSkipSelector(
                'Skip Back',
                _skipBack,
                (v) => setState(() => _skipBack = v),
              ),
              const SizedBox(height: Spacing.lg),

              // Playback Behavior
              _buildSectionHeader('PLAYBACK BEHAVIOR'),
              _buildToggle(
                'Auto-Play Next',
                'Automatically play next chapter',
                _autoPlay,
                (v) => setState(() => _autoPlay = v),
              ),
              _buildToggle(
                'Remember Position',
                'Resume where you left off',
                _rememberPosition,
                (v) => setState(() => _rememberPosition = v),
              ),
              _buildToggle(
                'Continuous Play',
                'Play next book automatically',
                _continuousPlay,
                (v) => setState(() => _continuousPlay = v),
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

  Widget _buildSpeedSelector() {
    final speeds = [0.75, 1.0, 1.25, 1.5, 2.0];

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
                Text('Default Speed', style: AppTypography.labelMedium),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.md,
                    vertical: Spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(Spacing.radiusSm),
                    boxShadow: [GlowStyles.primaryGlowSubtle],
                  ),
                  child: Text(
                    '${_defaultSpeed}x',
                    style: AppTypography.labelMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: speeds.map((speed) {
                final isSelected = _defaultSpeed == speed;
                return GestureDetector(
                  onTap: () => setState(() => _defaultSpeed = speed),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.backgroundLight,
                      shape: BoxShape.circle,
                      boxShadow: isSelected
                          ? [GlowStyles.primaryGlowSubtle]
                          : [
                              BoxShadow(
                                color: Colors.white.withValues(alpha: 0.8),
                                blurRadius: 4,
                                offset: Offset(-2, -2),
                              ),
                              BoxShadow(
                                color: AppColors.darkShadowLight.withValues(
                                  alpha: 0.1,
                                ),
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                    ),
                    child: Center(
                      child: Text(
                        '${speed}x',
                        style: AppTypography.labelSmall.copyWith(
                          color: isSelected
                              ? Colors.white
                              : AppColors.textPrimary,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkipSelector(
    String label,
    int value,
    ValueChanged<int> onChanged,
  ) {
    final options = [10, 15, 30, 45, 60];

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
            Text(label, style: AppTypography.labelMedium),
            const SizedBox(height: Spacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: options.map((opt) {
                final isSelected = value == opt;
                return GestureDetector(
                  onTap: () => onChanged(opt),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.md,
                      vertical: Spacing.sm,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.secondary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(Spacing.radiusFull),
                      boxShadow: isSelected
                          ? [GlowStyles.accentGlowSubtle]
                          : null,
                    ),
                    child: Text(
                      '${opt}s',
                      style: AppTypography.labelMedium.copyWith(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              }).toList(),
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
}
