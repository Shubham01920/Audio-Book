// =============================================================================
// SERIES DETAIL SCREEN - Book Series View (Page 19)
// =============================================================================
// Displays a book series with all books in sequence, progress tracking,
// and continue reading options.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - From: Home, Library, Book Detail
// - To: Book Detail, Player
// =============================================================================

import 'package:flutter/material.dart';
import 'package:ui_app/core/theme/neumorphism/neumorphic_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/neumorphic/neu_button.dart';
import '../../../shared/widgets/glow/glow_styles.dart';
import '../../../app/routes.dart';

class SeriesDetailScreen extends StatelessWidget {
  final String? seriesId;

  const SeriesDetailScreen({super.key, this.seriesId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(child: _buildSeriesInfo()),
          SliverToBoxAdapter(child: _buildProgressSection()),
          SliverToBoxAdapter(child: _buildBooksList(context)),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: _buildContinueButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppColors.backgroundLight,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.chevron_left, color: AppColors.textPrimary),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withValues(alpha: 0.3),
                AppColors.secondary.withValues(alpha: 0.2),
                AppColors.backgroundLight,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Container(
                  padding: const EdgeInsets.all(Spacing.md),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [GlowStyles.primaryGlow],
                  ),
                  child: Icon(
                    Icons.library_books,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeriesInfo() {
    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Column(
        children: [
          // Series badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.md,
              vertical: Spacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Spacing.radiusFull),
            ),
            child: Text(
              '📚 SERIES • 5 BOOKS',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: Spacing.md),

          // Title
          Text(
            'A Song of Ice and Fire',
            style: AppTypography.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacing.sm),

          // Author
          Text(
            'by George R.R. Martin',
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: Spacing.md),

          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatItem(Icons.schedule, '201h total'),
              const SizedBox(width: Spacing.xl),
              _buildStatItem(Icons.star, '4.9 avg'),
              const SizedBox(width: Spacing.xl),
              _buildStatItem(Icons.download, '2.1M'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          boxShadow: [GlowStyles.primaryGlowSubtle],
        ),
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
                  Text('Your Progress', style: AppTypography.labelLarge),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(Spacing.radiusFull),
                    ),
                    child: Text(
                      '2 of 5 completed',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.md),

              // Progress bar with glow
              Container(
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 0.45,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                      ),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [GlowStyles.primaryGlowSubtle],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Spacing.sm),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '45% Complete',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '110h remaining',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBooksList(BuildContext context) {
    final books = [
      {
        'title': 'A Game of Thrones',
        'duration': '33h',
        'progress': 1.0,
        'book': 1,
      },
      {
        'title': 'A Clash of Kings',
        'duration': '37h',
        'progress': 1.0,
        'book': 2,
      },
      {
        'title': 'A Storm of Swords',
        'duration': '47h',
        'progress': 0.35,
        'book': 3,
      },
      {
        'title': 'A Feast for Crows',
        'duration': '33h',
        'progress': 0.0,
        'book': 4,
      },
      {
        'title': 'A Dance with Dragons',
        'duration': '48h',
        'progress': 0.0,
        'book': 5,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Spacing.lg),
          Text('Books in Series', style: AppTypography.h4),
          const SizedBox(height: Spacing.md),
          ...books.map((book) => _buildBookItem(context, book)).toList(),
        ],
      ),
    );
  }

  Widget _buildBookItem(BuildContext context, Map<String, dynamic> book) {
    final progress = book['progress'] as double;
    final isCompleted = progress >= 1.0;
    final isInProgress = progress > 0 && progress < 1.0;

    Color? glowColor;
    if (isCompleted) glowColor = AppColors.success;
    if (isInProgress) glowColor = AppColors.primary;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.bookDetail),
      child: Container(
        margin: const EdgeInsets.only(bottom: Spacing.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          boxShadow: glowColor != null
              ? [GlowStyles.colorGlowSubtle(glowColor)]
              : null,
        ),
        child: NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            children: [
              // Book number with status
              Container(
                width: 50,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isCompleted
                        ? [
                            AppColors.success.withValues(alpha: 0.2),
                            AppColors.success.withValues(alpha: 0.1),
                          ]
                        : [
                            AppColors.primary.withValues(alpha: 0.15),
                            AppColors.secondary.withValues(alpha: 0.1),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(Spacing.radiusSm),
                ),
                child: Center(
                  child: isCompleted
                      ? Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 28,
                        )
                      : Text(
                          '${book['book']}',
                          style: AppTypography.h4.copyWith(
                            color: isInProgress
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: Spacing.md),

              // Book info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book['title'],
                      style: AppTypography.labelLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isCompleted
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: Spacing.xs),
                    Text(
                      book['duration'],
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (isInProgress) ...[
                      const SizedBox(height: Spacing.sm),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                color: AppColors.border,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: progress,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: Spacing.sm),
                          Text(
                            '${(progress * 100).toInt()}%',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Play button
              if (!isCompleted)
                Icon(
                  isInProgress
                      ? Icons.play_circle_filled
                      : Icons.play_circle_outline,
                  color: isInProgress
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  size: 32,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        boxShadow: [GlowStyles.primaryGlow],
      ),
      child: NeuButton(
        text: 'Continue: A Storm of Swords',
        leadingIcon: Icons.play_arrow,
        onPressed: () => Navigator.pushNamed(context, Routes.player),
        variant: NeuButtonVariant.primary,
        backgroundColor: AppColors.primary,
        textColor: Colors.white,
      ),
    );
  }
}
