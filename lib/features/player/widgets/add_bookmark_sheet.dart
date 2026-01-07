// =============================================================================
// ADD BOOKMARK SHEET - Create New Bookmark
// =============================================================================
// Bottom sheet for adding bookmarks with:
// - Bookmark name input
// - Current position display
// - Tags input
// - Chapter preview with quote
// - Public/Notes toggles
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

class AddBookmarkSheet extends StatefulWidget {
  const AddBookmarkSheet({super.key});

  @override
  State<AddBookmarkSheet> createState() => _AddBookmarkSheetState();
}

class _AddBookmarkSheetState extends State<AddBookmarkSheet> {
  final _nameController = TextEditingController(text: 'Great Quote - Ch 3');
  final _tagsController = TextEditingController(
    text: '#inspirational #chapter3',
  );
  bool _isPublic = false;
  bool _addToNotes = true;

  @override
  void dispose() {
    _nameController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Spacing.radiusXl),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: Spacing.md),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: Spacing.lg),

              // Title
              Center(child: Text('Add Bookmark', style: AppTypography.h4)),
              const SizedBox(height: Spacing.xl),

              // Form fields
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.screenHorizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bookmark Name
                    _buildLabel('Bookmark Name'),
                    const SizedBox(height: Spacing.sm),
                    _buildTextField(_nameController, 'Enter bookmark name'),
                    const SizedBox(height: Spacing.lg),

                    // Current Position
                    _buildLabel('Current Position'),
                    const SizedBox(height: Spacing.sm),
                    _buildPositionField(),
                    const SizedBox(height: Spacing.lg),

                    // Tags
                    _buildLabel('Tags'),
                    const SizedBox(height: Spacing.sm),
                    _buildTagsField(),
                    const SizedBox(height: Spacing.lg),

                    // Chapter Preview
                    _buildChapterPreview(),
                    const SizedBox(height: Spacing.lg),

                    // Toggle options
                    _buildToggleOption('Public', _isPublic, (v) {
                      setState(() => _isPublic = v);
                    }),
                    _buildToggleOption('Add to Notes', _addToNotes, (v) {
                      setState(() => _addToNotes = v);
                    }),
                    const SizedBox(height: Spacing.xl),

                    // Action buttons
                    _buildActionButtons(),
                    const SizedBox(height: Spacing.xl),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTypography.labelMedium.copyWith(color: AppColors.textSecondary),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return NeuContainer(
      style: NeuStyle.pressed,
      intensity: NeuIntensity.light,
      borderRadius: Spacing.radiusMd,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: TextField(
        controller: controller,
        style: AppTypography.bodyMedium,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.textHint,
          ),
        ),
      ),
    );
  }

  Widget _buildPositionField() {
    return NeuContainer(
      style: NeuStyle.pressed,
      intensity: NeuIntensity.light,
      borderRadius: Spacing.radiusMd,
      padding: const EdgeInsets.all(Spacing.md),
      child: Row(
        children: [
          Expanded(child: Text('1:23:45', style: AppTypography.bodyMedium)),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, size: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsField() {
    return NeuContainer(
      style: NeuStyle.pressed,
      intensity: NeuIntensity.light,
      borderRadius: Spacing.radiusMd,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
      child: TextField(
        controller: _tagsController,
        style: AppTypography.bodyMedium.copyWith(color: AppColors.primary),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '#tag1 #tag2',
          hintStyle: AppTypography.bodyMedium.copyWith(
            color: AppColors.textHint,
          ),
        ),
      ),
    );
  }

  Widget _buildChapterPreview() {
    return Container(
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        border: Border(left: BorderSide(color: AppColors.primary, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chapter 3: The Great Revelation',
            style: AppTypography.labelMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: Spacing.xs),
          Row(
            children: [
              Icon(Icons.access_time, size: 12, color: AppColors.textHint),
              const SizedBox(width: 4),
              Text(
                '1:23:45 → 1:24:30',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.sm),
          RichText(
            text: TextSpan(
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
              children: [
                const TextSpan(text: '"...It was the best of times, '),
                TextSpan(
                  text: 'it was the worst of times',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const TextSpan(
                  text:
                      ', it was the age of wisdom, it was the age of foolishness..."',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleOption(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodyMedium),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // Cancel button
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: NeuContainer(
              style: NeuStyle.raised,
              intensity: NeuIntensity.light,
              borderRadius: Spacing.radiusMd,
              padding: const EdgeInsets.symmetric(vertical: Spacing.md),
              child: Center(
                child: Text(
                  'Cancel',
                  style: AppTypography.buttonMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: Spacing.md),

        // Save button with glow
        Expanded(
          flex: 2,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: Spacing.md),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                boxShadow: [GlowStyles.primaryGlow],
              ),
              child: Center(
                child: Text(
                  'Save Bookmark',
                  style: AppTypography.buttonMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
