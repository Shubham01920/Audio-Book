import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import '../models/book_model.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../features/player/provider/player_provider.dart';
import '../features/player/widgets/mini_player.dart';
import '../repositories/book_repository.dart';
import 'book_details_page.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bookRepository = context.read<BookRepository>();

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          // Book grid - using repository stream
          StreamBuilder<List<Book>>(
            stream: bookRepository.getBooksStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error: ${snapshot.error}",
                    style: TextStyle(color: AppColors.error),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              final books = snapshot.data ?? [];

              if (books.isEmpty) {
                return _buildEmptyState();
              }

              return _buildBookGrid(context, books);
            },
          ),

          // Mini player at bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Consumer<PlayerProvider>(
              builder: (context, playerProvider, child) {
                if (!playerProvider.state.hasContent) {
                  return const SizedBox.shrink();
                }
                return const MiniPlayer();
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundDark,
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.headphones, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            'Audiobooks',
            style: AppTypography.headlineSmall.copyWith(
              color: AppColors.textPrimaryDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.textPrimaryDark),
          onPressed: () {
            _showSearchDialog(context);
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.person_outline,
            color: AppColors.textPrimaryDark,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
          },
        ),
      ],
    );
  }

  void _showSearchDialog(BuildContext context) {
    showSearch(
      context: context,
      delegate: BookSearchDelegate(
        bookRepository: context.read<BookRepository>(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.library_books_outlined,
            size: 80,
            color: AppColors.textTertiaryDark,
          ),
          const SizedBox(height: 16),
          Text(
            'No Books Available',
            style: AppTypography.titleLarge.copyWith(
              color: AppColors.textSecondaryDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for new titles',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textTertiaryDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookGrid(BuildContext context, List<Book> books) {
    return Consumer<PlayerProvider>(
      builder: (context, playerProvider, child) {
        final bottomPadding = playerProvider.state.hasContent ? 80.0 : 10.0;

        return GridView.builder(
          padding: EdgeInsets.fromLTRB(16, 16, 16, bottomPadding),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            return FadeInUp(
              duration: const Duration(milliseconds: 400),
              delay: Duration(milliseconds: index * 50),
              child: _BookCard(book: books[index]),
            );
          },
        );
      },
    );
  }
}

// Search delegate for book search
class BookSearchDelegate extends SearchDelegate<Book?> {
  final BookRepository bookRepository;

  BookSearchDelegate({required this.bookRepository});

  @override
  String get searchFieldLabel => 'Search audiobooks...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: AppColors.textTertiaryDark),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(
          'Search by title or author',
          style: TextStyle(color: AppColors.textTertiaryDark),
        ),
      );
    }
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    return FutureBuilder<List<Book>>(
      future: bookRepository.searchBooks(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final results = snapshot.data ?? [];

        if (results.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: AppColors.textTertiaryDark,
                ),
                const SizedBox(height: 16),
                Text(
                  'No books found for "$query"',
                  style: TextStyle(color: AppColors.textSecondaryDark),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final book = results[index];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: book.coverUrl,
                  width: 50,
                  height: 70,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => Container(
                    width: 50,
                    height: 70,
                    color: AppColors.elevatedDark,
                    child: const Icon(
                      Icons.book,
                      color: AppColors.textTertiaryDark,
                    ),
                  ),
                ),
              ),
              title: Text(
                book.title,
                style: TextStyle(color: AppColors.textPrimaryDark),
              ),
              subtitle: Text(
                book.author,
                style: TextStyle(color: AppColors.textSecondaryDark),
              ),
              onTap: () {
                close(context, book);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailsScreen(bookId: book.id),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _BookCard extends StatelessWidget {
  final Book book;

  const _BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsScreen(bookId: book.id),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image
            Expanded(
              flex: 4,
              child: Hero(
                tag: 'book_cover_${book.id}',
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    color: AppColors.elevatedDark,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: book.coverUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.elevatedDark,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.elevatedDark,
                        child: const Icon(
                          Icons.book,
                          size: 48,
                          color: AppColors.textTertiaryDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Title and author
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.titleSmall.copyWith(
                        color: AppColors.textPrimaryDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                    const Spacer(),

                    // Progress indicator (if started)
                    if (book.progress > 0) ...[
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: LinearProgressIndicator(
                                value: book.progress,
                                minHeight: 4,
                                backgroundColor: AppColors.progressInactive,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            book.progressPercentage,
                            style: AppTypography.labelSmall.copyWith(
                              color: AppColors.textTertiaryDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
