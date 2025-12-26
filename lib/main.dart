import 'package:audiobooks/core/theme/app_theme.dart';
import 'package:audiobooks/features/player/provider/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';
import 'features/auth/auth_wrapper.dart';
import 'repositories/book_repository.dart';
import 'repositories/collection_repository.dart';
import 'repositories/bookmark_repository.dart';
import 'services/progress_service.dart';
import 'services/download_manager.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Initialize services that need async setup
  final progressService = ProgressService();
  await progressService.init();

  final downloadManager = DownloadManager();
  await downloadManager.init();

  final authService = AuthService();
  await authService.init();

  runApp(
    AudiobooksApp(
      progressService: progressService,
      downloadManager: downloadManager,
      authService: authService,
    ),
  );
}

class AudiobooksApp extends StatelessWidget {
  final ProgressService progressService;
  final DownloadManager downloadManager;
  final AuthService authService;

  const AudiobooksApp({
    super.key,
    required this.progressService,
    required this.downloadManager,
    required this.authService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Auth service (must be first for auth-dependent services)
        ChangeNotifierProvider<AuthService>.value(value: authService),

        // Repositories (stateless, can be created fresh)
        Provider<BookRepository>(create: (_) => BookRepository()),
        Provider<CollectionRepository>(create: (_) => CollectionRepository()),
        Provider<BookmarkRepository>(create: (_) => BookmarkRepository()),

        // Services (already initialized)
        Provider<ProgressService>.value(value: progressService),
        ChangeNotifierProvider<DownloadManager>.value(value: downloadManager),

        // Player provider
        ChangeNotifierProvider<PlayerProvider>(create: (_) => PlayerProvider()),
      ],
      child: MaterialApp(
        title: 'Audiobooks',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: const AuthWrapper(),
      ),
    );
  }
}
