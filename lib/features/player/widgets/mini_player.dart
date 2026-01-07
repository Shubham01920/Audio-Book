// =============================================================================
// MINI PLAYER - Compact Player Widget (Redesigned)
// =============================================================================
// Compact player bar with neumorphic design:
// - Progress bar with gradient glow
// - Book cover with subtle shadow
// - Play/pause with glow effect
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/glow/glow_styles.dart';
import '../../../app/routes.dart';

class MiniPlayer extends StatefulWidget {
  final bool isVisible;

  const MiniPlayer({super.key, this.isVisible = true});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  bool _isPlaying = true;
  final double _progress = 0.35;

  final Map<String, dynamic> _book = {
    'title': 'The Midnight Library',
    'author': 'Matt Haig',
    'chapter': 'Chapter 5',
  };

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return const SizedBox.shrink();

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.player),
      child: Container(
        height: 76,
        margin: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(Spacing.radiusMd),
          boxShadow: [
            // Light shadow (top-left) - neumorphic
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.8),
              blurRadius: 10,
              offset: const Offset(-4, -4),
            ),
            // Dark shadow (bottom-right) - neumorphic
            BoxShadow(
              color: AppColors.darkShadowLight.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(4, 4),
            ),
            // Subtle primary glow
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            // Progress bar with gradient glow
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Spacing.radiusMd),
                topRight: Radius.circular(Spacing.radiusMd),
              ),
              child: Container(
                height: 4,
                color: AppColors.border.withValues(alpha: 0.5),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progress,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.secondary],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.5),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
                child: Row(
                  children: [
                    // Book cover with glow
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary.withValues(alpha: 0.15),
                            AppColors.secondary.withValues(alpha: 0.25),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(Spacing.radiusSm),
                        boxShadow: [GlowStyles.primaryGlowSubtle],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.headphones,
                          size: 24,
                          color: AppColors.primary.withValues(alpha: 0.8),
                        ),
                      ),
                    ),
                    const SizedBox(width: Spacing.md),

                    // Title and info
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _book['title'],
                            style: AppTypography.labelMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${_book['author']} • ${_book['chapter']}',
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Controls with glow
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Rewind
                        _buildControlButton(
                          icon: Icons.replay_10,
                          onTap: () {},
                          hasGlow: false,
                        ),
                        const SizedBox(width: Spacing.xs),

                        // Play/Pause with glow
                        _buildControlButton(
                          icon: _isPlaying ? Icons.pause : Icons.play_arrow,
                          onTap: () => setState(() => _isPlaying = !_isPlaying),
                          hasGlow: true,
                          isPrimary: true,
                        ),
                        const SizedBox(width: Spacing.xs),

                        // Forward
                        _buildControlButton(
                          icon: Icons.forward_10,
                          onTap: () {},
                          hasGlow: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasGlow = false,
    bool isPrimary = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isPrimary ? 44 : 36,
        height: isPrimary ? 44 : 36,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : Colors.transparent,
          shape: BoxShape.circle,
          boxShadow: hasGlow ? [GlowStyles.primaryGlow] : null,
        ),
        child: Icon(
          icon,
          size: isPrimary ? 24 : 20,
          color: isPrimary ? Colors.white : AppColors.textSecondary,
        ),
      ),
    );
  }
}
