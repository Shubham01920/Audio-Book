import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../provider/player_provider.dart';
import '../provider/player_state.dart';

/// Car mode player with large buttons for driver safety
class CarModePlayer extends StatelessWidget {
  const CarModePlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, player, child) {
        final state = player.state;
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: GestureDetector(
              onDoubleTap: () => Navigator.of(context).pop(),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Exit hint
                    Text(
                      'Double tap to exit Car Mode',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppColors.textTertiaryDark,
                      ),
                    ),
                    const Spacer(),

                    // Book info
                    Text(
                      state.currentBook?.title ?? 'No book playing',
                      style: AppTypography.headlineMedium.copyWith(
                        color: AppColors.textPrimaryDark,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.currentEpisode?.title ?? '',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textSecondaryDark,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const Spacer(),

                    // Large controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Rewind 30s
                        _CarModeButton(
                          icon: Icons.replay_30,
                          label: '-30s',
                          onTap: () {
                            player.seekBackward(const Duration(seconds: 30));
                          },
                        ),

                        // Play/Pause
                        _CarModePlayButton(
                          isPlaying: state.isPlaying,
                          onTap: () {
                            player.togglePlayPause();
                          },
                        ),

                        // Forward 30s
                        _CarModeButton(
                          icon: Icons.forward_30,
                          label: '+30s',
                          onTap: () {
                            player.seekForward(const Duration(seconds: 30));
                          },
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Progress
                    _buildProgress(state),

                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgress(PlayerState state) {
    final progress = state.progress;
    final remaining = state.remaining;

    String formatDuration(Duration d) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final hours = d.inHours;
      final minutes = d.inMinutes.remainder(60);
      final seconds = d.inSeconds.remainder(60);
      if (hours > 0) {
        return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
      }
      return '${twoDigits(minutes)}:${twoDigits(seconds)}';
    }

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: AppColors.progressInactive,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '${formatDuration(remaining)} remaining',
          style: AppTypography.titleMedium.copyWith(
            color: AppColors.textSecondaryDark,
          ),
        ),
      ],
    );
  }

  static void show(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CarModePlayer(),
        fullscreenDialog: true,
      ),
    );
  }
}

class _CarModeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _CarModeButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: AppColors.textPrimaryDark),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.textSecondaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarModePlayButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onTap;

  const _CarModePlayButton({required this.isPlaying, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          size: 80,
          color: Colors.white,
        ),
      ),
    );
  }
}
