// =============================================================================
// WISHLIST SCREEN - Saved Books (Page 16)
// =============================================================================
// User's wishlist of books they want to purchase or listen to.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - From: Library
// - To: Book Detail, Purchase flow
// =============================================================================

import 'package:flutter/material.dart';
import 'package:ui_app/core/theme/neumorphism/neumorphic_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/neumorphic/neu_button.dart';
import '../../../shared/widgets/glow/glow_styles.dart';
import '../../../app/routes.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final Set<int> _removedItems = {};

  final List<Map<String, dynamic>> _wishlistItems = [
    {
      'title': 'Project Hail Mary',
      'author': 'Andy Weir',
      'price': 14.99,
      'color': Colors.blue,
      'rating': 4.9,
    },
    {
      'title': 'Atomic Habits',
      'author': 'James Clear',
      'price': 12.99,
      'color': Colors.purple,
      'rating': 4.8,
    },
    {
      'title': 'The Thursday Murder Club',
      'author': 'Richard Osman',
      'price': 11.99,
      'color': Colors.orange,
      'rating': 4.5,
    },
    {
      'title': 'Circe',
      'author': 'Madeline Miller',
      'price': 13.99,
      'color': Colors.teal,
      'rating': 4.7,
    },
    {
      'title': 'Educated',
      'author': 'Tara Westover',
      'price': 15.99,
      'color': Colors.pink,
      'rating': 4.6,
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
                color: Colors.pink.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                boxShadow: [GlowStyles.colorGlowSubtle(Colors.pink)],
              ),
              child: const Icon(Icons.favorite, color: Colors.pink, size: 18),
            ),
            const SizedBox(width: Spacing.sm),
            Text('My Wishlist', style: AppTypography.h3),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Summary bar
          _buildSummaryBar(),

          // Wishlist items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(Spacing.screenHorizontal),
              physics: const BouncingScrollPhysics(),
              itemCount: _wishlistItems.length,
              itemBuilder: (context, index) {
                if (_removedItems.contains(index)) {
                  return const SizedBox.shrink();
                }
                return _buildWishlistItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBar() {
    final totalPrice = _wishlistItems
        .asMap()
        .entries
        .where((e) => !_removedItems.contains(e.key))
        .map((e) => e.value['price'] as double)
        .fold(0.0, (a, b) => a + b);

    return Container(
      margin: const EdgeInsets.all(Spacing.screenHorizontal),
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.pink.withValues(alpha: 0.1),
            Colors.purple.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        boxShadow: [GlowStyles.colorGlowSubtle(Colors.pink)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_wishlistItems.length - _removedItems.length} items',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)} total',
                style: AppTypography.h4.copyWith(color: Colors.pink),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Spacing.radiusSm),
              boxShadow: [GlowStyles.colorGlow(Colors.pink, intensity: 0.35)],
            ),
            child: NeuButton(
              text: 'Buy All',
              onPressed: () {},
              variant: NeuButtonVariant.primary,
              size: NeuButtonSize.small,
              backgroundColor: Colors.pink,
              fullWidth: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistItem(int index) {
    final item = _wishlistItems[index];
    final color = item['color'] as Color;

    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.md),
      child: Dismissible(
        key: Key('wishlist_$index'),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: Spacing.lg),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
          ),
          child: const Icon(Icons.delete, color: Colors.red),
        ),
        onDismissed: (_) => setState(() => _removedItems.add(index)),
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
                  // Cover with gradient
                  Container(
                    width: 65,
                    height: 90,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          color.withValues(alpha: 0.15),
                          color.withValues(alpha: 0.3),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(Spacing.radiusSm),
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
                          item['title'],
                          style: AppTypography.labelLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: Spacing.xs),
                        Text(
                          item['author'],
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: Spacing.xs),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
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
                                    '${item['rating']}',
                                    style: AppTypography.labelSmall.copyWith(
                                      color: Colors.amber.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '\$${item['price']}',
                              style: AppTypography.labelLarge.copyWith(
                                color: color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: Spacing.md),

                  // Buy button
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Spacing.radiusSm),
                      boxShadow: [GlowStyles.colorGlowSubtle(color)],
                    ),
                    child: NeuButton(
                      text: 'Buy',
                      onPressed: () {},
                      variant: NeuButtonVariant.primary,
                      size: NeuButtonSize.small,
                      backgroundColor: color,
                      fullWidth: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
