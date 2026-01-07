// =============================================================================
// ADVANCED SEARCH FILTERS SCREEN - Search Filtering (Page 21)
// =============================================================================
// DESIGN: 60% Neumorphism + 30% Solid Glow + 10% Flat Elements
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class AdvancedSearchFiltersScreen extends StatefulWidget {
  const AdvancedSearchFiltersScreen({super.key});

  @override
  State<AdvancedSearchFiltersScreen> createState() =>
      _AdvancedSearchFiltersScreenState();
}

class _AdvancedSearchFiltersScreenState
    extends State<AdvancedSearchFiltersScreen> {
  // Filter states
  RangeValues _durationRange = const RangeValues(1, 30);
  RangeValues _ratingRange = const RangeValues(3, 5);
  String _sortBy = 'Relevance';
  final Set<String> _selectedGenres = {'Fiction', 'Mystery'};
  final Set<String> _selectedFormats = {'Audiobook'};
  bool _freeOnly = false;
  bool _newReleasesOnly = false;

  final List<String> _genres = [
    'Fiction',
    'Mystery',
    'Sci-Fi',
    'Romance',
    'Thriller',
    'Fantasy',
    'Non-Fiction',
    'Biography',
    'Self-Help',
    'Business',
  ];
  final List<String> _formats = ['Audiobook', 'eBook', 'Podcast', 'Summary'];
  final List<String> _sortOptions = [
    'Relevance',
    'Newest',
    'Highest Rated',
    'Most Popular',
    'Duration',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.screenHorizontal,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSortSection(),
                    const SizedBox(height: Spacing.xl),
                    _buildGenreSection(),
                    const SizedBox(height: Spacing.xl),
                    _buildFormatSection(),
                    const SizedBox(height: Spacing.xl),
                    _buildDurationSection(),
                    const SizedBox(height: Spacing.xl),
                    _buildRatingSection(),
                    const SizedBox(height: Spacing.xl),
                    _buildToggleFilters(),
                    const SizedBox(height: Spacing.xxl),
                  ],
                ),
              ),
            ),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(Spacing.radiusSm),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.8),
                    blurRadius: 6,
                    offset: Offset(-3, -3),
                  ),
                  BoxShadow(
                    color: AppColors.darkShadowLight.withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: const Icon(Icons.close, size: 20),
            ),
          ),
          const SizedBox(width: Spacing.md),
          Text('Advanced Filters', style: AppTypography.h4),
          const Spacer(),
          GestureDetector(
            onTap: () => _resetFilters(),
            child: Text(
              'Reset',
              style: AppTypography.labelMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.md),
      child: Text(
        title,
        style: AppTypography.overline.copyWith(
          color: AppColors.textHint,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildSortSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('SORT BY'),
        NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Wrap(
            spacing: Spacing.sm,
            runSpacing: Spacing.sm,
            children: _sortOptions.map((option) {
              final isSelected = _sortBy == option;
              return GestureDetector(
                onTap: () => setState(() => _sortBy = option),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.md,
                    vertical: Spacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(Spacing.radiusFull),
                    boxShadow: isSelected
                        ? [GlowStyles.primaryGlowSubtle]
                        : null,
                  ),
                  child: Text(
                    option,
                    style: AppTypography.labelSmall.copyWith(
                      color: isSelected
                          ? Colors.white
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildGenreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('GENRES'),
        NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Wrap(
            spacing: Spacing.sm,
            runSpacing: Spacing.sm,
            children: _genres.map((genre) {
              final isSelected = _selectedGenres.contains(genre);
              final color = _getGenreColor(genre);
              return GestureDetector(
                onTap: () => setState(() {
                  if (isSelected) {
                    _selectedGenres.remove(genre);
                  } else {
                    _selectedGenres.add(genre);
                  }
                }),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.md,
                    vertical: Spacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? color : color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Spacing.radiusFull),
                    boxShadow: isSelected
                        ? [GlowStyles.colorGlowSubtle(color)]
                        : null,
                  ),
                  child: Text(
                    genre,
                    style: AppTypography.labelSmall.copyWith(
                      color: isSelected ? Colors.white : color,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Color _getGenreColor(String genre) {
    switch (genre) {
      case 'Fiction':
        return Colors.blue;
      case 'Mystery':
        return Colors.purple;
      case 'Sci-Fi':
        return Colors.teal;
      case 'Romance':
        return Colors.pink;
      case 'Thriller':
        return Colors.red;
      case 'Fantasy':
        return Colors.indigo;
      case 'Non-Fiction':
        return Colors.orange;
      case 'Biography':
        return Colors.brown;
      case 'Self-Help':
        return Colors.green;
      case 'Business':
        return Colors.blueGrey;
      default:
        return AppColors.primary;
    }
  }

  Widget _buildFormatSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('FORMAT'),
        NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: Row(
            children: _formats.map((format) {
              final isSelected = _selectedFormats.contains(format);
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() {
                    if (isSelected) {
                      _selectedFormats.remove(format);
                    } else {
                      _selectedFormats.add(format);
                    }
                  }),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: format == _formats.last ? 0 : Spacing.sm,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: Spacing.md),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.secondary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(Spacing.radiusSm),
                      boxShadow: isSelected
                          ? [GlowStyles.colorGlowSubtle(AppColors.secondary)]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        format,
                        style: AppTypography.labelSmall.copyWith(
                          color: isSelected
                              ? Colors.white
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDurationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'DURATION',
              style: AppTypography.overline.copyWith(
                color: AppColors.textHint,
                letterSpacing: 1.5,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.sm,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Spacing.radiusFull),
              ),
              child: Text(
                '${_durationRange.start.toInt()}-${_durationRange.end.toInt()} hrs',
                style: AppTypography.labelSmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: Spacing.md),
        NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.all(Spacing.md),
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.border,
              thumbColor: AppColors.primary,
              overlayColor: AppColors.primary.withValues(alpha: 0.2),
            ),
            child: RangeSlider(
              values: _durationRange,
              min: 0,
              max: 50,
              divisions: 50,
              onChanged: (v) => setState(() => _durationRange = v),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'MINIMUM RATING',
              style: AppTypography.overline.copyWith(
                color: AppColors.textHint,
                letterSpacing: 1.5,
              ),
            ),
            Row(
              children: List.generate(5, (i) {
                return Icon(
                  i < _ratingRange.start.toInt()
                      ? Icons.star_border
                      : Icons.star,
                  size: 18,
                  color: Colors.amber,
                );
              }),
            ),
          ],
        ),
        const SizedBox(height: Spacing.md),
        NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.md,
            vertical: Spacing.sm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (i) {
              final rating = i + 1;
              final isSelected = rating >= _ratingRange.start.toInt();
              return GestureDetector(
                onTap: () => setState(
                  () => _ratingRange = RangeValues(rating.toDouble(), 5),
                ),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.amber : Colors.transparent,
                    shape: BoxShape.circle,
                    boxShadow: isSelected
                        ? [GlowStyles.colorGlowSubtle(Colors.amber)]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      '$rating+',
                      style: AppTypography.labelMedium.copyWith(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('MORE OPTIONS'),
        NeuContainer(
          style: NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusMd,
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildToggleItem(
                'Free books only',
                _freeOnly,
                (v) => setState(() => _freeOnly = v),
                Colors.green,
              ),
              Divider(
                height: 1,
                indent: Spacing.md,
                endIndent: Spacing.md,
                color: AppColors.border.withValues(alpha: 0.5),
              ),
              _buildToggleItem(
                'New releases only',
                _newReleasesOnly,
                (v) => setState(() => _newReleasesOnly = v),
                Colors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggleItem(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.all(Spacing.md),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Spacing.radiusSm),
            ),
            child: Icon(
              value ? Icons.check : Icons.close,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: Spacing.md),
          Expanded(child: Text(title, style: AppTypography.labelMedium)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: color,
            activeTrackColor: color.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        Spacing.screenHorizontal,
        Spacing.md,
        Spacing.screenHorizontal,
        MediaQuery.of(context).padding.bottom + Spacing.md,
      ),
      child: Row(
        children: [
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
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: Spacing.md),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                  borderRadius: BorderRadius.circular(Spacing.radiusMd),
                  boxShadow: [GlowStyles.primaryGlow],
                ),
                child: Center(
                  child: Text(
                    'Apply Filters',
                    style: AppTypography.buttonMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      _durationRange = const RangeValues(1, 30);
      _ratingRange = const RangeValues(3, 5);
      _sortBy = 'Relevance';
      _selectedGenres.clear();
      _selectedFormats.clear();
      _selectedFormats.add('Audiobook');
      _freeOnly = false;
      _newReleasesOnly = false;
    });
  }
}
