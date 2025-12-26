import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book_model.dart';
import '../models/episode_model.dart';

/// Complete Book Repository with all CRUD operations
class BookRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Books collection reference
  CollectionReference<Map<String, dynamic>> get _booksCollection =>
      _firestore.collection('books');

  // ==================== BOOK OPERATIONS ====================

  /// Get all books from Firestore
  Future<List<Book>> getAllBooks() async {
    try {
      final snapshot = await _booksCollection.get();
      return snapshot.docs
          .map((doc) => Book.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching books: $e");
      return [];
    }
  }

  /// Get all books as a stream (real-time updates)
  Stream<List<Book>> getBooksStream() {
    return _booksCollection.snapshots().map(
      (snapshot) =>
          snapshot.docs.map((doc) => Book.fromMap(doc.data(), doc.id)).toList(),
    );
  }

  /// Get a single book by ID
  Future<Book?> getBook(String bookId) async {
    try {
      final doc = await _booksCollection.doc(bookId).get();
      if (doc.exists && doc.data() != null) {
        return Book.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      print("Error fetching book: $e");
      return null;
    }
  }

  /// Get books by genre
  Future<List<Book>> getBooksByGenre(String genre) async {
    try {
      final snapshot = await _booksCollection
          .where('genre', isEqualTo: genre)
          .get();
      return snapshot.docs
          .map((doc) => Book.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching books by genre: $e");
      return [];
    }
  }

  /// Get books by author
  Future<List<Book>> getBooksByAuthor(String author) async {
    try {
      final snapshot = await _booksCollection
          .where('author', isEqualTo: author)
          .get();
      return snapshot.docs
          .map((doc) => Book.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching books by author: $e");
      return [];
    }
  }

  /// Search books by title (prefix search)
  Future<List<Book>> searchBooks(String query) async {
    try {
      final queryLower = query.toLowerCase();
      final snapshot = await _booksCollection.get();

      // Client-side filtering for flexible search
      return snapshot.docs
          .map((doc) => Book.fromMap(doc.data(), doc.id))
          .where(
            (book) =>
                book.title.toLowerCase().contains(queryLower) ||
                book.author.toLowerCase().contains(queryLower),
          )
          .toList();
    } catch (e) {
      print("Error searching books: $e");
      return [];
    }
  }

  /// Get favorite books
  Future<List<Book>> getFavoriteBooks() async {
    try {
      final snapshot = await _booksCollection
          .where('isFavorite', isEqualTo: true)
          .get();
      return snapshot.docs
          .map((doc) => Book.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching favorite books: $e");
      return [];
    }
  }

  /// Get books by status (inProgress, finished, etc.)
  Future<List<Book>> getBooksByStatus(BookStatus status) async {
    try {
      final snapshot = await _booksCollection
          .where('status', isEqualTo: status.name)
          .get();
      return snapshot.docs
          .map((doc) => Book.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching books by status: $e");
      return [];
    }
  }

  /// Get currently reading books (in progress)
  Future<List<Book>> getCurrentlyReading() async {
    return getBooksByStatus(BookStatus.inProgress);
  }

  // ==================== UPDATE OPERATIONS ====================

  /// Update book progress
  Future<void> updateBookProgress(
    String bookId, {
    required double progress,
    Duration? lastPosition,
    BookStatus? status,
  }) async {
    try {
      final Map<String, dynamic> updates = {
        'progress': progress,
        'lastListenedAt': FieldValue.serverTimestamp(),
      };

      if (lastPosition != null) {
        updates['lastPositionSeconds'] = lastPosition.inSeconds;
      }

      if (status != null) {
        updates['status'] = status.name;
      } else if (progress > 0 && progress < 1) {
        updates['status'] = BookStatus.inProgress.name;
      } else if (progress >= 1) {
        updates['status'] = BookStatus.finished.name;
      }

      await _booksCollection.doc(bookId).update(updates);
    } catch (e) {
      print("Error updating book progress: $e");
    }
  }

  /// Toggle favorite status
  Future<void> toggleFavorite(String bookId, bool isFavorite) async {
    try {
      await _booksCollection.doc(bookId).update({'isFavorite': isFavorite});
    } catch (e) {
      print("Error toggling favorite: $e");
    }
  }

  /// Update book status
  Future<void> updateBookStatus(String bookId, BookStatus status) async {
    try {
      await _booksCollection.doc(bookId).update({'status': status.name});
    } catch (e) {
      print("Error updating book status: $e");
    }
  }

  // ==================== EPISODE OPERATIONS ====================

  /// Get all episodes for a book (sorted by index)
  Future<List<Episode>> getEpisodes(String bookId) async {
    try {
      final snapshot = await _booksCollection
          .doc(bookId)
          .collection('episodes')
          .orderBy('index')
          .get();

      return snapshot.docs
          .map((doc) => Episode.fromMap(doc.data(), doc.id, bookId: bookId))
          .toList();
    } catch (e) {
      print("Error fetching episodes: $e");
      return [];
    }
  }

  /// Get episodes as stream
  Stream<List<Episode>> getEpisodesStream(String bookId) {
    return _booksCollection
        .doc(bookId)
        .collection('episodes')
        .orderBy('index')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Episode.fromMap(doc.data(), doc.id, bookId: bookId))
              .toList(),
        );
  }

  /// Get a single episode
  Future<Episode?> getEpisode(String bookId, String episodeId) async {
    try {
      final doc = await _booksCollection
          .doc(bookId)
          .collection('episodes')
          .doc(episodeId)
          .get();

      if (doc.exists && doc.data() != null) {
        return Episode.fromMap(doc.data()!, doc.id, bookId: bookId);
      }
      return null;
    } catch (e) {
      print("Error fetching episode: $e");
      return null;
    }
  }

  /// Update episode progress (last played position)
  Future<void> updateEpisodeProgress(
    String bookId,
    String episodeId,
    Duration position,
  ) async {
    try {
      await _booksCollection
          .doc(bookId)
          .collection('episodes')
          .doc(episodeId)
          .update({
            'lastPositionSeconds': position.inSeconds,
            'lastPlayedAt': FieldValue.serverTimestamp(),
          });
    } catch (e) {
      print("Error updating episode progress: $e");
    }
  }
}
