import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../provider/player_provider.dart';
import '../provider/player_state.dart';
import 'progress_bar.dart';
import 'speed_selector.dart';
import 'sleep_timer_sheet.dart';

/// Full-screen audio player
class FullPlayer extends StatelessWidget {
  const FullPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, player, child) {
        final state = player.state;
        if (!state.hasContent) {
          return const Scaffold(
            backgroundColor: AppColors.backgroundDark,
            body: Center(
              child: Text(
                'No audio loaded',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.backgroundDark,
          body: Container(
            decoration: const BoxDecoration(gradient: AppColors.playerGradient),
            child: SafeArea(
              child: Column(
                children: [
                  // App bar
                  _buildAppBar(context, state),

                  // Book cover and info
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Cover art
                          _buildCoverArt(state),
                          const SizedBox(height: 32),

                          // Title and author
                          _buildBookInfo(state),
                          const SizedBox(height: 8),

                          // Chapter info
                          _buildChapterInfo(state),
                        ],
                      ),
                    ),
                  ),

                  // Progress bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: PlayerProgressBar(
                      position: state.position,
                      duration: state.duration,
                      bufferedPosition: state.bufferedPosition,
                      onSeek: (position) {
                        player.seek(position);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Controls
                  _buildControls(context, player, state),
                  const SizedBox(height: 16),

                  // Additional controls
                  _buildSecondaryControls(context, player, state),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context, PlayerState state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down, size: 32),
            color: AppColors.textPrimaryDark,
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          // Sleep timer indicator
          if (state.sleepTimer.isActive)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.bedtime, size: 16, color: AppColors.primary),
                  const SizedBox(width: 6),
                  Text(
                    state.sleepTimer.formattedRemaining ?? '',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.more_vert),
            color: AppColors.textPrimaryDark,
            onPressed: () {
              // TODO: Show options menu
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCoverArt(PlayerState state) {
    return Hero(
      tag: state.currentBook?.id ?? 'cover',
      child: Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: state.currentBook?.coverUrl ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppColors.cardDark,
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppColors.cardDark,
              child: const Icon(
                Icons.book,
                size: 80,
                color: AppColors.textTertiaryDark,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookInfo(PlayerState state) {
    return Column(
      children: [
        Text(
          state.currentBook?.title ?? '',
          style: AppTypography.bookTitle.copyWith(
            color: AppColors.textPrimaryDark,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          state.currentBook?.author ?? '',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondaryDark,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildChapterInfo(PlayerState state) {
    return Text(
      state.currentEpisode?.title ?? 'Chapter ${state.currentIndex + 1}',
      style: AppTypography.labelMedium.copyWith(color: AppColors.primary),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildControls(
    BuildContext context,
    PlayerProvider player,
    PlayerState state,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Skip backward
        IconButton(
          icon: const Icon(Icons.replay_10),
          iconSize: 36,
          color: AppColors.textPrimaryDark,
          onPressed: () => player.seekBackward(
            Duration(seconds: AppConstants.shortSkipSeconds),
          ),
        ),
        const SizedBox(width: 16),

        // Previous
        IconButton(
          icon: const Icon(Icons.skip_previous),
          iconSize: 44,
          color: state.canSkipPrevious
              ? AppColors.textPrimaryDark
              : AppColors.textTertiaryDark,
          onPressed: state.canSkipPrevious ? () => player.skipPrevious() : null,
        ),
        const SizedBox(width: 8),

        // Play/Pause
        _PlayPauseButton(
          isPlaying: state.isPlaying,
          isLoading:
              state.status == PlayerStatus.loading ||
              state.status == PlayerStatus.buffering,
          onPressed: () => player.togglePlayPause(),
        ),
        const SizedBox(width: 8),

        // Next
        IconButton(
          icon: const Icon(Icons.skip_next),
          iconSize: 44,
          color: state.canSkipNext
              ? AppColors.textPrimaryDark
              : AppColors.textTertiaryDark,
          onPressed: state.canSkipNext ? () => player.skipNext() : null,
        ),
        const SizedBox(width: 16),

        // Skip forward
        IconButton(
          icon: const Icon(Icons.forward_30),
          iconSize: 36,
          color: AppColors.textPrimaryDark,
          onPressed: () => player.seekForward(
            Duration(seconds: AppConstants.longSkipSeconds),
          ),
        ),
      ],
    );
  }

  Widget _buildSecondaryControls(
    BuildContext context,
    PlayerProvider player,
    PlayerState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Speed
          _SecondaryButton(
            icon: Icons.speed,
            label: '${state.speed.toStringAsFixed(1)}x',
            onTap: () {
              SpeedSelector.show(
                context,
                state.speed,
                (speed) => player.setSpeed(speed),
              );
            },
          ),

          // Sleep timer
          _SecondaryButton(
            icon: state.sleepTimer.isActive
                ? Icons.bedtime
                : Icons.bedtime_outlined,
            label: 'Timer',
            isActive: state.sleepTimer.isActive,
            onTap: () {
              SleepTimerSheet.show(
                context,
                timerState: state.sleepTimer,
                onSetTimer: (duration) => player.startSleepTimer(duration),
                onEndOfChapter: () => player.startEndOfChapterTimer(),
                onCancel: () => player.cancelSleepTimer(),
              );
            },
          ),

          // Repeat
          _SecondaryButton(
            icon: _getLoopIcon(state.loopMode),
            label: _getLoopLabel(state.loopMode),
            isActive: state.loopMode != LoopMode.off,
            onTap: () => player.cycleLoopMode(),
          ),

          // Chapters
          _SecondaryButton(
            icon: Icons.list,
            label: 'Chapters',
            onTap: () {
              // TODO: Show chapters list
            },
          ),
        ],
      ),
    );
  }

  IconData _getLoopIcon(LoopMode mode) {
    switch (mode) {
      case LoopMode.off:
        return Icons.repeat;
      case LoopMode.one:
        return Icons.repeat_one;
      case LoopMode.all:
        return Icons.repeat;
    }
  }

  String _getLoopLabel(LoopMode mode) {
    switch (mode) {
      case LoopMode.off:
        return 'Repeat';
      case LoopMode.one:
        return 'Repeat 1';
      case LoopMode.all:
        return 'Repeat All';
    }
  }
}

class _PlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final bool isLoading;
  final VoidCallback onPressed;

  const _PlayPauseButton({
    required this.isPlaying,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  ),
                ),
              )
            : Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 44,
                color: Colors.white,
              ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _SecondaryButton({
    required this.icon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.textSecondaryDark;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(label, style: AppTypography.labelSmall.copyWith(color: color)),
        ],
      ),
    );
  }
}
