// =============================================================================
// MOOD SEARCH SCREEN - Emotional Discovery (Page 7)
// =============================================================================
// Discover books based on current mood or emotional state.
//
// DESIGN: 60% Neumorphism + 30% Solid Glow
//
// NAVIGATION RELATIONSHIPS:
// - From: Discover, Home
// - To: Search Results, Book Detail
// =============================================================================

import 'package:flutter/material.dart';
import 'package:ui_app/core/theme/neumorphism/neumorphic_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_container.dart';
import '../../../shared/widgets/glow/glow_styles.dart';
import '../../../app/routes.dart';

class MoodSearchScreen extends StatefulWidget {
  const MoodSearchScreen({super.key});

  @override
  State<MoodSearchScreen> createState() => _MoodSearchScreenState();
}

class _MoodSearchScreenState extends State<MoodSearchScreen> {
  String? _selectedMood;

  final List<Map<String, dynamic>> _moods = [
    {
      'emoji': '😊',
      'name': 'Happy',
      'color': Colors.amber,
      'description': 'Uplifting stories',
    },
    {
      'emoji': '😌',
      'name': 'Relaxed',
      'color': Colors.teal,
      'description': 'Calm & peaceful',
    },
    {
      'emoji': '🤔',
      'name': 'Curious',
      'color': Colors.purple,
      'description': 'Learn something new',
    },
    {
      'emoji': '😤',
      'name': 'Motivated',
      'color': Colors.orange,
      'description': 'Get inspired',
    },
    {
      'emoji': '😢',
      'name': 'Sad',
      'color': Colors.blue,
      'description': 'Comforting reads',
    },
    {
      'emoji': '😰',
      'name': 'Anxious',
      'color': Colors.green,
      'description': 'Soothing escapes',
    },
    {
      'emoji': '🤩',
      'name': 'Adventurous',
      'color': Colors.red,
      'description': 'Exciting journeys',
    },
    {
      'emoji': '💭',
      'name': 'Reflective',
      'color': Colors.indigo,
      'description': 'Deep thinking',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text('How are you feeling?', style: AppTypography.h3),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
      ),
      body: Column(
        children: [
          // Header description
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: Text(
              'Select your current mood and we\'ll find the perfect audiobook for you',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: Spacing.xl),

          // Mood grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(Spacing.screenHorizontal),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: Spacing.md,
                mainAxisSpacing: Spacing.md,
              ),
              itemCount: _moods.length,
              itemBuilder: (context, index) {
                return _buildMoodCard(_moods[index]);
              },
            ),
          ),

          // Continue button
          if (_selectedMood != null) _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildMoodCard(Map<String, dynamic> mood) {
    final isSelected = _selectedMood == mood['name'];
    final color = mood['color'] as Color;

    return GestureDetector(
      onTap: () => setState(() => _selectedMood = mood['name']),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Spacing.radiusLg),
          boxShadow: isSelected
              ? [GlowStyles.colorGlow(color, intensity: 0.5)]
              : [GlowStyles.colorGlowSubtle(color)],
        ),
        child: NeuContainer(
          style: isSelected ? NeuStyle.pressed : NeuStyle.raised,
          intensity: NeuIntensity.light,
          borderRadius: Spacing.radiusLg,
          child: Container(
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withValues(alpha: 0.15),
                        color.withValues(alpha: 0.05),
                      ],
                    )
                  : null,
              borderRadius: BorderRadius.circular(Spacing.radiusLg),
              border: isSelected
                  ? Border.all(color: color.withValues(alpha: 0.5), width: 2)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Emoji with glow
                Container(
                  padding: const EdgeInsets.all(Spacing.md),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: isSelected
                        ? [GlowStyles.colorGlow(color)]
                        : null,
                  ),
                  child: Text(
                    mood['emoji'],
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
                const SizedBox(height: Spacing.sm),

                // Mood name
                Text(
                  mood['name'],
                  style: AppTypography.h5.copyWith(
                    color: isSelected ? color : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: Spacing.xs),

                // Description
                Text(
                  mood['description'],
                  style: AppTypography.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                // Selected indicator
                if (isSelected) ...[
                  const SizedBox(height: Spacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(Spacing.radiusFull),
                    ),
                    child: Text(
                      'Selected',
                      style: AppTypography.labelSmall.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    final selectedMood = _moods.firstWhere((m) => m['name'] == _selectedMood);
    final color = selectedMood['color'] as Color;

    return Container(
      padding: const EdgeInsets.all(Spacing.screenHorizontal),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, Routes.discover),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: Spacing.md),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withValues(alpha: 0.8)],
            ),
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
            boxShadow: [GlowStyles.colorGlow(color)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Find ${selectedMood['emoji']} $_selectedMood Books',
                style: AppTypography.buttonMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: Spacing.sm),
              const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
