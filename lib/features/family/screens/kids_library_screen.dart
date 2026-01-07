// =============================================================================
// KIDS LIBRARY SCREEN - Children's Content Library
// =============================================================================
// Kids-friendly library with:
// - Age-appropriate content
// - Fun colorful design
// - Character-based browsing
//
// DESIGN: 60% Neumorphism + 30% Solid Glow (Kid-friendly colors)
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class KidsLibraryScreen extends StatelessWidget {
  const KidsLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0FF), // Light purple background
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(context),

              // Categories
              _buildCategoriesRow(),
              const SizedBox(height: Spacing.xl),

              // Continue listening
              _buildSectionHeader('Continue Listening 📚', null),
              _buildContinueListening(),
              const SizedBox(height: Spacing.xl),

              // Popular characters
              _buildSectionHeader('Popular Characters 🌟', 'See all'),
              _buildCharactersRow(),
              const SizedBox(height: Spacing.xl),

              // New releases
              _buildSectionHeader('New Adventures 🎉', null),
              _buildNewReleases(),
              const SizedBox(height: Spacing.xxl),
            ],
          ),
        ),
      ),
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(Icons.arrow_back, color: Colors.purple),
            ),
          ),
          const SizedBox(width: Spacing.md),
          Text(
            'Kids Library',
            style: AppTypography.h3.copyWith(color: Colors.purple.shade700),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(Spacing.sm),
            decoration: BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
              boxShadow: [GlowStyles.colorGlowSubtle(Colors.amber)],
            ),
            child: Icon(Icons.star, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesRow() {
    final categories = [
      {'icon': '📖', 'label': 'Stories', 'color': Colors.pink},
      {'icon': '🎵', 'label': 'Songs', 'color': Colors.blue},
      {'icon': '🧠', 'label': 'Learning', 'color': Colors.green},
      {'icon': '🌙', 'label': 'Bedtime', 'color': Colors.indigo},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.screenHorizontal,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: Spacing.md),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: (cat['color'] as Color).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(Spacing.radiusMd),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.8),
                        blurRadius: 6,
                        offset: Offset(-3, -3),
                      ),
                      BoxShadow(
                        color: (cat['color'] as Color).withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      cat['icon'] as String,
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(height: Spacing.sm),
                Text(cat['label'] as String, style: AppTypography.labelSmall),
              ],
            ),
          );
        },
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
          Text(title, style: AppTypography.h5),
          if (action != null)
            Text(
              action,
              style: AppTypography.labelSmall.copyWith(color: Colors.purple),
            ),
        ],
      ),
    );
  }

  Widget _buildContinueListening() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Container(
        padding: const EdgeInsets.all(Spacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.yellow],
                ),
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
              ),
              child: Center(child: Text('🦁', style: TextStyle(fontSize: 40))),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('The Lion King', style: AppTypography.labelMedium),
                  Text(
                    'Chapter 3: Pride Rock',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                  const SizedBox(height: Spacing.sm),
                  LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: AppColors.border.withValues(alpha: 0.3),
                    valueColor: AlwaysStoppedAnimation(Colors.orange),
                  ),
                ],
              ),
            ),
            const SizedBox(width: Spacing.md),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
                boxShadow: [GlowStyles.colorGlowSubtle(Colors.orange)],
              ),
              child: Icon(Icons.play_arrow, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharactersRow() {
    final characters = [
      {'emoji': '🐭', 'name': 'Mickey', 'color': Colors.red},
      {'emoji': '🧸', 'name': 'Teddy', 'color': Colors.brown},
      {'emoji': '🦋', 'name': 'Fairy', 'color': Colors.pink},
      {'emoji': '🐉', 'name': 'Dragon', 'color': Colors.green},
      {'emoji': '🧙', 'name': 'Wizard', 'color': Colors.purple},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.screenHorizontal,
        ),
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final char = characters[index];
          return Container(
            width: 70,
            margin: const EdgeInsets.only(right: Spacing.md),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        (char['color'] as Color).withValues(alpha: 0.3),
                        (char['color'] as Color).withValues(alpha: 0.6),
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      GlowStyles.colorGlowSubtle(char['color'] as Color),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      char['emoji'] as String,
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ),
                const SizedBox(height: Spacing.xs),
                Text(char['name'] as String, style: AppTypography.labelSmall),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewReleases() {
    final books = [
      {'emoji': '🐘', 'title': 'Elephant Tales', 'color': Colors.grey},
      {'emoji': '🌈', 'title': 'Rainbow Magic', 'color': Colors.purple},
      {'emoji': '🚀', 'title': 'Space Adventure', 'color': Colors.blue},
    ];

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.screenHorizontal,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Container(
            width: 140,
            margin: const EdgeInsets.only(right: Spacing.md),
            child: Column(
              children: [
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        (book['color'] as Color).withValues(alpha: 0.3),
                        (book['color'] as Color).withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(Spacing.radiusMd),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.8),
                        blurRadius: 6,
                        offset: Offset(-3, -3),
                      ),
                      BoxShadow(
                        color: (book['color'] as Color).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      book['emoji'] as String,
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ),
                const SizedBox(height: Spacing.sm),
                Text(
                  book['title'] as String,
                  style: AppTypography.labelSmall,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
