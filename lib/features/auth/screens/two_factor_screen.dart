import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../services/auth_service.dart';
import '../../../page/home_page.dart';

class TwoFactorScreen extends StatefulWidget {
  final bool isEnabling; // true = setting up 2FA, false = verifying login

  const TwoFactorScreen({super.key, this.isEnabling = false});

  @override
  State<TwoFactorScreen> createState() => _TwoFactorScreenState();
}

class _TwoFactorScreenState extends State<TwoFactorScreen> {
  final List<TextEditingController> _codeControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    // Request 2FA code on login
    if (!widget.isEnabling) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<AuthService>().send2FACode();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _code => _codeControllers.map((c) => c.text).join();

  void _onCodeChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    // Auto-submit when complete
    if (_code.length == 6) {
      _handleVerify();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: widget.isEnabling
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimaryDark,
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Consumer<AuthService>(
          builder: (context, authService, child) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  // Icon
                  FadeInDown(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.security,
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
                      widget.isEnabling
                          ? 'Set Up 2-Factor Auth'
                          : 'Verification Required',
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
                      widget.isEnabling
                          ? 'Enter the 6-digit code sent to your phone'
                          : 'Enter the verification code sent to your phone',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textSecondaryDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Error message
                  if (authService.errorMessage != null)
                    FadeIn(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppColors.error,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                authService.errorMessage!,
                                style: TextStyle(color: AppColors.error),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Code input
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 48,
                          height: 56,
                          child: TextField(
                            controller: _codeControllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: AppTypography.headlineSmall.copyWith(
                              color: AppColors.textPrimaryDark,
                            ),
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: AppColors.cardDark,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (value) => _onCodeChanged(index, value),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Verify button
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: authService.isLoading || _code.length < 6
                            ? null
                            : _handleVerify,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: authService.isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Verify',
                                style: AppTypography.labelLarge.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Resend code
                  FadeIn(
                    delay: const Duration(milliseconds: 600),
                    child: TextButton.icon(
                      onPressed: () {
                        context.read<AuthService>().send2FACode();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Code sent!')),
                        );
                      },
                      icon: Icon(Icons.refresh, color: AppColors.primary),
                      label: Text(
                        'Resend Code',
                        style: TextStyle(color: AppColors.primary),
                      ),
                    ),
                  ),

                  if (!widget.isEnabling) ...[
                    const SizedBox(height: 16),
                    FadeIn(
                      delay: const Duration(milliseconds: 700),
                      child: TextButton(
                        onPressed: () async {
                          await context.read<AuthService>().signOut();
                        },
                        child: Text(
                          'Sign out',
                          style: TextStyle(color: AppColors.textSecondaryDark),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _handleVerify() async {
    final authService = context.read<AuthService>();

    bool success;
    if (widget.isEnabling) {
      success = await authService.verify2FACode(_code);
    } else {
      success = await authService.verify2FAOnLogin(_code);
    }

    if (success && mounted) {
      if (widget.isEnabling) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('2FA enabled successfully!')),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } else {
      // Clear input on error
      for (var controller in _codeControllers) {
        controller.clear();
      }
      _focusNodes[0].requestFocus();
    }
  }
}
