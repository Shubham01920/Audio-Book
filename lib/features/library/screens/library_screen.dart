// =============================================================================
// LIBRARY SCREEN - My Library (Page 14)
// =============================================================================
// User's personal book collection with filters and organization.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - Parent: Main Shell (Tab 3)
// - To: Wishlist, Stats, Downloads, Filters, Book Detail, Player screens
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';
import '../../../app/routes.dart';
import '../widgets/filters_bottom_sheet.dart';

/// Library screen showing user's book collection.
///
/// Features:
/// - Tab filters (All, In Progress, Finished, Downloaded)
/// - Grid/list view toggle
/// - Book cards with progress and glow effects
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedTab = 0;
  bool _isGridView = true;

  final List<String> _tabs = ['All', 'In Progress', 'Finished', 'Downloaded'];

  final List<_BookItem> _books = [
    _BookItem('Atomic Habits', 'James Clear', 0.75, true, Colors.purple),
    _BookItem('Deep Work', 'Cal Newport', 0.45, false, Colors.teal),
    _BookItem(
      'Psychology of Money',
      'Morgan Housel',
      0.0,
      false,
      Colors.orange,
    ),
    _BookItem('Sapiens', 'Yuval Noah Harari', 1.0, true, Colors.indigo),
    _BookItem(
      'Thinking Fast and Slow',
      'Daniel Kahneman',
      0.20,
      false,
      Colors.pink,
    ),
    _BookItem('The Lean Startup', 'Eric Ries', 0.0, true, Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildQuickNav(context),
            const SizedBox(height: Spacing.md),
            _buildTabs(context),
            const SizedBox(height: Spacing.md),
            Expanded(
              child: _isGridView ? _buildGrid(context) : _buildList(context),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Library', style: AppTypography.h2),
              Text(
                '${_books.length} audiobooks',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _NeuIconButton(
                icon: _isGridView ? Icons.view_list : Icons.grid_view,
                onPressed: () => setState(() => _isGridView = !_isGridView),
                size: 42,
              ),
              const SizedBox(width: Spacing.sm),
              _NeuIconButton(
                icon: Icons.tune,
                onPressed: () => _showFilters(context),
                size: 42,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickNav(BuildContext context) {
    final items = [
      ('Shelves', Icons.collections_bookmark, Colors.amber, Routes.shelves),
      ('Wishlist', Icons.favorite_border, Colors.pink, Routes.wishlist),
      ('Stats', Icons.bar_chart, Colors.purple, Routes.stats),
      ('Downloads', Icons.download_done, Colors.teal, Routes.downloads),
    ];

    return SizedBox(
      height: 95,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.screenHorizontal,
        ),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: Spacing.md),
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildQuickNavItem(
            context,
            item.$1,
            item.$2,
            item.$3,
            item.$4,
          );
        },
      ),
    );
  }

  Widget _buildQuickNavItem(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    String route,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: 80,
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
                padding: const EdgeInsets.all(Spacing.sm),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: Spacing.xs),
              Text(
                label,
                style: AppTypography.labelSmall.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.screenHorizontal,
        ),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _tabs.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedTab;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: Spacing.sm),
              padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(Spacing.radiusCircle),
                border: isSelected ? null : Border.all(color: AppColors.border),
                boxShadow: isSelected ? [GlowStyles.primaryGlowSubtle] : null,
              ),
              child: Center(
                child: Text(
                  _tabs[index],
                  style: AppTypography.labelMedium.copyWith(
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: Spacing.md,
        mainAxisSpacing: Spacing.md,
        childAspectRatio: 0.62,
      ),
      itemCount: _books.length,
      itemBuilder: (context, index) {
        return _buildBookCardGrid(context, _books[index]);
      },
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      physics: const BouncingScrollPhysics(),
      itemCount: _books.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: Spacing.md),
          child: _buildBookCardList(context, _books[index]),
        );
      },
    );
  }

  Widget _buildBookCardGrid(BuildContext context, _BookItem book) {
    final isCompleted = book.progress >= 1.0;
    final isInProgress = book.progress > 0 && book.progress < 1.0;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.player),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          boxShadow: isInProgress
              ? [GlowStyles.colorGlowSubtle(book.color)]
              : isCompleted
              ? [GlowStyles.successGlowSubtle]
              : null,
        ),
        child: NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            book.color.withValues(alpha: 0.15),
                            book.color.withValues(alpha: 0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(Spacing.radiusSm),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.book,
                          size: 48,
                          color: book.color.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                    // Downloaded indicator
                    if (book.isDownloaded)
                      Positioned(
                        top: Spacing.xs,
                        right: Spacing.xs,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                            boxShadow: [GlowStyles.successGlowSubtle],
                          ),
                          child: const Icon(
                            Icons.download_done,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    // Completed badge
                    if (isCompleted)
                      Positioned(
                        bottom: Spacing.xs,
                        left: Spacing.xs,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            borderRadius: BorderRadius.circular(
                              Spacing.radiusSm,
                            ),
                          ),
                          child: Text(
                            '✓ Finished',
                            style: AppTypography.labelSmall.copyWith(
                              color: Colors.white,
                              fontSize: 9,
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
                book.title,
                style: AppTypography.labelLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              // Author
              Text(
                book.author,
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 1,
              ),
              const SizedBox(height: Spacing.xs),
              // Progress bar
              if (isInProgress)
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
                          widthFactor: book.progress,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  book.color,
                                  book.color.withValues(alpha: 0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: [
                                GlowStyles.colorGlowSubtle(book.color),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: Spacing.xs),
                    Text(
                      '${(book.progress * 100).toInt()}%',
                      style: AppTypography.labelSmall.copyWith(
                        color: book.color,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
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

  Widget _buildBookCardList(BuildContext context, _BookItem book) {
    final isCompleted = book.progress >= 1.0;
    final isInProgress = book.progress > 0 && book.progress < 1.0;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.bookDetail),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          boxShadow: isInProgress
              ? [GlowStyles.colorGlowSubtle(book.color)]
              : null,
        ),
        child: NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            children: [
              // Cover
              Container(
                width: 65,
                height: 85,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      book.color.withValues(alpha: 0.15),
                      book.color.withValues(alpha: 0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(Spacing.radiusSm),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(Icons.book, color: book.color, size: 28),
                    ),
                    if (book.isDownloaded)
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.download_done,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.md),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: AppTypography.labelLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: Spacing.xs),
                    Text(
                      book.author,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (isInProgress) ...[
                      const SizedBox(height: Spacing.sm),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 5,
                              decoration: BoxDecoration(
                                color: AppColors.border,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: book.progress,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        book.color,
                                        book.color.withValues(alpha: 0.7),
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
                            '${(book.progress * 100).toInt()}%',
                            style: AppTypography.labelSmall.copyWith(
                              color: book.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (isCompleted)
                      Container(
                        margin: const EdgeInsets.only(top: Spacing.sm),
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.sm,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(Spacing.radiusSm),
                        ),
                        child: Text(
                          '✓ Finished',
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Play button
              _NeuIconButton(
                icon: Icons.play_arrow_rounded,
                onPressed: () => Navigator.pushNamed(context, Routes.player),
                size: 46,
                iconColor: book.color,
                hasGlow: true,
                glowColor: book.color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilters(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const FiltersBottomSheet(),
    );
  }
}

class _BookItem {
  final String title;
  final String author;
  final double progress;
  final bool isDownloaded;
  final Color color;

  _BookItem(
    this.title,
    this.author,
    this.progress,
    this.isDownloaded,
    this.color,
  );
}

class _NeuIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color? iconColor;
  final bool hasGlow;
  final Color? glowColor;

  const _NeuIconButton({
    required this.icon,
    this.onPressed,
    this.size = 48,
    this.iconColor,
    this.hasGlow = false,
    this.glowColor,
  });

  @override
  State<_NeuIconButton> createState() => _NeuIconButtonState();
}

class _NeuIconButtonState extends State<_NeuIconButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onPressed != null
          ? (_) => setState(() => _isPressed = true)
          : null,
      onTapUp: widget.onPressed != null
          ? (_) => setState(() => _isPressed = false)
          : null,
      onTapCancel: widget.onPressed != null
          ? () => setState(() => _isPressed = false)
          : null,
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.size / 2),
          boxShadow: widget.hasGlow && widget.glowColor != null
              ? [GlowStyles.colorGlowSubtle(widget.glowColor!)]
              : null,
        ),
        child: Container(
          decoration: _isPressed
              ? NeuDecoration.pressed(
                  radius: widget.size / 2,
                  intensity: NeuIntensity.light,
                  isDark: false,
                )
              : NeuDecoration.raised(
                  radius: widget.size / 2,
                  intensity: NeuIntensity.light,
                  isDark: false,
                ),
          child: Icon(
            widget.icon,
            size: widget.size * 0.5,
            color: widget.iconColor ?? AppColors.iconDefault,
          ),
        ),
      ),
    );
  }
}
