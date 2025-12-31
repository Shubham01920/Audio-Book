import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hive/hive.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../models/book_model.dart';
import '../repositories/book_repository.dart';
import 'book_details_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<Book> _searchResults = [];
  List<String> _recentSearches = [];
  bool _isLoading = false;
  bool _hasSearched = false;

  // Genre shortcuts for quick browsing
  final List<Map<String, dynamic>> _genres = [
    {'name': 'Fiction', 'icon': Icons.auto_stories, 'color': Color(0xFF6366F1)},
    {'name': 'Non-Fiction', 'icon': Icons.school, 'color': Color(0xFF10B981)},
    {'name': 'Self-Help', 'icon': Icons.psychology, 'color': Color(0xFFF59E0B)},
    {'name': 'Mystery', 'icon': Icons.search, 'color': Color(0xFFEF4444)},
    {'name': 'Romance', 'icon': Icons.favorite, 'color': Color(0xFFEC4899)},
    {'name': 'Sci-Fi', 'icon': Icons.rocket_launch, 'color': Color(0xFF8B5CF6)},
    {
      'name': 'Fantasy',
      'icon': Icons.auto_fix_high,
      'color': Color(0xFF14B8A6),
    },
    {'name': 'Biography', 'icon': Icons.person, 'color': Color(0xFF3B82F6)},
  ];

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
    // Auto-focus search field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _loadRecentSearches() async {
    try {
      final box = await Hive.openBox('search_history');
      final searches = box.get('recent', defaultValue: <String>[]);
      setState(() {
        _recentSearches = List<String>.from(searches);
      });
    } catch (e) {
      debugPrint('Error loading recent searches: $e');
    }
  }

  Future<void> _saveRecentSearch(String query) async {
    if (query.trim().isEmpty) return;

    try {
      final box = await Hive.openBox('search_history');
      final searches = List<String>.from(
        box.get('recent', defaultValue: <String>[]),
      );

      // Remove if exists, add to front
      searches.remove(query);
      searches.insert(0, query);

      // Keep only last 10
      if (searches.length > 10) {
        searches.removeRange(10, searches.length);
      }

      await box.put('recent', searches);
      setState(() {
        _recentSearches = searches;
      });
    } catch (e) {
      debugPrint('Error saving search: $e');
    }
  }

  Future<void> _clearRecentSearches() async {
    try {
      final box = await Hive.openBox('search_history');
      await box.put('recent', <String>[]);
      setState(() {
        _recentSearches = [];
      });
    } catch (e) {
      debugPrint('Error clearing searches: $e');
    }
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _hasSearched = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _hasSearched = true;
    });

    try {
      final bookRepository = context.read<BookRepository>();
      final results = await bookRepository.searchBooks(query);

      setState(() {
        _searchResults = results;
        _isLoading = false;
      });

      _saveRecentSearch(query);
    } catch (e) {
      debugPrint('Search error: $e');
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
    }
  }

  void _searchByGenre(String genre) {
    _searchController.text = genre;
    _performSearch(genre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search Header
            _buildSearchHeader(),

            // Content
            Expanded(
              child: _isLoading
                  ? _buildLoadingState()
                  : _hasSearched
                  ? _buildSearchResults()
                  : _buildDiscoveryContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchHeader() {
    return FadeInDown(
      duration: const Duration(milliseconds: 300),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Back Button
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () => Navigator.pop(context),
            ),

            // Search Field
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  style: TextStyle(color: Theme.of(context).hintColor),
                  decoration: InputDecoration(
                    hintText: 'Search books, authors, narrators...',
                    hintStyle: TextStyle(color: AppColors.textTertiaryDark),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.textTertiaryDark,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(
                              Icons.close,
                              color: AppColors.textTertiaryDark,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchResults = [];
                                _hasSearched = false;
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onSubmitted: _performSearch,
                  onChanged: (value) {
                    setState(() {}); // Update clear button visibility
                    // Debounced search
                    if (value.length >= 2) {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        if (_searchController.text == value) {
                          _performSearch(value);
                        }
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            'Searching...',
            style: TextStyle(color: AppColors.textSecondaryDark),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoveryContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent Searches
          if (_recentSearches.isNotEmpty) ...[
            _buildRecentSearches(),
            const SizedBox(height: 24),
          ],

          // Browse by Genre
          _buildGenreGrid(),
        ],
      ),
    );
  }

  Widget _buildRecentSearches() {
    return FadeInUp(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: AppTypography.titleMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              TextButton(
                onPressed: _clearRecentSearches,
                child: Text(
                  'Clear All',
                  style: TextStyle(color: AppColors.textTertiaryDark),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _recentSearches.map((search) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = search;
                  _performSearch(search);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.elevatedDark,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.history,
                        size: 16,
                        color: AppColors.textTertiaryDark,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        search,
                        style: TextStyle(color: AppColors.textSecondaryDark),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildGenreGrid() {
    return FadeInUp(
      delay: const Duration(milliseconds: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Browse by Genre',
            style: AppTypography.titleMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: _genres.length,
            itemBuilder: (context, index) {
              final genre = _genres[index];
              return _GenreCard(
                name: genre['name'],
                icon: genre['icon'],
                color: genre['color'],
                onTap: () => _searchByGenre(genre['name']),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return _buildEmptyResults();
    }

    return FadeIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '${_searchResults.length} results found',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return FadeInUp(
                  delay: Duration(milliseconds: 50 * index),
                  child: _SearchResultCard(
                    book: _searchResults[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookDetailsScreen(
                            bookId: _searchResults[index].id,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyResults() {
    return FadeIn(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: AppColors.textTertiaryDark),
            const SizedBox(height: 16),
            Text(
              'No books found',
              style: AppTypography.titleLarge.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching with different keywords',
              style: TextStyle(color: AppColors.textSecondaryDark),
            ),
          ],
        ),
      ),
    );
  }
}

class _GenreCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _GenreCard({
    required this.name,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withValues(alpha: 0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 8),
            Text(
              name,
              style: AppTypography.labelLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  final Book book;
  final VoidCallback onTap;

  const _SearchResultCard({required this.book, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Book Cover
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: book.coverUrl,
                width: 60,
                height: 90,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  color: AppColors.elevatedDark,
                  child: Icon(Icons.book, color: AppColors.textTertiaryDark),
                ),
                errorWidget: (_, __, ___) => Container(
                  color: AppColors.elevatedDark,
                  child: Icon(Icons.book, color: AppColors.textTertiaryDark),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Book Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: AppTypography.titleSmall.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.author,
                    style: TextStyle(
                      color: AppColors.textSecondaryDark,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        (book.rating ?? 0.0).toStringAsFixed(1),
                        style: TextStyle(
                          color: AppColors.textSecondaryDark,
                          fontSize: 12,
                        ),
                      ),
                      if (book.duration != null) ...[
                        const SizedBox(width: 12),
                        Icon(
                          Icons.headphones,
                          color: AppColors.textTertiaryDark,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDuration(book.duration!),
                          style: TextStyle(
                            color: AppColors.textTertiaryDark,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(Icons.chevron_right, color: AppColors.textTertiaryDark),
          ],
        ),
      ),
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
