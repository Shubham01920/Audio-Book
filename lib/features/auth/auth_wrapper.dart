import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../auth/screens/login_screen.dart';
import '../auth/screens/verify_email_screen.dart';
import '../auth/screens/two_factor_screen.dart';
import '../../page/main_navigation_page.dart';

/// Widget that handles auth state and routes to appropriate screen
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        switch (authService.state) {
          case AuthState.initial:
          case AuthState.loading:
            return const _SplashScreen();

          case AuthState.authenticated:
            return const MainNavigationPage();

          case AuthState.needsVerification:
            return const VerifyEmailScreen();

          case AuthState.needs2FA:
            return const TwoFactorScreen();

          case AuthState.unauthenticated:
          case AuthState.error:
            return const LoginScreen();
        }
      },
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.headphones,
                color: Colors.white,
                size: 56,
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(color: Color(0xFF6366F1)),
          ],
        ),
      ),
    );
  }
}
