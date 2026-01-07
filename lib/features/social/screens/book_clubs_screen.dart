// =============================================================================
// BOOK CLUBS SCREEN - Community Book Clubs
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

class BookClubsScreen extends StatelessWidget {
  const BookClubsScreen({super.key});

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
              _buildHeader(context),
              _buildSearchBar(),
              const SizedBox(height: Spacing.lg),
              _buildSectionHeader('MY CLUBS', 'See all'),
              _buildMyClubsList(context),
              const SizedBox(height: Spacing.xl),
              _buildSectionHeader('FEATURED', null),
              _buildFeaturedClub(context),
              const SizedBox(height: Spacing.xl),
              _buildSectionHeader('TRENDING', 'Browse all'),
              _buildTrendingClubs(context),
              const SizedBox(height: Spacing.xl),
              _buildSectionHeader('DISCOVER BY GENRE', null),
              _buildDiscoverGrid(context),
              const SizedBox(height: Spacing.xxl),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildCreateFAB(context),
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
              child: const Icon(Icons.arrow_back, size: 20),
            ),
          ),
          const SizedBox(width: Spacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Book Clubs', style: AppTypography.h3),
              Text(
                'Join 50+ active communities',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.pressed,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.textHint, size: 20),
            const SizedBox(width: Spacing.sm),
            Text(
              'Search clubs...',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String? action) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.screenHorizontal,
        vertical: Spacing.sm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTypography.overline.copyWith(
              color: AppColors.textHint,
              letterSpacing: 1.5,
            ),
          ),
          if (action != null)
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
                action,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMyClubsList(BuildContext context) {
    final clubs = [
      {
        'name': 'Sci-Fi Explorers',
        'members': '2.4k',
        'color': Colors.purple,
        'reading': 'Dune',
        'isLive': true,
      },
      {
        'name': 'Mystery Minds',
        'members': '1.8k',
        'color': Colors.red,
        'reading': 'Gone Girl',
        'isLive': false,
      },
      {
        'name': 'Self-Growth',
        'members': '3.1k',
        'color': Colors.teal,
        'reading': 'Atomic Habits',
        'isLive': false,
      },
    ];

    return SizedBox(
      height: 155,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.screenHorizontal,
        ),
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          final club = clubs[index];
          final color = club['color'] as Color;
          final isLive = club['isLive'] as bool;

          return Container(
            width: 200,
            margin: const EdgeInsets.only(right: Spacing.md),
            child: NeuContainer(
              style: NeuStyle.raised,
              intensity: NeuIntensity.light,
              borderRadius: Spacing.radiusMd,
              padding: const EdgeInsets.all(Spacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.withValues(alpha: 0.3),
                              color.withValues(alpha: 0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(Spacing.radiusSm),
                          boxShadow: [GlowStyles.colorGlowSubtle(color)],
                        ),
                        child: Icon(
                          Icons.groups,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: Spacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              club['name'] as String,
                              style: AppTypography.labelMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (isLive)
                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(
                                    Spacing.radiusFull,
                                  ),
                                  boxShadow: [
                                    GlowStyles.colorGlowSubtle(Colors.red),
                                  ],
                                ),
                                child: Text(
                                  'LIVE NOW',
                                  style: AppTypography.overline.copyWith(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '${club['members']} members',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Reading: ${club['reading']}',
                    style: AppTypography.labelSmall.copyWith(color: color),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedClub(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Container(
        padding: const EdgeInsets.all(Spacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(Spacing.radiusLg),
          boxShadow: [GlowStyles.primaryGlow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  ),
                  child: Icon(
                    Icons.auto_stories,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Book of the Month',
                            style: AppTypography.h5.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: Spacing.xs),
                          Icon(Icons.verified, color: Colors.white, size: 16),
                        ],
                      ),
                      Text(
                        '15.2k members • Official',
                        style: AppTypography.labelSmall.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.md),
            Text(
              'Join thousands of readers discussing the hottest new releases. Live sessions every Friday at 7 PM!',
              style: AppTypography.bodySmall.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
              ),
            ),
            const SizedBox(height: Spacing.md),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: Spacing.sm),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Spacing.radiusSm),
                    ),
                    child: Center(
                      child: Text(
                        'Join Club',
                        style: AppTypography.buttonMedium.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Spacing.md),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(Spacing.radiusSm),
                  ),
                  child: Icon(Icons.share, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingClubs(BuildContext context) {
    final trending = [
      {
        'name': 'Psychology Deep Dive',
        'members': '5.2k',
        'color': Colors.indigo,
        'growth': '+24%',
      },
      {
        'name': 'Finance Masters',
        'members': '3.8k',
        'color': Colors.green,
        'growth': '+18%',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        children: trending.map((club) {
          final color = club['color'] as Color;
          return Padding(
            padding: const EdgeInsets.only(bottom: Spacing.md),
            child: NeuContainer(
              style: NeuStyle.raised,
              intensity: NeuIntensity.light,
              borderRadius: Spacing.radiusMd,
              padding: const EdgeInsets.all(Spacing.md),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color.withValues(alpha: 0.4), color],
                      ),
                      borderRadius: BorderRadius.circular(Spacing.radiusSm),
                      boxShadow: [GlowStyles.colorGlowSubtle(color)],
                    ),
                    child: Icon(Icons.groups, color: Colors.white, size: 26),
                  ),
                  const SizedBox(width: Spacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          club['name'] as String,
                          style: AppTypography.labelMedium,
                        ),
                        Text(
                          '${club['members']} members',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.sm,
                      vertical: Spacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(Spacing.radiusFull),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.trending_up, size: 14, color: Colors.green),
                        const SizedBox(width: 2),
                        Text(
                          club['growth'] as String,
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDiscoverGrid(BuildContext context) {
    final categories = [
      {
        'name': 'Fiction',
        'icon': Icons.menu_book,
        'color': Colors.blue,
        'clubs': 15,
      },
      {
        'name': 'Non-Fiction',
        'icon': Icons.lightbulb_outline,
        'color': Colors.orange,
        'clubs': 12,
      },
      {
        'name': 'Poetry',
        'icon': Icons.format_quote,
        'color': Colors.purple,
        'clubs': 8,
      },
      {
        'name': 'Business',
        'icon': Icons.trending_up,
        'color': Colors.green,
        'clubs': 10,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: Spacing.md,
          mainAxisSpacing: Spacing.md,
          childAspectRatio: 1.4,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          final color = cat['color'] as Color;
          return NeuContainer(
            style: NeuStyle.raised,
            intensity: NeuIntensity.light,
            borderRadius: Spacing.radiusMd,
            padding: const EdgeInsets.all(Spacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(Spacing.radiusSm),
                    boxShadow: [GlowStyles.colorGlowSubtle(color)],
                  ),
                  child: Icon(cat['icon'] as IconData, color: color, size: 22),
                ),
                const SizedBox(height: Spacing.sm),
                Text(cat['name'] as String, style: AppTypography.labelMedium),
                Text(
                  '${cat['clubs']} clubs',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCreateFAB(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [GlowStyles.primaryGlow]),
      child: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text('Create Club', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
