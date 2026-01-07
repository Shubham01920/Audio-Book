// =============================================================================
// HOME SCREEN - Main Dashboard (Page 5)
// =============================================================================
// The main home screen matching reference design with:
// - Greeting header with avatar
// - Continue Reading section with progress
// - Recommended For You carousel
// - New Releases with NEW badges
// - Best Sellers numbered list
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - Parent: Main Shell (Tab 1)
// - To: Book Detail, Player, Discover screens
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';
import '../../../app/routes.dart';

/// Home screen / Dashboard matching reference design.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              // Greeting Header Card
              _buildGreetingHeader(context),
              const SizedBox(height: Spacing.lg),

              // Continue Reading Section
              _buildSectionHeader(context, 'Continue Reading', onSeeAll: () {}),
              const SizedBox(height: Spacing.md),
              _buildContinueReading(context),
              const SizedBox(height: Spacing.xl),

              // Recommended For You
              _buildSectionHeader(
                context,
                'Recommended For You',
                onSeeAll: () {},
              ),
              const SizedBox(height: Spacing.md),
              _buildRecommendedCarousel(context),
              const SizedBox(height: Spacing.xl),

              // New Releases
              _buildSectionHeader(context, 'New Releases', onSeeAll: () {}),
              const SizedBox(height: Spacing.md),
              _buildNewReleases(context),
              const SizedBox(height: Spacing.xl),

              // Best Sellers
              _buildSectionHeader(context, 'Best Sellers', onSeeAll: () {}),
              const SizedBox(height: Spacing.md),
              _buildBestSellers(context),
              const SizedBox(height: Spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  /// Greeting header card with avatar
  Widget _buildGreetingHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.primary, Color(0xFF5BA3E8)],
          ),
          borderRadius: BorderRadius.circular(Spacing.radiusLg),
          boxShadow: [GlowStyles.primaryGlow],
        ),
        padding: const EdgeInsets.all(Spacing.lg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(),
                  style: AppTypography.h3.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Spacing.xs),
                Text(
                  'Ready to continue your story?',
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
            // Avatar with glow border
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                child: const Icon(Icons.person, color: Colors.white, size: 28),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section header with See All button
  Widget _buildSectionHeader(
    BuildContext context,
    String title, {
    VoidCallback? onSeeAll,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.h4),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                'See All',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Continue Reading section with book card and progress
  Widget _buildContinueReading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, Routes.player),
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
            child: Row(
              children: [
                // Book cover
                Container(
                  width: 70,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.2),
                        AppColors.secondary.withValues(alpha: 0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(Spacing.radiusSm),
                    boxShadow: [GlowStyles.primaryGlowSubtle],
                  ),
                  child: const Center(
                    child: Icon(Icons.book, color: AppColors.primary, size: 32),
                  ),
                ),
                const SizedBox(width: Spacing.md),

                // Book info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The Midnight...',
                        style: AppTypography.labelLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Matt Haig',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: Spacing.sm),
                      // Progress bar
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppColors.border,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: 0.45,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.primary,
                                        AppColors.secondary,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: Spacing.sm),
                          Text(
                            '45%',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: Spacing.md),

                // Play button with glow
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [GlowStyles.primaryGlow],
                  ),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primary,
                    child: const Icon(Icons.play_arrow, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Recommended For You carousel
  Widget _buildRecommendedCarousel(BuildContext context) {
    final books = [
      {
        'title': 'Project Hail Mary',
        'author': 'Andy Weir',
        'rating': 4.8,
        'label': 'TRENDING',
        'color': Colors.orange,
      },
      {
        'title': 'Dune',
        'author': 'Frank Herbert',
        'rating': 4.9,
        'label': '',
        'color': Colors.teal,
      },
      {
        'title': 'The Alchemist',
        'author': 'Paulo Coelho',
        'rating': 4.7,
        'label': '',
        'color': Colors.purple,
      },
    ];

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.screenHorizontal,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return _buildRecommendedCard(context, book, index);
        },
      ),
    );
  }

  Widget _buildRecommendedCard(
    BuildContext context,
    Map<String, dynamic> book,
    int index,
  ) {
    final color = book['color'] as Color;
    final hasLabel = (book['label'] as String).isNotEmpty;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.bookDetail),
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book cover with label
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Spacing.radiusMd),
                      boxShadow: [GlowStyles.colorGlowSubtle(color)],
                    ),
                    child: NeuContainer(
                      style: NeuStyle.raised,
                      intensity: NeuIntensity.light,
                      borderRadius: Spacing.radiusMd,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              color.withValues(alpha: 0.15),
                              color.withValues(alpha: 0.3),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(Spacing.radiusMd),
                        ),
                        child: Center(
                          child: Icon(Icons.book, size: 48, color: color),
                        ),
                      ),
                    ),
                  ),
                  if (hasLabel)
                    Positioned(
                      top: Spacing.sm,
                      left: Spacing.sm,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          book['label'] as String,
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.sm),

            // Title
            Text(
              book['title'] as String,
              style: AppTypography.labelMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Author
            Text(
              book['author'] as String,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            // Rating
            Row(
              children: [
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 2),
                Text(
                  '${book['rating']}',
                  style: AppTypography.labelSmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// New Releases section with NEW badges
  Widget _buildNewReleases(BuildContext context) {
    final releases = [
      {
        'title': 'Fourth Wing',
        'author': 'Rebecca Yarros',
        'color': Colors.green,
      },
      {'title': 'Yellowface', 'author': 'R. F. Kuang', 'color': Colors.amber},
      {'title': 'The Covenant', 'author': 'A. Verghese', 'color': Colors.blue},
    ];

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.screenHorizontal,
        ),
        itemCount: releases.length,
        itemBuilder: (context, index) {
          final book = releases[index];
          final color = book['color'] as Color;
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.bookDetail),
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: Spacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cover with NEW badge
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Spacing.radiusMd,
                            ),
                            boxShadow: [GlowStyles.colorGlowSubtle(color)],
                          ),
                          child: NeuContainer(
                            style: NeuStyle.raised,
                            intensity: NeuIntensity.light,
                            borderRadius: Spacing.radiusMd,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    color.withValues(alpha: 0.2),
                                    color.withValues(alpha: 0.4),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(
                                  Spacing.radiusMd,
                                ),
                              ),
                              child: Center(
                                child: Icon(Icons.book, size: 40, color: color),
                              ),
                            ),
                          ),
                        ),
                        // NEW badge with glow
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(Spacing.radiusMd),
                                bottomRight: Radius.circular(Spacing.radiusSm),
                              ),
                              boxShadow: [GlowStyles.primaryGlowSubtle],
                            ),
                            child: Text(
                              'NEW',
                              style: AppTypography.labelSmall.copyWith(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacing.sm),
                  Text(
                    book['title'] as String,
                    style: AppTypography.labelMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    book['author'] as String,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Best Sellers numbered list
  Widget _buildBestSellers(BuildContext context) {
    final sellers = [
      {'title': 'Becoming', 'author': 'Michelle Obama', 'listeners': '2M'},
      {
        'title': 'Greenlights',
        'author': 'Matthew McConaughey',
        'listeners': '1.9M',
      },
      {
        'title': 'Lessons in Chemistry',
        'author': 'Bonnie Garmus',
        'listeners': '1.2M',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        children: List.generate(sellers.length, (index) {
          final book = sellers[index];
          return _buildBestSellerItem(context, book, index + 1);
        }),
      ),
    );
  }

  Widget _buildBestSellerItem(
    BuildContext context,
    Map<String, dynamic> book,
    int rank,
  ) {
    final colors = [Colors.orange, Colors.blue, Colors.purple];
    final color = colors[(rank - 1) % colors.length];

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.bookDetail),
      child: Padding(
        padding: const EdgeInsets.only(bottom: Spacing.md),
        child: NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            children: [
              // Rank number with glow
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(Spacing.radiusSm),
                  boxShadow: [GlowStyles.colorGlowSubtle(color)],
                ),
                child: Center(
                  child: Text(
                    '$rank',
                    style: AppTypography.h4.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: Spacing.md),

              // Book cover thumbnail
              Container(
                width: 45,
                height: 55,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.2),
                      color.withValues(alpha: 0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(Spacing.radiusSm),
                ),
                child: Center(child: Icon(Icons.book, size: 22, color: color)),
              ),
              const SizedBox(width: Spacing.md),

              // Book info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book['title'] as String,
                      style: AppTypography.labelLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      book['author'] as String,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.headphones,
                          size: 12,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${book['listeners']} Listens',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning,\nSarah';
    if (hour < 17) return 'Good Afternoon,\nSarah';
    return 'Good Evening,\nSarah';
  }
}
