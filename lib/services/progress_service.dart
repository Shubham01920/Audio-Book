import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

/// Service for managing user listening progress with cross-device sync
class ProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _boxName = 'user_progress';

  // Local Hive box for offline caching
  Box? _progressBox;

  /// Initialize the progress service
  Future<void> init() async {
    _progressBox = await Hive.openBox(_boxName);
  }

  /// Get progress collection reference for a user
  CollectionReference<Map<String, dynamic>> _getUserProgressCollection(
    String userId,
  ) {
    return _firestore.collection('users').doc(userId).collection('progress');
  }

  // ==================== SAVE PROGRESS ====================

  /// Save listening progress (both local and remote)
  Future<void> saveProgress({
    required String userId,
    required String bookId,
    required String episodeId,
    required Duration position,
    required Duration totalDuration,
  }) async {
    final progressData = {
      'bookId': bookId,
      'episodeId': episodeId,
      'positionSeconds': position.inSeconds,
      'totalDurationSeconds': totalDuration.inSeconds,
      'progress': totalDuration.inSeconds > 0
          ? position.inSeconds / totalDuration.inSeconds
          : 0.0,
      'updatedAt': DateTime.now().toIso8601String(),
    };

    // Save locally first (offline-first)
    await _saveLocalProgress(bookId, progressData);

    // Then sync to Firestore
    try {
      await _getUserProgressCollection(userId).doc(bookId).set({
        ...progressData,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error saving progress to Firestore: $e");
      // Local save already done, will sync later
    }
  }

  /// Save progress locally using Hive
  Future<void> _saveLocalProgress(
    String bookId,
    Map<String, dynamic> data,
  ) async {
    await _progressBox?.put(bookId, data);
  }

  // ==================== GET PROGRESS ====================

  /// Get last listening position for a book
  Future<({String? episodeId, Duration? position})?> getLastPosition({
    required String userId,
    required String bookId,
  }) async {
    // Try local first
    final localProgress = _getLocalProgress(bookId);
    if (localProgress != null) {
      return (
        episodeId: localProgress['episodeId'] as String?,
        position: Duration(seconds: localProgress['positionSeconds'] ?? 0),
      );
    }

    // Fallback to Firestore
    try {
      final doc = await _getUserProgressCollection(userId).doc(bookId).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        return (
          episodeId: data['episodeId'] as String?,
          position: Duration(seconds: data['positionSeconds'] ?? 0),
        );
      }
    } catch (e) {
      print("Error getting progress from Firestore: $e");
    }

    return null;
  }

  /// Get progress from local storage
  Map<String, dynamic>? _getLocalProgress(String bookId) {
    return _progressBox?.get(bookId) as Map<String, dynamic>?;
  }

  /// Get progress percentage for a book (0.0 to 1.0)
  Future<double> getBookProgress({
    required String userId,
    required String bookId,
  }) async {
    final localData = _getLocalProgress(bookId);
    if (localData != null) {
      return (localData['progress'] as num?)?.toDouble() ?? 0.0;
    }

    try {
      final doc = await _getUserProgressCollection(userId).doc(bookId).get();
      if (doc.exists && doc.data() != null) {
        return (doc.data()!['progress'] as num?)?.toDouble() ?? 0.0;
      }
    } catch (e) {
      print("Error getting book progress: $e");
    }

    return 0.0;
  }

  // ==================== LISTENING HISTORY ====================

  /// Get all books with progress (listening history)
  Future<List<Map<String, dynamic>>> getListeningHistory(String userId) async {
    try {
      final snapshot = await _getUserProgressCollection(
        userId,
      ).orderBy('updatedAt', descending: true).get();

      return snapshot.docs
          .map((doc) => {...doc.data(), 'bookId': doc.id})
          .toList();
    } catch (e) {
      print("Error getting listening history: $e");
      return [];
    }
  }

  /// Get recently played books
  Future<List<String>> getRecentlyPlayedBookIds(
    String userId, {
    int limit = 10,
  }) async {
    try {
      final snapshot = await _getUserProgressCollection(
        userId,
      ).orderBy('updatedAt', descending: true).limit(limit).get();

      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print("Error getting recently played: $e");
      return [];
    }
  }

  // ==================== SYNC ====================

  /// Sync local progress to Firestore (call on app resume / connectivity restore)
  Future<void> syncProgressToCloud(String userId) async {
    if (_progressBox == null) return;

    final allLocal = _progressBox!.toMap();
    for (final entry in allLocal.entries) {
      final bookId = entry.key as String;
      final data = entry.value as Map<String, dynamic>;

      try {
        // Check if remote is newer
        final remoteDoc = await _getUserProgressCollection(
          userId,
        ).doc(bookId).get();

        bool shouldUpdate = true;
        if (remoteDoc.exists && remoteDoc.data() != null) {
          final remoteTimestamp = remoteDoc.data()!['updatedAt'] as Timestamp?;
          final localTimestamp = DateTime.tryParse(data['updatedAt'] ?? '');

          if (remoteTimestamp != null && localTimestamp != null) {
            shouldUpdate = localTimestamp.isAfter(remoteTimestamp.toDate());
          }
        }

        if (shouldUpdate) {
          await _getUserProgressCollection(userId).doc(bookId).set({
            ...data,
            'updatedAt': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true));
        }
      } catch (e) {
        print("Error syncing progress for $bookId: $e");
      }
    }
  }

  /// Clear all local progress data
  Future<void> clearLocalProgress() async {
    await _progressBox?.clear();
  }

  /// Delete progress for a specific book
  Future<void> deleteBookProgress({
    required String userId,
    required String bookId,
  }) async {
    // Delete local
    await _progressBox?.delete(bookId);

    // Delete remote
    try {
      await _getUserProgressCollection(userId).doc(bookId).delete();
    } catch (e) {
      print("Error deleting progress: $e");
    }
  }
}
