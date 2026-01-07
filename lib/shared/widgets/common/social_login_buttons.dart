// =============================================================================
// SOCIAL LOGIN BUTTONS - Social Authentication Buttons
// =============================================================================
// Buttons for Google, Apple, and Facebook authentication.
// Styled to match the reference design with neumorphic containers.
//
// NAVIGATION RELATIONSHIPS:
// - Used by: Login (Page 3), Welcome (Page 2) screens
// - Dependencies: neu_container.dart, app_colors.dart
// =============================================================================

import 'package:flutter/material.dart';
import '../../../core/theme/neumorphism/neumorphic_styles.dart';
import '../../../core/constants/spacing.dart';

/// Social login provider enum
enum SocialProvider { google, apple, facebook }

/// A single social login button with neumorphic styling.
///
/// Example:
/// ```dart
/// SocialLoginButton(
///   provider: SocialProvider.google,
///   onPressed: () => _handleGoogleLogin(),
/// )
/// ```
class SocialLoginButton extends StatefulWidget {
  /// Social provider type
  final SocialProvider provider;

  /// Callback when pressed
  final VoidCallback? onPressed;

  /// Button size (width and height)
  final double size;

  const SocialLoginButton({
    super.key,
    required this.provider,
    this.onPressed,
    this.size = 60,
  });

  @override
  State<SocialLoginButton> createState() => _SocialLoginButtonState();
}

class _SocialLoginButtonState extends State<SocialLoginButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: widget.onPressed != null
          ? (_) => setState(() => _isPressed = true)
          : null,
      onTapUp: widget.onPressed != null
          ? (_) => setState(() => _isPressed = false)
          : null,
      onTapCancel: widget.onPressed != null
          ? () => setState(() => _isPressed = false)
          : null,
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.size,
        height: widget.size,
        decoration: _isPressed
            ? NeuDecoration.pressed(
                radius: Spacing.radiusMd,
                intensity: NeuIntensity.light,
                isDark: isDark,
              )
            : NeuDecoration.raised(
                radius: Spacing.radiusMd,
                intensity: NeuIntensity.light,
                isDark: isDark,
              ),
        child: Center(child: _buildIcon()),
      ),
    );
  }

  Widget _buildIcon() {
    switch (widget.provider) {
      case SocialProvider.google:
        return _GoogleIcon(size: widget.size * 0.45);
      case SocialProvider.apple:
        return Icon(Icons.apple, size: widget.size * 0.5, color: Colors.black);
      case SocialProvider.facebook:
        return Icon(
          Icons.facebook,
          size: widget.size * 0.5,
          color: const Color(0xFF4267B2),
        );
    }
  }
}

/// Google's multi-color 'G' icon
class _GoogleIcon extends StatelessWidget {
  final double size;

  const _GoogleIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    // Using a simple representation of Google's G
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _GoogleIconPainter()),
    );
  }
}

class _GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width;
    final center = Offset(s / 2, s / 2);
    final radius = s / 2;

    // Blue arc (right side)
    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = s * 0.18
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.7),
      -0.8,
      1.4,
      false,
      bluePaint,
    );

    // Green arc (bottom right)
    final greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.stroke
      ..strokeWidth = s * 0.18
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.7),
      0.6,
      1.0,
      false,
      greenPaint,
    );

    // Yellow arc (bottom left)
    final yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = s * 0.18
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.7),
      1.6,
      1.0,
      false,
      yellowPaint,
    );

    // Red arc (top left)
    final redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.stroke
      ..strokeWidth = s * 0.18
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius * 0.7),
      2.6,
      1.0,
      false,
      redPaint,
    );

    // Horizontal line
    final linePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTWH(s * 0.5, s * 0.4, s * 0.4, s * 0.18),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// A row of social login buttons
///
/// Example:
/// ```dart
/// SocialLoginButtonRow(
///   onGooglePressed: () => _handleGoogle(),
///   onApplePressed: () => _handleApple(),
///   onFacebookPressed: () => _handleFacebook(),
/// )
/// ```
class SocialLoginButtonRow extends StatelessWidget {
  final VoidCallback? onGooglePressed;
  final VoidCallback? onApplePressed;
  final VoidCallback? onFacebookPressed;
  final double buttonSize;
  final double spacing;

  const SocialLoginButtonRow({
    super.key,
    this.onGooglePressed,
    this.onApplePressed,
    this.onFacebookPressed,
    this.buttonSize = 60,
    this.spacing = Spacing.lg,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialLoginButton(
          provider: SocialProvider.google,
          onPressed: onGooglePressed,
          size: buttonSize,
        ),
        SizedBox(width: spacing),
        SocialLoginButton(
          provider: SocialProvider.apple,
          onPressed: onApplePressed,
          size: buttonSize,
        ),
        SizedBox(width: spacing),
        SocialLoginButton(
          provider: SocialProvider.facebook,
          onPressed: onFacebookPressed,
          size: buttonSize,
        ),
      ],
    );
  }
}
