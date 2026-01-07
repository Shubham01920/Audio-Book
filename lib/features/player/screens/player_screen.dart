// =============================================================================
// PLAYER SCREEN - Full Audiobook Player (Matching Reference Design)
// =============================================================================
// Full-screen player with exact neumorphic design:
// - NOW PLAYING header with chapter name
// - Large neumorphic book cover
// - Progress bar with remaining time
// - Circular neumorphic controls (rewind/play/forward)
// - Square neumorphic secondary controls (speed/bookmark/sleep/car)
// - Tab bar (Chapters/Transcript/Queue)
// - Chapter navigation buttons
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
// =============================================================================

import 'package:flutter/material.dart';
import 'package:ui_app/app/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';
import '../widgets/speed_settings_sheet.dart';
import '../widgets/sleep_timer_sheet.dart';

class PlayerScreen extends StatefulWidget {
  final String? bookId;

  const PlayerScreen({super.key, this.bookId});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = true;
  double _progress = 0.35;
  double _speed = 1.0;
  late TabController _tabController;

  final Map<String, dynamic> _book = {
    'title': 'The Midnight Library',
    'author': 'Matt Haig',
    'currentChapter': 'Chapter 5: The Sliding Doors',
    'currentTime': '1:23:45',
    'totalTime': '8:50:00',
    'remainingTime': '7h 26m remaining',
  };

