// =============================================================================
// ROUTES - Application Route Configuration
// =============================================================================
// Defines all navigation routes for the 70+ screens in the app.
// Uses named routes for clear navigation throughout the application.
//
// NAVIGATION RELATIONSHIPS:
// - Used by: app.dart, all screens for navigation
// - Dependencies: All screen files
// =============================================================================

import 'package:flutter/material.dart';

// Auth Screens
import '../features/auth/screens/splash_screen.dart';
import '../features/auth/screens/welcome_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/signin_screen.dart';
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/auth/screens/verification_screen.dart';
import '../features/auth/screens/preferences_screen.dart';

// Main Shell
import '../features/main_shell.dart';

// Discovery Screens
import '../features/home/screens/discover_screen.dart';
import '../features/home/screens/book_detail_screen.dart';

// Player Screens

import '../features/player/screens/player_screen.dart';
import '../features/player/screens/car_mode_screen.dart';
import '../features/player/screens/bookmarks_screen.dart';
import '../features/player/screens/transcript_screen.dart';

// Discovery - New Screens
import '../features/home/screens/samples_screen.dart';
import '../features/home/screens/upcoming_screen.dart';
import '../features/home/screens/mood_search_screen.dart';
import '../features/home/screens/series_detail_screen.dart';
// Library Screens
import '../features/library/screens/wishlist_screen.dart';
import '../features/library/screens/stats_screen.dart';
import '../features/library/screens/downloads_screen.dart';
import '../features/library/screens/shelves_screen.dart';
import '../features/library/screens/saved_bookmarks_screen.dart';

// Search Screens
import '../features/search/screens/advanced_search_filters_screen.dart';
import '../features/search/screens/narrator_detail_screen.dart';

// Social Screens
import '../features/social/screens/social_hub_screen.dart';
import '../features/social/screens/book_clubs_screen.dart';
import '../features/social/screens/live_discussion_screen.dart';
import '../features/social/screens/challenges_screen.dart';
import '../features/social/screens/review_screen.dart';
import '../features/social/screens/follow_screen.dart';

// Settings Screens
import '../features/settings/screens/app_settings_screen.dart';
import '../features/settings/screens/display_screen.dart';
import '../features/settings/screens/notifications_screen.dart';
import '../features/settings/screens/privacy_screen.dart';
import '../features/settings/screens/accessibility_screen.dart';
import '../features/settings/screens/language_screen.dart';
import '../features/settings/screens/storage_screen.dart';
import '../features/settings/screens/playback_settings_screen.dart';

// Family Screens
import '../features/family/screens/family_sharing_screen.dart';
import '../features/family/screens/kids_mode_screen.dart';
import '../features/family/screens/kids_library_screen.dart';
import '../features/family/screens/child_dashboard_screen.dart';

/// Application route names.
///
/// Use these constants for navigation to ensure type safety
/// and avoid typos.
class Routes {
  // Private constructor
  Routes._();

  // ===========================================================================
  // AUTHENTICATION & ONBOARDING
  // ===========================================================================

  /// Splash screen - App launch
  static const String splash = '/';

  /// Welcome screen with feature carousel
  static const String welcome = '/welcome';

  /// Login / Sign up screen
  static const String login = '/login';

  /// User preferences setup
  static const String preferences = '/preferences';

  /// Sign in screen for returning users
  static const String signIn = '/signin';

  /// Forgot password screen
  static const String forgotPassword = '/forgot-password';

  /// Verification code screen
  static const String verification = '/verification';

  // ===========================================================================
  // MAIN APP SHELL (Authenticated)
  // ===========================================================================

  /// Main app shell with bottom navigation
  static const String main = '/main';

  // ===========================================================================
  // HOME & DISCOVERY
  // ===========================================================================

  static const String home = '/home';
  static const String discover = '/discover';
  static const String moodSearch = '/mood-search';
  static const String samples = '/samples';
  static const String upcoming = '/upcoming';
  static const String seriesDetail = '/series/:id';
  static const String bookDetail = '/book-detail';

