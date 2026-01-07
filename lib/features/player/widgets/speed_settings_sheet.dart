// =============================================================================
// SPEED SETTINGS SHEET - Playback Speed Controls
// =============================================================================
// Bottom sheet for adjusting playback speed with:
// - Preset speed buttons (0.5x to 2.0x)
// - Custom speed slider (0.5x to 3.0x)
// - Test audio preview
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

class SpeedSettingsSheet extends StatefulWidget {
  final double currentSpeed;
  final ValueChanged<double> onSpeedChanged;

  const SpeedSettingsSheet({
    super.key,
    required this.currentSpeed,
    required this.onSpeedChanged,
  });

  @override
  State<SpeedSettingsSheet> createState() => _SpeedSettingsSheetState();
}

class _SpeedSettingsSheetState extends State<SpeedSettingsSheet> {
  late double _selectedSpeed;
  late double _customSpeed;
  bool _isPlaying = false;

  final List<double> _presets = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];

  @override
  void initState() {
    super.initState();
    _selectedSpeed = widget.currentSpeed;
    _customSpeed = widget.currentSpeed;
  }

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
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: Spacing.md),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: Spacing.lg),

          // Title
          Text(
            'SPEED OPTIONS',
            style: AppTypography.overline.copyWith(
              letterSpacing: 2,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: Spacing.xl),

          // Preset buttons grid
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: _buildPresetGrid(),
          ),
          const SizedBox(height: Spacing.xl),

          // Custom speed slider section
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: _buildCustomSlider(),
          ),
          const SizedBox(height: Spacing.xl),

          // Test audio section
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: _buildTestAudio(),
          ),
          const SizedBox(height: Spacing.xl),

          // Action buttons
          Padding(
            padding: const EdgeInsets.all(Spacing.screenHorizontal),
            child: _buildActionButtons(),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + Spacing.md),
        ],
      ),
    );
  }

  Widget _buildPresetGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildPresetButton(0.5)),
            const SizedBox(width: Spacing.md),
            Expanded(child: _buildPresetButton(0.75)),
          ],
        ),
        const SizedBox(height: Spacing.md),
        Row(
          children: [
            Expanded(child: _buildPresetButton(1.0, isDefault: true)),
            const SizedBox(width: Spacing.md),
            Expanded(child: _buildPresetButton(1.25)),
          ],
        ),
        const SizedBox(height: Spacing.md),
        Row(
          children: [
            Expanded(child: _buildPresetButton(1.5)),
            const SizedBox(width: Spacing.md),
            Expanded(child: _buildPresetButton(2.0)),
          ],
        ),
      ],
    );
  }

  Widget _buildPresetButton(double speed, {bool isDefault = false}) {
    final isSelected = _selectedSpeed == speed;
    final label = isDefault ? '${speed}x (Default)' : '${speed}x';

    return GestureDetector(
      onTap: () => setState(() {
        _selectedSpeed = speed;
        _customSpeed = speed;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: Spacing.md),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          border: isSelected ? null : Border.all(color: AppColors.border),
          boxShadow: isSelected ? [GlowStyles.primaryGlowSubtle] : null,
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.labelMedium.copyWith(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CUSTOM SPEED SLIDER',
          style: AppTypography.overline.copyWith(
            letterSpacing: 1.5,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: Spacing.md),

        NeuContainer(
          style: NeuStyle.pressed,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Custom Speed', style: AppTypography.bodyMedium),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.md,
                      vertical: Spacing.xs,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(Spacing.radiusSm),
                    ),
                    child: Text(
                      '${_customSpeed.toStringAsFixed(1)}x',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.primary,
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
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.border,
                  thumbColor: AppColors.primary,
                  overlayColor: AppColors.primary.withValues(alpha: 0.2),
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 10,
                  ),
                ),
                child: Slider(
                  value: _customSpeed,
                  min: 0.5,
                  max: 3.0,
                  divisions: 25,
                  onChanged: (value) => setState(() {
                    _customSpeed = value;
                    _selectedSpeed = value;
                  }),
                ),
              ),

              // Labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0.5X',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                  Text(
                    'NORMAL',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '3.0X',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTestAudio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TEST AUDIO',
          style: AppTypography.overline.copyWith(
            letterSpacing: 1.5,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: Spacing.md),

        NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            children: [
              // Play button
              GestureDetector(
                onTap: () => setState(() => _isPlaying = !_isPlaying),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: Spacing.md),

              // Waveform
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Test Current Playback',
                      style: AppTypography.labelMedium,
                    ),
                    const SizedBox(height: Spacing.xs),
                    Row(
                      children: List.generate(
                        20,
                        (i) => Container(
                          width: 3,
                          height: (i % 4 + 1) * 4.0 + 4,
                          margin: const EdgeInsets.only(right: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(
                              alpha: _isPlaying ? 0.8 : 0.3,
                            ),
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
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // Reset button
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() {
              _selectedSpeed = 1.0;
              _customSpeed = 1.0;
            }),
            child: NeuContainer(
              style: NeuStyle.raised,
              intensity: NeuIntensity.light,
              borderRadius: Spacing.radiusMd,
              padding: const EdgeInsets.symmetric(vertical: Spacing.md),
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

        // Apply button with glow
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () {
              widget.onSpeedChanged(_selectedSpeed);
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Spacing.md),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                boxShadow: [GlowStyles.primaryGlow],
              ),
              child: Center(
                child: Text(
                  'Apply Speed',
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
