// =============================================================================
// REVIEW SCREEN - Book Review & Rating
// =============================================================================
// DESIGN: 60% Neumorphism + 30% Solid Glow + 10% Flat Elements
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _rating = 4;
  final _reviewController = TextEditingController();
  final List<String> _selectedTags = ['Well-Written', 'Inspiring'];
  bool _containsSpoilers = false;

  final List<String> _availableTags = [
    'Well-Written',
    'Page Turner',
    'Inspiring',
    'Emotional',
    'Thought-Provoking',
    'Easy Read',
    'Great Narration',
    'Funny',
    'Must Read',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.screenHorizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBookInfo(),
                    const SizedBox(height: Spacing.xl),
                    _buildRatingSection(),
                    const SizedBox(height: Spacing.xl),
                    _buildReviewInput(),
                    const SizedBox(height: Spacing.xl),
                    _buildTagsSection(),
                    const SizedBox(height: Spacing.lg),
                    _buildSpoilerToggle(),
                    const SizedBox(height: Spacing.xl),
                    _buildSubmitButton(),
                    const SizedBox(height: Spacing.xxl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.8),
                    blurRadius: 6,
                    offset: Offset(-3, -3),
                  ),
                  BoxShadow(
                    color: AppColors.darkShadowLight.withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.close, size: 20),
            ),
          ),
          const SizedBox(width: Spacing.md),
          Text('Write a Review', style: AppTypography.h4),
        ],
      ),
    );
  }

  Widget _buildBookInfo() {
    return NeuContainer(
      style: NeuStyle.raised,
      intensity: NeuIntensity.light,
      borderRadius: Spacing.radiusMd,
      padding: const EdgeInsets.all(Spacing.md),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 95,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.4),
                  AppColors.secondary.withValues(alpha: 0.6),
                ],
              ),
              borderRadius: BorderRadius.circular(Spacing.radiusSm),
              boxShadow: [GlowStyles.primaryGlowSubtle],
            ),
            child: Icon(Icons.book, color: Colors.white, size: 35),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('The Midnight Library', style: AppTypography.h5),
                Text(
                  'by Matt Haig',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
                const SizedBox(height: Spacing.sm),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.sm,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(Spacing.radiusFull),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 14, color: Colors.amber),
                          const SizedBox(width: 2),
                          Text(
                            '4.2',
                            style: AppTypography.labelSmall.copyWith(
                              color: Colors.amber,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: Spacing.sm),
                    Text(
                      '12.5k reviews',
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
      ),
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR RATING',
          style: AppTypography.overline.copyWith(
            color: AppColors.textHint,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: Spacing.md),
        NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.symmetric(
            vertical: Spacing.lg,
            horizontal: Spacing.md,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) {
                  final isSelected = i < _rating;
                  return GestureDetector(
                    onTap: () => setState(() => _rating = i + 1),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: Spacing.sm,
                      ),
                      child: Icon(
                        isSelected ? Icons.star : Icons.star_border,
                        size: 42,
                        color: isSelected ? Colors.amber : AppColors.border,
                        shadows: isSelected
                            ? [
                                Shadow(
                                  color: Colors.amber.withValues(alpha: 0.5),
                                  blurRadius: 10,
                                ),
                              ]
                            : null,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: Spacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.xs,
                ),
                decoration: BoxDecoration(
                  color: _getRatingColor().withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(Spacing.radiusFull),
                ),
                child: Text(
                  _getRatingText(),
                  style: AppTypography.labelMedium.copyWith(
                    color: _getRatingColor(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getRatingColor() {
    if (_rating <= 2) return Colors.red;
    if (_rating == 3) return Colors.orange;
    return Colors.green;
  }

  String _getRatingText() {
    switch (_rating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Very Good';
      case 5:
        return 'Excellent!';
      default:
        return '';
    }
  }

  Widget _buildReviewInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'YOUR REVIEW',
          style: AppTypography.overline.copyWith(
            color: AppColors.textHint,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: Spacing.md),
        NeuContainer(
          style: NeuStyle.pressed,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: TextField(
            controller: _reviewController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText:
                  'Share your thoughts about this book...\n\nWhat did you like? What could be better?',
              hintStyle: AppTypography.bodyMedium.copyWith(
                color: AppColors.textHint,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTagsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TAGS',
          style: AppTypography.overline.copyWith(
            color: AppColors.textHint,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: Spacing.md),
        Wrap(
          spacing: Spacing.sm,
          runSpacing: Spacing.sm,
          children: _availableTags.map((tag) {
            final isSelected = _selectedTags.contains(tag);
            return GestureDetector(
              onTap: () => setState(() {
                if (isSelected) {
                  _selectedTags.remove(tag);
                } else {
                  _selectedTags.add(tag);
                }
              }),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.sm,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(Spacing.radiusFull),
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
                child: Text(
                  tag,
                  style: AppTypography.labelSmall.copyWith(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSpoilerToggle() {
    return NeuContainer(
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
              color: Colors.orange.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Spacing.radiusSm),
            ),
            child: Icon(Icons.warning_amber, color: Colors.orange),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contains Spoilers', style: AppTypography.labelMedium),
                Text(
                  'Hide review behind a warning',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _containsSpoilers,
            onChanged: (v) => setState(() => _containsSpoilers = v),
            activeColor: Colors.orange,
            activeTrackColor: Colors.orange.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: Spacing.md),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ),
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          boxShadow: [GlowStyles.primaryGlow],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.send, color: Colors.white, size: 20),
            const SizedBox(width: Spacing.sm),
            Text(
              'Submit Review',
              style: AppTypography.buttonMedium.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
