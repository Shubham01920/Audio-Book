import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../provider/player_provider.dart';
import '../provider/player_state.dart';

/// Car Mode Player - Large buttons, minimal UI for safe driving
class CarModePlayer extends StatefulWidget {
  const CarModePlayer({super.key});

  @override
  State<CarModePlayer> createState() => _CarModePlayerState();

  static void show(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CarModePlayer(),
        fullscreenDialog: true,
      ),
    );
  }
}

class _CarModePlayerState extends State<CarModePlayer> {
  @override
  void initState() {
    super.initState();
    // Allow landscape and hide status bar for immersive experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<PlayerProvider>(
        builder: (context, player, child) {
          final state = player.state;

          if (state.currentBook == null) {
            return _buildNoBookPlaying(context);
          }

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1A1A2E), Colors.black],
              ),
            ),
            child: SafeArea(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  if (orientation == Orientation.landscape) {
                    return _buildLandscapeLayout(context, player, state);
                  }
                  return _buildPortraitLayout(context, player, state);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoBookPlaying(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.directions_car_outlined,
            size: 80,
            color: Colors.white38,
          ),
          const SizedBox(height: 24),
          Text(
            'No Audiobook Playing',
            style: AppTypography.headlineSmall.copyWith(color: Colors.white54),
          ),
          const SizedBox(height: 32),
          _buildExitButton(context),
        ],
      ),
    );
  }

  // ==================== PORTRAIT LAYOUT ====================
  Widget _buildPortraitLayout(
    BuildContext context,
    PlayerProvider player,
    PlayerState state,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_buildExitButton(context), _buildCarModeLabel()],
          ),
        ),
        Expanded(flex: 2, child: FadeInDown(child: _buildBookInfo(state))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: _buildProgressBar(state, player),
        ),
        const SizedBox(height: 24),
        Expanded(
          flex: 3,
          child: FadeInUp(child: _buildMainControls(player, state)),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: _buildSecondaryControls(player, state),
        ),
      ],
    );
  }

  // ==================== LANDSCAPE LAYOUT ====================
  Widget _buildLandscapeLayout(
    BuildContext context,
    PlayerProvider player,
    PlayerState state,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildExitButton(context),
              const SizedBox(height: 16),
              _buildBookInfo(state),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildProgressBar(state, player),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCarModeLabel(),
              const SizedBox(height: 24),
              _buildMainControls(player, state),
              const SizedBox(height: 24),
              _buildSecondaryControls(player, state),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExitButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.close, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              'EXIT',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarModeLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.directions_car, color: Colors.white, size: 18),
          SizedBox(width: 8),
          Text(
            'CAR MODE',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookInfo(PlayerState state) {
    final coverUrl = state.currentBook?.coverUrl;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: coverUrl != null && coverUrl.isNotEmpty
                ? CachedNetworkImage(imageUrl: coverUrl, fit: BoxFit.cover)
                : Container(
                    color: AppColors.cardDark,
                    child: const Icon(
                      Icons.book,
                      color: Colors.white54,
                      size: 40,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            state.currentBook?.title ?? 'Unknown',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          state.currentEpisode?.title ?? 'Chapter 1',
          style: const TextStyle(color: Colors.white60, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgressBar(PlayerState state, PlayerProvider player) {
    final duration = state.duration ?? Duration.zero;
    final progress = duration.inMilliseconds > 0
        ? state.position.inMilliseconds / duration.inMilliseconds
        : 0.0;

    return Column(
      children: [
        Container(
          height: 12,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(state.position),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              _formatDuration(duration),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainControls(PlayerProvider player, PlayerState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildControlButton(
          icon: Icons.replay_30,
          size: 70,
          iconSize: 36,
          onTap: () => player.seekBackward(const Duration(seconds: 30)),
          label: '30s',
        ),
        const SizedBox(width: 24),
        _buildPlayButton(player, state),
        const SizedBox(width: 24),
        _buildControlButton(
          icon: Icons.forward_30,
          size: 70,
          iconSize: 36,
          onTap: () => player.seekForward(const Duration(seconds: 30)),
          label: '30s',
        ),
      ],
    );
  }

  Widget _buildPlayButton(PlayerProvider player, PlayerState state) {
    final isPlaying = state.status == PlayerStatus.playing;

    return GestureDetector(
      onTap: () => player.togglePlayPause(),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6366F1).withValues(alpha: 0.5),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Icon(
          isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required double size,
    required double iconSize,
    required VoidCallback onTap,
    String? label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: Icon(icon, color: Colors.white, size: iconSize),
          ),
          if (label != null) ...[
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSecondaryControls(PlayerProvider player, PlayerState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSmallControlButton(
          icon: Icons.skip_previous_rounded,
          label: 'Previous',
          onTap: () => player.skipPrevious(),
        ),
        _buildSmallControlButton(
          icon: Icons.speed,
          label: '${state.speed.toStringAsFixed(1)}x',
          onTap: () => _cycleSpeed(player, state),
          isActive: state.speed != 1.0,
        ),
        _buildSmallControlButton(
          icon: state.sleepTimer.isActive
              ? Icons.bedtime
              : Icons.bedtime_outlined,
          label: state.sleepTimer.formattedRemaining ?? 'Sleep',
          onTap: () => _toggleSleepTimer(player, state),
          isActive: state.sleepTimer.isActive,
        ),
        _buildSmallControlButton(
          icon: Icons.skip_next_rounded,
          label: 'Next',
          onTap: () => player.skipNext(),
        ),
      ],
    );
  }

  Widget _buildSmallControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.2)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isActive
                ? AppColors.primary.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.primary : Colors.white70,
              size: 28,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.primary : Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _cycleSpeed(PlayerProvider player, PlayerState state) {
    const speeds = [0.75, 1.0, 1.25, 1.5, 1.75, 2.0];
    final currentIndex = speeds.indexOf(state.speed);
    final nextIndex = (currentIndex + 1) % speeds.length;
    player.setSpeed(speeds[nextIndex]);
  }

  void _toggleSleepTimer(PlayerProvider player, PlayerState state) {
    if (state.sleepTimer.isActive) {
      player.cancelSleepTimer();
    } else {
      player.startSleepTimer(const Duration(minutes: 30));
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    if (hours > 0)
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }
}