  final List<Map<String, dynamic>> _chapters = [
    {'number': 1, 'title': 'The Root', 'duration': '15:30', 'completed': true},
    {
      'number': 2,
      'title': 'The Butterfly',
      'duration': '18:45',
      'completed': true,
    },
    {
      'number': 3,
      'title': 'The Spiral',
      'duration': '14:20 left',
      'current': true,
    },
    {
      'number': 4,
      'title': 'Hugo Lefèvre',
      'duration': '19:55',
      'completed': false,
    },
    {
      'number': 5,
      'title': 'The Sliding Doors',
      'duration': '24:30',
      'completed': false,
    },
    {
      'number': 6,
      'title': 'The Swimmer',
      'duration': '21:00',
      'completed': false,
    },
    {
      'number': 7,
      'title': 'End of the Road',
      'duration': '35 min',
      'completed': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: Spacing.lg),

                    // Book cover
                    _buildBookCover(),
                    const SizedBox(height: Spacing.xl),

                    // Progress bar
                    _buildProgressBar(),
                    const SizedBox(height: Spacing.xl),

                    // Main controls
                    _buildMainControls(),
                    const SizedBox(height: Spacing.lg),

                    // Secondary controls
                    _buildSecondaryControls(),
                    const SizedBox(height: Spacing.xl),

                    // Tab bar and content
                    _buildTabSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.screenHorizontal,
        vertical: Spacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Minimize button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.keyboard_arrow_down, size: 28),
          ),

          // Now Playing info
          Column(
            children: [
              Text(
                'NOW PLAYING',
                style: AppTypography.overline.copyWith(
                  color: AppColors.textHint,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 2),
              Text(_book['currentChapter'], style: AppTypography.labelMedium),
            ],
          ),

          // More options
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.more_vert, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCover() {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(Spacing.radiusLg),
        boxShadow: [
          // Neumorphic light shadow (top-left)
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            blurRadius: 20,
            offset: const Offset(-10, -10),
          ),
          // Neumorphic dark shadow (bottom-right)
          BoxShadow(
            color: AppColors.darkShadowLight.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(10, 10),
          ),
          // Subtle color glow
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 40,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.headphones,
          size: 80,
          color: AppColors.primary.withValues(alpha: 0.6),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        children: [
          // Slider with neumorphic track
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.border.withValues(alpha: 0.5),
              thumbColor: AppColors.primary,
              overlayColor: AppColors.primary.withValues(alpha: 0.2),
            ),
            child: Slider(
              value: _progress,
              onChanged: (value) => setState(() => _progress = value),
            ),
          ),

          // Time labels
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _book['currentTime'],
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _book['remainingTime'],
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
                Text(
                  _book['totalTime'],
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Rewind 30s - Neumorphic circle
          _buildCircularNeuButton(
            icon: Icons.replay_30,
            onTap: () {},
            size: 64,
          ),
          const SizedBox(width: Spacing.xl),

          // Play/Pause - Primary with glow
          GestureDetector(
            onTap: () => setState(() => _isPlaying = !_isPlaying),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [GlowStyles.primaryGlow],
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: Spacing.xl),

          // Forward 30s - Neumorphic circle
          _buildCircularNeuButton(
            icon: Icons.forward_30,
            onTap: () {},
            size: 64,
          ),
        ],
      ),
    );
  }

  Widget _buildCircularNeuButton({
    required IconData icon,
    required VoidCallback onTap,
    required double size,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          shape: BoxShape.circle,
          boxShadow: [
            // Light shadow (top-left)
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.9),
              blurRadius: 10,
              offset: const Offset(-5, -5),
            ),
            // Dark shadow (bottom-right)
            BoxShadow(
              color: AppColors.darkShadowLight.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: Icon(icon, size: size * 0.4, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildSecondaryControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSquareNeuButton(
            icon: Icons.speed,
            label: '${_speed}x',
            onTap: () => _showSpeedSettings(),
          ),
          _buildSquareNeuButton(
            icon: Icons.bookmark_outline,
            label: 'Bookmark',
            onTap: () => Navigator.pushNamed(context, Routes.bookmarks),
          ),
          _buildSquareNeuButton(
            icon: Icons.nightlight_outlined,
            label: 'Sleep',
            onTap: () => _showSleepTimer(),
          ),
          _buildSquareNeuButton(
            icon: Icons.directions_car_outlined,
            label: 'Car Mode',
            onTap: () => Navigator.pushNamed(context, Routes.carMode),
          ),
        ],
      ),
    );
  }

  Widget _buildSquareNeuButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(Spacing.radiusMd),
              boxShadow: [
                // Light shadow (top-left)
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.9),
                  blurRadius: 8,
                  offset: const Offset(-4, -4),
                ),
                // Dark shadow (bottom-right)
                BoxShadow(
                  color: AppColors.darkShadowLight.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Icon(icon, size: 24, color: AppColors.textSecondary),
          ),
          const SizedBox(height: Spacing.xs),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return Column(
      children: [
        // Tab bar with neumorphic style
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: Spacing.screenHorizontal,
          ),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
          ),
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Spacing.radiusMd),
            ),
            dividerColor: Colors.transparent,
            labelStyle: AppTypography.labelMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
            tabs: const [
              Tab(text: 'Chapters'),
              Tab(text: 'Transcript'),
              Tab(text: 'Queue'),
            ],
          ),
        ),
        const SizedBox(height: Spacing.md),

        // Tab content
        SizedBox(
          height: 400,
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildChaptersTab(),
              _buildTranscriptTab(),
              _buildQueueTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChaptersTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Column(
        children: [
          // Header with View all
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Chapters', style: AppTypography.h5),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'View all',
                  style: AppTypography.labelMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.md),

          // Chapters list
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _chapters.length,
              itemBuilder: (context, index) {
                final chapter = _chapters[index];
                return _buildChapterItem(chapter);
              },
            ),
          ),

          // UP NEXT section
          _buildUpNextSection(),
        ],
      ),
    );
  }

  Widget _buildCurrentChapterCard(Map<String, dynamic> chapter) {
    return Container(
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            blurRadius: 8,
            offset: const Offset(-3, -3),
          ),
          BoxShadow(
            color: AppColors.darkShadowLight.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Book cover mini
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.6),
                  AppColors.secondary.withValues(alpha: 0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(Spacing.radiusSm),
            ),
            child: const Icon(Icons.book, color: Colors.white, size: 24),
          ),
          const SizedBox(width: Spacing.md),

          // Chapter info
          Expanded(
            child: Text(
              'Chapter ${chapter['number']} • ${chapter['duration']}',
              style: AppTypography.labelLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Play button with glow
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [GlowStyles.primaryGlowSubtle],
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterNavButtons() {
    return Row(
      children: [
        Expanded(child: _buildNavButton(Icons.skip_previous, 'First Unplayed')),
        const SizedBox(width: Spacing.sm),
        Expanded(child: _buildNavButton(Icons.fast_forward, 'Next Chapter')),
        const SizedBox(width: Spacing.sm),
        Expanded(child: _buildNavButton(Icons.skip_next, 'Last Chapter')),
      ],
    );
  }

  Widget _buildNavButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: Spacing.sm + 2),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.7),
            blurRadius: 6,
            offset: const Offset(-2, -2),
          ),
          BoxShadow(
            color: AppColors.darkShadowLight.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondary,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildChapterItem(Map<String, dynamic> chapter) {
    final isCompleted = chapter['completed'] == true;
    final isCurrent = chapter['current'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: Spacing.xs),
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.md,
      ),
      decoration: BoxDecoration(
        color: isCurrent ? AppColors.primary.withValues(alpha: 0.08) : null,
        borderRadius: BorderRadius.circular(Spacing.radiusSm),
        border: isCurrent
            ? Border(left: BorderSide(color: AppColors.primary, width: 3))
            : null,
      ),
      child: Row(
        children: [
          // Status indicator
          SizedBox(
            width: 24,
            child: isCompleted
                ? Icon(Icons.check_circle, size: 18, color: AppColors.textHint)
                : isCurrent
                ? Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  )
                : Text(
                    '${chapter['number']}',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
          ),
          const SizedBox(width: Spacing.md),

          // Chapter info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Chapter ${chapter['number']}',
                  style: AppTypography.labelMedium.copyWith(
                    color: isCurrent
                        ? AppColors.primary
                        : AppColors.textPrimary,
                    fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isCurrent
                      ? 'Playing • ${chapter['duration']}'
                      : chapter['duration'],
                  style: AppTypography.labelSmall.copyWith(
                    color: isCurrent ? AppColors.primary : AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),

          // Action icon
          if (isCurrent)
            Icon(Icons.graphic_eq, size: 20, color: AppColors.primary)
          else if (!isCompleted)
            Icon(Icons.download_outlined, size: 20, color: AppColors.textHint),
        ],
      ),
    );
  }

  Widget _buildUpNextSection() {
    return Container(
      margin: const EdgeInsets.only(top: Spacing.md),
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            blurRadius: 8,
            offset: const Offset(-3, -3),
          ),
          BoxShadow(
            color: AppColors.darkShadowLight.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Book cover
          Container(
            width: 50,
            height: 65,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.teal.withValues(alpha: 0.3),
                  Colors.teal.withValues(alpha: 0.5),
                ],
              ),
              borderRadius: BorderRadius.circular(Spacing.radiusSm),
            ),
            child: const Center(
              child: Icon(Icons.book, color: Colors.teal, size: 24),
            ),
          ),
          const SizedBox(width: Spacing.md),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UP NEXT',
                  style: AppTypography.overline.copyWith(
                    color: AppColors.textHint,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Atomic Habits',
                  style: AppTypography.labelMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'by James Clear',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Skip to next button
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.skip_next, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildTranscriptTab() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.text_snippet_outlined,
            size: 48,
            color: AppColors.textHint,
          ),
          SizedBox(height: Spacing.md),
          Text('Transcript', style: TextStyle(color: AppColors.textSecondary)),
          SizedBox(height: Spacing.sm),
          Text(
            'Follow along with the text',
            style: TextStyle(color: AppColors.textHint, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.queue_music_outlined, size: 48, color: AppColors.textHint),
          const SizedBox(height: Spacing.md),
          Text(
            'Your queue is empty',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: Spacing.sm),
          Text(
            'Add books to listen next',
            style: AppTypography.caption.copyWith(color: AppColors.textHint),
          ),
        ],
      ),
    );
  }

  void _showSpeedSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => SpeedSettingsSheet(
        currentSpeed: _speed,
        onSpeedChanged: (speed) => setState(() => _speed = speed),
      ),
    );
  }

  void _showSleepTimer() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const SleepTimerSheet(),
    );
  }
}
