// =============================================================================
// LOGIN SCREEN - Sign Up / Login (Page 3)
// =============================================================================
// Authentication screen matching the reference design with neumorphic styling.
// Handles both sign up and login flows.
//
// NAVIGATION RELATIONSHIPS:
// - From: Welcome Screen (Page 2)
// - To: Preferences Screen (Page 4) on successful signup
// - To: Main Shell on successful login
// - Dependencies: neu_text_field.dart, neu_button.dart, neu_checkbox.dart
// =============================================================================

import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_text_field.dart';
import '../../../shared/widgets/neumorphic/neu_button.dart';
import '../../../shared/widgets/neumorphic/neu_checkbox.dart';
import '../../../shared/widgets/common/social_login_buttons.dart';

/// Login / Sign Up screen.
///
/// Matches the reference design with:
/// - Full Name, Email, Password, Confirm Password fields
/// - Terms agreement checkbox
/// - Create Account button
/// - Social login options
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // State
  bool _agreedToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Handle create account action
  void _handleCreateAccount() {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms of Service'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate network delay
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, Routes.preferences);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.screenHorizontal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Spacing.md),

                // Back button
                _buildBackButton(),
                const SizedBox(height: Spacing.lg),

                // Header
                _buildHeader(),
                const SizedBox(height: Spacing.xl),

                // Form fields
                _buildForm(),
                const SizedBox(height: Spacing.lg),

                // Terms checkbox
                _buildTermsCheckbox(),
                const SizedBox(height: Spacing.xl),

                // Create Account button
                NeuButton(
                  text: 'Create Account',
                  onPressed: _handleCreateAccount,
                  isLoading: _isLoading,
                  variant: NeuButtonVariant.primary,
                  size: NeuButtonSize.large,
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                ),
                const SizedBox(height: Spacing.xl),

                // Divider
                _buildDivider(),
                const SizedBox(height: Spacing.lg),

                // Social login
                const SocialLoginButtonRow(),
                const SizedBox(height: Spacing.lg),

                // Already have an account link
                Center(
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, Routes.signIn),
                    child: Text.rich(
                      TextSpan(
                        text: 'Already have an account? ',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Spacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Build back button with neumorphic styling
  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Icon(
        Icons.chevron_left,
        size: 28,
        color: AppColors.textPrimary,
      ),
    );
  }

  /// Build header section
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Title
        Center(child: Text('Create Account', style: AppTypography.h2)),
        const SizedBox(height: Spacing.sm),

        // Subtitle
        Center(
          child: Text(
            'Join millions of listeners',
            style: AppTypography.subtitle.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  /// Build form fields
  Widget _buildForm() {
    return Column(
      children: [
        // Full Name
        NeuTextField(
          label: 'Full Name',
          hint: 'John Doe',
          controller: _fullNameController,
          prefixIcon: Icons.person_outline,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: Spacing.lg),

        // Email
        NeuTextField(
          label: 'Email',
          hint: 'user@example.com',
          controller: _emailController,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: Spacing.lg),

        // Password
        NeuTextField(
          label: 'Password',
          hint: 'Create a password',
          controller: _passwordController,
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: Spacing.lg),

        // Confirm Password
        NeuTextField(
          label: 'Confirm Password',
          hint: 'Confirm your password',
          controller: _confirmPasswordController,
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _handleCreateAccount(),
        ),
      ],
    );
  }

  /// Build terms agreement checkbox
  Widget _buildTermsCheckbox() {
    return NeuCheckbox(
      value: _agreedToTerms,
      onChanged: (value) => setState(() => _agreedToTerms = value),
      richLabel: Text.rich(
        TextSpan(
          text: 'I agree to ',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
          children: [
            TextSpan(
              text: 'Terms of Service',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
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
}
