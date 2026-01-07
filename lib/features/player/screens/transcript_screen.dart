// =============================================================================
// TRANSCRIPT SCREEN - Full Audio Transcript (NEW)
// =============================================================================
// Full transcript view with:
// - Chapter info and progress
// - Search transcript functionality
// - Timestamped speaker sections
// - Highlighted current playing text
// - Bottom playback controls
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

class TranscriptScreen extends StatefulWidget {
  const TranscriptScreen({super.key});

  @override
  State<TranscriptScreen> createState() => _TranscriptScreenState();
}

class _TranscriptScreenState extends State<TranscriptScreen> {
  bool _isPlaying = true;
  final _searchController = TextEditingController();

  final List<Map<String, dynamic>> _transcript = [
    {
      'timestamp': '1:15:20',
      'speaker': 'NARRATOR',
      'text':
          'Before the dawn, a hidden trail emerged. It was not on any map, known only to the oldest of the village elders. A path to a forgotten time, a forgotten truth.',
      'isCurrent': false,
    },
    {
      'timestamp': '1:16:05',
      'speaker': 'ELARA',
      'text':
          '"This is it," Elara had whispered, her eyes wide with a mix of fear and exhilaration. "The gateway to what they spoke of in the ancient texts."',
      'isCurrent': true,
    },
    {
      'timestamp': '1:16:50',
      'speaker': 'KAEL',
      'text':
          'Kael, ever the pragmatist, scanned the dense foliage. "The legends speak of guardians. We must be cautious. They said the path reveals itself...',
      'isCurrent': false,
    },
    {
      'timestamp': '1:17:30',
      'speaker': 'NARRATOR',
      'text':
          'The mist began to part, revealing stone steps carved into the mountainside, each one glowing faintly with an otherworldly light...',
      'isCurrent': false,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
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

            // Search bar
            _buildSearchBar(),
            const SizedBox(height: Spacing.md),

            // Chapter title
            _buildChapterTitle(),
            const SizedBox(height: Spacing.md),

            // Transcript content
            Expanded(child: _buildTranscriptList()),

            // Bottom controls
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chapter 4 of 12', style: AppTypography.h4),
                Text(
                  '1:23:45 / 12:45:30',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(Spacing.sm),
              child: const Icon(Icons.close, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.pressed,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.textHint, size: 20),
            const SizedBox(width: Spacing.sm),
            Expanded(
              child: TextField(
                controller: _searchController,
                style: AppTypography.bodyMedium,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search transcript...',
                  hintStyle: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChapterTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Text('Chapter 3: The Forgotten Path', style: AppTypography.h4),
    );
  }

  Widget _buildTranscriptList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      physics: const BouncingScrollPhysics(),
      itemCount: _transcript.length,
      itemBuilder: (context, index) {
        final item = _transcript[index];
        return _buildTranscriptItem(item);
      },
    );
  }

  Widget _buildTranscriptItem(Map<String, dynamic> item) {
    final isCurrent = item['isCurrent'] == true;
    final isNarrator = item['speaker'] == 'NARRATOR';

    return Container(
      margin: const EdgeInsets.only(bottom: Spacing.lg),
      padding: isCurrent ? const EdgeInsets.all(Spacing.md) : null,
      decoration: isCurrent
          ? BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(Spacing.radiusMd),
              border: Border(
                left: BorderSide(color: AppColors.primary, width: 3),
              ),
              boxShadow: [GlowStyles.primaryGlowSubtle],
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timestamp and speaker
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: isCurrent
                      ? AppColors.primary.withValues(alpha: 0.2)
                      : AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item['timestamp'],
                  style: AppTypography.labelSmall.copyWith(
                    color: isCurrent ? AppColors.primary : AppColors.textHint,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: Spacing.sm),
              Text(
                item['speaker'],
                style: AppTypography.labelSmall.copyWith(
                  color: isNarrator
                      ? AppColors.textSecondary
                      : AppColors.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.sm),

          // Text content
          Text(
            item['text'],
            style: AppTypography.bodyMedium.copyWith(
              color: isCurrent
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
              height: 1.6,
              fontStyle: isNarrator ? FontStyle.normal : FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        boxShadow: [
          BoxShadow(
            color: AppColors.darkShadowLight.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress bar with gradient glow
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.35,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: Spacing.sm),

          // Time labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1:23:45',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '-11:21:45',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.md),

          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Speed
              Text(
                '1.0x',
                style: AppTypography.labelMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),

              // Rewind
              _buildSmallControl(Icons.replay_10, () {}),

              // Play/Pause with glow
              GestureDetector(
                onTap: () => setState(() => _isPlaying = !_isPlaying),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                    boxShadow: [GlowStyles.accentGlow],
                  ),
                  child: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),

              // Forward
              _buildSmallControl(Icons.forward_10, () {}),

              // Chapters
              _buildSmallControl(Icons.list, () {}),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildSmallControl(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.textSecondary, size: 24),
      ),
    );
  }
}
