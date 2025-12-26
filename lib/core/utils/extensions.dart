import 'package:flutter/material.dart';

/// Extension methods for Duration to format time strings
extension DurationExtensions on Duration {
  /// Format as HH:MM:SS or MM:SS
  String toFormattedString() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = inHours;
    final minutes = inMinutes.remainder(60);
    final seconds = inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  /// Format as short time string (e.g., "2h 30m" or "45m")
  String toShortString() {
    final hours = inHours;
    final minutes = inMinutes.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  /// Format as remaining time (e.g., "2:30:45 remaining")
  String toRemainingString() {
    return '${toFormattedString()} remaining';
  }
}

/// Extension methods for String utilities
extension StringExtensions on String {
  /// Capitalize first letter
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Truncate string with ellipsis
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - 3)}...';
  }

  /// Parse duration from string like "01:23:45" or "23:45"
  Duration? toDuration() {
    try {
      final parts = split(':').map(int.parse).toList();
      if (parts.length == 3) {
        return Duration(hours: parts[0], minutes: parts[1], seconds: parts[2]);
      } else if (parts.length == 2) {
        return Duration(minutes: parts[0], seconds: parts[1]);
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}

/// Extension methods for BuildContext
extension ContextExtensions on BuildContext {
  /// Get theme
  ThemeData get theme => Theme.of(this);

  /// Get color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Check if dark mode
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Get padding
  EdgeInsets get padding => MediaQuery.of(this).padding;

  /// Show snackbar
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? colorScheme.error : colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

/// Extension methods for numbers
extension NumExtensions on num {
  /// Convert seconds to Duration
  Duration get seconds => Duration(seconds: toInt());

  /// Convert milliseconds to Duration
  Duration get milliseconds => Duration(milliseconds: toInt());

  /// Convert minutes to Duration
  Duration get minutes => Duration(minutes: toInt());

  /// Format as speed multiplier (e.g., "1.5x")
  String toSpeedString() => '${toStringAsFixed(1)}x';
}
