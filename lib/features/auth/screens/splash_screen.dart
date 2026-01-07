// =============================================================================
// SPLASH SCREEN - App Launch Screen (Page 1)
// =============================================================================
// Displays app branding during initial load.
// Auto-navigates to Welcome or Main screen based on auth state.
//
// NAVIGATION RELATIONSHIPS:
// - Entry point: App launch
// - Navigates to: Welcome Screen (Page 2) if not authenticated
// - Navigates to: Main Shell if authenticated
// - Dependencies: routes.dart
// =============================================================================

import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';

/// Splash screen displayed on app launch.
///
/// Shows the app logo and tagline for 2-3 seconds before
/// auto-redirecting based on authentication state.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    // Start animation
    _animationController.forward();

    // Navigate after delay
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    // Wait for splash duration
    await Future.delayed(const Duration(milliseconds: 2500));

    if (!mounted) return;

    // TODO: Check authentication state
    // For now, always go to welcome screen
    Navigator.pushReplacementNamed(context, Routes.welcome);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo/icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(Spacing.radiusXl),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      offset: const Offset(0, 10),
                      blurRadius: 30,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.headphones_rounded,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: Spacing.lg),

              // App name
              Text(
                'Audiobook',
                style: AppTypography.h1.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Spacing.sm),

              // Tagline
              Text(
                'Your Personal Audiobook Universe',
                style: AppTypography.subtitle.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
