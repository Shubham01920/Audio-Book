import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../services/auth_service.dart';
import '../services/download_manager.dart';
import '../features/auth/screens/two_factor_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        title: Text(
          'Profile',
          style: AppTypography.headlineSmall.copyWith(
            color: AppColors.textPrimaryDark,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<AuthService>(
        builder: (context, authService, child) {
          final user = authService.currentUser;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Profile header
                FadeInDown(child: _ProfileHeader(user: user)),

                const SizedBox(height: 32),

                // Settings sections
                FadeInUp(
                  delay: const Duration(milliseconds: 100),
                  child: _SettingsSection(
                    title: 'Account',
                    items: [
                      _SettingsItem(
                        icon: Icons.person_outline,
                        title: 'Edit Profile',
                        onTap: () {
                          // TODO: Edit profile
                        },
                      ),
                      _SettingsItem(
                        icon: Icons.security,
                        title: '2-Factor Authentication',
                        subtitle: user?.is2FAEnabled == true
                            ? 'Enabled'
                            : 'Disabled',
                        onTap: () {
                          if (user?.is2FAEnabled != true) {
                            _showEnable2FADialog(context);
                          } else {
                            _showDisable2FADialog(context);
                          }
                        },
                      ),
                      _SettingsItem(
                        icon: Icons.lock_outline,
                        title: 'Change Password',
                        onTap: () {
                          _showChangePasswordDialog(context);
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: Consumer<DownloadManager>(
                    builder: (context, downloadManager, _) {
                      return FutureBuilder<int>(
                        future: downloadManager.getTotalDownloadSize(),
                        builder: (context, snapshot) {
                          final size = snapshot.data ?? 0;
                          final sizeInMB = (size / (1024 * 1024))
                              .toStringAsFixed(1);
                          return _SettingsSection(
                            title: 'Storage',
                            items: [
                              _SettingsItem(
                                icon: Icons.download_done,
                                title: 'Downloaded Episodes',
                                subtitle: '$sizeInMB MB used',
                                onTap: () {},
                              ),
                              _SettingsItem(
                                icon: Icons.delete_outline,
                                title: 'Clear Downloads',
                                titleColor: AppColors.error,
                                onTap: () {
                                  _showClearDownloadsDialog(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: _SettingsSection(
                    title: 'About',
                    items: [
                      _SettingsItem(
                        icon: Icons.info_outline,
                        title: 'App Version',
                        subtitle: '1.0.0',
                        onTap: () {},
                      ),
                      _SettingsItem(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Privacy Policy',
                        onTap: () {},
                      ),
                      _SettingsItem(
                        icon: Icons.description_outlined,
                        title: 'Terms of Service',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Sign out button
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _showSignOutDialog(context),
                      icon: const Icon(Icons.logout),
                      label: const Text('Sign Out'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: BorderSide(color: AppColors.error),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Delete account
                FadeIn(
                  delay: const Duration(milliseconds: 500),
                  child: TextButton(
                    onPressed: () => _showDeleteAccountDialog(context),
                    child: Text(
                      'Delete Account',
                      style: TextStyle(color: AppColors.textTertiaryDark),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Sign Out',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: AppColors.textSecondaryDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await context.read<AuthService>().signOut();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Delete Account', style: TextStyle(color: AppColors.error)),
        content: Text(
          'This action cannot be undone. All your data will be permanently deleted.',
          style: TextStyle(color: AppColors.textSecondaryDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await context.read<AuthService>().deleteAccount();
              if (!success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Failed to delete account. Please re-login and try again.',
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showClearDownloadsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Clear Downloads',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: Text(
          'This will delete all downloaded episodes. You can re-download them later.',
          style: TextStyle(color: AppColors.textSecondaryDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await context.read<DownloadManager>().clearAllDownloads();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All downloads cleared')),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showEnable2FADialog(BuildContext context) {
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Enable 2-Factor Auth',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Enter your phone number to receive verification codes',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: TextStyle(color: AppColors.textPrimaryDark),
              decoration: InputDecoration(
                hintText: '+91 9876543210',
                hintStyle: TextStyle(color: AppColors.textTertiaryDark),
                prefixIcon: Icon(
                  Icons.phone,
                  color: AppColors.textTertiaryDark,
                ),
                filled: true,
                fillColor: AppColors.elevatedDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await context.read<AuthService>().enable2FA(
                phoneController.text.trim(),
              );
              if (success && context.mounted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TwoFactorScreen(isEnabling: true),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showDisable2FADialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Disable 2-Factor Auth',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: Text(
          'This will make your account less secure. Are you sure?',
          style: TextStyle(color: AppColors.textSecondaryDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await context.read<AuthService>().disable2FA();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Disable'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Change Password',
          style: TextStyle(color: AppColors.textPrimaryDark),
        ),
        content: Text(
          'We will send a password reset link to your email.',
          style: TextStyle(color: AppColors.textSecondaryDark),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final authService = context.read<AuthService>();
              if (authService.currentUser?.email != null) {
                await authService.sendPasswordResetEmail(
                  authService.currentUser!.email!,
                );
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password reset email sent!')),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Send Link'),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final AppUser? user;

  const _ProfileHeader({this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Avatar
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.primaryGradient,
          ),
          child: user?.photoUrl != null
              ? ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: user!.photoUrl!,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => _buildDefaultAvatar(),
                  ),
                )
              : _buildDefaultAvatar(),
        ),
        const SizedBox(height: 16),

        // Name
        Text(
          user?.displayName ?? 'User',
          style: AppTypography.headlineSmall.copyWith(
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 4),

        // Email
        Text(
          user?.email ?? '',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondaryDark,
          ),
        ),

        // Auth provider badge
        if (user?.authProvider != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.elevatedDark,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getProviderIcon(user!.authProvider!),
                    size: 14,
                    color: AppColors.textSecondaryDark,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _getProviderLabel(user!.authProvider!),
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDefaultAvatar() {
    return Center(
      child: Text(
        (user?.displayName?.substring(0, 1) ?? 'U').toUpperCase(),
        style: AppTypography.headlineLarge.copyWith(color: Colors.white),
      ),
    );
  }

  IconData _getProviderIcon(String provider) {
    switch (provider) {
      case 'google':
        return Icons.g_mobiledata;
      case 'apple':
        return Icons.apple;
      default:
        return Icons.email_outlined;
    }
  }

  String _getProviderLabel(String provider) {
    switch (provider) {
      case 'google':
        return 'Google Account';
      case 'apple':
        return 'Apple ID';
      default:
        return 'Email';
    }
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<_SettingsItem> items;

  const _SettingsSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: AppTypography.labelLarge.copyWith(
              color: AppColors.textTertiaryDark,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return Column(
                children: [
                  item,
                  if (index < items.length - 1)
                    Divider(
                      height: 1,
                      color: AppColors.elevatedDark,
                      indent: 56,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? titleColor;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.titleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.elevatedDark,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: titleColor ?? AppColors.textSecondaryDark),
      ),
      title: Text(
        title,
        style: AppTypography.bodyLarge.copyWith(
          color: titleColor ?? AppColors.textPrimaryDark,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textTertiaryDark,
              ),
            )
          : null,
      trailing: Icon(Icons.chevron_right, color: AppColors.textTertiaryDark),
      onTap: onTap,
    );
  }
}
