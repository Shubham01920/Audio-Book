// =============================================================================
// SHARE CLIP SHEET - Share Audio Clip Modal
// =============================================================================
// Bottom sheet for sharing audio clips:
// - Select clip range
// - Add caption
// - Choose sharing destination
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class ShareClipSheet extends StatefulWidget {
  const ShareClipSheet({super.key});

  @override
  State<ShareClipSheet> createState() => _ShareClipSheetState();
}

class _ShareClipSheetState extends State<ShareClipSheet> {
  double _startTime = 0.3;
  double _endTime = 0.5;
  final _captionController = TextEditingController();

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
          const SizedBox(height: Spacing.lg),

          // Title
          Text('Share Audio Clip', style: AppTypography.h5),
          const SizedBox(height: Spacing.lg),

          // Waveform with selection
          _buildWaveformSelector(),
          const SizedBox(height: Spacing.lg),

          // Time labels
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Start: ${_formatTime(_startTime)}',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.md,
                    vertical: Spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Spacing.radiusFull),
                  ),
                  child: Text(
                    '${((_endTime - _startTime) * 180).toInt()}s clip',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  'End: ${_formatTime(_endTime)}',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.lg),

          // Caption input
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: Container(
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.8),
                    blurRadius: 6,
                    offset: Offset(-3, -3),
                  ),
                  BoxShadow(
                    color: AppColors.darkShadowLight.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _captionController,
                decoration: InputDecoration(
                  hintText: 'Add a caption...',
                  hintStyle: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textHint,
                  ),
                  border: InputBorder.none,
                ),
                maxLines: 2,
              ),
            ),
          ),
          const SizedBox(height: Spacing.lg),

          // Share destinations
          _buildShareDestinations(),
          const SizedBox(height: Spacing.lg),

          // Share button
          Padding(
            padding: const EdgeInsets.all(Spacing.screenHorizontal),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: Spacing.md),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  boxShadow: [GlowStyles.primaryGlow],
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.share, color: Colors.white, size: 20),
                      const SizedBox(width: Spacing.sm),
                      Text(
                        'Share Clip',
                        style: AppTypography.buttonMedium.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: Spacing.md),
        ],
      ),
    );
  }

  Widget _buildWaveformSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
        ),
        child: Stack(
          children: [
            // Waveform bars
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(40, (i) {
                  final height = 20.0 + (i % 5) * 8 + (i % 3) * 4;
                  final isSelected = i / 40 >= _startTime && i / 40 <= _endTime;
                  return Container(
                    width: 4,
                    height: height,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                }),
              ),
            ),
            // Range slider
            SliderTheme(
              data: SliderThemeData(
                rangeThumbShape: RoundRangeSliderThumbShape(
                  enabledThumbRadius: 8,
                ),
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                overlayColor: AppColors.primary.withValues(alpha: 0.2),
              ),
              child: RangeSlider(
                values: RangeValues(_startTime, _endTime),
                onChanged: (values) => setState(() {
                  _startTime = values.start;
                  _endTime = values.end;
                }),
                activeColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareDestinations() {
    final destinations = [
      {'icon': Icons.copy, 'label': 'Copy Link', 'color': Colors.grey},
      {'icon': Icons.message, 'label': 'Messages', 'color': Colors.green},
      {'icon': Icons.share, 'label': 'Twitter', 'color': Colors.blue},
      {'icon': Icons.facebook, 'label': 'Facebook', 'color': Colors.indigo},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: destinations.map((dest) {
          return Column(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (dest['color'] as Color).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  dest['icon'] as IconData,
                  color: dest['color'] as Color,
                ),
              ),
              const SizedBox(height: Spacing.xs),
              Text(
                dest['label'] as String,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  String _formatTime(double fraction) {
    final totalSeconds = (fraction * 180).toInt();
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
