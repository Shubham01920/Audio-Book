import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/bookmark_model.dart';

/// Repository for managing bookmarks and notes
class BookmarkRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get bookmarks reference for a user
  CollectionReference<Map<String, dynamic>> _getUserBookmarks(String userId) {
    return _firestore.collection('users').doc(userId).collection('bookmarks');
  }

  // ==================== READ OPERATIONS ====================

  /// Get all bookmarks for a user
  Future<List<Bookmark>> getAllBookmarks(String userId) async {
    try {
      final snapshot = await _getUserBookmarks(
        userId,
      ).orderBy('createdAt', descending: true).get();

      return snapshot.docs
          .map((doc) => Bookmark.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching bookmarks: $e");
      return [];
    }
  }

  /// Get bookmarks for a specific book
  Future<List<Bookmark>> getBookmarksForBook(
    String userId,
    String bookId,
  ) async {
    try {
      final snapshot = await _getUserBookmarks(
        userId,
      ).where('bookId', isEqualTo: bookId).orderBy('position').get();

      return snapshot.docs
          .map((doc) => Bookmark.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching bookmarks for book: $e");
      return [];
    }
  }

  /// Get bookmarks for a specific episode
  Future<List<Bookmark>> getBookmarksForEpisode(
    String userId,
    String bookId,
    String episodeId,
  ) async {
    try {
      final snapshot = await _getUserBookmarks(userId)
          .where('bookId', isEqualTo: bookId)
          .where('episodeId', isEqualTo: episodeId)
          .orderBy('position')
          .get();

      return snapshot.docs
          .map((doc) => Bookmark.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching episode bookmarks: $e");
      return [];
    }
  }

  /// Get bookmarks stream for a book
  Stream<List<Bookmark>> getBookmarksStream(String userId, String bookId) {
    return _getUserBookmarks(userId)
        .where('bookId', isEqualTo: bookId)
        .orderBy('position')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Bookmark.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  /// Get bookmarks by category
  Future<List<Bookmark>> getBookmarksByCategory(
    String userId,
    String category,
  ) async {
    try {
      final snapshot = await _getUserBookmarks(userId)
          .where('category', isEqualTo: category)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Bookmark.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching bookmarks by category: $e");
      return [];
    }
  }

  /// Get a single bookmark
  Future<Bookmark?> getBookmark(String userId, String bookmarkId) async {
    try {
      final doc = await _getUserBookmarks(userId).doc(bookmarkId).get();
      if (doc.exists && doc.data() != null) {
        return Bookmark.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      print("Error fetching bookmark: $e");
      return null;
    }
  }

  // ==================== WRITE OPERATIONS ====================

  /// Create a new bookmark
  Future<Bookmark?> createBookmark(String userId, Bookmark bookmark) async {
    try {
      final docRef = await _getUserBookmarks(userId).add(bookmark.toMap());
      return bookmark.copyWith(id: docRef.id);
    } catch (e) {
      print("Error creating bookmark: $e");
      return null;
    }
  }

  /// Quick bookmark at current position
  Future<Bookmark?> quickBookmark({
    required String userId,
    required String bookId,
    required String episodeId,
    required Duration position,
    String? title,
  }) async {
    final bookmark = Bookmark(
      id: '',
      bookId: bookId,
      episodeId: episodeId,
      position: position,
      title: title ?? 'Bookmark at ${_formatDuration(position)}',
      createdAt: DateTime.now(),
    );

    return createBookmark(userId, bookmark);
  }

  /// Update a bookmark
  Future<void> updateBookmark(
    String userId,
    String bookmarkId, {
    String? title,
    String? note,
    BookmarkColor? color,
    String? category,
    Duration? clipDuration,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (title != null) updates['title'] = title;
      if (note != null) updates['note'] = note;
      if (color != null) updates['color'] = color.name;
      if (category != null) updates['category'] = category;
      if (clipDuration != null) {
        updates['clipDurationSeconds'] = clipDuration.inSeconds;
      }

      if (updates.isNotEmpty) {
        await _getUserBookmarks(userId).doc(bookmarkId).update(updates);
      }
    } catch (e) {
      print("Error updating bookmark: $e");
    }
  }

  /// Delete a bookmark
  Future<void> deleteBookmark(String userId, String bookmarkId) async {
    try {
      await _getUserBookmarks(userId).doc(bookmarkId).delete();
    } catch (e) {
      print("Error deleting bookmark: $e");
    }
  }

  /// Delete all bookmarks for a book
  Future<void> deleteBookmarksForBook(String userId, String bookId) async {
    try {
      final snapshot = await _getUserBookmarks(
        userId,
      ).where('bookId', isEqualTo: bookId).get();

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      print("Error deleting bookmarks for book: $e");
    }
  }

  // ==================== EXPORT ====================

  /// Export all bookmarks for a book as text
  Future<String> exportBookmarks(String userId, String bookId) async {
    final bookmarks = await getBookmarksForBook(userId, bookId);

    final buffer = StringBuffer();
    buffer.writeln('Bookmarks Export');
    buffer.writeln('================');
    buffer.writeln('');

    for (final bookmark in bookmarks) {
      buffer.writeln('📌 ${bookmark.title}');
      buffer.writeln('   Position: ${_formatDuration(bookmark.position)}');
      if (bookmark.note != null) {
        buffer.writeln('   Note: ${bookmark.note}');
      }
      buffer.writeln('');
    }

    return buffer.toString();
  }

  // ==================== HELPERS ====================

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }
}
