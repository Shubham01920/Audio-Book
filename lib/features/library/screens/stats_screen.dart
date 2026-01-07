// =============================================================================
// STATS SCREEN - Reading Statistics (Page 15)
// =============================================================================
// User's listening statistics with visual charts and achievements.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - From: Library
// - To: Detailed stats, Achievements
// =============================================================================

import 'package:flutter/material.dart';
import 'package:ui_app/core/theme/neumorphism/neumorphic_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

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
                color: Colors.purple.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                boxShadow: [GlowStyles.colorGlowSubtle(Colors.purple)],
              ),
              child: const Icon(
                Icons.bar_chart,
                color: Colors.purple,
                size: 18,
              ),
            ),
            const SizedBox(width: Spacing.sm),
            Text('Reading Stats', style: AppTypography.h3),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.screenHorizontal),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Summary Cards Row 1
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Books Read',
                    '12',
                    Icons.menu_book,
                    Colors.blue,
                  ),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: _buildStatCard(
                    'Total Hours',
                    '48.5',
                    Icons.timer,
                    Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.md),

            // Summary Cards Row 2
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Day Streak',
                    '🔥 5',
                    Icons.local_fire_department,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: _buildStatCard(
                    'Avg. Session',
                    '45m',
                    Icons.access_time,
                    Colors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.xl),

            // Weekly Activity Chart
            _buildWeeklyChart(),
            const SizedBox(height: Spacing.xl),

            // Top Genres
            _buildTopGenres(),
            const SizedBox(height: Spacing.xl),

            // Recent Achievements
            _buildAchievements(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
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
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: Spacing.sm),
            Text(value, style: AppTypography.h3.copyWith(color: color)),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyChart() {
    final dayData = [
      {'day': 'Mon', 'hours': 1.5, 'color': Colors.blue},
      {'day': 'Tue', 'hours': 2.0, 'color': Colors.blue},
      {'day': 'Wed', 'hours': 0.5, 'color': Colors.blue},
      {'day': 'Thu', 'hours': 2.5, 'color': Colors.blue},
      {'day': 'Fri', 'hours': 1.0, 'color': Colors.blue},
      {'day': 'Sat', 'hours': 3.0, 'color': AppColors.primary},
      {'day': 'Sun', 'hours': 2.0, 'color': AppColors.primary},
    ];
    final maxHours = 3.5;

    return NeuContainer(
      style: NeuStyle.raised,
      intensity: NeuIntensity.light,
      borderRadius: Spacing.radiusLg,
      padding: const EdgeInsets.all(Spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Weekly Activity', style: AppTypography.h4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(Spacing.radiusFull),
                ),
                child: Text(
                  '+15% vs last week',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.lg),

          // Bar chart
          SizedBox(
            height: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: dayData.map((data) {
                final height = (data['hours'] as double) / maxHours * 100;
                final isWeekend = data['day'] == 'Sat' || data['day'] == 'Sun';
                final color = isWeekend ? AppColors.primary : Colors.blue;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${data['hours']}h',
                      style: AppTypography.labelSmall.copyWith(
                        color: color,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 28,
                      height: height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [color, color.withValues(alpha: 0.6)],
                        ),
                        borderRadius: BorderRadius.circular(Spacing.radiusSm),
                        boxShadow: isWeekend
                            ? [GlowStyles.colorGlowSubtle(color)]
                            : null,
                      ),
                    ),
                    const SizedBox(height: Spacing.sm),
                    Text(
                      data['day'] as String,
                      style: AppTypography.labelSmall.copyWith(
                        color: isWeekend ? color : AppColors.textSecondary,
                        fontWeight: isWeekend
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopGenres() {
    final genres = [
      {'name': 'Self-Help', 'percent': 0.35, 'color': Colors.purple},
      {'name': 'Fiction', 'percent': 0.25, 'color': Colors.blue},
      {'name': 'Business', 'percent': 0.20, 'color': Colors.teal},
      {'name': 'Sci-Fi', 'percent': 0.20, 'color': Colors.orange},
    ];

    return NeuContainer(
      style: NeuStyle.raised,
      intensity: NeuIntensity.light,
      borderRadius: Spacing.radiusLg,
      padding: const EdgeInsets.all(Spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Top Genres', style: AppTypography.h4),
          const SizedBox(height: Spacing.md),
          ...genres.map((genre) {
            final color = genre['color'] as Color;
            final percent = genre['percent'] as double;
            return Padding(
              padding: const EdgeInsets.only(bottom: Spacing.sm),
              child: Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      genre['name'] as String,
                      style: AppTypography.labelMedium,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: percent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [GlowStyles.colorGlowSubtle(color)],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: Spacing.sm),
                  Text(
                    '${(percent * 100).toInt()}%',
                    style: AppTypography.labelSmall.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAchievements() {
    final achievements = [
      {
        'icon': '🔥',
        'name': 'Week Streak',
        'desc': '7 days in a row',
        'unlocked': true,
      },
      {
        'icon': '📚',
        'name': 'Bookworm',
        'desc': 'Read 10 books',
        'unlocked': true,
      },
      {
        'icon': '⏱️',
        'name': 'Marathon',
        'desc': 'Listen 5h in one day',
        'unlocked': false,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Achievements', style: AppTypography.h4),
        const SizedBox(height: Spacing.md),
        Row(
          children: achievements.map((ach) {
            final unlocked = ach['unlocked'] as bool;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  right: ach != achievements.last ? Spacing.sm : 0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  boxShadow: unlocked
                      ? [GlowStyles.colorGlowSubtle(Colors.amber)]
                      : null,
                ),
                child: NeuContainer(
                  style: unlocked ? NeuStyle.raised : NeuStyle.flat,
                  intensity: NeuIntensity.light,
                  borderRadius: Spacing.radiusMd,
                  padding: const EdgeInsets.all(Spacing.md),
                  child: Column(
                    children: [
                      Text(
                        ach['icon'] as String,
                        style: TextStyle(
                          fontSize: 28,
                          color: unlocked ? null : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: Spacing.xs),
                      Text(
                        ach['name'] as String,
                        style: AppTypography.labelSmall.copyWith(
                          fontWeight: FontWeight.w600,
                          color: unlocked
                              ? AppColors.textPrimary
                              : AppColors.textHint,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        ach['desc'] as String,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
