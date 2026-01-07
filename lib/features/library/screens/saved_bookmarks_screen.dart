// =============================================================================
// SAVED BOOKMARKS SCREEN - User Bookmarks (Page NEW)
// =============================================================================
// Displays all bookmarks across all audiobooks.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - From: Library, Player
// - To: Player (at bookmark time)
// =============================================================================

import 'package:flutter/material.dart';
import 'package:ui_app/core/theme/neumorphism/neumorphic_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';
import '../../../app/routes.dart';

class SavedBookmarksScreen extends StatelessWidget {
  const SavedBookmarksScreen({super.key});

  final List<Map<String, dynamic>> _bookmarks = const [
    {
      'book': 'Atomic Habits',
      'chapter': 'Chapter 3: The Habit Loop',
      'timestamp': '01:23:45',
      'note': 'Great insight on cue-routine-reward',
      'color': Colors.purple,
    },
    {
      'book': 'Deep Work',
      'chapter': 'Chapter 1: Deep Work is Valuable',
      'timestamp': '00:45:12',
      'note': 'Definition of deep work',
      'color': Colors.teal,
    },
    {
      'book': 'The Midnight Library',
      'chapter': 'Chapter 7: The Library',
      'timestamp': '02:15:30',
      'note': 'Beautiful metaphor about choices',
      'color': Colors.blue,
    },
    {
      'book': 'Psychology of Money',
      'chapter': 'Chapter 12: Wealth is What You Don\'t See',
      'timestamp': '03:05:00',
      'note': '',
      'color': Colors.orange,
    },
    {
      'book': 'Atomic Habits',
      'chapter': 'Chapter 8: Identity Change',
      'timestamp': '02:45:22',
      'note': 'Focus on who you want to become',
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(Spacing.sm),
            child: NeuContainer(
              style: NeuStyle.raised,
              intensity: NeuIntensity.light,
              isCircular: true,
              child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            ),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                boxShadow: [GlowStyles.primaryGlowSubtle],
              ),
              child: const Icon(
                Icons.bookmark,
                color: AppColors.primary,
                size: 18,
              ),
            ),
            const SizedBox(width: Spacing.sm),
            Text('Saved Bookmarks', style: AppTypography.h3),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textSecondary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary
          _buildSummary(),

          // Bookmarks list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(Spacing.screenHorizontal),
              physics: const BouncingScrollPhysics(),
              itemCount: _bookmarks.length,
              itemBuilder: (context, index) =>
                  _buildBookmarkItem(context, _bookmarks[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    // Group by book
    final bookCounts = <String, int>{};
    for (final bookmark in _bookmarks) {
      final book = bookmark['book'] as String;
      bookCounts[book] = (bookCounts[book] ?? 0) + 1;
    }

    return Container(
      margin: const EdgeInsets.all(Spacing.screenHorizontal),
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.secondary.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(Spacing.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              boxShadow: [GlowStyles.primaryGlowSubtle],
            ),
            child: const Icon(
              Icons.bookmarks,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${_bookmarks.length} Bookmarks', style: AppTypography.h4),
                Text(
                  'Across ${bookCounts.length} books',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookmarkItem(
    BuildContext context,
    Map<String, dynamic> bookmark,
  ) {
    final color = bookmark['color'] as Color;
    final hasNote = (bookmark['note'] as String).isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.md),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, Routes.player),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  children: [
                    // Book indicator
                    Container(
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: [GlowStyles.colorGlowSubtle(color)],
                      ),
                    ),
                    const SizedBox(width: Spacing.sm),

                    // Book info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bookmark['book'] as String,
                            style: AppTypography.labelLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            bookmark['chapter'] as String,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Timestamp badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.sm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(Spacing.radiusSm),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.access_time, size: 14, color: color),
                          const SizedBox(width: 4),
                          Text(
                            bookmark['timestamp'] as String,
                            style: AppTypography.labelSmall.copyWith(
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Note
                if (hasNote) ...[
                  const SizedBox(height: Spacing.sm),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(Spacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(Spacing.radiusSm),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.note,
                          size: 14,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: Spacing.xs),
                        Expanded(
                          child: Text(
                            bookmark['note'] as String,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                // Actions
                const SizedBox(height: Spacing.sm),
                Row(
                  children: [
                    _buildActionButton(
                      Icons.play_circle_outline,
                      'Play',
                      color,
                      () => Navigator.pushNamed(context, Routes.player),
                    ),
                    const SizedBox(width: Spacing.md),
                    _buildActionButton(
                      Icons.edit_outlined,
                      'Edit',
                      AppColors.textSecondary,
                      () {},
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: Colors.red.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
