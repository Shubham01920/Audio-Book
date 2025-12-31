import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import '../models/book_model.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_typography.dart';
import '../repositories/book_repository.dart';
import 'book_details_page.dart';

/// Discover Page - Browse by categories, trending, new releases
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  // Categories
  final List<_Category> categories = [
    _Category('📖', 'Fiction', Colors.purple),
    _Category('🎭', 'Drama', Colors.pink),
    _Category('💕', 'Romance', Colors.red),
    _Category('🔍', 'Mystery', Colors.indigo),
    _Category('🚀', 'Sci-Fi', Colors.blue),
    _Category('📚', 'Non-Fiction', Colors.teal),
    _Category('🧘', 'Self-Help', Colors.green),
    _Category('💼', 'Business', Colors.orange),
    _Category('👶', 'Kids', Colors.amber),
    _Category('🎵', 'Music', Colors.cyan),
  ];

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final bookRepository = context.read<BookRepository>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Discover',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 20, bottom: 16),
            ),
          ),

          // Categories Grid
          SliverToBoxAdapter(
            child: FadeInDown(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                    child: Text(
                      'Browse Categories',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        final isSelected = selectedCategory == cat.name;
                        return _CategoryCard(
                          category: cat,
                          isSelected: isSelected,
                          onTap: () {
                            setState(() {
                              selectedCategory = isSelected ? null : cat.name;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Trending Section
          SliverToBoxAdapter(
            child: FadeInUp(
              delay: const Duration(milliseconds: 100),
              child: _SectionHeader(title: '🔥 Trending Now', onSeeAll: () {}),
            ),
          ),
          _BookHorizontalList(
            stream: bookRepository.getBooksStream(),
            filterCategory: selectedCategory,
          ),

          // New Releases
          SliverToBoxAdapter(
            child: FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: _SectionHeader(title: '✨ New Releases', onSeeAll: () {}),
            ),
          ),
          _BookHorizontalList(
            stream: bookRepository.getBooksStream(),
            filterCategory: selectedCategory,
            sortByDate: true,
          ),

          // Popular Authors
          SliverToBoxAdapter(
            child: FadeInUp(
              delay: const Duration(milliseconds: 300),
              child: _SectionHeader(
                title: '👤 Popular Authors',
                onSeeAll: () {},
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FadeInUp(
              delay: const Duration(milliseconds: 350),
              child: StreamBuilder<List<Book>>(
                stream: bookRepository.getBooksStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox(height: 100);
                  }
                  final authors = snapshot.data!
                      .map((b) => b.author)
                      .toSet()
                      .take(10)
                      .toList();
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: authors.length,
                      itemBuilder: (context, index) {
                        return _AuthorChip(name: authors[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // Continue Listening - Placeholder
          SliverToBoxAdapter(
            child: FadeInUp(
              delay: const Duration(milliseconds: 400),
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.3),
                      AppColors.primary.withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.headphones,
                      color: AppColors.primary,
                      size: 40,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Continue Listening',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                          ),
                          Text(
                            'Pick up where you left off',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textSecondaryDark,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }
}

class _Category {
  final String emoji;
  final String name;
  final Color color;

  _Category(this.emoji, this.name, this.color);
}

class _CategoryCard extends StatelessWidget {
  final _Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 85,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isSelected
                ? [category.color, category.color.withValues(alpha: 0.7)]
                : [
                    category.color.withValues(alpha: 0.3),
                    category.color.withValues(alpha: 0.1),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? category.color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(category.emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 6),
            Text(
              category.name,
              style: AppTypography.labelSmall.copyWith(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: Text('See All', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}

class _BookHorizontalList extends StatelessWidget {
  final Stream<List<Book>> stream;
  final String? filterCategory;
  final bool sortByDate;

  const _BookHorizontalList({
    required this.stream,
    this.filterCategory,
    this.sortByDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: StreamBuilder<List<Book>>(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            List<Book> books = List.from(snapshot.data!);

            // Filter by category if selected
            if (filterCategory != null) {
              books = books
                  .where(
                    (b) =>
                        b.genre?.toLowerCase().contains(
                          filterCategory!.toLowerCase(),
                        ) ??
                        false,
                  )
                  .toList();
            }

            // Shuffle for "new releases" to show different books
            if (sortByDate) {
              books.shuffle();
            }

            if (books.isEmpty) {
              return Center(
                child: Text(
                  'No books in this category',
                  style: TextStyle(color: AppColors.textSecondaryDark),
                ),
              );
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: books.length.clamp(0, 10),
              itemBuilder: (context, index) {
                return _DiscoverBookCard(book: books[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class _DiscoverBookCard extends StatelessWidget {
  final Book book;

  const _DiscoverBookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    final coverUrl = book.coverUrl;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BookDetailsScreen(bookId: book.id)),
        );
      },
      child: Container(
        width: 130,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: coverUrl != null && coverUrl.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: coverUrl,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(
                            color: AppColors.cardDark,
                            child: const Icon(
                              Icons.book,
                              color: AppColors.primary,
                            ),
                          ),
                          errorWidget: (_, __, ___) => Container(
                            color: AppColors.cardDark,
                            child: const Icon(
                              Icons.book,
                              color: AppColors.primary,
                            ),
                          ),
                        )
                      : Container(
                          color: AppColors.cardDark,
                          child: const Icon(
                            Icons.book,
                            color: AppColors.primary,
                            size: 40,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Title
            Text(
              book.title,
              style: AppTypography.labelMedium.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // Author
            Text(
              book.author,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondaryDark,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthorChip extends StatelessWidget {
  final String name;

  const _AuthorChip({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary.withValues(alpha: 0.2),
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name.split(' ').first,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.textSecondaryDark,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
