// =============================================================================
// NARRATOR DETAIL SCREEN - Author/Narrator Profile (Page 23)
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

class NarratorDetailScreen extends StatelessWidget {
  final String? narratorId;

  const NarratorDetailScreen({super.key, this.narratorId});

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
              _buildProfileCard(),
              const SizedBox(height: Spacing.xl),
              _buildStatsRow(),
              const SizedBox(height: Spacing.xl),
              _buildBioSection(),
              const SizedBox(height: Spacing.xl),
              _buildAwardsSection(),
              const SizedBox(height: Spacing.xl),
              _buildNarrationStyleSection(),
              const SizedBox(height: Spacing.xl),
              _buildAudiobooksSection(context),
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
          Text('Narrator', style: AppTypography.h4),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(Spacing.sm),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Spacing.radiusSm),
            ),
            child: Icon(Icons.share, color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusLg,
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          children: [
            // Avatar with glow
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.4),
                    AppColors.secondary.withValues(alpha: 0.6),
                  ],
                ),
                shape: BoxShape.circle,
                boxShadow: [GlowStyles.primaryGlow],
              ),
              child: Center(
                child: Text(
                  'SJ',
                  style: AppTypography.h2.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: Spacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Stephen Fry', style: AppTypography.h4),
                const SizedBox(width: Spacing.xs),
                Icon(Icons.verified, color: AppColors.primary, size: 18),
              ],
            ),
            const SizedBox(height: Spacing.xs),
            Text(
              'Professional Narrator & Actor',
              style: AppTypography.labelSmall.copyWith(
                color: AppColors.textHint,
              ),
            ),
            const SizedBox(height: Spacing.lg),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: Spacing.sm),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                      ),
                      borderRadius: BorderRadius.circular(Spacing.radiusMd),
                      boxShadow: [GlowStyles.primaryGlowSubtle],
                    ),
                    child: Center(
                      child: Text(
                        'Follow',
                        style: AppTypography.buttonMedium.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Spacing.md),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(Spacing.radiusSm),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.8),
                        blurRadius: 4,
                        offset: Offset(-2, -2),
                      ),
                      BoxShadow(
                        color: AppColors.darkShadowLight.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.play_circle_outline,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Row(
        children: [
          _buildStatCard('156', 'Audiobooks', Colors.blue, Icons.headphones),
          const SizedBox(width: Spacing.md),
          _buildStatCard('4.9', 'Avg Rating', Colors.amber, Icons.star),
          const SizedBox(width: Spacing.md),
          _buildStatCard('2.1M', 'Listeners', Colors.green, Icons.people),
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
    return Expanded(
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
                boxShadow: [GlowStyles.colorGlowSubtle(color)],
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: Spacing.sm),
            Text(value, style: AppTypography.h5),
            Text(
              label,
              style: AppTypography.overline.copyWith(
                color: AppColors.textHint,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBioSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ABOUT',
            style: AppTypography.overline.copyWith(
              color: AppColors.textHint,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: Spacing.md),
          NeuContainer(
            style: NeuStyle.raised,
            intensity: NeuIntensity.light,
            borderRadius: Spacing.radiusMd,
            padding: const EdgeInsets.all(Spacing.md),
            child: Text(
              'Stephen Fry is an acclaimed British actor, writer, and narrator known for his distinctive voice and engaging storytelling. '
              'He has narrated the complete Harry Potter audiobook series, winning multiple awards for his performances.\n\n'
              'With over 30 years of experience in voice work, Stephen brings characters to life with his versatile range and impeccable comedic timing.',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAwardsSection() {
    final awards = [
      {'name': 'Audie Award', 'year': '2019', 'color': Colors.amber},
      {'name': 'Grammy Nominee', 'year': '2018', 'color': Colors.purple},
      {'name': 'AudioFile Earphones', 'year': '2020', 'color': Colors.blue},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AWARDS',
            style: AppTypography.overline.copyWith(
              color: AppColors.textHint,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: Spacing.md),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: awards.length,
              itemBuilder: (context, index) {
                final award = awards[index];
                final color = award['color'] as Color;
                return Container(
                  width: 130,
                  margin: EdgeInsets.only(right: Spacing.md),
                  child: NeuContainer(
                    style: NeuStyle.raised,
                    intensity: NeuIntensity.light,
                    borderRadius: Spacing.radiusMd,
                    padding: const EdgeInsets.all(Spacing.sm),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                            boxShadow: [GlowStyles.colorGlowSubtle(color)],
                          ),
                          child: Icon(
                            Icons.emoji_events,
                            color: color,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: Spacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                award['name'] as String,
                                style: AppTypography.labelSmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                award['year'] as String,
                                style: AppTypography.overline.copyWith(
                                  color: AppColors.textHint,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrationStyleSection() {
    final styles = [
      'Warm',
      'Expressive',
      'British Accent',
      'Comedic',
      'Dramatic',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NARRATION STYLE',
            style: AppTypography.overline.copyWith(
              color: AppColors.textHint,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: Spacing.md),
          Wrap(
            spacing: Spacing.sm,
            runSpacing: Spacing.sm,
            children: styles.map((style) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(Spacing.radiusFull),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.8),
                      blurRadius: 4,
                      offset: Offset(-2, -2),
                    ),
                    BoxShadow(
                      color: AppColors.darkShadowLight.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Text(
                  style,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAudiobooksSection(BuildContext context) {
    final books = [
      {
        'title': 'Harry Potter Series',
        'duration': '117 hrs',
        'rating': 4.9,
        'color': Colors.purple,
      },
      {
        'title': 'Mythos',
        'duration': '15 hrs',
        'rating': 4.8,
        'color': Colors.blue,
      },
      {
        'title': 'Heroes',
        'duration': '12 hrs',
        'rating': 4.7,
        'color': Colors.teal,
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
                'AUDIOBOOKS',
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
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Spacing.radiusFull),
                ),
                child: Text(
                  'See All 156',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.md),
          ...books.map((book) {
            final color = book['color'] as Color;
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
                      width: 60,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color.withValues(alpha: 0.4), color],
                        ),
                        borderRadius: BorderRadius.circular(Spacing.radiusSm),
                        boxShadow: [GlowStyles.colorGlowSubtle(color)],
                      ),
                      child: Icon(Icons.book, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: Spacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book['title'] as String,
                            style: AppTypography.labelMedium,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 14,
                                color: AppColors.textHint,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                book['duration'] as String,
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.textHint,
                                ),
                              ),
                              const SizedBox(width: Spacing.md),
                              Icon(Icons.star, size: 14, color: Colors.amber),
                              const SizedBox(width: 2),
                              Text(
                                '${book['rating']}',
                                style: AppTypography.labelSmall.copyWith(
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        boxShadow: [GlowStyles.colorGlowSubtle(color)],
                      ),
                      child: Icon(Icons.play_arrow, color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
