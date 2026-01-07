// =============================================================================
// CHALLENGES SCREEN - Reading Challenges & Leaderboard
// =============================================================================
// DESIGN: 60% Neumorphism + 30% Solid Glow + 10% Flat Elements
// =============================================================================

import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

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
              _buildHeader(context),
              _buildCurrentChallenge(context),
              const SizedBox(height: Spacing.xl),
              _buildPersonalGoal(),
              const SizedBox(height: Spacing.xl),
              _buildAvailableChallenges(context),
              const SizedBox(height: Spacing.xl),
              _buildLeaderboard(),
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
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.8),
                    blurRadius: 6,
                    offset: Offset(-3, -3),
                  ),
                  BoxShadow(
                    color: AppColors.darkShadowLight.withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_back, size: 20),
            ),
          ),
          const SizedBox(width: Spacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Challenges', style: AppTypography.h3),
              Text(
                'Earn badges & rewards',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(Spacing.sm),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Spacing.radiusSm),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  color: Colors.amber,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(
                  '7',
                  style: AppTypography.labelMedium.copyWith(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentChallenge(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Container(
        padding: const EdgeInsets.all(Spacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade500, Colors.blue.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(Spacing.radiusLg),
          boxShadow: [GlowStyles.colorGlow(Colors.purple)],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(Spacing.radiusFull),
                  ),
                  child: Text(
                    'CURRENT CHALLENGE',
                    style: AppTypography.overline.copyWith(
                      color: Colors.white,
                      fontSize: 9,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  '12 days left',
                  style: AppTypography.labelSmall.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.md),
            Row(
              children: [
                // Progress Ring
                SizedBox(
                  width: 90,
                  height: 90,
                  child: CustomPaint(
                    painter: _ProgressRingPainter(
                      progress: 0.65,
                      color: Colors.white,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '65%',
                            style: AppTypography.h4.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'done',
                            style: AppTypography.labelSmall.copyWith(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Spacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '2024 Reading Goal',
                        style: AppTypography.h5.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: Spacing.sm),
                      Row(
                        children: [
                          _buildStatChip(
                            '26',
                            'books read',
                            Colors.white.withValues(alpha: 0.2),
                          ),
                          const SizedBox(width: Spacing.sm),
                          _buildStatChip(
                            '14',
                            'to go',
                            Colors.white.withValues(alpha: 0.2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String value, String label, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.sm,
        vertical: Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(Spacing.radiusSm),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTypography.labelMedium.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: AppTypography.overline.copyWith(
              color: Colors.white70,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalGoal() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.amber, Colors.orange]),
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
                boxShadow: [GlowStyles.colorGlowSubtle(Colors.amber)],
              ),
              child: Icon(Icons.flag, color: Colors.white, size: 26),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Daily Reading Goal', style: AppTypography.labelMedium),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.border.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: 0.75,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.amber, Colors.orange],
                                ),
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  GlowStyles.colorGlowSubtle(Colors.amber),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: Spacing.sm),
                      Text(
                        '45/60 min',
                        style: AppTypography.labelSmall.copyWith(
                          color: Colors.amber,
                          fontWeight: FontWeight.w600,
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

  Widget _buildAvailableChallenges(BuildContext context) {
    final challenges = [
      {
        'name': 'Genre Explorer',
        'desc': 'Read 5 different genres',
        'reward': '50 coins',
        'color': Colors.teal,
        'icon': Icons.explore,
      },
      {
        'name': 'Weekend Warrior',
        'desc': 'Read 3 books in a weekend',
        'reward': '75 coins',
        'color': Colors.indigo,
        'icon': Icons.weekend,
      },
      {
        'name': 'Early Bird',
        'desc': 'Read for 7 mornings',
        'reward': '30 coins',
        'color': Colors.orange,
        'icon': Icons.wb_sunny,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.screenHorizontal,
          ),
          child: Text(
            'AVAILABLE CHALLENGES',
            style: AppTypography.overline.copyWith(
              color: AppColors.textHint,
              letterSpacing: 1.5,
            ),
          ),
        ),
        const SizedBox(height: Spacing.md),
        ...challenges.map((c) {
          final color = c['color'] as Color;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
              vertical: Spacing.xs,
            ),
            child: NeuContainer(
              style: NeuStyle.raised,
              intensity: NeuIntensity.light,
              borderRadius: Spacing.radiusMd,
              padding: const EdgeInsets.all(Spacing.md),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color.withValues(alpha: 0.4), color],
                      ),
                      borderRadius: BorderRadius.circular(Spacing.radiusSm),
                      boxShadow: [GlowStyles.colorGlowSubtle(color)],
                    ),
                    child: Icon(
                      c['icon'] as IconData,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: Spacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c['name'] as String,
                          style: AppTypography.labelMedium,
                        ),
                        Text(
                          c['desc'] as String,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textHint,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.sm,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(
                            Spacing.radiusFull,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.monetization_on,
                              size: 12,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              c['reward'] as String,
                              style: AppTypography.overline.copyWith(
                                color: Colors.amber,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: Spacing.xs),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Spacing.md,
                          vertical: Spacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(
                            Spacing.radiusFull,
                          ),
                          boxShadow: [GlowStyles.colorGlowSubtle(color)],
                        ),
                        child: Text(
                          'Join',
                          style: AppTypography.labelSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildLeaderboard() {
    final leaders = [
      {'rank': 1, 'name': 'BookWorm_Sarah', 'books': 42, 'color': Colors.amber},
      {
        'rank': 2,
        'name': 'ReadingMaster',
        'books': 38,
        'color': Colors.grey.shade400,
      },
      {
        'rank': 3,
        'name': 'PageTurner99',
        'books': 35,
        'color': Colors.brown.shade300,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LEADERBOARD',
                style: AppTypography.overline.copyWith(
                  color: AppColors.textHint,
                  letterSpacing: 1.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Spacing.radiusFull),
                ),
                child: Text(
                  'View All',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.md),
          NeuContainer(
            style: NeuStyle.raised,
            intensity: NeuIntensity.light,
            borderRadius: Spacing.radiusMd,
            padding: EdgeInsets.zero,
            child: Column(
              children: leaders.asMap().entries.map((entry) {
                final l = entry.value;
                final isLast = entry.key == leaders.length - 1;
                final color = l['color'] as Color;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Spacing.md),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              boxShadow: l['rank'] == 1
                                  ? [GlowStyles.colorGlowSubtle(Colors.amber)]
                                  : null,
                            ),
                            child: Center(
                              child: Text(
                                '${l['rank']}',
                                style: AppTypography.labelMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: Spacing.md),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              color: AppColors.primary,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: Spacing.sm),
                          Expanded(
                            child: Text(
                              l['name'] as String,
                              style: AppTypography.labelMedium,
                            ),
                          ),
                          Text(
                            '${l['books']} books',
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
                        indent: Spacing.md,
                        endIndent: Spacing.md,
                        color: AppColors.border.withValues(alpha: 0.5),
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
}

class _ProgressRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  _ProgressRingPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;
    const strokeWidth = 10.0;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
