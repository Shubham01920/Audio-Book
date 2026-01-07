// =============================================================================
// DISCOVER SCREEN - Browse & Discover Content (Page 6)
// =============================================================================
// Main discovery screen featuring collections, spotlights, and genre browsing.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - From: Home Screen, Bottom Navigation
// - To: Book Detail, Search Results, Mood Search, Samples, Upcoming
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_button.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';
import '../../../app/routes.dart';

/// Discover/Browse screen for content exploration.
class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = [
    'All',
    'Fiction',
    'Non-Fiction',
    'Self-Help',
    'Kids',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            SliverToBoxAdapter(child: _buildHeader()),

            // Search bar
            SliverToBoxAdapter(child: _buildSearchBar()),

            // Filter chips
            SliverToBoxAdapter(child: _buildFilterChips()),

            // Spotlight section
            SliverToBoxAdapter(child: _buildSpotlight()),

            // Discovery Features (Samples & Upcoming)
            SliverToBoxAdapter(child: _buildDiscoveryFeatures()),

            // Trending section
            SliverToBoxAdapter(
              child: _buildSection('Trending Now 🔥', _buildBookCarousel()),
            ),

            // Staff picks
            SliverToBoxAdapter(
              child: _buildSection('Staff Picks ⭐', _buildBookCarousel()),
            ),

            // Award winners
            SliverToBoxAdapter(
              child: _buildSection('Award Winners 🏆', _buildBookCarousel()),
            ),

            // Genre grid
            SliverToBoxAdapter(child: _buildGenreGrid()),

            const SliverToBoxAdapter(child: SizedBox(height: Spacing.xxl)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Discover', style: AppTypography.h2),
          Row(children: [_buildIconButton(Icons.tune, () {})]),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, Routes.search),
        child: NeuContainer(
          style: NeuStyle.pressed,
          intensity: NeuIntensity.light,
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.md,
            vertical: Spacing.md,
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: AppColors.textSecondary, size: 22),
              const SizedBox(width: Spacing.sm),
              Text(
                'Search books, authors, narrators...',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.sm,
                  vertical: Spacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Spacing.radiusSm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.mic, color: AppColors.primary, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: NeuDecoration.raised(
          radius: Spacing.radiusSm,
          intensity: NeuIntensity.light,
          isDark: false,
        ),
        child: Icon(icon, color: AppColors.iconDefault, size: 22),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.only(top: Spacing.md),
      child: SizedBox(
        height: 44,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.screenHorizontal,
          ),
          itemCount: _filters.length,
          itemBuilder: (context, index) {
            final isSelected = index == _selectedFilterIndex;
            return Padding(
              padding: const EdgeInsets.only(right: Spacing.sm),
              child: GestureDetector(
                onTap: () => setState(() => _selectedFilterIndex = index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.lg,
                    vertical: Spacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(Spacing.radiusFull),
                    border: isSelected
                        ? null
                        : Border.all(color: AppColors.border),
                    boxShadow: isSelected ? [GlowStyles.primaryGlow] : null,
                  ),
                  child: Center(
                    child: Text(
                      _filters[index],
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
          },
        ),
      ),
    );
  }

  Widget _buildSpotlight() {
    return Container(
      margin: const EdgeInsets.all(Spacing.screenHorizontal),
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.radiusLg),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, const Color(0xFF7E3AF2)],
        ),
        boxShadow: [
          GlowStyles.primaryGlow,
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.4),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(Spacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.sm,
                    vertical: Spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(Spacing.radiusSm),
                  ),
                  child: Text(
                    '✨ SPOTLIGHT',
                    style: AppTypography.overline.copyWith(
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: Spacing.sm),
                Text(
                  'The Midnight Library',
                  style: AppTypography.h3.copyWith(color: Colors.white),
                ),
                const SizedBox(height: Spacing.xs),
                Text(
                  'by Matt Haig',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: Spacing.md),
                Row(
                  children: [
                    // Listen Now button with glow
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Spacing.radiusSm),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: 0.3),
                            blurRadius: 12,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: NeuButton(
                        text: 'Listen Now',
                        onPressed: () =>
                            Navigator.pushNamed(context, Routes.player),
                        variant: NeuButtonVariant.primary,
                        size: NeuButtonSize.small,
                        backgroundColor: Colors.white,
                        textColor: AppColors.primary,
                        fullWidth: false,
                      ),
                    ),
                    const SizedBox(width: Spacing.md),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, Routes.samples),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.md,
                          vertical: Spacing.sm,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                          borderRadius: BorderRadius.circular(Spacing.radiusSm),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              color: Colors.white.withValues(alpha: 0.9),
                              size: 18,
                            ),
                            const SizedBox(width: Spacing.xs),
                            Text(
                              'Preview',
                              style: AppTypography.labelMedium.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildDiscoveryFeatures() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.screenHorizontal,
        vertical: Spacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildFeatureCard(
              'Mood Search',
              '😊 How are you feeling?',
              Icons.mood,
              Colors.purple,
              () => Navigator.pushNamed(context, Routes.moodSearch),
            ),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: _buildFeatureCard(
              'Samples Feed',
              '🎧 Preview books',
              Icons.ondemand_video,
              Colors.teal,
              () => Navigator.pushNamed(context, Routes.samples),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          boxShadow: [GlowStyles.colorGlowSubtle(color)],
        ),
        child: NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(Spacing.sm),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(Spacing.radiusSm),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(height: Spacing.sm),
              Text(
                title,
                style: AppTypography.labelMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.screenHorizontal,
            vertical: Spacing.md,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTypography.h4),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.sm,
                    vertical: Spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Spacing.radiusSm),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    'See All',
                    style: AppTypography.labelMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        content,
      ],
    );
  }

  Widget _buildBookCarousel() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.screenHorizontal,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => _buildBookCard(index),
      ),
    );
  }

  Widget _buildBookCard(int index) {
    final books = [
      {'title': 'Atomic Habits', 'author': 'James Clear', 'rating': '4.8'},
      {
        'title': 'Psychology of Money',
        'author': 'Morgan Housel',
        'rating': '4.7',
      },
      {'title': 'Project Hail Mary', 'author': 'Andy Weir', 'rating': '4.9'},
      {'title': 'Educated', 'author': 'Tara Westover', 'rating': '4.6'},
      {
        'title': 'Silent Patient',
        'author': 'Alex Michaelides',
        'rating': '4.5',
      },
      {'title': 'Crawdads Sing', 'author': 'Delia Owens', 'rating': '4.7'},
    ];

    final colors = [
      AppColors.primary,
      Colors.teal,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.indigo,
    ];

    final book = books[index % books.length];
    final color = colors[index % colors.length];

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.bookDetail),
      child: Container(
        width: 130,
        margin: const EdgeInsets.only(right: Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book cover
            Expanded(
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
                        color.withValues(alpha: 0.15),
                        color.withValues(alpha: 0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.headphones,
                          size: 40,
                          color: color.withValues(alpha: 0.6),
                        ),
                      ),
                      Positioned(
                        top: Spacing.sm,
                        right: Spacing.sm,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.95),
                            borderRadius: BorderRadius.circular(
                              Spacing.radiusSm,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.amber.withValues(alpha: 0.3),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 12,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                book['rating']!,
                                style: AppTypography.caption.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: Spacing.sm),
            // Title
            Text(
              book['title']!,
              style: AppTypography.labelMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Author
            Text(
              book['author']!,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreGrid() {
    final genres = [
      {'name': 'Mystery', 'icon': Icons.search, 'color': Colors.purple},
      {'name': 'Romance', 'icon': Icons.favorite, 'color': Colors.pink},
      {'name': 'Sci-Fi', 'icon': Icons.rocket_launch, 'color': Colors.blue},
      {'name': 'Thriller', 'icon': Icons.flash_on, 'color': Colors.orange},
      {'name': 'Fantasy', 'icon': Icons.castle, 'color': Colors.teal},
      {'name': 'Biography', 'icon': Icons.person, 'color': Colors.green},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Spacing.screenHorizontal),
          child: Text('Browse by Genre', style: AppTypography.h4),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.screenHorizontal,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.1,
            crossAxisSpacing: Spacing.md,
            mainAxisSpacing: Spacing.md,
          ),
          itemCount: genres.length,
          itemBuilder: (context, index) {
            final genre = genres[index];
            final color = genre['color'] as Color;
            return GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  boxShadow: [GlowStyles.colorGlowSubtle(color)],
                ),
                child: NeuContainer(
                  style: NeuStyle.raised,
                  intensity: NeuIntensity.light,
                  borderRadius: Spacing.radiusMd,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          genre['icon'] as IconData,
                          color: color,
                          size: 22,
                        ),
                      ),
                      const SizedBox(height: Spacing.sm),
                      Text(
                        genre['name'] as String,
                        style: AppTypography.labelSmall.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
