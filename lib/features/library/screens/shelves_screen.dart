// =============================================================================
// SHELVES SCREEN - Custom Collections (Page 18)
// =============================================================================
// User's custom book shelves/collections for organization.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - From: Library
// - To: Shelf Detail, Book Detail
// =============================================================================

import 'package:flutter/material.dart';
import 'package:ui_app/core/theme/neumorphism/neumorphic_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class ShelvesScreen extends StatelessWidget {
  const ShelvesScreen({super.key});

  final List<Map<String, dynamic>> _shelves = const [
    {
      'name': 'Currently Reading',
      'count': 3,
      'icon': Icons.menu_book,
      'color': Colors.blue,
    },
    {
      'name': 'Want to Read',
      'count': 12,
      'icon': Icons.bookmark_border,
      'color': Colors.orange,
    },
    {
      'name': 'Favorites',
      'count': 8,
      'icon': Icons.favorite,
      'color': Colors.pink,
    },
    {
      'name': 'Completed',
      'count': 24,
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'name': 'Business',
      'count': 6,
      'icon': Icons.business,
      'color': Colors.purple,
    },
    {
      'name': 'Fiction',
      'count': 9,
      'icon': Icons.auto_stories,
      'color': Colors.teal,
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
                color: Colors.amber.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                boxShadow: [GlowStyles.colorGlowSubtle(Colors.amber)],
              ),
              child: const Icon(
                Icons.collections_bookmark,
                color: Colors.amber,
                size: 18,
              ),
            ),
            const SizedBox(width: Spacing.sm),
            Text('My Shelves', style: AppTypography.h3),
          ],
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => _showCreateShelfDialog(context),
            child: Container(
              margin: const EdgeInsets.all(Spacing.sm),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
                boxShadow: [GlowStyles.primaryGlowSubtle],
              ),
              child: NeuContainer(
                style: NeuStyle.raised,
                intensity: NeuIntensity.light,
                borderRadius: Spacing.radiusSm,
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.sm,
                  vertical: Spacing.xs,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.add, color: AppColors.primary, size: 18),
                    const SizedBox(width: 2),
                    Text(
                      'New',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(Spacing.screenHorizontal),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: Spacing.md,
          mainAxisSpacing: Spacing.md,
          childAspectRatio: 0.95,
        ),
        itemCount: _shelves.length,
        itemBuilder: (context, index) => _buildShelfCard(_shelves[index]),
      ),
    );
  }

  Widget _buildShelfCard(Map<String, dynamic> shelf) {
    final color = shelf['color'] as Color;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.radiusLg),
        boxShadow: [GlowStyles.colorGlowSubtle(color)],
      ),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusLg,
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with glow
            Container(
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withValues(alpha: 0.15),
                    color.withValues(alpha: 0.3),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [GlowStyles.colorGlow(color, intensity: 0.3)],
              ),
              child: Icon(shelf['icon'] as IconData, size: 32, color: color),
            ),
            const SizedBox(height: Spacing.md),

            // Name
            Text(
              shelf['name'] as String,
              style: AppTypography.labelLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.xs),

            // Count badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.sm,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(Spacing.radiusFull),
              ),
              child: Text(
                '${shelf['count']} Books',
                style: AppTypography.labelSmall.copyWith(
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateShelfDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusLg),
        ),
        title: Text('Create New Shelf', style: AppTypography.h4),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Shelf name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
              ),
            ),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
