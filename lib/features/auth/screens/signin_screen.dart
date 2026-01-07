// =============================================================================
// SIGN IN SCREEN - User Login
// =============================================================================
// Login screen for returning users with email/password authentication.
//
// NAVIGATION RELATIONSHIPS:
// - From: Welcome Screen, Sign Up Screen
// - To: Main Shell on successful login, Forgot Password Screen
// =============================================================================

import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_text_field.dart';
import '../../../shared/widgets/neumorphic/neu_button.dart';
import '../../../shared/widgets/common/social_login_buttons.dart';

/// Sign In screen for returning users.
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    setState(() => _isLoading = true);

    // Simulate login
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false);
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
                const SizedBox(height: Spacing.xl),

                // Header
                _buildHeader(),
                const SizedBox(height: Spacing.xxl),

                // Form
                _buildForm(),
                const SizedBox(height: Spacing.md),

                // Remember me & Forgot password
                _buildOptions(),
                const SizedBox(height: Spacing.xl),

                // Sign In button
                NeuButton(
                  text: 'Login In',
                  onPressed: _handleSignIn,
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
                const SizedBox(height: Spacing.xl),

                // Sign up link
                _buildSignUpLink(),
                const SizedBox(height: Spacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text('Welcome Back', style: AppTypography.h2)),
        const SizedBox(height: Spacing.sm),
        Center(
          child: Text(
            'Sign in to continue listening',
            style: AppTypography.subtitle.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        NeuTextField(
          label: 'Email',
          hint: 'user@example.com',
          controller: _emailController,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: Spacing.lg),
        NeuTextField(
          label: 'Password',
          hint: 'Enter your password',
          controller: _passwordController,
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _handleSignIn(),
        ),
      ],
    );
  }

  Widget _buildOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Remember me
        GestureDetector(
          onTap: () => setState(() => _rememberMe = !_rememberMe),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: _rememberMe
                      ? AppColors.primary
                      : AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: _rememberMe ? AppColors.primary : AppColors.border,
                    width: 2,
                  ),
                ),
                child: _rememberMe
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: Spacing.sm),
              Text(
                'Remember me',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        // Forgot password
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, Routes.forgotPassword),
          child: Text(
            'Forgot Password?',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.divider)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.md),
          child: Text(
            'or sign in with',
            style: AppTypography.bodySmall.copyWith(color: AppColors.textHint),
          ),
        ),
        Expanded(child: Divider(color: AppColors.divider)),
      ],
    );
  }

  Widget _buildSignUpLink() {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, Routes.login),
        child: Text.rich(
          TextSpan(
            text: "Don't have an account? ",
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            children: [
              TextSpan(
                text: 'Sign Up',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
