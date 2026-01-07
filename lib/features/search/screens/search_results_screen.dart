// =============================================================================
// SEARCH RESULTS SCREEN - Filtered Search Results
// =============================================================================
// Displays search results with:
// - Filter tabs (All, Books, Authors, Narrators)
// - Advanced filter button
// - Result cards with neumorphic design
// - Sort options
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

class SearchResultsScreen extends StatefulWidget {
  final String? query;

  const SearchResultsScreen({super.key, this.query});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  int _selectedTabIndex = 0;
  final _searchController = TextEditingController();

  final List<String> _tabs = ['All', 'Books', 'Authors', 'Narrators'];

  final List<Map<String, dynamic>> _results = [
    {
      'type': 'book',
      'title': 'Atomic Habits',
      'subtitle': 'James Clear',
      'rating': 4.8,
      'duration': '5h 35m',
      'color': Colors.orange,
    },
    {
      'type': 'author',
      'title': 'James Clear',
      'subtitle': '3 Books',
      'followers': '1.2M followers',
      'color': Colors.blue,
    },
    {
      'type': 'book',
      'title': 'The Midnight Library',
      'subtitle': 'Matt Haig',
      'rating': 4.5,
      'duration': '8h 50m',
      'color': Colors.teal,
    },
    {
      'type': 'narrator',
      'title': 'Carey Mulligan',
      'subtitle': '15 Books narrated',
      'color': Colors.purple,
    },
    {
      'type': 'book',
      'title': 'The Psychology of Money',
      'subtitle': 'Morgan Housel',
      'rating': 4.7,
      'duration': '5h 48m',
      'color': Colors.green,
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.query ?? 'James Clear';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredResults = _selectedTabIndex == 0
        ? _results
        : _results.where((r) {
            if (_selectedTabIndex == 1) return r['type'] == 'book';
            if (_selectedTabIndex == 2) return r['type'] == 'author';
            return r['type'] == 'narrator';
          }).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header with search bar
            _buildHeader(),

            // Filter tabs
            _buildTabs(),
            const SizedBox(height: Spacing.md),

            // Results count and sort
            _buildResultsInfo(filteredResults.length),
            const SizedBox(height: Spacing.md),

            // Results list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.screenHorizontal,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: filteredResults.length,
                itemBuilder: (context, index) {
                  final result = filteredResults[index];
                  if (result['type'] == 'book') {
                    return _buildBookResult(result);
                  } else {
                    return _buildPersonResult(result);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(width: Spacing.md),

          // Search bar
          Expanded(
            child: NeuContainer(
              style: NeuStyle.pressed,
              intensity: NeuIntensity.light,
              borderRadius: Spacing.radiusFull,
              padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
              child: TextField(
                controller: _searchController,
                style: AppTypography.bodyMedium,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                  hintStyle: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textHint,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: Spacing.sm),

          // Filter button with glow
          GestureDetector(
            onTap: () => _showAdvancedFilters(),
            child: Container(
              padding: const EdgeInsets.all(Spacing.sm + 2),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Icon(Icons.tune, color: AppColors.primary, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedTabIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedTabIndex = index),
            child: Container(
              margin: const EdgeInsets.only(right: Spacing.sm),
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.lg,
                vertical: Spacing.sm,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(Spacing.radiusFull),
                border: isSelected ? null : Border.all(color: AppColors.border),
                boxShadow: isSelected ? [GlowStyles.primaryGlowSubtle] : null,
              ),
              child: Text(
                _tabs[index],
                style: AppTypography.labelMedium.copyWith(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildResultsInfo(int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$count results found',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Icon(Icons.sort, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(
                  'Best Match',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookResult(Map<String, dynamic> result) {
    final color = result['color'] as Color;

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
                  width: 60,
                  height: 85,
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
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(Icons.book, color: color, size: 28),
                  ),
                ),
                const SizedBox(width: Spacing.md),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result['title'],
                        style: AppTypography.labelLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        result['subtitle'],
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
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
                              borderRadius: BorderRadius.circular(4),
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
                                  '${result['rating']}',
                                  style: AppTypography.labelSmall.copyWith(
                                    color: Colors.amber.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: Spacing.sm),
                          Text(
                            result['duration'],
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textHint,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Play sample button
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

  Widget _buildPersonResult(Map<String, dynamic> result) {
    final color = result['color'] as Color;
    final isAuthor = result['type'] == 'author';

    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.md),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, Routes.authorDetail),
        child: NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.3),
                      color.withValues(alpha: 0.5),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [GlowStyles.colorGlowSubtle(color)],
                ),
                child: Center(
                  child: Icon(
                    isAuthor ? Icons.person : Icons.mic,
                    color: color,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: Spacing.md),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          result['title'],
                          style: AppTypography.labelLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: Spacing.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Spacing.sm,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            isAuthor ? 'Author' : 'Narrator',
                            style: AppTypography.overline.copyWith(
                              color: color,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      result['subtitle'],
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (result['followers'] != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        result['followers'],
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Follow button
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(Spacing.radiusFull),
                  boxShadow: [GlowStyles.primaryGlowSubtle],
                ),
                child: Text(
                  'Follow',
                  style: AppTypography.labelSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Spacing.radiusXl),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: Spacing.lg),
            Text('Advanced Filters', style: AppTypography.h4),
            const SizedBox(height: Spacing.lg),
            Text(
              'Coming soon...',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom + Spacing.lg,
            ),
          ],
        ),
      ),
    );
  }
}
