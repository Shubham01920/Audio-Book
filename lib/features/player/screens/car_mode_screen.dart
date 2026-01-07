// =============================================================================
// CAR MODE SCREEN - Driver Safe Interface (Redesigned)
// =============================================================================
// Simplified player interface for driving with:
// - High contrast dark theme
// - Extra large controls with glow effects
// - Minimal distractions
//
// DESIGN: Neumorphism + Strong Solid Glow for visibility
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/glow/glow_styles.dart';

class CarModeScreen extends StatefulWidget {
  const CarModeScreen({super.key});

  @override
  State<CarModeScreen> createState() => _CarModeScreenState();
}

class _CarModeScreenState extends State<CarModeScreen> {
  bool _isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Deep dark for night driving
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with glow badge
            _buildTopBar(),

            const Spacer(flex: 2),

            // Book Info
            _buildBookInfo(),

            const Spacer(flex: 2),

            // Progress indicator
            _buildProgress(),

            const Spacer(),

            // Giant Controls with strong glow
            _buildControls(),

            const SizedBox(height: Spacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(Spacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Close button with neumorphic dark style
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(-2, -2),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 8,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 28),
            ),
          ),

          // Car Mode badge with glow
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.lg,
              vertical: Spacing.sm,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(Spacing.radiusFull),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.5),
                  blurRadius: 16,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.directions_car, color: Colors.white, size: 22),
                const SizedBox(width: Spacing.sm),
                Text(
                  'CAR MODE',
                  style: AppTypography.labelLarge.copyWith(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 56), // Balance
        ],
      ),
    );
  }

  Widget _buildBookInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
      child: Column(
        children: [
          // Book cover with strong glow
          Container(
            width: 140,
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primary.withValues(alpha: 0.3),
                  AppColors.secondary.withValues(alpha: 0.4),
                ],
              ),
              borderRadius: BorderRadius.circular(Spacing.radiusLg),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.headphones, size: 60, color: Colors.white),
                const SizedBox(height: Spacing.sm),
                Text(
                  'THE MIDNIGHT\nLIBRARY',
                  textAlign: TextAlign.center,
                  style: AppTypography.labelSmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.xl),

          // Title - extra large for driving
          Text(
            'The Midnight Library',
            textAlign: TextAlign.center,
            style: AppTypography.h2.copyWith(color: Colors.white, fontSize: 28),
          ),
          const SizedBox(height: Spacing.sm),

          // Author
          Text(
            'Matt Haig',
            style: AppTypography.h5.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: Spacing.md),

          // Chapter info
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.lg,
              vertical: Spacing.sm,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(Spacing.radiusFull),
            ),
            child: Text(
              'Chapter 5 of 12',
              style: AppTypography.labelMedium.copyWith(
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgress() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
      child: Column(
        children: [
          // Progress bar with glow
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.35,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                  ),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.6),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: Spacing.md),

          // Time labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1:23:45',
                style: AppTypography.h5.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '-7:26:15',
                style: AppTypography.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Rewind - Giant button with dark neumorphism
          _buildGiantButton(icon: Icons.replay_30, onTap: () {}, size: 80),

          // Play/Pause - Massive with strong glow
          GestureDetector(
            onTap: () => setState(() => _isPlaying = !_isPlaying),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.6),
                    blurRadius: 40,
                    spreadRadius: 8,
                  ),
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 64,
              ),
            ),
          ),

          // Forward - Giant button
          _buildGiantButton(icon: Icons.forward_30, onTap: () {}, size: 80),
        ],
      ),
    );
  }

  Widget _buildGiantButton({
    required IconData icon,
    required VoidCallback onTap,
    required double size,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.15),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(-3, -3),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 10,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.5),
      ),
    );
  }
}
