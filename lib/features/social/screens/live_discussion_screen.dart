// =============================================================================
// LIVE DISCUSSION SCREEN - Real-time Book Discussions
// =============================================================================
// DESIGN: 60% Neumorphism + 30% Solid Glow + 10% Flat Elements
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class LiveDiscussionScreen extends StatelessWidget {
  const LiveDiscussionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildLiveNowBanner(),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(Spacing.screenHorizontal),
                children: [
                  _buildActiveRoom(
                    'The Psychology of Money',
                    'Deep dive into Chapter 5',
                    24,
                    true,
                    Colors.green,
                    'https://example.com',
                  ),
                  _buildActiveRoom(
                    'Atomic Habits Accountability',
                    'Weekly check-in session',
                    156,
                    true,
                    Colors.blue,
                    'https://example.com',
                  ),
                  _buildActiveRoom(
                    'Mystery Book Club',
                    'Spoiler-free first impressions',
                    42,
                    false,
                    Colors.purple,
                    'https://example.com',
                  ),
                  const SizedBox(height: Spacing.lg),
                  _buildUpcomingSection(context),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildStartButton(context),
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
              Text('Live Discussions', style: AppTypography.h4),
              Text(
                '3 happening now',
                style: AppTypography.labelSmall.copyWith(color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLiveNowBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.red.shade400, Colors.orange.shade400],
        ),
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        boxShadow: [GlowStyles.colorGlow(Colors.red)],
      ),
      child: Row(
        children: [
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.white, blurRadius: 10, spreadRadius: 2),
              ],
            ),
          ),
          const SizedBox(width: Spacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '222 people listening now',
                  style: AppTypography.labelMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Join the conversation!',
                  style: AppTypography.labelSmall.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.md,
              vertical: Spacing.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Spacing.radiusFull),
            ),
            child: Text(
              'Explore',
              style: AppTypography.labelSmall.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveRoom(
    String title,
    String subtitle,
    int participants,
    bool isLive,
    Color color,
    String url,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.md),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withValues(alpha: 0.4), color],
                ),
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                boxShadow: isLive ? [GlowStyles.colorGlowSubtle(color)] : null,
              ),
              child: Stack(
                children: [
                  Center(child: Icon(Icons.mic, color: Colors.white, size: 26)),
                  if (isLive)
                    Positioned(
                      top: 4,
                      right: 4,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [GlowStyles.colorGlowSubtle(Colors.red)],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 14,
                        color: AppColors.textHint,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$participants listening',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.md,
                vertical: Spacing.sm,
              ),
              decoration: BoxDecoration(
                color: isLive ? color : AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(Spacing.radiusFull),
                boxShadow: isLive
                    ? [GlowStyles.colorGlowSubtle(color)]
                    : [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.8),
                          blurRadius: 4,
                          offset: Offset(-2, -2),
                        ),
                        BoxShadow(
                          color: AppColors.darkShadowLight.withValues(
                            alpha: 0.1,
                          ),
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
              ),
              child: Text(
                isLive ? 'Join' : 'Notify',
                style: AppTypography.labelSmall.copyWith(
                  color: isLive ? Colors.white : AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingSection(BuildContext context) {
    final upcoming = [
      {
        'title': 'Author Q&A: Sarah J. Maas',
        'time': 'Tomorrow at 7:00 PM',
        'color': Colors.purple,
      },
      {
        'title': 'Fiction Friday Roundup',
        'time': 'Friday at 8:00 PM',
        'color': Colors.indigo,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'UPCOMING',
          style: AppTypography.overline.copyWith(
            color: AppColors.textHint,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: Spacing.md),
        ...upcoming.map((event) {
          final color = event['color'] as Color;
          return Padding(
            padding: const EdgeInsets.only(bottom: Spacing.sm),
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
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(Spacing.radiusSm),
                    ),
                    child: Icon(Icons.schedule, color: color),
                  ),
                  const SizedBox(width: Spacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event['title'] as String,
                          style: AppTypography.labelMedium,
                        ),
                        Text(
                          event['time'] as String,
                          style: AppTypography.labelSmall.copyWith(
                            color: color,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(Spacing.radiusSm),
                    ),
                    child: Icon(
                      Icons.notifications_none,
                      color: color,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [GlowStyles.primaryGlow]),
      child: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text('Start Discussion', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