  // ===========================================================================
  // PLAYER & PLAYBACK
  // ===========================================================================

  static const String player = '/player';
  static const String carMode = '/car-mode';
  static const String transcript = '/transcript';

  // ===========================================================================
  // LIBRARY & COLLECTION
  // ===========================================================================

  static const String library = '/library';
  static const String wishlist = '/wishlist';
  static const String stats = '/stats';
  static const String downloads = '/downloads';
  static const String bookmarks = '/bookmarks';
  static const String savedBookmarks = '/saved-bookmarks';
  static const String shelves = '/shelves';

  // ===========================================================================
  // SEARCH
  // ===========================================================================

  static const String search = '/search';
  static const String searchResults = '/search/results';
  static const String advancedFilters = '/search/filters';
  static const String authorDetail = '/author/:id';
  static const String narratorDetail = '/narrator/:id';

  // ===========================================================================
  // SOCIAL & COMMUNITY
  // ===========================================================================

  static const String socialHub = '/social';
  static const String bookClubs = '/book-clubs';
  static const String bookClubDetail = '/book-clubs/:id';
  static const String liveDiscussion = '/live-discussion/:id';
  static const String challenge = '/challenge/:id';
  static const String review = '/review/:bookId';

  // ===========================================================================
  // MONETIZATION
  // ===========================================================================

  static const String pricing = '/pricing';
  static const String paymentMethods = '/payment-methods';
  static const String billingHistory = '/billing-history';
  static const String promoCode = '/promo-code';
  static const String subscription = '/subscription';
  static const String referral = '/referral';

  // ===========================================================================
  // SETTINGS
  // ===========================================================================

  static const String accessibility = '/settings/accessibility';
  static const String displayTheme = '/settings/display';
  static const String notifications = '/settings/notifications';
  static const String privacy = '/settings/privacy';
  static const String appSettings = '/settings/app';
  static const String language = '/settings/language';
  static const String storage = '/settings/storage';
  static const String playbackSettings = '/settings/playback';

  // Social Additional
  static const String challenges = '/challenges';
  static const String follow = '/follow';

  // ===========================================================================
  // KIDS & FAMILY
  // ===========================================================================

  static const String familySharing = '/family';
  static const String kidsMode = '/kids-mode';
  static const String kidsLibrary = '/kids-library';
  static const String childProfile = '/child/:id';

  // ===========================================================================
  // PROFILE & ACCOUNT
  // ===========================================================================

  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String notificationCenter = '/notification-center';
}

/// Route generator for MaterialApp
///
/// Usage:
/// ```dart
/// MaterialApp(
///   onGenerateRoute: AppRouter.generateRoute,
/// )
/// ```
class AppRouter {
  /// Generate route based on settings
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth routes
      case Routes.splash:
        return _fadeRoute(const SplashScreen(), settings);

      case Routes.welcome:
        return _slideRoute(const WelcomeScreen(), settings);

      case Routes.login:
        return _slideRoute(const LoginScreen(), settings);

      case Routes.preferences:
        return _slideRoute(const PreferencesScreen(), settings);

      case Routes.signIn:
        return _slideRoute(const SignInScreen(), settings);

      case Routes.forgotPassword:
        return _slideRoute(const ForgotPasswordScreen(), settings);

      case Routes.verification:
        return _slideRoute(const VerificationScreen(), settings);

      // Main shell
      case Routes.main:
        return _fadeRoute(const MainShell(), settings);

      // Discovery screens
      case Routes.discover:
        return _slideRoute(const DiscoverScreen(), settings);

      case Routes.bookDetail:
        final bookId = settings.arguments as String?;
        return _slideRoute(BookDetailScreen(bookId: bookId), settings);

      // Player screens
      case Routes.player:
        final bookId = settings.arguments as String?;
        return _slideRoute(PlayerScreen(bookId: bookId), settings);

      case Routes.carMode:
        return _slideRoute(const CarModeScreen(), settings);

      case Routes.bookmarks:
        return _slideRoute(const BookmarksScreen(), settings);

      case Routes.samples:
        return _slideRoute(const SamplesScreen(), settings);

