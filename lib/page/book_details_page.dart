import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book_model.dart';
import '../models/episode_model.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../features/player/provider/player_provider.dart';
import '../features/player/widgets/widgets.dart';
import '../repositories/book_repository.dart';
import '../repositories/bookmark_repository.dart';
import '../services/download_manager.dart';
import '../services/auth_service.dart';
import '../services/coin_service.dart';
import '../features/premium/paywall_sheet.dart';

class BookDetailsScreen extends StatefulWidget {
  final String bookId;

  const BookDetailsScreen({super.key, required this.bookId});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  Book? _book;
  List<Episode> _episodes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadBookData();
    });
  }

  Future<void> _loadBookData() async {
    final bookRepository = context.read<BookRepository>();
    final book = await bookRepository.getBook(widget.bookId);
    final episodes = await bookRepository.getEpisodes(widget.bookId);

    if (mounted) {
      setState(() {
        _book = book;
        _episodes = episodes;
        _isLoading = false;
      });
    }
  }

  /// Get bookmarks count for this book from Firestore
  Future<int> _getBookmarksCount(String bookId) async {
    final authService = context.read<AuthService>();
    final userId = authService.currentUser?.uid;
    if (userId == null) return 0;

    final bookmarkRepo = BookmarkRepository();
    final bookmarks = await bookmarkRepo.getBookmarksForBook(userId, bookId);
    return bookmarks.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // App bar with cover
              _buildSliverAppBar(),

              // Book info
              SliverToBoxAdapter(child: _buildBookInfo()),

              // Episodes list
              _buildEpisodesList(),

              // Bottom padding for mini player
              SliverToBoxAdapter(
                child: Consumer<PlayerProvider>(
                  builder: (context, player, child) {
                    return SizedBox(height: player.state.hasContent ? 88 : 24);
                  },
                ),
              ),
            ],
          ),

          // Mini player
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Consumer<PlayerProvider>(
              builder: (context, player, child) {
                if (!player.state.hasContent) return const SizedBox.shrink();
                return const MiniPlayer();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    final bookRepository = context.read<BookRepository>();

    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _book?.isFavorite == true
                  ? Icons.bookmark
                  : Icons.bookmark_border,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            if (_book != null) {
              bookRepository.toggleFavorite(_book!.id, !(_book!.isFavorite));
              setState(() {
                _book = _book!.copyWith(isFavorite: !_book!.isFavorite);
              });
            }
          },
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.share, color: Colors.white),
          ),
          onPressed: () {
            // TODO: Share book
          },
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Blurred background
            if (_book != null)
              CachedNetworkImage(
                imageUrl: _book!.coverUrl,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.6),
                colorBlendMode: BlendMode.darken,
              ),

            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.backgroundDark.withOpacity(0.8),
                    AppColors.backgroundDark,
                  ],
                  stops: const [0.3, 0.7, 1.0],
                ),
              ),
            ),

            // Cover art - Hero tag unique per screen
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: Hero(
                  tag: 'book_cover_${widget.bookId}',
                  child: Container(
                    width: 160,
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _book != null
                          ? CachedNetworkImage(
                              imageUrl: _book!.coverUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Container(color: AppColors.cardDark),
                              errorWidget: (context, url, error) => Container(
                                color: AppColors.cardDark,
                                child: const Icon(
                                  Icons.book,
                                  size: 60,
                                  color: AppColors.textTertiaryDark,
                                ),
                              ),
                            )
                          : Container(color: AppColors.cardDark),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookInfo() {
    if (_isLoading || _book == null) {
      return const SizedBox(height: 150);
    }

    final book = _book!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Title
          FadeInDown(
            duration: const Duration(milliseconds: 400),
            child: Text(
              book.title,
              style: AppTypography.headlineMedium.copyWith(
                color: AppColors.textPrimaryDark,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),

          // Author
          FadeIn(
            delay: const Duration(milliseconds: 200),
            child: Text(
              'By ${book.author}',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondaryDark,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Stats row
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (book.rating != null) ...[
                  _StatChip(
                    icon: Icons.star,
                    value: book.rating!.toStringAsFixed(1),
                    iconColor: AppColors.warning,
                  ),
                  const SizedBox(width: 16),
                ],
                if (book.duration != null) ...[
                  _StatChip(
                    icon: Icons.access_time,
                    value: _formatDuration(book.duration!),
                  ),
                  const SizedBox(width: 16),
                ],
                _StatChip(
                  icon: Icons.list,
                  value: '${_episodes.length} chapters',
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Audio Bookmarks indicator
          FutureBuilder<int>(
            future: _getBookmarksCount(book.id),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data! > 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.bookmark,
                          color: AppColors.primary,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${snapshot.data} bookmark${snapshot.data! > 1 ? 's' : ''} saved',
                          style: AppTypography.labelMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 24),

          // Play button
          FadeInUp(
            delay: const Duration(milliseconds: 400),
            child: _PlayBookButton(book: book, episodes: _episodes),
          ),

          // Download button
          const SizedBox(height: 12),
          FadeInUp(
            delay: const Duration(milliseconds: 450),
            child: _DownloadBookButton(bookId: book.id, episodes: _episodes),
          ),

          // Synopsis
          if (book.synopsis != null && book.synopsis!.isNotEmpty) ...[
            const SizedBox(height: 24),
            FadeInUp(
              delay: const Duration(milliseconds: 500),
              child: _buildSynopsis(book.synopsis!),
            ),
          ],

          const SizedBox(height: 16),
          const Divider(color: AppColors.elevatedDark),
          const SizedBox(height: 8),

          // Chapters header
          Row(
            children: [
              Text(
                'Chapters',
                style: AppTypography.titleLarge.copyWith(
                  color: AppColors.textPrimaryDark,
                ),
              ),
              const Spacer(),
              Text(
                '${_episodes.length} total',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textTertiaryDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSynopsis(String synopsis) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Synopsis',
          style: AppTypography.titleMedium.copyWith(
            color: AppColors.textPrimaryDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          synopsis,
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondaryDark,
            height: 1.6,
          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildEpisodesList() {
    if (_isLoading) {
      return const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    if (_episodes.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Text(
              'No Chapters Added Yet',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondaryDark,
              ),
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final episode = _episodes[index];
        return FadeInLeft(
          delay: Duration(milliseconds: index * 30),
          duration: const Duration(milliseconds: 300),
          child: _EpisodeListTile(
            episode: episode,
            book: _book,
            allEpisodes: _episodes,
            index: index,
          ),
        );
      }, childCount: _episodes.length),
    );
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color? iconColor;

  const _StatChip({required this.icon, required this.value, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: iconColor ?? AppColors.textSecondaryDark),
        const SizedBox(width: 4),
        Text(
          value,
          style: AppTypography.labelMedium.copyWith(
            color: AppColors.textSecondaryDark,
          ),
        ),
      ],
    );
  }
}

class _PlayBookButton extends StatelessWidget {
  final Book book;
  final List<Episode> episodes;

  const _PlayBookButton({required this.book, required this.episodes});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, player, child) {
        final state = player.state;
        final isCurrentBook = state.currentBook?.id == book.id;
        final isPlaying = isCurrentBook && state.isPlaying;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Play/Resume button
            GestureDetector(
              onTap: () {
                if (episodes.isEmpty) return;

                if (isCurrentBook) {
                  player.togglePlayPause();
                } else {
                  player.loadBook(
                    book: book,
                    episodes: episodes,
                    startIndex: 0,
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isPlaying
                          ? 'Pause'
                          : isCurrentBook
                          ? 'Resume'
                          : 'Play',
                      style: AppTypography.labelLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DownloadBookButton extends StatelessWidget {
  final String bookId;
  final List<Episode> episodes;

  const _DownloadBookButton({required this.bookId, required this.episodes});

  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadManager>(
      builder: (context, downloadManager, child) {
        final downloadedCount = downloadManager
            .getDownloadedEpisodeIds(bookId)
            .length;
        final isDownloading = episodes.any(
          (e) => downloadManager.isDownloading(e.id),
        );
        final isFullyDownloaded =
            downloadedCount == episodes.length && episodes.isNotEmpty;

        return OutlinedButton.icon(
          onPressed: () {
            if (isFullyDownloaded) {
              // Delete all downloads
              downloadManager.deleteBookDownloads(bookId);
            } else if (!isDownloading) {
              // Start downloading
              downloadManager.downloadBook(bookId, episodes);
            }
          },
          icon: Icon(
            isFullyDownloaded
                ? Icons.download_done
                : isDownloading
                ? Icons.downloading
                : Icons.download,
          ),
          label: Text(
            isFullyDownloaded
                ? 'Downloaded'
                : isDownloading
                ? 'Downloading...'
                : 'Download',
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: isFullyDownloaded
                ? AppColors.success
                : AppColors.textSecondaryDark,
            side: BorderSide(
              color: isFullyDownloaded
                  ? AppColors.success
                  : AppColors.textTertiaryDark,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          ),
        );
      },
    );
  }
}

class _EpisodeListTile extends StatelessWidget {
  final Episode episode;
  final Book? book;
  final List<Episode> allEpisodes;
  final int index;

  // First 2 episodes are always free
  static const int freeEpisodeCount = 2;

  const _EpisodeListTile({
    required this.episode,
    required this.book,
    required this.allEpisodes,
    required this.index,
  });

  /// Check if episode is locked using the unlocked list from stream
  bool _isLocked(List<dynamic> unlockedList, bool isPremium) {
    // First 2 episodes always free
    if (index < freeEpisodeCount) return false;

    // Episode marked as free in database
    if (episode.isFree) return false;

    // User has premium
    if (isPremium) return false;

    // Check if unlocked with coins using bookId_index format
    if (book != null &&
        CoinService.isEpisodeUnlocked(unlockedList, book!.id, index)) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final downloadManager = context.watch<DownloadManager>();
    final authService = context.watch<AuthService>();
    final user = authService.currentUser;
    final userId = user?.uid;

    final isDownloaded = downloadManager.isDownloaded(episode.id);
    final downloadProgress = downloadManager.getDownloadProgress(episode.id);
    final isDownloading = downloadManager.isDownloading(episode.id);

    // Wrap in StreamBuilder for real-time updates
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: userId != null ? CoinService().getUserStream(userId) : null,
      builder: (context, snapshot) {
        // Get current coins and unlocked episodes from stream
        final currentCoins = CoinService.getCoinsFromSnapshot(snapshot.data);
        final unlockedList = CoinService.getUnlockedFromSnapshot(snapshot.data);
        final isPremium = user?.hasPremiumAccess ?? false;
        final isLocked = _isLocked(unlockedList, isPremium);

        return Consumer<PlayerProvider>(
          builder: (context, player, child) {
            final state = player.state;
            final isPlaying =
                state.currentEpisode?.id == episode.id && state.isPlaying;
            final isCurrent = state.currentEpisode?.id == episode.id;

            return ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 4,
              ),
              tileColor: isCurrent ? AppColors.primary.withOpacity(0.1) : null,
              leading: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      // Locked episodes get gold/amber color
                      color: isLocked
                          ? Colors.amber.shade800
                          : isCurrent
                          ? AppColors.primary
                          : AppColors.cardDark,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: isLocked
                          ? const Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 20,
                            )
                          : isPlaying
                          ? const Icon(
                              Icons.graphic_eq,
                              color: Colors.white,
                              size: 22,
                            )
                          : Text(
                              '${index + 1}',
                              style: AppTypography.titleMedium.copyWith(
                                color: isCurrent
                                    ? Colors.white
                                    : AppColors.textSecondaryDark,
                              ),
                            ),
                    ),
                  ),
                  if (isDownloading && !isLocked)
                    SizedBox(
                      width: 44,
                      height: 44,
                      child: CircularProgressIndicator(
                        value: downloadProgress,
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    ),
                ],
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      episode.title,
                      style: AppTypography.titleSmall.copyWith(
                        color: isLocked
                            ? AppColors.textTertiaryDark
                            : isCurrent
                            ? AppColors.primary
                            : AppColors.textPrimaryDark,
                        fontWeight: isCurrent
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                  if (isDownloaded && !isLocked)
                    const Icon(
                      Icons.download_done,
                      size: 16,
                      color: AppColors.success,
                    ),
                  if (isLocked)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${CoinService.episodeUnlockCost}🪙',
                        style: const TextStyle(
                          color: Colors.amber,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              subtitle: Text(
                episode.formattedDuration,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondaryDark,
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  isLocked
                      ? Icons.lock_open
                      : isCurrent
                      ? (isPlaying ? Icons.pause_circle : Icons.play_circle)
                      : Icons.play_circle_outline,
                  color: isLocked
                      ? Colors.amber
                      : isCurrent
                      ? AppColors.primary
                      : AppColors.textSecondaryDark,
                ),
                iconSize: 36,
                onPressed: () =>
                    _onTap(context, player, isLocked, currentCoins),
              ),
              onTap: () => _onTap(context, player, isLocked, currentCoins),
            );
          },
        );
      },
    );
  }

  void _onTap(
    BuildContext context,
    PlayerProvider player,
    bool isLocked,
    int currentCoins,
  ) {
    if (book == null) return;

    if (isLocked) {
      // Show paywall with current coin balance
      PaywallSheet.show(
        context,
        episode: episode,
        episodeIndex: index,
        currentCoins: currentCoins,
        onUnlocked: () {
          // Play the episode after unlock
          player.loadBook(
            book: book!,
            episodes: allEpisodes,
            startIndex: index,
          );
        },
      );
    } else {
      // Play normally
      final state = player.state;
      final isCurrent = state.currentEpisode?.id == episode.id;

      if (isCurrent) {
        player.togglePlayPause();
      } else {
        player.loadBook(book: book!, episodes: allEpisodes, startIndex: index);
      }
    }
  }
}
