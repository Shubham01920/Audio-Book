import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Theme mode options
enum AppThemeMode { light, dark, system }

/// Theme provider with persistence
class ThemeProvider extends ChangeNotifier {
  static const String _boxName = 'settings';
  static const String _themeKey = 'theme_mode';

  AppThemeMode _themeMode = AppThemeMode.system;
  bool _isInitialized = false;

  AppThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    if (_themeMode == AppThemeMode.system) {
      final brightness =
          SchedulerBinding.instance.platformDispatcher.platformBrightness;
      return brightness == Brightness.dark;
    }
    return _themeMode == AppThemeMode.dark;
  }

  ThemeMode get flutterThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  /// Initialize theme from storage
  Future<void> init() async {
    if (_isInitialized) return;

    final box = await Hive.openBox(_boxName);
    final savedMode = box.get(_themeKey, defaultValue: 'system');

    switch (savedMode) {
      case 'light':
        _themeMode = AppThemeMode.light;
        break;
      case 'dark':
        _themeMode = AppThemeMode.dark;
        break;
      default:
        _themeMode = AppThemeMode.system;
    }

    _isInitialized = true;
    notifyListeners();
  }

  /// Set theme mode and persist
  Future<void> setThemeMode(AppThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();

    final box = await Hive.openBox(_boxName);
    String modeString;
    switch (mode) {
      case AppThemeMode.light:
        modeString = 'light';
        break;
      case AppThemeMode.dark:
        modeString = 'dark';
        break;
      case AppThemeMode.system:
        modeString = 'system';
    }
    await box.put(_themeKey, modeString);
  }

  /// Toggle between light and dark
  Future<void> toggleTheme() async {
    if (isDarkMode) {
      await setThemeMode(AppThemeMode.light);
    } else {
      await setThemeMode(AppThemeMode.dark);
    }
  }

  /// Cycle through modes: system -> light -> dark -> system
  Future<void> cycleThemeMode() async {
    switch (_themeMode) {
      case AppThemeMode.system:
        await setThemeMode(AppThemeMode.light);
        break;
      case AppThemeMode.light:
        await setThemeMode(AppThemeMode.dark);
        break;
      case AppThemeMode.dark:
        await setThemeMode(AppThemeMode.system);
        break;
    }
  }

  /// Get theme mode display name
  String get themeModeDisplayName {
    switch (_themeMode) {
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
      case AppThemeMode.system:
        return 'System';
    }
  }

  /// Get icon for current theme
  IconData get themeModeIcon {
    switch (_themeMode) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.system:
        return Icons.brightness_auto;
    }
  }
}
