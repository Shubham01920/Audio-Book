import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';

/// Speed selector bottom sheet - StatefulWidget for live slider updates
class SpeedSelector extends StatefulWidget {
  final double initialSpeed;
  final ValueChanged<double> onSpeedChanged;

  const SpeedSelector({
    super.key,
    required this.initialSpeed,
    required this.onSpeedChanged,
  });

  static const List<double> presets = [
    0.5,
    0.75,
    1.0,
    1.25,
    1.5,
    1.75,
    2.0,
    2.5,
    3.0,
  ];

  @override
  State<SpeedSelector> createState() => _SpeedSelectorState();

  static void show(
    BuildContext context,
    double currentSpeed,
    ValueChanged<double> onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          SpeedSelector(initialSpeed: currentSpeed, onSpeedChanged: onChanged),
    );
  }
}

class _SpeedSelectorState extends State<SpeedSelector> {
  late double _currentSpeed;

  @override
  void initState() {
    super.initState();
    _currentSpeed = widget.initialSpeed;
  }

  void _updateSpeed(double speed) {
    setState(() {
      _currentSpeed = speed;
    });
    widget.onSpeedChanged(speed);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.elevatedDark,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            'Playback Speed',
            style: AppTypography.titleLarge.copyWith(
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 8),

          // Current speed display
          Text(
            '${_currentSpeed.toStringAsFixed(2)}x',
            style: AppTypography.displaySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Slider - now works because we're StatefulWidget
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.progressInactive,
              thumbColor: AppColors.primary,
              overlayColor: AppColors.primary.withValues(alpha: 0.2),
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            ),
            child: Slider(
              value: _currentSpeed,
              min: AppConstants.minPlaybackSpeed,
              max: AppConstants.maxPlaybackSpeed,
              divisions:
                  ((AppConstants.maxPlaybackSpeed -
                              AppConstants.minPlaybackSpeed) /
                          0.05)
                      .round(),
              onChanged: _updateSpeed,
            ),
          ),

          // Speed labels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${AppConstants.minPlaybackSpeed}x',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textTertiaryDark,
                  ),
                ),
                Text(
                  '${AppConstants.maxPlaybackSpeed}x',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textTertiaryDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Preset buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: SpeedSelector.presets.map((speed) {
              final isSelected = (_currentSpeed - speed).abs() < 0.05;
              return _SpeedChip(
                speed: speed,
                isSelected: isSelected,
                onTap: () => _updateSpeed(speed),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SpeedChip extends StatelessWidget {
  final double speed;
  final bool isSelected;
  final VoidCallback onTap;

  const _SpeedChip({
    required this.speed,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.cardDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.elevatedDark,
            width: 1.5,
          ),
        ),
        child: Text(
          '${speed.toStringAsFixed(speed == speed.roundToDouble() ? 0 : 1)}x',
          style: AppTypography.labelLarge.copyWith(
            color: isSelected ? Colors.white : AppColors.textSecondaryDark,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
