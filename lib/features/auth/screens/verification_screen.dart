// =============================================================================
// VERIFICATION SCREEN - OTP/Code Verification
// =============================================================================
// Verification screen for email/phone OTP confirmation.
//
// NAVIGATION RELATIONSHIPS:
// - From: Forgot Password Screen, Sign Up Screen
// - To: Reset Password Screen, Main Shell
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/spacing.dart';
import '../../../shared/widgets/neumorphic/neu_button.dart';

/// OTP Verification screen.
class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isLoading = false;
  int _resendSeconds = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    _resendSeconds = 60;
    _canResend = false;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;

      setState(() {
        _resendSeconds--;
        if (_resendSeconds <= 0) {
          _canResend = true;
        }
      });

      return _resendSeconds > 0;
    });
  }

  String get _code => _controllers.map((c) => c.text).join();

  void _handleVerify() {
    if (_code.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the complete verification code'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Simulate verification
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _isLoading = false);

      // Navigate to reset password or main shell
      Navigator.pushNamedAndRemoveUntil(context, Routes.main, (route) => false);
    });
  }

  void _handleResend() {
    if (!_canResend) return;

    // Clear fields
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();

    _startResendTimer();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification code resent'),
        behavior: SnackBarBehavior.floating,
      ),
    );
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

              // OTP fields
              _buildOtpFields(),
              const SizedBox(height: Spacing.xl),

              // Verify button
              NeuButton(
                text: 'Verify Code',
                onPressed: _handleVerify,
                isLoading: _isLoading,
                variant: NeuButtonVariant.primary,
                size: NeuButtonSize.large,
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
              ),
              const SizedBox(height: Spacing.xl),

              // Resend section
              _buildResendSection(),

              const Spacer(),
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
            child: const Icon(
              Icons.verified_outlined,
              size: 40,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(height: Spacing.lg),

        Center(child: Text('Verification Code', style: AppTypography.h2)),
        const SizedBox(height: Spacing.sm),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
            child: Text(
              'Enter the 6-digit code we sent to your email',
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

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return _buildOtpBox(index);
      }),
    );
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(Spacing.radiusMd),
        border: Border.all(
          color: _focusNodes[index].hasFocus
              ? AppColors.primary
              : _controllers[index].text.isNotEmpty
              ? AppColors.primary.withValues(alpha: 0.5)
              : AppColors.border,
          width: _focusNodes[index].hasFocus ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkShadowLight.withValues(alpha: 0.3),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.8),
            offset: const Offset(-2, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: AppTypography.h3.copyWith(color: AppColors.textPrimary),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            _focusNodes[index + 1].requestFocus();
          }
          if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
          setState(() {});
        },
      ),
    );
  }

  Widget _buildResendSection() {
    return Center(
      child: Column(
        children: [
          Text(
            'Didn\'t receive the code?',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: Spacing.sm),
          GestureDetector(
            onTap: _canResend ? _handleResend : null,
            child: Text(
              _canResend ? 'Resend Code' : 'Resend in ${_resendSeconds}s',
              style: AppTypography.bodyMedium.copyWith(
                color: _canResend ? AppColors.primary : AppColors.textHint,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
