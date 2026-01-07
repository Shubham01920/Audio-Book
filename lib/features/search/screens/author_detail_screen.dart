// =============================================================================
// AUTHOR DETAIL SCREEN - Author/Narrator Profile
// =============================================================================
// Displays author or narrator profile with:
// - Profile header with avatar and stats
// - Bio section
// - Books by author/narrator
// - Follow button with glow
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
import '../../../app/routes.dart';

class AuthorDetailScreen extends StatefulWidget {
  final String? authorId;

  const AuthorDetailScreen({super.key, this.authorId});

  @override
  State<AuthorDetailScreen> createState() => _AuthorDetailScreenState();
}

class _AuthorDetailScreenState extends State<AuthorDetailScreen> {
  bool _isFollowing = false;

  final Map<String, dynamic> _author = {
    'name': 'James Clear',
    'type': 'Author',
    'followers': '1.2M followers',
    'books': 3,
    'listeners': '5.8M',
    'bio':
        'James Clear is an author and speaker focused on habits, decision-making, and continuous improvement. He is the author of Atomic Habits, which has sold more than 5 million copies worldwide.',
    'color': Colors.blue,
  };

  final List<Map<String, dynamic>> _books = [
    {
      'title': 'Atomic Habits',
      'year': '2018',
      'rating': 4.8,
      'duration': '5h 35m',
      'color': Colors.orange,
    },
    {
      'title': 'Transform Your Habits',
      'year': '2014',
      'rating': 4.5,
      'duration': '2h 15m',
      'color': Colors.green,
    },
    {
      'title': 'The Habits Academy',
      'year': '2021',
      'rating': 4.7,
      'duration': '8h 20m',
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final color = _author['color'] as Color;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // App bar
          SliverAppBar(
            backgroundColor: AppColors.backgroundLight,
            elevation: 0,
            pinned: true,
            expandedHeight: 200,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: NeuDecoration.raised(
                  radius: 20,
                  intensity: NeuIntensity.light,
                  isDark: false,
                ),
                child: const Icon(Icons.arrow_back, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      color.withValues(alpha: 0.2),
                      AppColors.backgroundLight,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Profile header
                _buildProfileHeader(color),
                const SizedBox(height: Spacing.xl),

                // Stats
                _buildStats(),
                const SizedBox(height: Spacing.xl),

                // Bio
                _buildBio(),
                const SizedBox(height: Spacing.xl),

                // Books section
                _buildBooksSection(),
                const SizedBox(height: Spacing.xxl),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(Color color) {
    return Column(
      children: [
        // Avatar with glow
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withValues(alpha: 0.4),
                color.withValues(alpha: 0.7),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [GlowStyles.colorGlow(color, intensity: 0.35)],
          ),
          child: const Center(
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: Spacing.md),

        // Name
        Text(_author['name'], style: AppTypography.h3),
        const SizedBox(height: Spacing.xs),

        // Type badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.md,
            vertical: Spacing.xs,
          ),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(Spacing.radiusFull),
          ),
          child: Text(
            _author['type'],
            style: AppTypography.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: Spacing.sm),

        // Followers
        Text(
          _author['followers'],
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: Spacing.lg),

        // Follow button with glow
        GestureDetector(
          onTap: () => setState(() => _isFollowing = !_isFollowing),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.xl,
              vertical: Spacing.md,
            ),
            decoration: BoxDecoration(
              color: _isFollowing ? Colors.transparent : AppColors.primary,
              borderRadius: BorderRadius.circular(Spacing.radiusFull),
              border: _isFollowing
                  ? Border.all(color: AppColors.primary, width: 2)
                  : null,
              boxShadow: _isFollowing ? null : [GlowStyles.primaryGlow],
            ),
            child: Text(
              _isFollowing ? 'Following' : 'Follow',
              style: AppTypography.buttonMedium.copyWith(
                color: _isFollowing ? AppColors.primary : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStats() {
    final stats = [
      {'label': 'Books', 'value': '${_author['books']}'},
      {'label': 'Listeners', 'value': _author['listeners']},
      {'label': 'Rating', 'value': '4.8'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.symmetric(vertical: Spacing.lg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: stats.map((stat) {
            return Column(
              children: [
                Text(
                  stat['value']!,
                  style: AppTypography.h4.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 4),
                Text(
                  stat['label']!,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About', style: AppTypography.h5),
          const SizedBox(height: Spacing.md),
          Text(
            _author['bio'],
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBooksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.screenHorizontal,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Books', style: AppTypography.h5),
              Text(
                'See All',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.md),

        // Books list
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.screenHorizontal,
          ),
          itemCount: _books.length,
          itemBuilder: (context, index) {
            return _buildBookCard(_books[index]);
          },
        ),
      ],
    );
  }

  Widget _buildBookCard(Map<String, dynamic> book) {
    final color = book['color'] as Color;

    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.md),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, Routes.bookDetail),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
            boxShadow: [GlowStyles.colorGlowSubtle(color)],
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
                  width: 55,
                  height: 75,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withValues(alpha: 0.2),
                        color.withValues(alpha: 0.4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(Spacing.radiusSm),
                  ),
                  child: Center(
                    child: Icon(Icons.book, color: color, size: 26),
                  ),
                ),
                const SizedBox(width: Spacing.md),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book['title'],
                        style: AppTypography.labelMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        book['year'],
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: Spacing.sm),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 12, color: Colors.amber),
                          const SizedBox(width: 2),
                          Text(
                            '${book['rating']}',
                            style: AppTypography.labelSmall,
                          ),
                          const SizedBox(width: Spacing.sm),
                          Text(
                            '• ${book['duration']}',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textHint,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Play button
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.play_arrow, color: color, size: 22),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
