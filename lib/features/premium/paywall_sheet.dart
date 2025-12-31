import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../services/auth_service.dart';
import '../../services/coin_service.dart';
import '../../models/episode_model.dart';

/// Paywall bottom sheet shown when user taps a locked episode
class PaywallSheet extends StatelessWidget {
  final Episode episode;
  final int episodeIndex;
  final int currentCoins;
  final VoidCallback onUnlocked;

  // Pricing constants
  static const int subscriptionPrice = 149; // ₹149/month
  static const int coinsEquivalent = 300; // 300 coins = ₹149

  const PaywallSheet({
    super.key,
    required this.episode,
    required this.episodeIndex,
    required this.currentCoins,
    required this.onUnlocked,
  });

  static void show(
    BuildContext context, {
    required Episode episode,
    required int episodeIndex,
    required int currentCoins,
    required VoidCallback onUnlocked,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => PaywallSheet(
        episode: episode,
        episodeIndex: episodeIndex,
        currentCoins: currentCoins,
        onUnlocked: onUnlocked,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final canUnlock = currentCoins >= CoinService.episodeUnlockCost;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.elevatedDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Lock icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.amber.shade700, Colors.amber.shade400],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lock, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            'Episode Locked',
            style: AppTypography.headlineSmall.copyWith(
              color: AppColors.textPrimaryDark,
            ),
          ),
          const SizedBox(height: 8),

          // Episode name
          Text(
            episode.title,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondaryDark,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Current Balance Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.amber.shade900.withValues(alpha: 0.3),
                  Colors.amber.shade700.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.monetization_on,
                  color: Colors.amber,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  '$currentCoins Coins',
                  style: AppTypography.headlineSmall.copyWith(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 🌟 PREMIUM SUBSCRIPTION - Full App Access
          _UnlockOption(
            icon: Icons.star,
            iconColor: AppColors.primary,
            title: 'Get Premium - ₹$subscriptionPrice/month',
            subtitle: 'Unlimited access to all episodes',
            isPremium: true,
            onTap: () => _showPremiumDialog(context),
          ),
          const SizedBox(height: 12),

          // Unlock single episode with coins
          _UnlockOption(
            icon: Icons.lock_open,
            iconColor: Colors.amber,
            title: 'Unlock for ${CoinService.episodeUnlockCost} Coins',
            subtitle: canUnlock
                ? 'Tap to unlock this episode'
                : 'Not enough coins ($coinsEquivalent coins = ₹$subscriptionPrice)',
            enabled: canUnlock,
            onTap: () => _unlockWithCoins(context),
          ),
          const SizedBox(height: 12),

          // Share & Earn button
          _UnlockOption(
            icon: Icons.share,
            iconColor: Colors.blueAccent,
            title: 'Share & Earn ${CoinService.shareReward} coins',
            subtitle: 'Invite friends to earn coins',
            onTap: () => _shareAndEarn(context),
          ),
          const SizedBox(height: 16),

          // Value equation hint
          Text(
            '$coinsEquivalent coins = ₹$subscriptionPrice value',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textTertiaryDark,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showPremiumDialog(BuildContext context) {
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.elevatedDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.star, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Text(
              'Premium Plan',
              style: TextStyle(color: AppColors.textPrimaryDark),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: 0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '₹$subscriptionPrice/month',
                  style: AppTypography.headlineMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Benefits
            _PremiumBenefit('Unlock ALL episodes'),
            _PremiumBenefit('No ads'),
            _PremiumBenefit('Offline downloads'),
            _PremiumBenefit('Early access to new books'),
            _PremiumBenefit('Equivalent to $coinsEquivalent coins value'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Integrate RevenueCat here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    '🚀 Payment integration coming soon with RevenueCat!',
                  ),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Subscribe Now'),
          ),
        ],
      ),
    );
  }

  Future<void> _unlockWithCoins(BuildContext context) async {
    final authService = context.read<AuthService>();
    final userId = authService.currentUser?.uid;
    if (userId == null) return;

    final success = await CoinService().unlockEpisode(
      userId: userId,
      bookId: episode.bookId,
      episodeIndex: episodeIndex,
      cost: CoinService.episodeUnlockCost,
    );

    if (context.mounted) {
      Navigator.pop(context);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('🎉 ${episode.title} unlocked!'),
            backgroundColor: Colors.green,
          ),
        );
        onUnlocked();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Not enough coins!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _shareAndEarn(BuildContext context) async {
    final authService = context.read<AuthService>();
    final userId = authService.currentUser?.uid;
    if (userId == null) return;

    final result = await Share.share(
      'Listen to "${episode.title}" on our Audiobook app! 🎧📚\n\nDownload now: https://audiobooks.app/book/${episode.bookId}',
      subject: 'Check out this audiobook!',
    );

    if (result.status == ShareResultStatus.success) {
      await CoinService().addCoins(
        userId: userId,
        amount: CoinService.shareReward,
        source: CoinSource.share,
        description: 'Shared ${episode.title}',
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('🎉 +${CoinService.shareReward} coins earned!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}

class _UnlockOption extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool enabled;
  final bool isPremium;
  final VoidCallback onTap;

  const _UnlockOption({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.enabled = true,
    this.isPremium = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: isPremium
                  ? LinearGradient(
                      colors: [
                        AppColors.primary.withValues(alpha: 0.15),
                        AppColors.primary.withValues(alpha: 0.05),
                      ],
                    )
                  : null,
              color: isPremium ? null : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isPremium
                    ? AppColors.primary.withValues(alpha: 0.5)
                    : enabled
                    ? iconColor.withValues(alpha: 0.3)
                    : Colors.white.withValues(alpha: 0.1),
                width: isPremium ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: AppTypography.titleMedium.copyWith(
                                color: AppColors.textPrimaryDark,
                              ),
                            ),
                          ),
                          if (isPremium)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'BEST',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textTertiaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white24, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PremiumBenefit extends StatelessWidget {
  final String text;

  const _PremiumBenefit(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
          ),
        ],
      ),
    );
  }
}
