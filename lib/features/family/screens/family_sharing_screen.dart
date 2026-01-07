// =============================================================================
// FAMILY SHARING SCREEN - Family Account Management
// =============================================================================
// Family sharing hub with:
// - Family members list
// - Add/remove members
// - Sharing settings
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

class FamilySharingScreen extends StatelessWidget {
  const FamilySharingScreen({super.key});

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
                    Text('Family Sharing', style: AppTypography.h4),
                  ],
                ),
              ),

              // Family plan info
              _buildFamilyPlanCard(),
              const SizedBox(height: Spacing.xl),

              // Family members
              _buildSectionHeader('FAMILY MEMBERS (3/6)'),
              _buildMembersList(),
              const SizedBox(height: Spacing.md),
              _buildAddMemberButton(),
              const SizedBox(height: Spacing.xl),

              // Sharing settings
              _buildSectionHeader('SHARING SETTINGS'),
              _buildSharingSettings(),
              const SizedBox(height: Spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFamilyPlanCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.pink],
                    ),
                    borderRadius: BorderRadius.circular(Spacing.radiusMd),
                    boxShadow: [GlowStyles.colorGlowSubtle(Colors.purple)],
                  ),
                  child: Icon(
                    Icons.family_restroom,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Family Premium', style: AppTypography.h5),
                      Text(
                        'Up to 6 members',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.md,
                    vertical: Spacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(Spacing.radiusFull),
                  ),
                  child: Text(
                    'Active',
                    style: AppTypography.labelSmall.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.lg),
            Container(
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 18, color: AppColors.primary),
                  const SizedBox(width: Spacing.sm),
                  Expanded(
                    child: Text(
                      'Share your subscription with up to 5 family members at no extra cost.',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
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

  Widget _buildMembersList() {
    final members = [
      {
        'name': 'You (Owner)',
        'email': 'you@email.com',
        'isOwner': true,
        'isKid': false,
      },
      {
        'name': 'Sarah',
        'email': 'sarah@email.com',
        'isOwner': false,
        'isKid': false,
      },
      {
        'name': 'Tommy',
        'email': 'tommy@email.com',
        'isOwner': false,
        'isKid': true,
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
          children: members.asMap().entries.map((entry) {
            final member = entry.value;
            final isLast = entry.key == members.length - 1;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Spacing.md),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: (member['isKid'] as bool)
                            ? Colors.orange.withValues(alpha: 0.2)
                            : AppColors.primary.withValues(alpha: 0.2),
                        child: Icon(
                          (member['isKid'] as bool)
                              ? Icons.child_care
                              : Icons.person,
                          color: (member['isKid'] as bool)
                              ? Colors.orange
                              : AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: Spacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  member['name'] as String,
                                  style: AppTypography.labelMedium,
                                ),
                                if (member['isKid'] as bool) ...[
                                  const SizedBox(width: Spacing.xs),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withValues(
                                        alpha: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Kid',
                                      style: AppTypography.overline.copyWith(
                                        color: Colors.orange,
                                        fontSize: 9,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              member['email'] as String,
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textHint,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!(member['isOwner'] as bool))
                        Icon(
                          Icons.more_vert,
                          color: AppColors.textHint,
                          size: 20,
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

  Widget _buildAddMemberButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: GestureDetector(
        onTap: () {},
        child: NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: Spacing.md),
              Text(
                'Add Family Member',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSharingSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            _buildSettingTile(
              'Share Library',
              'Allow family to access shared books',
              true,
            ),
            Divider(
              height: 1,
              indent: Spacing.md,
              endIndent: Spacing.md,
              color: AppColors.border.withValues(alpha: 0.5),
            ),
            _buildSettingTile(
              'Shared Purchases',
              'Share new purchases automatically',
              true,
            ),
            Divider(
              height: 1,
              indent: Spacing.md,
              endIndent: Spacing.md,
              color: AppColors.border.withValues(alpha: 0.5),
            ),
            _buildSettingTile(
              'Ask to Buy',
              'Approve kids\' purchase requests',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile(String title, String subtitle, bool value) {
    return Padding(
      padding: const EdgeInsets.all(Spacing.md),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.labelMedium),
                Text(
                  subtitle,
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (_) {},
            activeColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }
}
