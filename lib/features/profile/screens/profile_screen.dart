// =============================================================================
// PROFILE SCREEN - User Profile & Account (Page 48)
// =============================================================================
// User profile with settings, stats, and account management.
//
// NAVIGATION RELATIONSHIPS:
// - Parent: Main Shell (Tab 5)
// - To: Edit Profile, Settings, Family, Downloads, Subscription screens
// - Dependencies: neu_container.dart
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';

/// Profile and account screen.
///
/// Features:
/// - Profile header with avatar
/// - Listening statistics
/// - Quick actions (Settings, Downloads, etc)
/// - Account management
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile header
              _buildProfileHeader(context),
              const SizedBox(height: Spacing.xl),

              // Stats row
              _buildStatsRow(context),
              const SizedBox(height: Spacing.xl),

              // Menu sections
              _buildMenuSections(context),
              const SizedBox(height: Spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  /// Build profile header
  Widget _buildProfileHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Column(
        children: [
          // Edit button
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {},
              color: AppColors.textSecondary,
            ),
          ),

          // Avatar
          NeuContainer(
            style: NeuStyle.raised,
            intensity: NeuIntensity.medium,
            isCircular: true,
            width: 100,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.3),
                    AppColors.secondary.withValues(alpha: 0.3),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'JD',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: Spacing.md),

          // Name
          Text('John Doe', style: AppTypography.h2),
          const SizedBox(height: Spacing.xs),

          // Email
          Text(
            'john.doe@example.com',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: Spacing.sm),

          // Member badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.md,
              vertical: Spacing.xs,
            ),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Spacing.radiusCircle),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, color: AppColors.warning, size: 16),
                const SizedBox(width: Spacing.xs),
                Text(
                  'Premium Member',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.warning,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build stats row
  Widget _buildStatsRow(BuildContext context) {
    final stats = [('Books', '24'), ('Hours', '156'), ('Badges', '12')];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        padding: const EdgeInsets.symmetric(vertical: Spacing.lg),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: stats.asMap().entries.map((entry) {
            final isLast = entry.key == stats.length - 1;
            return Expanded(
              child: Container(
                decoration: isLast
                    ? null
                    : BoxDecoration(
                        border: Border(
                          right: BorderSide(color: AppColors.divider, width: 1),
                        ),
                      ),
                child: Column(
                  children: [
                    Text(
                      entry.value.$2,
                      style: AppTypography.h2.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: Spacing.xs),
                    Text(
                      entry.value.$1,
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Build menu sections
  Widget _buildMenuSections(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Library & Content
          _buildSectionTitle('Library'),
          _buildMenuItem(
            context,
            Icons.download_outlined,
            'My Downloads',
            '6 books',
            () => Navigator.pushNamed(context, '/downloads'),
          ),
          _buildMenuItem(
            context,
            Icons.bookmark_outline,
            'Saved Bookmarks',
            '23 saved',
            () => Navigator.pushNamed(context, '/saved-bookmarks'),
          ),
          _buildMenuItem(
            context,
            Icons.bar_chart_outlined,
            'Listening Stats',
            '',
            () => Navigator.pushNamed(context, '/stats'),
          ),
          const SizedBox(height: Spacing.lg),

          // Account
          _buildSectionTitle('Account'),
          _buildMenuItem(
            context,
            Icons.person_outline,
            'Edit Profile',
            '',
            () => Navigator.pushNamed(context, '/profile/edit'),
          ),
          _buildMenuItem(
            context,
            Icons.credit_card_outlined,
            'Subscription',
            'Premium',
            () => Navigator.pushNamed(context, '/subscription'),
          ),
          _buildMenuItem(
            context,
            Icons.family_restroom_outlined,
            'Family Sharing',
            '',
            () => Navigator.pushNamed(context, '/family'),
          ),
          _buildMenuItem(
            context,
            Icons.child_care,
            'Kids Mode',
            '',
            () => Navigator.pushNamed(context, '/kids-mode'),
          ),
          const SizedBox(height: Spacing.lg),

          // Settings
          _buildSectionTitle('Settings'),
          _buildMenuItem(
            context,
            Icons.settings_outlined,
            'All Settings',
            '',
            () => Navigator.pushNamed(context, '/settings/app'),
          ),
          _buildMenuItem(
            context,
            Icons.accessibility_outlined,
            'Accessibility',
            '',
            () => Navigator.pushNamed(context, '/settings/accessibility'),
          ),
          _buildMenuItem(
            context,
            Icons.palette_outlined,
            'Display & Theme',
            'Light',
            () => Navigator.pushNamed(context, '/settings/display'),
          ),
          _buildMenuItem(
            context,
            Icons.notifications_outlined,
            'Notifications',
            '',
            () => Navigator.pushNamed(context, '/settings/notifications'),
          ),
          _buildMenuItem(
            context,
            Icons.lock_outline,
            'Privacy',
            '',
            () => Navigator.pushNamed(context, '/settings/privacy'),
          ),
          _buildMenuItem(
            context,
            Icons.language_outlined,
            'Language',
            'English',
            () => Navigator.pushNamed(context, '/settings/language'),
          ),
          const SizedBox(height: Spacing.lg),

          // Support
          _buildSectionTitle('Support'),
          _buildMenuItem(context, Icons.help_outline, 'Help Center', '', () {}),
          _buildMenuItem(
            context,
            Icons.feedback_outlined,
            'Send Feedback',
            '',
            () {},
          ),
          _buildMenuItem(context, Icons.info_outline, 'About', 'v2.0.0', () {}),
          const SizedBox(height: Spacing.lg),

          // Logout button
          NeuContainer(
            style: NeuStyle.raised,
            intensity: NeuIntensity.light,
            child: ListTile(
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: Text(
                'Log Out',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.error,
                ),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.sm),
      child: Text(
        title,
        style: AppTypography.overline.copyWith(color: AppColors.textSecondary),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String trailing,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.sm),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        child: ListTile(
          leading: Icon(icon, color: AppColors.iconDefault),
          title: Text(title, style: AppTypography.bodyMedium),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (trailing.isNotEmpty)
                Text(
                  trailing,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              const SizedBox(width: Spacing.xs),
              const Icon(Icons.chevron_right, color: AppColors.iconDefault),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
