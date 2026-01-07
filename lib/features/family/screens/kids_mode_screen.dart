// =============================================================================
// KIDS MODE SCREEN - Parental Controls
// =============================================================================
// Kids mode settings with:
// - Enable/disable kids mode
// - Content restrictions
// - Time limits
// - PIN protection
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

class KidsModeScreen extends StatefulWidget {
  const KidsModeScreen({super.key});

  @override
  State<KidsModeScreen> createState() => _KidsModeScreenState();
}

class _KidsModeScreenState extends State<KidsModeScreen> {
  bool _kidsModeEnabled = true;
  bool _pinProtection = true;
  bool _timeLimit = true;
  double _dailyLimit = 2.0;
  String _ageRating = '7+';

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
                    Text('Kids Mode', style: AppTypography.h4),
                  ],
                ),
              ),

              // Kids mode toggle
              _buildKidsModeToggle(),
              const SizedBox(height: Spacing.xl),

              // Content restrictions
              _buildSectionHeader('CONTENT RESTRICTIONS'),
              _buildAgeRatingSelector(),
              const SizedBox(height: Spacing.xl),

              // Time limits
              _buildSectionHeader('TIME LIMITS'),
              _buildTimeLimitSettings(),
              const SizedBox(height: Spacing.xl),

              // Security
              _buildSectionHeader('SECURITY'),
              _buildSecuritySettings(),
              const SizedBox(height: Spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKidsModeToggle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.lg),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.orange, Colors.amber]),
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                boxShadow: [GlowStyles.colorGlowSubtle(Colors.orange)],
              ),
              child: Icon(Icons.child_care, color: Colors.white, size: 30),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kids Mode', style: AppTypography.h5),
                  Text(
                    _kidsModeEnabled
                        ? 'Enabled - Safe content only'
                        : 'Disabled',
                    style: AppTypography.labelSmall.copyWith(
                      color: _kidsModeEnabled
                          ? Colors.green
                          : AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _kidsModeEnabled,
              onChanged: (v) => setState(() => _kidsModeEnabled = v),
              activeColor: Colors.orange,
              activeTrackColor: Colors.orange.withValues(alpha: 0.3),
            ),
          ],
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

  Widget _buildAgeRatingSelector() {
    final ratings = ['3+', '7+', '12+', '16+'];

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
            Text('Maximum Age Rating', style: AppTypography.labelMedium),
            const SizedBox(height: Spacing.md),
            Row(
              children: ratings.map((rating) {
                final isSelected = _ageRating == rating;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _ageRating = rating),
                    child: Container(
                      margin: EdgeInsets.only(
                        right: rating == '16+' ? 0 : Spacing.sm,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: Spacing.md),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.orange : Colors.transparent,
                        borderRadius: BorderRadius.circular(Spacing.radiusSm),
                        boxShadow: isSelected
                            ? [GlowStyles.colorGlowSubtle(Colors.orange)]
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          rating,
                          style: AppTypography.labelMedium.copyWith(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
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

  Widget _buildTimeLimitSettings() {
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
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Time Limit',
                        style: AppTypography.labelMedium,
                      ),
                      Text(
                        'Limit listening time per day',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _timeLimit,
                  onChanged: (v) => setState(() => _timeLimit = v),
                  activeColor: Colors.orange,
                  activeTrackColor: Colors.orange.withValues(alpha: 0.3),
                ),
              ],
            ),
            if (_timeLimit) ...[
              const SizedBox(height: Spacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Limit',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.md,
                      vertical: Spacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(Spacing.radiusFull),
                    ),
                    child: Text(
                      '${_dailyLimit.toInt()} hours',
                      style: AppTypography.labelMedium.copyWith(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: Colors.orange,
                  inactiveTrackColor: AppColors.border,
                  thumbColor: Colors.orange,
                ),
                child: Slider(
                  value: _dailyLimit,
                  min: 0.5,
                  max: 6,
                  divisions: 11,
                  onChanged: (v) => setState(() => _dailyLimit = v),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        children: [
          NeuContainer(
            style: NeuStyle.raised,
            intensity: NeuIntensity.light,
            borderRadius: Spacing.radiusMd,
            padding: const EdgeInsets.all(Spacing.md),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(Spacing.radiusSm),
                  ),
                  child: Icon(Icons.lock_outline, color: AppColors.primary),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PIN Protection', style: AppTypography.labelMedium),
                      Text(
                        'Require PIN to exit kids mode',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _pinProtection,
                  onChanged: (v) => setState(() => _pinProtection = v),
                  activeColor: AppColors.primary,
                  activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.sm),
          GestureDetector(
            onTap: () {},
            child: NeuContainer(
              style: NeuStyle.raised,
              intensity: NeuIntensity.light,
              borderRadius: Spacing.radiusMd,
              padding: const EdgeInsets.all(Spacing.md),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(Spacing.radiusSm),
                    ),
                    child: Icon(Icons.dialpad, color: AppColors.secondary),
                  ),
                  const SizedBox(width: Spacing.md),
                  Expanded(
                    child: Text('Change PIN', style: AppTypography.labelMedium),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.textHint,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
