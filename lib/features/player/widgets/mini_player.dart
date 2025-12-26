import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../provider/player_provider.dart';
import '../provider/player_state.dart';
import 'full_player.dart';

/// Mini player widget shown at bottom of screen
class MiniPlayer extends StatelessWidget {
  final VoidCallback? onTap;

  const MiniPlayer({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, player, child) {
        final state = player.state;
        if (!state.hasContent) {
          return const SizedBox.shrink();
        }

        return GestureDetector(
          onTap: onTap ?? () => _openFullPlayer(context),
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity != null &&
                details.primaryVelocity! < -300) {
              _openFullPlayer(context);
            }
          },
          child: Container(
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Progress indicator
                _buildProgressIndicator(state),

                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        // Cover
                        _buildCover(state),
                        const SizedBox(width: 12),

                        // Info
                        Expanded(child: _buildInfo(state)),

                        // Controls
                        _buildControls(context, player, state),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressIndicator(PlayerState state) {
    final progress = state.progress;
    return Container(
      height: 3,
      child: LinearProgressIndicator(
        value: progress,
        backgroundColor: AppColors.progressInactive,
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
      ),
    );
  }

  Widget _buildCover(PlayerState state) {
    return Hero(
      tag: state.currentBook?.id ?? 'cover',
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: state.currentBook?.coverUrl ?? '',
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: AppColors.cardDark),
            errorWidget: (context, url, error) => Container(
              color: AppColors.cardDark,
              child: const Icon(
                Icons.book,
                size: 24,
                color: AppColors.textTertiaryDark,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfo(PlayerState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          state.currentBook?.title ?? '',
          style: AppTypography.titleSmall.copyWith(
            color: AppColors.textPrimaryDark,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          state.currentEpisode?.title ?? 'Chapter ${state.currentIndex + 1}',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.textSecondaryDark,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildControls(
    BuildContext context,
    PlayerProvider player,
    PlayerState state,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Skip backward
        IconButton(
          icon: const Icon(Icons.replay_10),
          iconSize: 24,
          color: AppColors.textSecondaryDark,
          onPressed: () => player.seekBackward(const Duration(seconds: 10)),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
        ),

        // Play/Pause
        IconButton(
          icon: Icon(
            state.isPlaying
                ? Icons.pause_circle_filled
                : Icons.play_circle_filled,
          ),
          iconSize: 44,
          color: AppColors.primary,
          onPressed: () => player.togglePlayPause(),
          padding: EdgeInsets.zero,
        ),

        // Skip forward
        IconButton(
          icon: const Icon(Icons.forward_30),
          iconSize: 24,
          color: AppColors.textSecondaryDark,
          onPressed: () => player.seekForward(const Duration(seconds: 30)),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
        ),
      ],
    );
  }

  void _openFullPlayer(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const FullPlayer(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }
}