      case Routes.upcoming:
        return _slideRoute(const UpcomingScreen(), settings);

      // Library Routes
      case Routes.wishlist:
        return _slideRoute(const WishlistScreen(), settings);

      case Routes.stats:
        return _slideRoute(const StatsScreen(), settings);

      case Routes.downloads:
        return _slideRoute(const DownloadsScreen(), settings);

      case Routes.savedBookmarks:
        return _slideRoute(const SavedBookmarksScreen(), settings);

      case Routes.shelves:
        return _slideRoute(const ShelvesScreen(), settings);

      case Routes.moodSearch:
        return _slideRoute(const MoodSearchScreen(), settings);

      case Routes.seriesDetail:
        final seriesId = settings.arguments as String?;
        return _slideRoute(SeriesDetailScreen(seriesId: seriesId), settings);

      case Routes.transcript:
        return _slideRoute(const TranscriptScreen(), settings);

      // Search routes
      case Routes.advancedFilters:
        return _slideRoute(const AdvancedSearchFiltersScreen(), settings);

      case Routes.narratorDetail:
        final narratorId = settings.arguments as String?;
        return _slideRoute(
          NarratorDetailScreen(narratorId: narratorId),
          settings,
        );

      // Social routes
      case Routes.socialHub:
        return _slideRoute(const SocialHubScreen(), settings);

      case Routes.bookClubs:
        return _slideRoute(const BookClubsScreen(), settings);

      case Routes.liveDiscussion:
        return _slideRoute(const LiveDiscussionScreen(), settings);

      case Routes.challenges:
        return _slideRoute(const ChallengesScreen(), settings);

      case Routes.review:
        return _slideRoute(const ReviewScreen(), settings);

      case Routes.follow:
        return _slideRoute(const FollowScreen(), settings);

      // Settings routes
      case Routes.appSettings:
        return _slideRoute(const AppSettingsScreen(), settings);

      case Routes.displayTheme:
        return _slideRoute(const DisplayScreen(), settings);

      case Routes.notifications:
        return _slideRoute(const NotificationsScreen(), settings);

      case Routes.privacy:
        return _slideRoute(const PrivacyScreen(), settings);

      case Routes.accessibility:
        return _slideRoute(const AccessibilityScreen(), settings);

      case Routes.language:
        return _slideRoute(const LanguageScreen(), settings);

      case Routes.storage:
        return _slideRoute(const StorageScreen(), settings);

      case Routes.playbackSettings:
        return _slideRoute(const PlaybackSettingsScreen(), settings);

      // Family routes
      case Routes.familySharing:
        return _slideRoute(const FamilySharingScreen(), settings);

      case Routes.kidsMode:
        return _slideRoute(const KidsModeScreen(), settings);

      case Routes.kidsLibrary:
        return _slideRoute(const KidsLibraryScreen(), settings);

      case Routes.childProfile:
        return _slideRoute(const ChildDashboardScreen(), settings);

      // Default - not found
      default:
        return _fadeRoute(
          Scaffold(
            body: Center(child: Text('Route not found: ${settings.name}')),
          ),
          settings,
        );
    }
  }

  /// Fade transition route
  static Route<dynamic> _fadeRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  /// Slide transition route (right to left)
  static Route<dynamic> _slideRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  /// Bottom sheet route
  static Route<dynamic> bottomSheetRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}

/// Navigation helper extensions
extension NavigationExtensions on BuildContext {
  /// Navigate to a named route
  Future<T?> navigateTo<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamed<T>(this, routeName, arguments: arguments);
  }

  /// Replace current route with a new one
  Future<T?> replaceTo<T>(String routeName, {Object? arguments}) {
    return Navigator.pushReplacementNamed<T, dynamic>(
      this,
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate and remove all previous routes
  Future<T?> navigateAndClear<T>(String routeName, {Object? arguments}) {
    return Navigator.pushNamedAndRemoveUntil<T>(
      this,
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Go back to previous screen
  void goBack<T>([T? result]) {
    Navigator.pop<T>(this, result);
  }
}
