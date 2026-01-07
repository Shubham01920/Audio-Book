// =============================================================================
// SOCIAL HUB SCREEN - Community & Social (Page 24)
// =============================================================================
// Social hub for book clubs, discussions, and friends.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow + 10% Flat Elements
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class SocialHubScreen extends StatelessWidget {
  const SocialHubScreen({super.key});

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
              _buildHeader(context),

              // Quick actions with glow
              _buildQuickActions(context),
              const SizedBox(height: Spacing.xl),

              // Featured Challenge with strong glow
              _buildFeaturedChallenge(context),
              const SizedBox(height: Spacing.xl),

              // Active Challenges
              _buildChallengesSection(context),
              const SizedBox(height: Spacing.xl),

              // Book Clubs
              _buildBookClubsSection(context),
              const SizedBox(height: Spacing.xl),

              // Friends Activity
              _buildFriendsActivity(context),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Community', style: AppTypography.h2),
              Text(
                '12 friends active now',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
          // Notification bell with glow
          Container(
            padding: const EdgeInsets.all(Spacing.sm),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.8),
                  blurRadius: 6,
                  offset: const Offset(-3, -3),
                ),
                BoxShadow(
                  color: AppColors.darkShadowLight.withValues(alpha: 0.15),
                  blurRadius: 6,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textPrimary,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                      boxShadow: [GlowStyles.colorGlowSubtle(AppColors.error)],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      ('Clubs', Icons.groups_outlined, AppColors.primary, '/book-clubs'),
      ('Challenges', Icons.emoji_events_outlined, Colors.amber, '/challenges'),
      ('Reviews', Icons.star_outline, AppColors.secondary, '/review/:bookId'),
      ('Friends', Icons.person_add_outlined, Colors.green, '/follow'),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions.map((action) {
          return _buildActionButton(
            context,
            action.$1,
            action.$2,
            action.$3,
            action.$4,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    String route,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Column(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.8),
                  blurRadius: 8,
                  offset: const Offset(-4, -4),
                ),
                BoxShadow(
                  color: AppColors.darkShadowLight.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(4, 4),
                ),
                // Subtle color glow
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
          ),
          const SizedBox(height: Spacing.sm),
          Text(label, style: AppTypography.labelSmall),
        ],
      ),
    );
  }

  Widget _buildFeaturedChallenge(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, '/challenges'),
        child: Container(
          padding: const EdgeInsets.all(Spacing.lg),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(Spacing.radiusLg),
            boxShadow: [GlowStyles.primaryGlow],
          ),
          child: Row(
            children: [
              // Trophy icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                ),
                child: const Icon(
                  Icons.emoji_events,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        'FEATURED',
                        style: AppTypography.overline.copyWith(
                          color: Colors.white,
                          fontSize: 9,
                        ),
                      ),
                    ),
                    const SizedBox(height: Spacing.xs),
                    Text(
                      '2024 Reading Challenge',
                      style: AppTypography.h5.copyWith(color: Colors.white),
                    ),
                    Text(
                      '26/40 books • 65% complete',
                      style: AppTypography.labelSmall.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChallengesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.screenHorizontal,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Active Challenges', style: AppTypography.h4),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/challenges'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.md,
                    vertical: Spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Spacing.radiusFull),
                  ),
                  child: Text(
                    'See All',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.md),
        SizedBox(
          height: 150,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) =>
                _buildChallengeCard(context, index),
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeCard(BuildContext context, int index) {
    final challenges = [
      ('Sci-Fi Sprint', '5 days left', 0.8, Colors.purple, Icons.rocket_launch),
      ('Horror Month', '12 days left', 0.45, Colors.red, Icons.dark_mode),
      ('Self-Growth', '3 days left', 0.9, Colors.teal, Icons.psychology),
    ];
    final challenge = challenges[index];

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/challenges'),
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: Spacing.md),
        child: NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: challenge.$4.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(Spacing.radiusSm),
                      boxShadow: [GlowStyles.colorGlowSubtle(challenge.$4)],
                    ),
                    child: Icon(challenge.$5, color: challenge.$4, size: 22),
                  ),
                  const SizedBox(width: Spacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challenge.$1,
                          style: AppTypography.labelMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          challenge.$2,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textHint,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${(challenge.$3 * 100).toInt()}%',
                    style: AppTypography.labelMedium.copyWith(
                      color: challenge.$4,
                    ),
                  ),
                  Text(
                    'Progress',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.xs),
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.border.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: challenge.$3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: challenge.$4,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [GlowStyles.colorGlowSubtle(challenge.$4)],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookClubsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.screenHorizontal,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('My Book Clubs', style: AppTypography.h4),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/book-clubs'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.md,
                    vertical: Spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Spacing.radiusFull),
                  ),
                  child: Text(
                    'See All',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.screenHorizontal,
          ),
          child: Column(
            children: [
              _buildClubCard(
                context,
                'Fiction Fanatics',
                '128 members',
                'The Great Gatsby',
                Colors.blue,
                true,
              ),
              const SizedBox(height: Spacing.md),
              _buildClubCard(
                context,
                'Tech Readers',
                '64 members',
                'Clean Code',
                Colors.green,
                false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClubCard(
    BuildContext context,
    String name,
    String members,
    String book,
    Color color,
    bool isLive,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/book-clubs'),
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
                  colors: [
                    color.withValues(alpha: 0.3),
                    color.withValues(alpha: 0.6),
                  ],
                ),
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                boxShadow: [GlowStyles.colorGlowSubtle(color)],
              ),
              child: Icon(Icons.groups, color: Colors.white, size: 26),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name, style: AppTypography.labelMedium),
                      if (isLive) ...[
                        const SizedBox(width: Spacing.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(
                              Spacing.radiusFull,
                            ),
                            boxShadow: [GlowStyles.colorGlowSubtle(Colors.red)],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Text(
                                'LIVE',
                                style: AppTypography.overline.copyWith(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    members,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                  Text(
                    'Reading: $book',
                    style: AppTypography.labelSmall.copyWith(color: color),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textHint, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendsActivity(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Friends Activity', style: AppTypography.h4),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/follow'),
                child: Text(
                  'View All',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
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
              children: [
                _buildActivityItem(
                  'Sarah',
                  'finished',
                  'Atomic Habits',
                  '2h ago',
                  Colors.green,
                ),
                Divider(
                  height: 1,
                  indent: Spacing.md + 44,
                  color: AppColors.border.withValues(alpha: 0.5),
                ),
                _buildActivityItem(
                  'Mike',
                  'started',
                  'Deep Work',
                  '5h ago',
                  Colors.blue,
                ),
                Divider(
                  height: 1,
                  indent: Spacing.md + 44,
                  color: AppColors.border.withValues(alpha: 0.5),
                ),
                _buildActivityItem(
                  'Emma',
                  'reviewed',
                  'Psychology of Money',
                  '1d ago',
                  Colors.amber,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String name,
    String action,
    String book,
    String time,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.all(Spacing.md),
      child: Row(
        children: [
          // Avatar with glow
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.3),
                  color.withValues(alpha: 0.5),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [GlowStyles.colorGlowSubtle(color)],
            ),
            child: Center(
              child: Text(
                name[0],
                style: AppTypography.h6.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: name, style: AppTypography.labelMedium),
                  TextSpan(
                    text: ' $action ',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  TextSpan(
                    text: book,
                    style: AppTypography.labelMedium.copyWith(color: color),
                  ),
                ],
              ),
            ),
          ),
          Text(
            time,
            style: AppTypography.labelSmall.copyWith(color: AppColors.textHint),
          ),
        ],
      ),
    );
  }
}
