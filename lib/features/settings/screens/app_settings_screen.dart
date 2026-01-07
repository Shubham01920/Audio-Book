// =============================================================================
// APP SETTINGS SCREEN - Main Settings Hub
// =============================================================================
// Central settings screen with navigation to all settings categories:
// - Account settings
// - Playback settings
// - Display & Theme
// - Notifications
// - Privacy & Data
// - Accessibility
// - Language & Region
// - Storage & Downloads
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

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

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
                    Text('Settings', style: AppTypography.h3),
                  ],
                ),
              ),

              // Settings categories
              _buildSection(context, 'Account', [
                _SettingItem(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  subtitle: 'Name, email, avatar',
                  color: Colors.blue,
                  route: '/profile/edit',
                ),
                _SettingItem(
                  icon: Icons.subscriptions_outlined,
                  title: 'Subscription',
                  subtitle: 'Premium Plan - Active',
                  color: Colors.amber,
                  route: '/subscription',
                ),
              ]),

              _buildSection(context, 'Kids & Family', [
                _SettingItem(
                  icon: Icons.family_restroom,
                  title: 'Family Sharing',
                  subtitle: 'Manage family members',
                  color: Colors.purple,
                  route: '/family',
                ),
                _SettingItem(
                  icon: Icons.child_care,
                  title: 'Kids Mode',
                  subtitle: 'Parental controls & limits',
                  color: Colors.orange,
                  route: '/kids-mode',
                ),
                _SettingItem(
                  icon: Icons.auto_stories,
                  title: 'Kids Library',
                  subtitle: 'Age-appropriate content',
                  color: Colors.pink,
                  route: '/kids-library',
                ),
              ]),

              _buildSection(context, 'Playback', [
                _SettingItem(
                  icon: Icons.speed,
                  title: 'Playback Settings',
                  subtitle: 'Speed, skip intervals',
                  color: Colors.teal,
                  route: '/settings/playback',
                ),
                _SettingItem(
                  icon: Icons.equalizer,
                  title: 'Audio Quality',
                  subtitle: 'High (320kbps)',
                  color: Colors.green,
                  route: '/settings/playback',
                ),
                _SettingItem(
                  icon: Icons.download_outlined,
                  title: 'Downloads',
                  subtitle: 'Wi-Fi only, audio quality',
                  color: Colors.indigo,
                  route: '/settings/storage',
                ),
              ]),

              _buildSection(context, 'Appearance', [
                _SettingItem(
                  icon: Icons.palette_outlined,
                  title: 'Display & Theme',
                  subtitle: 'Light mode',
                  color: Colors.pink,
                  route: '/settings/display',
                ),
                _SettingItem(
                  icon: Icons.language,
                  title: 'Language & Region',
                  subtitle: 'English (US)',
                  color: Colors.cyan,
                  route: '/settings/language',
                ),
              ]),

              _buildSection(context, 'Privacy & Security', [
                _SettingItem(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: 'Push, email, in-app',
                  color: Colors.orange,
                  route: '/settings/notifications',
                ),
                _SettingItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy & Data',
                  subtitle: 'Data sharing, history',
                  color: Colors.red,
                  route: '/settings/privacy',
                ),
                _SettingItem(
                  icon: Icons.accessibility_new,
                  title: 'Accessibility',
                  subtitle: 'Text size, contrast',
                  color: Colors.deepPurple,
                  route: '/settings/accessibility',
                ),
              ]),

              _buildSection(context, 'Storage', [
                _SettingItem(
                  icon: Icons.storage_outlined,
                  title: 'Data & Storage',
                  subtitle: '2.4 GB used',
                  color: Colors.blueGrey,
                  route: '/settings/storage',
                ),
                _SettingItem(
                  icon: Icons.cleaning_services_outlined,
                  title: 'Clear Cache',
                  subtitle: '156 MB',
                  color: Colors.brown,
                  route: '/settings/storage',
                ),
              ]),

              // App info
              _buildAppInfo(),
              const SizedBox(height: Spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<_SettingItem> items,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Spacing.lg),
          Text(
            title.toUpperCase(),
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
            padding: EdgeInsets.zero,
            child: Column(
              children: items.asMap().entries.map((entry) {
                final isLast = entry.key == items.length - 1;
                return _buildSettingTile(
                  context,
                  entry.value,
                  showDivider: !isLast,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context,
    _SettingItem item, {
    bool showDivider = true,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, item.route),
          child: Padding(
            padding: const EdgeInsets.all(Spacing.md),
            child: Row(
              children: [
                // Icon with color background
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(Spacing.radiusSm),
                  ),
                  child: Icon(item.icon, color: item.color, size: 22),
                ),
                const SizedBox(width: Spacing.md),

                // Title and subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: AppTypography.labelMedium),
                      if (item.subtitle != null)
                        Text(
                          item.subtitle!,
                          style: AppTypography.labelSmall.copyWith(
                            color: AppColors.textHint,
                          ),
                        ),
                    ],
                  ),
                ),

                // Arrow
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.textHint,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: Spacing.md + 40 + Spacing.md,
            color: AppColors.border.withValues(alpha: 0.5),
          ),
      ],
    );
  }

  Widget _buildAppInfo() {
    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Column(
        children: [
          const SizedBox(height: Spacing.xl),
          Text(
            'Audiobook App',
            style: AppTypography.labelMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: Spacing.xs),
          Text(
            'Version 1.0.0 (Build 42)',
            style: AppTypography.labelSmall.copyWith(color: AppColors.textHint),
          ),
          const SizedBox(height: Spacing.lg),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: Text(
                  'Terms of Service',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              Text(' • ', style: TextStyle(color: AppColors.textHint)),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Privacy Policy',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color color;
  final String route;

  _SettingItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.color,
    required this.route,
  });
}
