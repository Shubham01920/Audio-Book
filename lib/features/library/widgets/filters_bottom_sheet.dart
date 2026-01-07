// =============================================================================
// FILTERS BOTTOM SHEET - Library Filters
// =============================================================================
// Bottom sheet for sorting and filtering library books.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - From: Library Screen (modal)
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_button.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class FiltersBottomSheet extends StatefulWidget {
  const FiltersBottomSheet({super.key});

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  String _selectedSort = 'Recent';
  String _selectedStatus = 'All';
  Set<String> _selectedGenres = {};

  final List<String> _sortOptions = [
    'Recent',
    'Title',
    'Author',
    'Length',
    'Progress',
  ];
  final List<String> _statusOptions = [
    'All',
    'In Progress',
    'Finished',
    'Not Started',
    'Downloaded',
  ];
  final List<Map<String, dynamic>> _genres = [
    {'name': 'Fiction', 'color': Colors.purple},
    {'name': 'Non-Fiction', 'color': Colors.teal},
    {'name': 'Self-Help', 'color': Colors.orange},
    {'name': 'Business', 'color': Colors.blue},
    {'name': 'Sci-Fi', 'color': Colors.indigo},
    {'name': 'Mystery', 'color': Colors.pink},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacing.lg),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Spacing.radiusXl),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkShadowLight.withValues(alpha: 0.15),
            blurRadius: 30,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(height: Spacing.lg),

          // Title with icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(Spacing.radiusSm),
                ),
                child: const Icon(
                  Icons.tune,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: Spacing.sm),
              Text('Sort & Filter', style: AppTypography.h3),
              const Spacer(),
              // Active filter count
              if (_selectedSort != 'Recent' ||
                  _selectedStatus != 'All' ||
                  _selectedGenres.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.sm,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(Spacing.radiusFull),
                    boxShadow: [GlowStyles.primaryGlowSubtle],
                  ),
                  child: Text(
                    '${(_selectedSort != 'Recent' ? 1 : 0) + (_selectedStatus != 'All' ? 1 : 0) + _selectedGenres.length} active',
                    style: AppTypography.labelSmall.copyWith(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: Spacing.xl),

          // Sort By
          Text('Sort By', style: AppTypography.labelLarge),
          const SizedBox(height: Spacing.md),
          Wrap(
            spacing: Spacing.sm,
            runSpacing: Spacing.sm,
            children: _sortOptions.map((option) {
              return _buildOptionChip(
                option,
                _selectedSort == option,
                () => setState(() => _selectedSort = option),
              );
            }).toList(),
          ),
          const SizedBox(height: Spacing.lg),

          // Status
          Text('Status', style: AppTypography.labelLarge),
          const SizedBox(height: Spacing.md),
          Wrap(
            spacing: Spacing.sm,
            runSpacing: Spacing.sm,
            children: _statusOptions.map((option) {
              return _buildOptionChip(
                option,
                _selectedStatus == option,
                () => setState(() => _selectedStatus = option),
              );
            }).toList(),
          ),
          const SizedBox(height: Spacing.lg),

          // Genres
          Text('Genres', style: AppTypography.labelLarge),
          const SizedBox(height: Spacing.md),
          Wrap(
            spacing: Spacing.sm,
            runSpacing: Spacing.sm,
            children: _genres.map((genre) {
              final isSelected = _selectedGenres.contains(genre['name']);
              final color = genre['color'] as Color;
              return _buildGenreChip(
                genre['name'] as String,
                color,
                isSelected,
                () {
                  setState(() {
                    if (isSelected) {
                      _selectedGenres.remove(genre['name']);
                    } else {
                      _selectedGenres.add(genre['name'] as String);
                    }
                  });
                },
              );
            }).toList(),
          ),

          const SizedBox(height: Spacing.xl),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: NeuButton(
                  text: 'Reset',
                  onPressed: () {
                    setState(() {
                      _selectedSort = 'Recent';
                      _selectedStatus = 'All';
                      _selectedGenres.clear();
                    });
                  },
                  variant: NeuButtonVariant.secondary,
                ),
              ),
              const SizedBox(width: Spacing.md),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Spacing.radiusMd),
                    boxShadow: [GlowStyles.primaryGlowSubtle],
                  ),
                  child: NeuButton(
                    text: 'Apply Filters',
                    onPressed: () => Navigator.pop(context),
                    variant: NeuButtonVariant.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.lg),
        ],
      ),
    );
  }

  Widget _buildOptionChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(Spacing.radiusFull),
          border: isSelected ? null : Border.all(color: AppColors.border),
          boxShadow: isSelected ? [GlowStyles.primaryGlowSubtle] : null,
        ),
        child: Text(
          label,
          style: AppTypography.labelMedium.copyWith(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildGenreChip(
    String label,
    Color color,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected ? color : AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(Spacing.radiusFull),
          border: Border.all(color: isSelected ? color : AppColors.border),
          boxShadow: isSelected ? [GlowStyles.colorGlowSubtle(color)] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              const Icon(Icons.check, size: 14, color: Colors.white),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: AppTypography.labelMedium.copyWith(
                color: isSelected ? Colors.white : color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
