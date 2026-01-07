// =============================================================================
// LANGUAGE SCREEN - Language & Region Settings
// =============================================================================
// Language and regional settings with:
// - App language selection
// - Content language preferences
// - Region/timezone settings
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

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _appLanguage = 'English (US)';
  String _contentLanguage = 'English';
  String _region = 'United States';

  final List<String> _languages = [
    'English (US)',
    'English (UK)',
    'Spanish',
    'French',
    'German',
    'Japanese',
    'Chinese (Simplified)',
    'Portuguese',
    'Hindi',
  ];

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
                    Text('Language & Region', style: AppTypography.h4),
                  ],
                ),
              ),

              // App Language
              _buildSectionHeader('APP LANGUAGE'),
              _buildLanguageSelector(
                _appLanguage,
                (v) => setState(() => _appLanguage = v),
              ),
              const SizedBox(height: Spacing.lg),

              // Content Language
              _buildSectionHeader('CONTENT LANGUAGE'),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.screenHorizontal,
                ),
                child: Text(
                  'Preferred language for audiobook content',
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
              ),
              const SizedBox(height: Spacing.sm),
              _buildContentLanguages(),
              const SizedBox(height: Spacing.lg),

              // Region
              _buildSectionHeader('REGION'),
              _buildRegionTile(),
              const SizedBox(height: Spacing.xxl),
            ],
          ),
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

  Widget _buildLanguageSelector(
    String current,
    ValueChanged<String> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: EdgeInsets.zero,
        child: Column(
          children: _languages.map((lang) {
            final isSelected = current == lang;
            return Column(
              children: [
                InkWell(
                  onTap: () => onChanged(lang),
                  child: Padding(
                    padding: const EdgeInsets.all(Spacing.md),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(lang, style: AppTypography.labelMedium),
                        ),
                        if (isSelected)
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [GlowStyles.primaryGlowSubtle],
                            ),
                            child: Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (lang != _languages.last)
                  Divider(
                    height: 1,
                    indent: Spacing.md,
                    endIndent: Spacing.md,
                    color: AppColors.border.withValues(alpha: 0.5),
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildContentLanguages() {
    final contentLangs = ['English', 'Spanish', 'French', 'German'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: Wrap(
        spacing: Spacing.sm,
        runSpacing: Spacing.sm,
        children: contentLangs.map((lang) {
          final isSelected = _contentLanguage == lang;
          return GestureDetector(
            onTap: () => setState(() => _contentLanguage = lang),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.lg,
                vertical: Spacing.sm,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(Spacing.radiusFull),
                boxShadow: isSelected
                    ? [GlowStyles.primaryGlowSubtle]
                    : [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.8),
                          blurRadius: 4,
                          offset: Offset(-2, -2),
                        ),
                        BoxShadow(
                          color: AppColors.darkShadowLight.withValues(
                            alpha: 0.1,
                          ),
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
              ),
              child: Text(
                lang,
                style: AppTypography.labelMedium.copyWith(
                  color: isSelected ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRegionTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.screenHorizontal),
      child: NeuContainer(
        style: NeuStyle.raised,
        intensity: NeuIntensity.light,
        borderRadius: Spacing.radiusMd,
        padding: const EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
              ),
              child: Icon(Icons.public, color: AppColors.primary),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Region', style: AppTypography.labelMedium),
                  Text(
                    _region,
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textHint, size: 20),
          ],
        ),
      ),
    );
  }
}
