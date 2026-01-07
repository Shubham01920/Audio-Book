// =============================================================================
// NOTIFICATIONS SCREEN - Notification Preferences
// =============================================================================
// Notification settings with toggle options for:
// - Push notifications
// - Email notifications
// - In-app notifications
// - Specific notification types
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _pushEnabled = true;
  bool _emailEnabled = true;
  bool _newReleases = true;
  bool _recommendations = true;
  bool _socialUpdates = false;
  bool _readingReminders = true;
  bool _challengeUpdates = true;
  bool _promotions = false;

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
                    Text('Notifications', style: AppTypography.h4),
                  ],
                ),
              ),

              // Main toggles
              _buildSectionHeader('NOTIFICATION CHANNELS'),
              _buildMainToggle(
                'Push Notifications',
                'Receive push notifications on your device',
                Icons.notifications_active_outlined,
                _pushEnabled,
                (v) => setState(() => _pushEnabled = v),
              ),
              _buildMainToggle(
                'Email Notifications',
                'Receive updates via email',
                Icons.email_outlined,
                _emailEnabled,
                (v) => setState(() => _emailEnabled = v),
              ),
              const SizedBox(height: Spacing.lg),

              // Notification types
              _buildSectionHeader('NOTIFICATION TYPES'),
              _buildNotificationCategory([
                _NotifOption(
                  'New Releases',
                  'Books from authors you follow',
                  _newReleases,
                  (v) => setState(() => _newReleases = v),
                ),
                _NotifOption(
                  'Recommendations',
                  'Personalized book suggestions',
                  _recommendations,
                  (v) => setState(() => _recommendations = v),
                ),
                _NotifOption(
                  'Social Updates',
                  'Activity from friends',
                  _socialUpdates,
                  (v) => setState(() => _socialUpdates = v),
                ),
                _NotifOption(
                  'Reading Reminders',
                  'Daily listening goals',
                  _readingReminders,
                  (v) => setState(() => _readingReminders = v),
                ),
                _NotifOption(
                  'Challenge Updates',
                  'Reading challenge progress',
                  _challengeUpdates,
                  (v) => setState(() => _challengeUpdates = v),
                ),
                _NotifOption(
                  'Promotions & Sales',
                  'Deals and discounts',
                  _promotions,
                  (v) => setState(() => _promotions = v),
                ),
              ]),
              const SizedBox(height: Spacing.xxl),
            ],
          ),
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

  Widget _buildMainToggle(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
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
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: value
                    ? AppColors.primary.withValues(alpha: 0.15)
                    : AppColors.textHint.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
              ),
              child: Icon(
                icon,
                color: value ? AppColors.primary : AppColors.textHint,
              ),
            ),
            const SizedBox(width: Spacing.md),
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
              onChanged: onChanged,
              activeColor: AppColors.primary,
              activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCategory(List<_NotifOption> options) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: EdgeInsets.zero,
        child: Column(
          children: options.asMap().entries.map((entry) {
            final isLast = entry.key == options.length - 1;
            final option = entry.value;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Spacing.md),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              option.title,
                              style: AppTypography.labelMedium,
                            ),
                            Text(
                              option.subtitle,
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textHint,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: option.value,
                        onChanged: option.onChanged,
                        activeColor: AppColors.primary,
                        activeTrackColor: AppColors.primary.withValues(
                          alpha: 0.3,
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
    );
  }
}

class _NotifOption {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  _NotifOption(this.title, this.subtitle, this.value, this.onChanged);
}
