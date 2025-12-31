import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../services/auth_service.dart';
import '../../../repositories/bookmark_repository.dart';
import '../provider/player_provider.dart';
import '../provider/player_state.dart';
import 'progress_bar.dart';
import 'speed_selector.dart';
import 'sleep_timer_sheet.dart';
import 'car_mode_player.dart';

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
          // Car Mode Button
          IconButton(
            icon: const Icon(Icons.directions_car),
            color: AppColors.textPrimaryDark,
            tooltip: 'Car Mode',
            onPressed: () => CarModePlayer.show(context),
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
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

          // Bookmark - shows options sheet
          _SecondaryButton(
            icon: Icons.bookmark_add_outlined,
            label: 'Bookmark',
            onTap: () => _showBookmarkSheet(context, state),
          ),

          // Repeat
          _SecondaryButton(
            icon: _getLoopIcon(state.loopMode),
            label: _getLoopLabel(state.loopMode),
            isActive: state.loopMode != LoopMode.off,
            onTap: () => player.cycleLoopMode(),
          ),
        ],
      ),
    );
  }

  void _showBookmarkSheet(BuildContext context, PlayerState state) {
    if (state.currentBook == null || state.currentEpisode == null) return;

    final authService = context.read<AuthService>();
    final bookmarkRepo = context.read<BookmarkRepository>();

    if (authService.currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to use bookmarks')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.elevatedDark,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.bookmark, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  'Bookmarks',
                  style: AppTypography.titleLarge.copyWith(
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Current position
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Current: ${_formatDuration(state.position)}',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Save bookmark option
            ListTile(
              leading: const Icon(Icons.bookmark_add, color: AppColors.success),
              title: Text(
                'Save Bookmark Here',
                style: TextStyle(color: AppColors.textPrimaryDark),
              ),
              subtitle: Text(
                'At ${_formatDuration(state.position)}',
                style: TextStyle(color: AppColors.textTertiaryDark),
              ),
              onTap: () async {
                Navigator.pop(context);
                final bookmark = await bookmarkRepo.quickBookmark(
                  userId: authService.currentUser!.uid,
                  bookId: state.currentBook!.id,
                  episodeId: state.currentEpisode!.id,
                  position: state.position,
                );
                if (bookmark != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Bookmark saved at ${_formatDuration(state.position)}',
                      ),
                      backgroundColor: AppColors.success,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),

            const Divider(color: AppColors.elevatedDark),

            // View all bookmarks
            ListTile(
              leading: const Icon(Icons.list, color: AppColors.primary),
              title: Text(
                'View All Bookmarks',
                style: TextStyle(color: AppColors.textPrimaryDark),
              ),
              subtitle: Text(
                'See all saved positions',
                style: TextStyle(color: AppColors.textTertiaryDark),
              ),
              onTap: () {
                Navigator.pop(context);
                _showBookmarksList(
                  context,
                  state,
                  authService.currentUser!.uid,
                  bookmarkRepo,
                );
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showBookmarksList(
    BuildContext context,
    PlayerState state,
    String userId,
    BookmarkRepository bookmarkRepo,
  ) async {
    final bookmarks = await bookmarkRepo.getBookmarksForBook(
      userId,
      state.currentBook!.id,
    );

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.elevatedDark,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              'Saved Bookmarks (${bookmarks.length})',
              style: AppTypography.titleLarge.copyWith(
                color: AppColors.textPrimaryDark,
              ),
            ),
            const SizedBox(height: 16),

            if (bookmarks.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(
                      Icons.bookmark_border,
                      size: 48,
                      color: AppColors.textTertiaryDark,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No bookmarks yet',
                      style: TextStyle(color: AppColors.textSecondaryDark),
                    ),
                  ],
                ),
              )
            else
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: bookmarks.length,
                  itemBuilder: (context, index) {
                    final bookmark = bookmarks[index];
                    return ListTile(
                      leading: const Icon(
                        Icons.bookmark,
                        color: AppColors.primary,
                      ),
                      title: Text(
                        bookmark.title ?? 'Bookmark ${index + 1}',
                        style: TextStyle(color: AppColors.textPrimaryDark),
                      ),
                      subtitle: Text(
                        _formatDuration(bookmark.position),
                        style: TextStyle(color: AppColors.textTertiaryDark),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Jump to position
                          IconButton(
                            icon: const Icon(
                              Icons.play_circle,
                              color: AppColors.primary,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<PlayerProvider>().seek(
                                bookmark.position,
                              );
                            },
                          ),
                          // Delete
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline,
                              color: AppColors.error,
                            ),
                            onPressed: () async {
                              await bookmarkRepo.deleteBookmark(
                                userId,
                                bookmark.id,
                              );
                              Navigator.pop(context);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Bookmark deleted'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
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
