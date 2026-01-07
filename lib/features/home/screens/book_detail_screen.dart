// =============================================================================
// BOOK DETAIL SCREEN - Audiobook Details (Page 10)
// =============================================================================
// Displays complete information about an audiobook including synopsis,
// narrator info, reviews, and playback options.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - From: Home, Discover, Search Results, Library
// - To: Player Screen, Author Detail, Reviews
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

/// Book Detail screen showing complete audiobook information.
class BookDetailScreen extends StatefulWidget {
  final String? bookId;

  const BookDetailScreen({super.key, this.bookId});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool _isInLibrary = false;
  bool _isWishlisted = false;
  bool _showFullSynopsis = false;

  // Mock book data
  final Map<String, dynamic> _book = {
    'title': 'The Midnight Library',
    'author': 'Matt Haig',
    'narrator': 'Carey Mulligan',
    'rating': 4.8,
    'reviewCount': 12453,
    'duration': '8h 50m',
    'releaseDate': '2020',
    'genre': 'Fiction',
    'synopsis':
        'Between life and death there is a library, and within that library, '
        'the shelves go on forever. Every book provides a chance to try another life you could have lived. '
        'To see how things would be if you had made other choices... Would you have done anything different, '
        'if you had the chance to undo your regrets? A dazzling novel about all the choices that go into a life '
        'well lived, from the internationally bestselling author of Reasons to Stay Alive and How to Stop Time.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          // Main content
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(child: _buildBookInfo()),
              SliverToBoxAdapter(child: _buildActionButtons()),
              SliverToBoxAdapter(child: _buildSynopsis()),
              SliverToBoxAdapter(child: _buildDetails()),
              SliverToBoxAdapter(child: _buildReviewsPreview()),
              SliverToBoxAdapter(child: _buildSimilarBooks()),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),

