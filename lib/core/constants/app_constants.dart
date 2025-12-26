/// App-wide constants and configuration
class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Audiobooks';
  static const String appVersion = '1.0.0';

  // Audio Settings
  static const double minPlaybackSpeed = 0.5;
  static const double maxPlaybackSpeed = 3.5;
  static const double defaultPlaybackSpeed = 1.0;
  static const double speedIncrement = 0.1;

  static const double minVolumeBoost = 1.0;
  static const double maxVolumeBoost = 3.0;

  // Smart Resume
  static const int shortPauseThresholdSeconds = 30;
  static const int longPauseThresholdSeconds = 300;
  static const int shortRewindSeconds = 2;
  static const int longRewindSeconds = 5;

  // Sleep Timer Presets (in minutes)
  static const List<int> sleepTimerPresets = [15, 30, 45, 60, 90];

  // Smart Rewind/Forward (in seconds)
  static const int shortSkipSeconds = 10;
  static const int longSkipSeconds = 30;

  // Storage Keys
  static const String hiveBoxName = 'audiobooks_storage';
  static const String settingsBoxName = 'settings';
  static const String bookmarksBoxName = 'bookmarks';
  static const String downloadBoxName = 'downloads';

  // Firebase Collections
  static const String booksCollection = 'books';
  static const String episodesCollection = 'episodes';
  static const String usersCollection = 'users';
  static const String bookmarksCollection = 'bookmarks';
  static const String collectionsCollection = 'collections';

  // Pagination
  static const int defaultPageSize = 20;

  // Cache Duration
  static const Duration imageCacheDuration = Duration(days: 7);
  static const Duration coverCacheDuration = Duration(days: 30);
}
