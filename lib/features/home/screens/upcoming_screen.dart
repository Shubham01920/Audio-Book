// =============================================================================
// UPCOMING SCREEN - Pre-Order & Countdown (Page 9)
// =============================================================================
// Showcase for upcoming releases with countdown timers and pre-order options.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - From: Home, Discover
// - To: Book Detail
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

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  final Set<int> _notified = {};

  final List<Map<String, dynamic>> _upcomingBooks = [
    {
      'title': 'The Winds of Winter',
      'author': 'George R.R. Martin',
      'daysLeft': 12,
      'month': 'JAN',
      'day': '15',
      'color': Colors.blueGrey,
      'preOrders': '45.2k',
    },
    {
      'title': 'Project Hail Mary 2',
      'author': 'Andy Weir',
      'daysLeft': 25,
      'month': 'JAN',
      'day': '28',
      'color': Colors.indigo,
      'preOrders': '32.1k',
    },
    {
      'title': 'Atomic Habits 2.0',
      'author': 'James Clear',
      'daysLeft': 45,
      'month': 'FEB',
      'day': '18',
      'color': Colors.purple,
      'preOrders': '28.7k',
    },
    {
      'title': 'The Last of Us: Origins',
      'author': 'Neil Druckmann',
      'daysLeft': 60,
      'month': 'MAR',
      'day': '05',
      'color': Colors.green,
      'preOrders': '18.3k',
    },
    {
      'title': 'Deep Work 2',
      'author': 'Cal Newport',
      'daysLeft': 75,
      'month': 'MAR',
      'day': '20',
      'color': Colors.orange,
      'preOrders': '15.9k',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Coming Soon', style: AppTypography.h3),
            const SizedBox(width: Spacing.sm),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Text('🔥', style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            color: AppColors.textSecondary,
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(Spacing.screenHorizontal),
        physics: const BouncingScrollPhysics(),
        itemCount: _upcomingBooks.length,
        itemBuilder: (context, index) {
          return _buildUpcomingCard(context, _upcomingBooks[index], index);
        },
      ),
    );
  }

  Widget _buildUpcomingCard(
    BuildContext context,
    Map<String, dynamic> book,
    int index,
  ) {
    final color = book['color'] as Color;
    final isNotified = _notified.contains(index);

    return Container(
      margin: const EdgeInsets.only(bottom: Spacing.lg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.radiusLg),
        boxShadow: isNotified ? [GlowStyles.colorGlowSubtle(color)] : null,
      ),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusLg,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner with countdown
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(Spacing.radiusLg),
              ),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withValues(alpha: 0.3),
                      color.withValues(alpha: 0.15),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // Decorative icon
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Icon(
                        Icons.auto_stories,
                        size: 120,
                        color: color.withValues(alpha: 0.15),
                      ),
                    ),

                    // Countdown badge
                    Positioned(
                      top: Spacing.md,
                      left: Spacing.md,
                      child: _buildCountdownBadge(book['daysLeft'], color),
                    ),

                    // Pre-order count
                    Positioned(
                      bottom: Spacing.md,
                      right: Spacing.md,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.sm,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(Spacing.radiusSm),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.people,
                              size: 14,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${book['preOrders']} pre-orders',
                              style: AppTypography.labelSmall.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Info section
            Padding(
              padding: const EdgeInsets.all(Spacing.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date box with glow
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Spacing.radiusMd),
                      boxShadow: [GlowStyles.colorGlowSubtle(color)],
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.md,
                        vertical: Spacing.sm,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(Spacing.radiusMd),
                        border: Border.all(color: color.withValues(alpha: 0.3)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            book['month'],
                            style: AppTypography.caption.copyWith(
                              color: color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            book['day'],
                            style: AppTypography.h3.copyWith(color: color),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: Spacing.md),

                  // Book info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book['title'], style: AppTypography.h5),
                        const SizedBox(height: 4),
                        Text(
                          book['author'],
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: Spacing.md),

                        // Action buttons
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Spacing.radiusSm,
                                  ),
                                  boxShadow: [
                                    GlowStyles.colorGlowSubtle(color),
                                  ],
                                ),
                                child: NeuButton(
                                  text: 'Pre-Order',
                                  onPressed: () => Navigator.pushNamed(
                                    context,
                                    Routes.bookDetail,
                                  ),
                                  variant: NeuButtonVariant.primary,
                                  size: NeuButtonSize.small,
                                  backgroundColor: color,
                                ),
                              ),
                            ),
                            const SizedBox(width: Spacing.sm),

                            // Notify button
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isNotified) {
                                    _notified.remove(index);
                                  } else {
                                    _notified.add(index);
                                  }
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isNotified
                                      ? color.withValues(alpha: 0.15)
                                      : AppColors.backgroundLight,
                                  borderRadius: BorderRadius.circular(
                                    Spacing.radiusSm,
                                  ),
                                  border: Border.all(
                                    color: isNotified
                                        ? color
                                        : AppColors.border,
                                  ),
                                  boxShadow: isNotified
                                      ? [GlowStyles.colorGlowSubtle(color)]
                                      : null,
                                ),
                                child: Icon(
                                  isNotified
                                      ? Icons.notifications_active
                                      : Icons.notifications_none,
                                  color: isNotified
                                      ? color
                                      : AppColors.textSecondary,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountdownBadge(int daysLeft, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.sm,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        boxShadow: [
          GlowStyles.colorGlow(color, intensity: 0.3),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer, size: 18, color: color),
          const SizedBox(width: 6),
          Text(
            '$daysLeft days left',
            style: AppTypography.labelMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
