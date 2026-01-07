// =============================================================================
// WELCOME SCREEN - Onboarding Step 1 (Page 2)
// =============================================================================
// Welcome screen with feature carousel and authentication options.
//
// NAVIGATION RELATIONSHIPS:
// - From: Splash Screen (Page 1)
// - To: Login Screen (Page 3)
// - Dependencies: routes.dart, social_login_buttons.dart
// =============================================================================

import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_button.dart';
import '../../../shared/widgets/common/social_login_buttons.dart';

/// Welcome screen with feature carousel.
///
/// Displays key value propositions and authentication options.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Feature carousel items
  final List<_FeatureItem> _features = [
    _FeatureItem(
      icon: Icons.headphones_rounded,
      title: 'Listen Anywhere',
      description: 'Download audiobooks for offline listening on the go',
    ),
    _FeatureItem(
      icon: Icons.tune_rounded,
      title: 'Control Every Detail',
      description:
          'Adjust speed, set sleep timers, and bookmark your favorites',
    ),
    _FeatureItem(
      icon: Icons.people_rounded,
      title: 'Stay Connected',
      description: 'Join book clubs and share your reading journey',
    ),
    _FeatureItem(
      icon: Icons.emoji_events_rounded,
      title: 'Learn & Grow',
      description: 'Track your progress and earn achievement badges',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.screenHorizontal,
          ),
          child: Column(
            children: [
              const SizedBox(height: Spacing.xl),

              // Feature carousel
              Expanded(flex: 3, child: _buildCarousel()),

              // Page indicators
              _buildPageIndicators(),
              const SizedBox(height: Spacing.xl),

              // Continue with email button
              NeuButton(
                text: 'Continue with Email',
                onPressed: () => Navigator.pushNamed(context, Routes.signIn),
                variant: NeuButtonVariant.secondary,
                size: NeuButtonSize.large,
                textColor: AppColors.primary,
              ),
              const SizedBox(height: Spacing.lg),

              // Divider with text
              _buildDivider(),
              const SizedBox(height: Spacing.lg),

              // Social login buttons
              const SocialLoginButtonRow(
                onGooglePressed: null, // TODO: Implement
                onApplePressed: null,
                onFacebookPressed: null,
              ),
              const SizedBox(height: Spacing.xl),

              // Terms and privacy links
              _buildTermsText(),
              const SizedBox(height: Spacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  /// Build feature carousel
  Widget _buildCarousel() {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) => setState(() => _currentPage = index),
      itemCount: _features.length,
      itemBuilder: (context, index) {
        final feature = _features[index];
        return _buildFeatureCard(feature);
      },
    );
  }

  /// Build individual feature card
  Widget _buildFeatureCard(_FeatureItem feature) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icon container
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(feature.icon, size: 60, color: AppColors.primary),
        ),
        const SizedBox(height: Spacing.xl),

        // Title
        Text(
          feature.title,
          style: AppTypography.h2,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacing.md),

        // Description
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
          child: Text(
            feature.description,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// Build page indicator dots
  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_features.length, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.border,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  /// Build "or sign up with" divider
  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.divider)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
          child: Text(
            'or sign up with',
            style: AppTypography.bodySmall.copyWith(color: AppColors.textHint),
          ),
        ),
        Expanded(child: Divider(color: AppColors.divider)),
      ],
    );
  }

  /// Build terms and privacy text
  Widget _buildTermsText() {
    return Text.rich(
      TextSpan(
        text: 'By continuing, you agree to our ',
        style: AppTypography.caption.copyWith(color: AppColors.textHint),
        children: [
          TextSpan(
            text: 'Terms of Service',
            style: AppTypography.caption.copyWith(color: AppColors.primary),
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: AppTypography.caption.copyWith(color: AppColors.primary),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}

/// Data class for feature carousel items
class _FeatureItem {
  final IconData icon;
  final String title;
  final String description;

  _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
