// =============================================================================
// PREFERENCES SCREEN - User Preferences Setup (Page 4)
// =============================================================================
// Allows users to select their preferred genres and reading preferences
// during onboarding.
//
// NAVIGATION RELATIONSHIPS:
// - From: Login Screen (Page 3)
// - To: Main Shell on completion
// - Dependencies: neu_button.dart, neu_container.dart
// =============================================================================

import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_button.dart';

/// Preferences setup screen.
///
/// Allows users to select:
/// - Preferred genres
/// - Reading goals
/// - Notification preferences
class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  // Selected genres
  final Set<String> _selectedGenres = {};

  // Available genres
  final List<_GenreItem> _genres = [
    _GenreItem('Fiction', Icons.auto_stories_outlined),
    _GenreItem('Mystery', Icons.search_outlined),
    _GenreItem('Romance', Icons.favorite_outline),
    _GenreItem('Sci-Fi', Icons.rocket_launch_outlined),
    _GenreItem('Fantasy', Icons.castle_outlined),
    _GenreItem('Thriller', Icons.flash_on_outlined),
    _GenreItem('History', Icons.history_edu_outlined),
    _GenreItem('Biography', Icons.person_outline),
    _GenreItem('Self-Help', Icons.psychology_outlined),
    _GenreItem('Business', Icons.business_outlined),
    _GenreItem('Health', Icons.health_and_safety_outlined),
    _GenreItem('Travel', Icons.flight_outlined),
  ];

  /// Handle continue action
  void _handleContinue() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(Spacing.screenHorizontal),
              child: _buildHeader(),
            ),

            // Genre grid
            Expanded(child: _buildGenreGrid()),

            // Bottom section
            Padding(
              padding: const EdgeInsets.all(Spacing.screenHorizontal),
              child: Column(
                children: [
                  // Selected count
                  if (_selectedGenres.isNotEmpty) ...[
                    Text(
                      '${_selectedGenres.length} genre${_selectedGenres.length > 1 ? 's' : ''} selected',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: Spacing.md),
                  ],

                  // Continue button
                  NeuButton(
                    text: _selectedGenres.isEmpty ? 'Skip for now' : 'Continue',
                    onPressed: _handleContinue,
                    variant: NeuButtonVariant.secondary,
                    size: NeuButtonSize.large,
                    textColor: _selectedGenres.isEmpty
                        ? AppColors.textSecondary
                        : AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build header section
  Widget _buildHeader() {
    return Column(
      children: [
        const SizedBox(height: Spacing.md),

        // Progress indicator
        Row(
          children: [
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: Spacing.xs),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(width: Spacing.xs),
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.xl),

        // Title
        Text(
          'What do you like to listen?',
          style: AppTypography.h2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacing.sm),

        // Subtitle
        Text(
          'Select at least 3 genres to personalize your experience',
          style: AppTypography.subtitle.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Build genre selection grid
  Widget _buildGenreGrid() {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: Spacing.md,
        mainAxisSpacing: Spacing.md,
        childAspectRatio: 0.9,
      ),
      itemCount: _genres.length,
      itemBuilder: (context, index) {
        final genre = _genres[index];
        final isSelected = _selectedGenres.contains(genre.name);
        return _buildGenreChip(genre, isSelected);
      },
    );
  }

  /// Build individual genre chip
  Widget _buildGenreChip(_GenreItem genre, bool isSelected) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedGenres.remove(genre.name);
          } else {
            _selectedGenres.add(genre.name);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Spacing.radiusMd),
                border: Border.all(color: AppColors.primary, width: 2),
              )
            : NeuDecoration.raised(
                radius: Spacing.radiusMd,
                intensity: NeuIntensity.light,
                isDark: isDark,
              ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                genre.icon,
                size: 24,
                color: isSelected ? Colors.white : AppColors.primary,
              ),
            ),
            const SizedBox(height: Spacing.sm),

            // Name
            Text(
              genre.name,
              style: AppTypography.labelMedium.copyWith(
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Data class for genre items
class _GenreItem {
  final String name;
  final IconData icon;

  _GenreItem(this.name, this.icon);
}
