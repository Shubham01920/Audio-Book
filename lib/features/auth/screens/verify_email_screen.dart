import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../services/auth_service.dart';
import '../../../page/home_page.dart';
import 'login_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  Timer? _timer;
  bool _canResend = true;
  int _resendCountdown = 0;

  @override
  void initState() {
    super.initState();
    _startVerificationCheck();
  }

  void _startVerificationCheck() {
    // Check every 3 seconds if email is verified
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final authService = context.read<AuthService>();
      final verified = await authService.checkEmailVerification();

      if (verified && mounted) {
        timer.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  void _startResendCountdown() {
    setState(() {
      _canResend = false;
      _resendCountdown = 60;
    });

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        timer.cancel();
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Consumer<AuthService>(
          builder: (context, authService, child) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon
                  FadeInDown(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.mark_email_unread_outlined,
                        size: 64,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Title
                  FadeIn(
                    delay: const Duration(milliseconds: 200),
                    child: Text(
                      'Verify Your Email',
                      style: AppTypography.headlineMedium.copyWith(
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Description
                  FadeIn(
                    delay: const Duration(milliseconds: 300),
                    child: Text(
                      'We\'ve sent a verification link to\n${authService.currentUser?.email ?? "your email"}',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textSecondaryDark,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Loading indicator
                  FadeIn(
                    delay: const Duration(milliseconds: 400),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Waiting for verification...',
                          style: TextStyle(color: AppColors.textTertiaryDark),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Resend button
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: TextButton.icon(
                      onPressed: _canResend
                          ? () async {
                              await authService.resendVerificationEmail();
                              _startResendCountdown();
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Verification email sent!'),
                                  ),
                                );
                              }
                            }
                          : null,
                      icon: Icon(
                        Icons.refresh,
                        color: _canResend
                            ? AppColors.primary
                            : AppColors.textTertiaryDark,
                      ),
                      label: Text(
                        _canResend
                            ? 'Resend Email'
                            : 'Resend in $_resendCountdown s',
                        style: TextStyle(
                          color: _canResend
                              ? AppColors.primary
                              : AppColors.textTertiaryDark,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Back to login
                  FadeIn(
                    delay: const Duration(milliseconds: 600),
                    child: TextButton(
                      onPressed: () async {
                        await authService.signOut();
                        if (mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Back to Login',
                        style: TextStyle(color: AppColors.textSecondaryDark),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
