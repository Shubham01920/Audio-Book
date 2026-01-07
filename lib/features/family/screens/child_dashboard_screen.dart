// =============================================================================
// CHILD DASHBOARD SCREEN - Child Activity Dashboard
// =============================================================================
// Parent view of child's activity with:
// - Listening stats
// - Recent activity
// - Achievements
// - Content history
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

class ChildDashboardScreen extends StatelessWidget {
  const ChildDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(Spacing.screenHorizontal),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: Spacing.md),
                    Text('Tommy\'s Activity', style: AppTypography.h4),
                    const Spacer(),
                    Icon(Icons.settings_outlined, color: AppColors.textHint),
                  ],
                ),
              ),

              // Child profile card
              _buildProfileCard(),
              const SizedBox(height: Spacing.xl),

              // Weekly stats
              _buildSectionHeader('THIS WEEK'),
              _buildWeeklyStats(),
              const SizedBox(height: Spacing.xl),

              // Achievements
              _buildSectionHeader('ACHIEVEMENTS'),
              _buildAchievements(),
              const SizedBox(height: Spacing.xl),

              // Recent activity
              _buildSectionHeader('RECENT ACTIVITY'),
              _buildRecentActivity(),
              const SizedBox(height: Spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.lg),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.orange, Colors.amber]),
                shape: BoxShape.circle,
                boxShadow: [GlowStyles.colorGlowSubtle(Colors.orange)],
              ),
              child: Center(child: Text('🦁', style: TextStyle(fontSize: 35))),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Tommy', style: AppTypography.h5),
                      const SizedBox(width: Spacing.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(
                            Spacing.radiusFull,
                          ),
                        ),
                        child: Text(
                          'Age 7',
                          style: AppTypography.overline.copyWith(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '12 books completed',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        'Level 5 Explorer',
                        style: AppTypography.labelSmall.copyWith(
                          color: Colors.amber,
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
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.screenHorizontal,
        vertical: Spacing.sm,
      ),
      child: Text(
        title,
        style: AppTypography.overline.copyWith(
          color: AppColors.textHint,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildWeeklyStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              '5h 30m',
              'Listening Time',
              Colors.blue,
              Icons.headphones,
            ),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: _buildStatCard(
              '3',
              'Books Finished',
              Colors.green,
              Icons.menu_book,
            ),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: _buildStatCard(
              '7',
              'Day Streak',
              Colors.orange,
              Icons.local_fire_department,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String value,
    String label,
    Color color,
    IconData icon,
  ) {
    return NeuContainer(
      style: NeuStyle.raised,
      intensity: NeuIntensity.light,
      borderRadius: Spacing.radiusMd,
      padding: const EdgeInsets.all(Spacing.md),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Spacing.radiusSm),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: Spacing.sm),
          Text(value, style: AppTypography.h5),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textHint,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    final achievements = [
      {'emoji': '🌟', 'name': 'First Book', 'unlocked': true},
      {'emoji': '📚', 'name': '5 Books', 'unlocked': true},
      {'emoji': '🔥', 'name': '7 Day Streak', 'unlocked': true},
      {'emoji': '🏆', 'name': '10 Books', 'unlocked': false},
      {'emoji': '👑', 'name': 'Master Reader', 'unlocked': false},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.screenHorizontal,
        ),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final ach = achievements[index];
          final unlocked = ach['unlocked'] as bool;
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: Spacing.md),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: unlocked
                        ? Colors.amber.withValues(alpha: 0.2)
                        : AppColors.border.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    boxShadow: unlocked
                        ? [GlowStyles.colorGlowSubtle(Colors.amber)]
                        : null,
                  ),
                  child: Center(
                    child: unlocked
                        ? Text(
                            ach['emoji'] as String,
                            style: TextStyle(fontSize: 28),
                          )
                        : Icon(Icons.lock_outline, color: AppColors.textHint),
                  ),
                ),
                const SizedBox(height: Spacing.xs),
                Text(
                  ach['name'] as String,
                  style: AppTypography.labelSmall.copyWith(
                    color: unlocked
                        ? AppColors.textPrimary
                        : AppColors.textHint,
                    fontSize: 10,
                  ),
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

  Widget _buildRecentActivity() {
    final activities = [
      {
        'book': 'The Lion King',
        'action': 'Listened to Chapter 3',
        'time': '2 hours ago',
        'emoji': '🦁',
      },
      {
        'book': 'Space Adventure',
        'action': 'Started new book',
        'time': 'Yesterday',
        'emoji': '🚀',
      },
      {
        'book': 'Teddy Bear Tales',
        'action': 'Completed',
        'time': '2 days ago',
        'emoji': '🧸',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: EdgeInsets.zero,
        child: Column(
          children: activities.asMap().entries.map((entry) {
            final activity = entry.value;
            final isLast = entry.key == activities.length - 1;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Spacing.md),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(Spacing.radiusSm),
                        ),
                        child: Center(
                          child: Text(
                            activity['emoji']!,
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      const SizedBox(width: Spacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity['book']!,
                              style: AppTypography.labelMedium,
                            ),
                            Text(
                              activity['action']!,
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textHint,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        activity['time']!,
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Divider(
                    height: 1,
                    indent: Spacing.md + 44 + Spacing.md,
                    color: AppColors.border.withValues(alpha: 0.5),
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
