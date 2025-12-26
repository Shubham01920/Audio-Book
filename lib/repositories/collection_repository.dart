import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/collection_model.dart';

/// Repository for managing user collections (playlists/shelves)
class CollectionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get collections reference for a user
  CollectionReference<Map<String, dynamic>> _getUserCollections(String userId) {
    return _firestore.collection('users').doc(userId).collection('collections');
  }

  // ==================== READ OPERATIONS ====================

  /// Get all collections for a user
  Future<List<Collection>> getUserCollections(String userId) async {
    try {
      final snapshot = await _getUserCollections(
        userId,
      ).orderBy('createdAt', descending: true).get();

      return snapshot.docs
          .map((doc) => Collection.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching collections: $e");
      return [];
    }
  }

  /// Get collections as stream
  Stream<List<Collection>> getCollectionsStream(String userId) {
    return _getUserCollections(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Collection.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  /// Get a single collection
  Future<Collection?> getCollection(String userId, String collectionId) async {
    try {
      final doc = await _getUserCollections(userId).doc(collectionId).get();
      if (doc.exists && doc.data() != null) {
        return Collection.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      print("Error fetching collection: $e");
      return null;
    }
  }

  /// Get system collections (Favorites, DNF, etc.)
  Future<List<Collection>> getSystemCollections(String userId) async {
    try {
      final snapshot = await _getUserCollections(
        userId,
      ).where('isSystem', isEqualTo: true).get();

      return snapshot.docs
          .map((doc) => Collection.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching system collections: $e");
      return [];
    }
  }

  // ==================== WRITE OPERATIONS ====================

  /// Create a new collection
  Future<Collection?> createCollection(
    String userId, {
    required String name,
    String? description,
    bool isSystem = false,
  }) async {
    try {
      final collection = Collection(
        id: '', // Will be set by Firestore
        name: name,
        description: description,
        bookIds: [],
        createdAt: DateTime.now(),
        isSystem: isSystem,
      );

      final docRef = await _getUserCollections(userId).add(collection.toMap());

      return collection.copyWith(id: docRef.id);
    } catch (e) {
      print("Error creating collection: $e");
      return null;
    }
  }

  /// Update collection details
  Future<void> updateCollection(
    String userId,
    String collectionId, {
    String? name,
    String? description,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (name != null) updates['name'] = name;
      if (description != null) updates['description'] = description;

      if (updates.isNotEmpty) {
        await _getUserCollections(userId).doc(collectionId).update(updates);
      }
    } catch (e) {
      print("Error updating collection: $e");
    }
  }

  /// Delete a collection
  Future<void> deleteCollection(String userId, String collectionId) async {
    try {
      await _getUserCollections(userId).doc(collectionId).delete();
    } catch (e) {
      print("Error deleting collection: $e");
    }
  }

  // ==================== BOOK MANAGEMENT ====================

  /// Add a book to a collection
  Future<void> addBookToCollection(
    String userId,
    String collectionId,
    String bookId,
  ) async {
    try {
      await _getUserCollections(userId).doc(collectionId).update({
        'bookIds': FieldValue.arrayUnion([bookId]),
      });
    } catch (e) {
      print("Error adding book to collection: $e");
    }
  }

  /// Remove a book from a collection
  Future<void> removeBookFromCollection(
    String userId,
    String collectionId,
    String bookId,
  ) async {
    try {
      await _getUserCollections(userId).doc(collectionId).update({
        'bookIds': FieldValue.arrayRemove([bookId]),
      });
    } catch (e) {
      print("Error removing book from collection: $e");
    }
  }

  /// Check if a book is in any collection
  Future<List<String>> getCollectionsContainingBook(
    String userId,
    String bookId,
  ) async {
    try {
      final snapshot = await _getUserCollections(
        userId,
      ).where('bookIds', arrayContains: bookId).get();

      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print("Error checking book collections: $e");
      return [];
    }
  }

  // ==================== SYSTEM COLLECTIONS ====================

  /// Ensure system collections exist (Favorites, DNF, etc.)
  Future<void> ensureSystemCollections(String userId) async {
    final existing = await getSystemCollections(userId);
    final existingNames = existing.map((c) => c.name).toSet();

    final systemCollections = [
      ('Favorites', 'Your favorite audiobooks'),
      ('Currently Reading', 'Books you are listening to'),
      ('Finished', 'Completed audiobooks'),
      ('Want to Read', 'Books on your wishlist'),
      ('Did Not Finish', 'Books you stopped listening to'),
    ];

    for (final (name, description) in systemCollections) {
      if (!existingNames.contains(name)) {
        await createCollection(
          userId,
          name: name,
          description: description,
          isSystem: true,
        );
      }
    }
  }
}
