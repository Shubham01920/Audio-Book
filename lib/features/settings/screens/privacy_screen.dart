// =============================================================================
// PRIVACY SCREEN - Privacy & Data Settings
// =============================================================================
// Privacy settings with:
// - Data sharing preferences
// - Listening history controls
// - Account privacy options
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

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _shareListening = true;
  bool _publicProfile = false;
  bool _showActivity = true;
  bool _personalization = true;
  bool _analytics = true;

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
                    Text('Privacy & Data', style: AppTypography.h4),
                  ],
                ),
              ),

              // Profile Privacy
              _buildSectionHeader('PROFILE PRIVACY'),
              _buildToggle(
                'Public Profile',
                'Allow others to see your profile',
                _publicProfile,
                (v) => setState(() => _publicProfile = v),
              ),
              _buildToggle(
                'Show Listening Activity',
                'Share what you\'re listening to',
                _showActivity,
                (v) => setState(() => _showActivity = v),
              ),
              _buildToggle(
                'Share with Friends',
                'Allow friends to see your library',
                _shareListening,
                (v) => setState(() => _shareListening = v),
              ),
              const SizedBox(height: Spacing.lg),

              // Data Usage
              _buildSectionHeader('DATA USAGE'),
              _buildToggle(
                'Personalization',
                'Use data to improve recommendations',
                _personalization,
                (v) => setState(() => _personalization = v),
              ),
              _buildToggle(
                'Analytics',
                'Help improve the app with usage data',
                _analytics,
                (v) => setState(() => _analytics = v),
              ),
              const SizedBox(height: Spacing.lg),

              // Data Management
              _buildSectionHeader('DATA MANAGEMENT'),
              _buildActionTile(
                'Download My Data',
                'Get a copy of your data',
                Icons.download_outlined,
                Colors.blue,
                () {},
              ),
              _buildActionTile(
                'Clear Listening History',
                'Remove all history',
                Icons.history,
                Colors.orange,
                () => _showConfirmation(context),
              ),
              _buildActionTile(
                'Delete Account',
                'Permanently delete your account',
                Icons.delete_forever_outlined,
                Colors.red,
                () {},
              ),
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

  Widget _buildToggle(
    String title,
    String subtitle,
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

  Widget _buildActionTile(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.screenHorizontal,
        vertical: Spacing.xs,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
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
              const SizedBox(width: Spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.labelMedium.copyWith(
                        color: color == Colors.red ? color : null,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: AppColors.textHint, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Spacing.radiusLg),
        ),
        title: Text('Clear History?', style: AppTypography.h5),
        content: Text(
          'This will remove all your listening history. This action cannot be undone.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
