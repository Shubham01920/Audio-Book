// =============================================================================
// BOOKMARKS SCREEN - Saved Audio Moments (Redesigned)
// =============================================================================
// Display all bookmarks across books with:
// - Book filter tabs
// - Bookmark cards with cover, timestamp, and quote
// - Play button for each bookmark
// - FAB for adding new bookmarks
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
import '../widgets/add_bookmark_sheet.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  String _selectedFilter = 'All Books';

  final List<String> _filters = [
    'All Books',
    'The Midnight Library',
    'Atomic Habits',
    'Dune',
  ];

  final List<Map<String, dynamic>> _bookmarks = [
    {
      'book': 'The Midnight Library',
      'chapter': 'Chapter 3',
      'timestamp': '1:23:45',
      'quote': '"Between life and death there is a library..."',
      'color': Colors.teal,
    },
    {
      'book': 'Atomic Habits',
      'chapter': 'Chapter 1',
      'timestamp': '0:14:20',
      'quote': 'You do not rise to the level of your goals. Yo...',
      'color': Colors.orange,
    },
    {
      'book': 'Dune',
      'chapter': 'Chapter 8',
      'timestamp': '4:12:05',
      'quote': 'I must not fear. Fear is the mind-killer. Fear is...',
      'color': Colors.amber,
    },
    {
      'book': 'Atomic Habits',
      'chapter': 'Chapter 4',
      'timestamp': '2:45:10',
      'quote': 'Consistency is key. Small changes...',
      'color': Colors.orange,
    },
    {
      'book': 'The Midnight Library',
      'chapter': 'Chapter 2',
      'timestamp': '0:45:12',
      'quote': 'Learning is not attained by chance, it must be...',
      'color': Colors.teal,
    },
    {
      'book': 'Atomic Habits',
      'chapter': 'Chapter 11',
      'timestamp': '3:20:00',
      'quote': 'The only way to do great work is to love...',
      'color': Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredBookmarks = _selectedFilter == 'All Books'
        ? _bookmarks
        : _bookmarks.where((b) => b['book'] == _selectedFilter).toList();

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(Spacing.screenHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back),
                      ),
                      const SizedBox(width: Spacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Bookmarks', style: AppTypography.h3),
                            Text(
                              'Quick access to your favorite moments',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Filter tabs
            _buildFilterTabs(),
            const SizedBox(height: Spacing.md),

            // Bookmarks list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.screenHorizontal,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: filteredBookmarks.length,
                itemBuilder: (context, index) {
                  return _buildBookmarkCard(filteredBookmarks[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Row(
        children: _filters.map((filter) {
          final isSelected = _selectedFilter == filter;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = filter),
            child: Container(
              margin: const EdgeInsets.only(right: Spacing.sm),
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.md,
                vertical: Spacing.sm,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(Spacing.radiusFull),
                border: isSelected ? null : Border.all(color: AppColors.border),
                boxShadow: isSelected ? [GlowStyles.primaryGlowSubtle] : null,
              ),
              child: Text(
                filter,
                style: AppTypography.labelMedium.copyWith(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBookmarkCard(Map<String, dynamic> bookmark) {
    final color = bookmark['color'] as Color;

    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.md),
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
                height: 80,
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
                child: Center(child: Icon(Icons.book, color: color, size: 28)),
              ),
              const SizedBox(width: Spacing.md),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Chapter and timestamp
                    Row(
                      children: [
                        Text(
                          '${bookmark['chapter']} • ${bookmark['timestamp']}',
                          style: AppTypography.labelMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.xs),

                    // Quote
                    Text(
                      bookmark['quote'],
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Spacing.sm),

              // Play button
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.play_arrow, color: color, size: 22),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return GestureDetector(
      onTap: () => _showAddBookmark(),
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
          boxShadow: [GlowStyles.primaryGlow],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  void _showAddBookmark() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const AddBookmarkSheet(),
    );
  }
}