          // Floating play button
          _buildFloatingPlayButton(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 320,
      pinned: true,
      backgroundColor: AppColors.backgroundLight,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Icon(Icons.chevron_left, color: AppColors.textPrimary),
        ),
      ),
      actions: [
        _buildAppBarButton(Icons.share_outlined),
        _buildAppBarButton(Icons.more_vert),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary.withValues(alpha: 0.2),
                AppColors.secondary.withValues(alpha: 0.1),
                AppColors.backgroundLight,
              ],
            ),
          ),
          child: Center(
            child: Container(
              width: 170,
              height: 230,
              margin: const EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.2),
                    AppColors.secondary.withValues(alpha: 0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                boxShadow: [
                  GlowStyles.primaryGlow,
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.headphones,
                  size: 70,
                  color: AppColors.primary.withValues(alpha: 0.6),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarButton(IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 20),
      ),
    );
  }

  Widget _buildBookInfo() {
    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Column(
        children: [
          // Title
          Text(
            _book['title'],
            style: AppTypography.h2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacing.sm),

          // Author with glow link
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.md,
                vertical: Spacing.xs,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Spacing.radiusFull),
              ),
              child: Text(
                'by ${_book['author']}',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: Spacing.xs),

          // Narrator
          Text(
            'Narrated by ${_book['narrator']}',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: Spacing.md),

          // Rating and stats row with glow
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.lg,
              vertical: Spacing.md,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(Spacing.radiusMd),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withValues(alpha: 0.15),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: NeuContainer(
              style: NeuStyle.flat,
              intensity: NeuIntensity.light,
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.md,
                vertical: Spacing.sm,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Rating with glow
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [GlowStyles.colorGlowSubtle(Colors.amber)],
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${_book['rating']}',
                        style: AppTypography.h4.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${_book['reviewCount']})',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    margin: const EdgeInsets.symmetric(horizontal: Spacing.md),
                    color: AppColors.divider,
                  ),
                  // Duration
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: AppColors.textSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _book['duration'],
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Row(
        children: [
          // Add to Library with glow when active
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isInLibrary = !_isInLibrary),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  boxShadow: _isInLibrary
                      ? [GlowStyles.successGlowSubtle]
                      : null,
                ),
                child: NeuContainer(
                  style: NeuStyle.raised,
                  intensity: NeuIntensity.light,
                  borderRadius: Spacing.radiusMd,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _isInLibrary
                            ? Icons.check_circle
                            : Icons.add_circle_outline,
                        color: _isInLibrary
                            ? AppColors.success
                            : AppColors.textPrimary,
                        size: 22,
                      ),
                      const SizedBox(width: Spacing.sm),
                      Text(
                        _isInLibrary ? 'In Library' : 'Add to Library',
                        style: AppTypography.labelMedium.copyWith(
                          color: _isInLibrary
                              ? AppColors.success
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: Spacing.md),

          // Wishlist with glow
          _buildActionIcon(
            icon: _isWishlisted ? Icons.favorite : Icons.favorite_border,
            color: _isWishlisted ? Colors.pink : AppColors.iconDefault,
            isActive: _isWishlisted,
            glowColor: Colors.pink,
            onTap: () => setState(() => _isWishlisted = !_isWishlisted),
          ),
          const SizedBox(width: Spacing.sm),

          // Download
          _buildActionIcon(
            icon: Icons.download_outlined,
            color: AppColors.iconDefault,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool isActive = false,
    Color? glowColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          boxShadow: isActive && glowColor != null
              ? [GlowStyles.colorGlowSubtle(glowColor)]
              : null,
        ),
        child: NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          child: Icon(icon, color: color, size: 22),
        ),
      ),
    );
  }

  Widget _buildSynopsis() {
    final synopsis = _book['synopsis'] as String;
    final displayText = _showFullSynopsis
        ? synopsis
        : (synopsis.length > 200
              ? '${synopsis.substring(0, 200)}...'
              : synopsis);

    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Synopsis', style: AppTypography.h4),
          const SizedBox(height: Spacing.sm),
          Text(
            displayText,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          if (synopsis.length > 200) ...[
            const SizedBox(height: Spacing.sm),
            GestureDetector(
              onTap: () =>
                  setState(() => _showFullSynopsis = !_showFullSynopsis),
              child: Text(
                _showFullSynopsis ? 'Show Less' : 'Read More',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        padding: const EdgeInsets.all(Spacing.md),
        borderRadius: Spacing.radiusMd,
        child: Column(
          children: [
            _buildDetailRow('Genre', _book['genre'], Icons.category),
            const Divider(height: Spacing.lg),
            _buildDetailRow('Duration', _book['duration'], Icons.access_time),
            const Divider(height: Spacing.lg),
            _buildDetailRow(
              'Release Year',
              _book['releaseDate'],
              Icons.calendar_today,
            ),
            const Divider(height: Spacing.lg),
            _buildDetailRow('Language', 'English', Icons.language),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: AppColors.primary),
        ),
        const SizedBox(width: Spacing.md),
        Expanded(
          child: Text(
            label,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildReviewsPreview() {
    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Reviews', style: AppTypography.h4),
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
          const SizedBox(height: Spacing.md),
          _buildReviewCard(),
        ],
      ),
    );
  }

  Widget _buildReviewCard() {
    return NeuContainer(
      style: NeuStyle.raised,
      intensity: NeuIntensity.light,
      padding: const EdgeInsets.all(Spacing.md),
      borderRadius: Spacing.radiusMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                child: Text(
                  'JD',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: Spacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: AppTypography.labelMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Container(
                          margin: const EdgeInsets.only(right: 2),
                          child: Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '2 days ago',
                style: AppTypography.caption.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.sm),
          Text(
            'Absolutely loved this book! The narration was perfect and the story was captivating from start to finish. Highly recommended!',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarBooks() {
    final colors = [Colors.purple, Colors.teal, Colors.orange, Colors.indigo];
    final titles = [
      'Reasons to Stay Alive',
      'How to Stop Time',
      'The Humans',
      'Notes on a Nervous Planet',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(Spacing.screenHorizontal),
          child: Text('You Might Also Like', style: AppTypography.h4),
        ),
        SizedBox(
          height: 190,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              final color = colors[index];
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.bookDetail),
                child: Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: Spacing.md),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
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
                                    color.withValues(alpha: 0.15),
                                    color.withValues(alpha: 0.3),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(
                                  Spacing.radiusMd,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.headphones,
                                  size: 36,
                                  color: color.withValues(alpha: 0.6),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: Spacing.sm),
                      Text(
                        titles[index],
                        style: AppTypography.labelSmall.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingPlayButton() {
    return Positioned(
      bottom: Spacing.xl,
      left: Spacing.screenHorizontal,
      right: Spacing.screenHorizontal,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          boxShadow: [GlowStyles.primaryGlow],
        ),
        child: NeuButton(
          text: 'Play Sample',
          leadingIcon: Icons.play_arrow,
          onPressed: () => Navigator.pushNamed(context, Routes.player),
          variant: NeuButtonVariant.primary,
          size: NeuButtonSize.large,
          backgroundColor: AppColors.primary,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
