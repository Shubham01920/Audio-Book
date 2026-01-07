// =============================================================================
// DOWNLOADS SCREEN - Offline Content (Page 17)
// =============================================================================
// Manages downloaded audiobooks for offline listening.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - From: Library
// - To: Player
// =============================================================================

import 'package:flutter/material.dart';
import 'package:ui_app/core/theme/neumorphism/neumorphic_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';
import '../../../app/routes.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  final List<Map<String, dynamic>> _downloads = const [
    {
      'title': 'Atomic Habits',
      'author': 'James Clear',
      'size': '280 MB',
      'status': 'complete',
      'color': Colors.purple,
    },
    {
      'title': 'Deep Work',
      'author': 'Cal Newport',
      'size': '320 MB',
      'status': 'complete',
      'color': Colors.teal,
    },
    {
      'title': 'Psychology of Money',
      'author': 'Morgan Housel',
      'size': '240 MB',
      'status': 'downloading',
      'progress': 0.65,
      'color': Colors.orange,
    },
    {
      'title': 'The Midnight Library',
      'author': 'Matt Haig',
      'size': '350 MB',
      'status': 'pending',
      'color': Colors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(Spacing.sm),
            child: NeuContainer(
              style: NeuStyle.raised,
              intensity: NeuIntensity.light,
              isCircular: true,
              child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            ),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                boxShadow: [GlowStyles.colorGlowSubtle(Colors.teal)],
              ),
              child: const Icon(
                Icons.download_done,
                color: Colors.teal,
                size: 18,
              ),
            ),
            const SizedBox(width: Spacing.sm),
            Text('Downloads', style: AppTypography.h3),
          ],
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(Spacing.sm),
              child: NeuContainer(
                style: NeuStyle.raised,
                intensity: NeuIntensity.light,
                isCircular: true,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.settings,
                  color: AppColors.textSecondary,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStorageInfo(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(Spacing.screenHorizontal),
              physics: const BouncingScrollPhysics(),
              itemCount: _downloads.length,
              itemBuilder: (context, index) =>
                  _buildDownloadItem(context, _downloads[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageInfo() {
    return Container(
      margin: const EdgeInsets.all(Spacing.screenHorizontal),
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal.withValues(alpha: 0.1),
            Colors.blue.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(Spacing.sm),
            decoration: BoxDecoration(
              color: Colors.teal.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              boxShadow: [GlowStyles.colorGlowSubtle(Colors.teal)],
            ),
            child: const Icon(Icons.storage, color: Colors.teal, size: 24),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1.19 GB used', style: AppTypography.labelLarge),
                const SizedBox(height: Spacing.xs),
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
                          colors: [Colors.teal, Colors.blue],
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Spacing.xs),
                Text(
                  '2.21 GB available',
                  style: AppTypography.caption.copyWith(
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

  Widget _buildDownloadItem(BuildContext context, Map<String, dynamic> item) {
    final status = item['status'] as String;
    final color = item['color'] as Color;
    final isComplete = status == 'complete';
    final isDownloading = status == 'downloading';

    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.md),
      child: GestureDetector(
        onTap: isComplete
            ? () => Navigator.pushNamed(context, Routes.player)
            : null,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
            boxShadow: isComplete ? [GlowStyles.successGlowSubtle] : null,
          ),
          child: NeuContainer(
            style: NeuStyle.raised,
            intensity: NeuIntensity.light,
            borderRadius: Spacing.radiusMd,
            padding: const EdgeInsets.all(Spacing.md),
            child: Row(
              children: [
                // Status indicator
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    boxShadow: isComplete
                        ? [GlowStyles.successGlowSubtle]
                        : isDownloading
                        ? [GlowStyles.colorGlowSubtle(color)]
                        : null,
                  ),
                  child: isDownloading
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: item['progress'] as double,
                              strokeWidth: 3,
                              color: color,
                              backgroundColor: color.withValues(alpha: 0.2),
                            ),
                            Text(
                              '${((item['progress'] as double) * 100).toInt()}%',
                              style: AppTypography.labelSmall.copyWith(
                                color: color,
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : Icon(
                          _getStatusIcon(status),
                          color: _getStatusColor(status),
                          size: 24,
                        ),
                ),
                const SizedBox(width: Spacing.md),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: AppTypography.labelLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['author'] as String,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: Spacing.xs),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                status,
                              ).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _getStatusText(status),
                              style: AppTypography.labelSmall.copyWith(
                                color: _getStatusColor(status),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            item['size'] as String,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Actions
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.textSecondary,
                  ),
                  onSelected: (value) {},
                  itemBuilder: (context) => [
                    if (isComplete)
                      const PopupMenuItem(value: 'play', child: Text('Play')),
                    const PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'complete':
        return AppColors.success;
      case 'downloading':
        return Colors.orange;
      case 'pending':
        return AppColors.textSecondary;
      default:
        return AppColors.textSecondary;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'complete':
        return Icons.check_circle;
      case 'downloading':
        return Icons.downloading;
      case 'pending':
        return Icons.schedule;
      default:
        return Icons.help_outline;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'complete':
        return 'Ready';
      case 'downloading':
        return 'Downloading';
      case 'pending':
        return 'Queued';
      default:
        return status;
    }
  }
}
