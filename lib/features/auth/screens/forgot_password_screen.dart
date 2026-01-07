// =============================================================================
// FORGOT PASSWORD SCREEN - Password Recovery
// =============================================================================
// Allows users to request a password reset link via email.
//
// NAVIGATION RELATIONSHIPS:
// - From: Sign In Screen
// - To: Verification Screen
// =============================================================================

import 'package:flutter/material.dart';
import '../../../app/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_text_field.dart';
import '../../../shared/widgets/neumorphic/neu_button.dart';

/// Forgot Password screen for password recovery.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendReset() {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate sending reset email
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _emailSent = true;
      });
    });
  }

  void _handleContinueToVerification() {
    Navigator.pushNamed(context, Routes.verification);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Spacing.md),

              // Back button
              _buildBackButton(),
              const SizedBox(height: Spacing.xl),

              // Header
              _buildHeader(),
              const SizedBox(height: Spacing.xxl),

              // Content
              Expanded(
                child: _emailSent
                    ? _buildSuccessContent()
                    : _buildFormContent(),
              ),
            ],
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
        // Icon
        Center(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _emailSent
                  ? Icons.mark_email_read_outlined
                  : Icons.lock_reset_outlined,
              size: 40,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: Spacing.lg),

        Center(
          child: Text(
            _emailSent ? 'Check Your Email' : 'Forgot Password?',
            style: AppTypography.h2,
          ),
        ),
        const SizedBox(height: Spacing.sm),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
            child: Text(
              _emailSent
                  ? 'We\'ve sent a verification code to ${_emailController.text}'
                  : 'Enter your email address and we\'ll send you a code to reset your password.',
              style: AppTypography.subtitle.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormContent() {
    return Column(
      children: [
        NeuTextField(
          label: 'Email Address',
          hint: 'user@example.com',
          controller: _emailController,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _handleSendReset(),
        ),
        const SizedBox(height: Spacing.xl),

        NeuButton(
          text: 'Send Reset Code',
          onPressed: _handleSendReset,
          isLoading: _isLoading,
          variant: NeuButtonVariant.primary,
          size: NeuButtonSize.large,
          backgroundColor: AppColors.primary,
          textColor: Colors.white,
        ),
        const SizedBox(height: Spacing.lg),

        // Back to login
        Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              'Back to Sign In',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessContent() {
    return Column(
      children: [
        // Resend code info
        Container(
          padding: const EdgeInsets.all(Spacing.md),
          decoration: BoxDecoration(
            color: AppColors.info.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Spacing.radiusMd),
            border: Border.all(color: AppColors.info.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.info, size: 20),
              const SizedBox(width: Spacing.sm),
              Expanded(
                child: Text(
                  'Didn\'t receive the email? Check your spam folder or resend.',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.info,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacing.xl),

        NeuButton(
          text: 'Continue to Verification',
          onPressed: _handleContinueToVerification,
          variant: NeuButtonVariant.primary,
          size: NeuButtonSize.large,
          backgroundColor: AppColors.primary,
          textColor: Colors.white,
        ),
        const SizedBox(height: Spacing.lg),

        // Resend button
        Center(
          child: GestureDetector(
            onTap: () {
              setState(() => _emailSent = false);
            },
            child: Text(
              'Resend Code',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
