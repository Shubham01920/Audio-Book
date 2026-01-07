// =============================================================================
// STORAGE SCREEN - Data & Storage Settings
// =============================================================================
// Storage management with:
// - Storage usage breakdown
// - Download quality settings
// - Cache management
// - Offline storage limits
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

class StorageScreen extends StatefulWidget {
  const StorageScreen({super.key});

  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen> {
  String _downloadQuality = 'high';
  bool _wifiOnly = true;
  bool _autoDelete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(Spacing.screenHorizontal),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(width: Spacing.md),
                    Text('Data & Storage', style: AppTypography.h4),
                  ],
                ),
              ),

              // Storage Overview
              _buildStorageOverview(),
              const SizedBox(height: Spacing.lg),

              // Download Settings
              _buildSectionHeader('DOWNLOAD SETTINGS'),
              _buildQualitySelector(),
              const SizedBox(height: Spacing.sm),
              _buildToggle(
                'Wi-Fi Only',
                'Only download on Wi-Fi',
                _wifiOnly,
                (v) => setState(() => _wifiOnly = v),
              ),
              _buildToggle(
                'Auto-Delete Finished',
                'Remove after listening',
                _autoDelete,
                (v) => setState(() => _autoDelete = v),
              ),
              const SizedBox(height: Spacing.lg),

              // Cache Management
              _buildSectionHeader('CACHE'),
              _buildCacheTile(),
              const SizedBox(height: Spacing.xxl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStorageOverview() {
    final items = [
      {
        'label': 'Audiobooks',
        'size': '1.8 GB',
        'color': AppColors.primary,
        'percent': 0.6,
      },
      {
        'label': 'Cache',
        'size': '156 MB',
        'color': Colors.orange,
        'percent': 0.15,
      },
      {
        'label': 'Other',
        'size': '450 MB',
        'color': Colors.grey,
        'percent': 0.25,
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          children: [
            // Total usage
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '2.4 GB',
                  style: AppTypography.h2.copyWith(color: AppColors.primary),
                ),
                const SizedBox(width: Spacing.sm),
                Text(
                  'used',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Spacing.md),

            // Progress bar
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: AppColors.border.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: items.map((item) {
                  return Expanded(
                    flex: ((item['percent'] as double) * 100).toInt(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: item['color'] as Color,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: Spacing.lg),

            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items.map((item) {
                return Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: item['color'] as Color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: Spacing.xs),
                    Text(
                      '${item['label']}\n${item['size']}',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.screenHorizontal,
        vertical: Spacing.sm,
      ),
      child: Text(
        title,
        style: AppTypography.overline.copyWith(
          color: AppColors.textHint,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildQualitySelector() {
    final options = [
      {'value': 'low', 'label': 'Low', 'desc': '64 kbps'},
      {'value': 'medium', 'label': 'Medium', 'desc': '128 kbps'},
      {'value': 'high', 'label': 'High', 'desc': '320 kbps'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Download Quality', style: AppTypography.labelMedium),
            const SizedBox(height: Spacing.md),
            Row(
              children: options.map((opt) {
                final isSelected = _downloadQuality == opt['value'];
                return Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _downloadQuality = opt['value']!),
                    child: Container(
                      margin: EdgeInsets.only(
                        right: opt['value'] == 'high' ? 0 : Spacing.sm,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: Spacing.md),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(Spacing.radiusSm),
                        boxShadow: isSelected
                            ? [GlowStyles.primaryGlowSubtle]
                            : null,
                      ),
                      child: Column(
                        children: [
                          Text(
                            opt['label']!,
                            style: AppTypography.labelMedium.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            opt['desc']!,
                            style: AppTypography.labelSmall.copyWith(
                              color: isSelected
                                  ? Colors.white70
                                  : AppColors.textHint,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggle(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.screenHorizontal,
        vertical: Spacing.xs,
      ),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.labelMedium),
                  Text(
                    subtitle,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primary,
              activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCacheTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: GestureDetector(
        onTap: () {},
        child: NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(Spacing.radiusSm),
                ),
                child: Icon(
                  Icons.cleaning_services_outlined,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Clear Cache', style: AppTypography.labelMedium),
                    Text(
                      '156 MB can be freed',
                      style: AppTypography.labelSmall.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.sm,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(Spacing.radiusFull),
                  boxShadow: [GlowStyles.colorGlowSubtle(Colors.orange)],
                ),
                child: Text(
                  'Clear',
                  style: AppTypography.labelSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
