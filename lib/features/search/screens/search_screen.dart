// =============================================================================
// SEARCH SCREEN - Search & Explore (Page 20)
// =============================================================================
// Search screen for discovering books, authors, and narrators.
//
// NAVIGATION RELATIONSHIPS:
// - Parent: Main Shell (Tab 2)
// - To: Search Results, Author Detail, Book Detail screens
// - Dependencies: neu_text_field.dart
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';

/// Search and explore screen.
///
/// Features:
/// - Search bar with neumorphic styling
/// - Recent searches
/// - Trending topics
/// - Category browsing
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isSearching = false;

  // Mock recent searches
  final List<String> _recentSearches = [
    'James Clear',
    'Atomic Habits',
    'Self improvement',
    'Fiction bestsellers',
  ];

  // Mock trending topics
  final List<String> _trending = [
    '🔥 New Releases',
    '📚 Book Club Picks',
    '🏆 Award Winners',
    '🎧 Editor\'s Choice',
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isSearching = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with search bar
            _buildHeader(context),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Spacing.lg),

                    // Recent searches
                    if (_recentSearches.isNotEmpty) ...[
                      _buildRecentSearches(context),
                      const SizedBox(height: Spacing.xl),
                    ],

                    // Trending
                    _buildTrending(context),
                    const SizedBox(height: Spacing.xl),

                    // Browse categories
                    _buildCategories(context),
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

  /// Build header with search bar
  Widget _buildHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text('Search', style: AppTypography.h2),
          const SizedBox(height: Spacing.md),

          // Search bar
          NeuContainer(
            style: NeuStyle.pressed,
            intensity: NeuIntensity.light,
            padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              style: AppTypography.bodyLarge,
              decoration: InputDecoration(
                hintText: 'Search books, authors, narrators...',
                hintStyle: AppTypography.inputHint,
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  color: _isSearching
                      ? AppColors.primary
                      : AppColors.iconDefault,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 20),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }

  /// Build recent searches section
  Widget _buildRecentSearches(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Searches', style: AppTypography.h5),
              TextButton(
                onPressed: () => setState(() => _recentSearches.clear()),
                child: Text(
                  'Clear',
                  style: AppTypography.buttonSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.sm),

          Wrap(
            spacing: Spacing.sm,
            runSpacing: Spacing.sm,
            children: _recentSearches.map((search) {
              return _buildSearchChip(context, search);
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// Build search chip
  Widget _buildSearchChip(BuildContext context, String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        _searchController.text = text;
        setState(() {});
      },
      child: NeuContainer(
        style: NeuStyle.flat,
        intensity: NeuIntensity.light,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        borderRadius: Spacing.radiusCircle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, size: 16, color: AppColors.iconDefault),
            const SizedBox(width: Spacing.xs),
            Text(text, style: AppTypography.bodySmall),
          ],
        ),
      ),
    );
  }

  /// Build trending section
  Widget _buildTrending(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trending', style: AppTypography.h5),
          const SizedBox(height: Spacing.md),

          ..._trending.map((topic) {
            return Padding(
              padding: const EdgeInsets.only(bottom: Spacing.sm),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(topic, style: AppTypography.bodyMedium),
                    const Spacer(),
                    const Icon(
                      Icons.chevron_right,
                      color: AppColors.iconDefault,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Build category grid
  Widget _buildCategories(BuildContext context) {
    final categories = [
      ('Fiction', Icons.auto_stories, const Color(0xFFE3F2FD)),
      ('Non-Fiction', Icons.menu_book, const Color(0xFFFFF3E0)),
      ('Mystery', Icons.search, const Color(0xFFF3E5F5)),
      ('Romance', Icons.favorite, const Color(0xFFFFEBEE)),
      ('Sci-Fi', Icons.rocket_launch, const Color(0xFFE8F5E9)),
      ('Business', Icons.trending_up, const Color(0xFFFCE4EC)),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Browse Categories', style: AppTypography.h5),
          const SizedBox(height: Spacing.md),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: Spacing.md,
              mainAxisSpacing: Spacing.md,
              childAspectRatio: 2.5,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final (name, icon, color) = categories[index];
              return _buildCategoryCard(context, name, icon, color);
            },
          ),
        ],
      ),
    );
  }

  /// Build category card
  Widget _buildCategoryCard(
    BuildContext context,
    String name,
    IconData icon,
    Color color,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return NeuContainer(
      style: NeuStyle.raised,
      intensity: NeuIntensity.light,
      padding: const EdgeInsets.all(Spacing.md),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(Spacing.radiusSm),
            ),
            child: Icon(icon, color: AppColors.textPrimary, size: 20),
          ),
          const SizedBox(width: Spacing.sm),
          Expanded(
            child: Text(
              name,
              style: AppTypography.labelLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
