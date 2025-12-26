import 'package:equatable/equatable.dart';

/// User collection/shelf model
class Collection extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String? coverUrl;
  final List<String> bookIds;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isSystem;
  final CollectionType type;

  const Collection({
    required this.id,
    required this.name,
    this.description,
    this.coverUrl,
    this.bookIds = const [],
    required this.createdAt,
    this.updatedAt,
    this.isSystem = false,
    this.type = CollectionType.custom,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    coverUrl,
    bookIds,
    createdAt,
    updatedAt,
    isSystem,
    type,
  ];

  /// Create from Firestore document
  factory Collection.fromMap(Map<String, dynamic> data, String id) {
    return Collection(
      id: id,
      name: data['name'] ?? 'Untitled',
      description: data['description'],
      coverUrl: data['coverUrl'],
      bookIds: List<String>.from(data['bookIds'] ?? []),
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'])
          : DateTime.now(),
      updatedAt: data['updatedAt'] != null
          ? DateTime.parse(data['updatedAt'])
          : null,
      isSystem: data['isSystem'] ?? false,
      type: CollectionType.fromString(data['type']),
    );
  }

  /// Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'coverUrl': coverUrl,
      'bookIds': bookIds,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isSystem': isSystem,
      'type': type.name,
    };
  }

  /// Copy with modified values
  Collection copyWith({
    String? id,
    String? name,
    String? description,
    String? coverUrl,
    List<String>? bookIds,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSystem,
    CollectionType? type,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      bookIds: bookIds ?? this.bookIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isSystem: isSystem ?? this.isSystem,
      type: type ?? this.type,
    );
  }

  /// Get book count
  int get bookCount => bookIds.length;

  /// Check if collection contains a book
  bool containsBook(String bookId) => bookIds.contains(bookId);

  /// System collections
  static Collection favorites(String userId) => Collection(
    id: '${userId}_favorites',
    name: 'Favorites',
    isSystem: true,
    type: CollectionType.favorites,
    createdAt: DateTime.now(),
  );

  static Collection recentlyListened(String userId) => Collection(
    id: '${userId}_recent',
    name: 'Recently Listened',
    isSystem: true,
    type: CollectionType.recentlyListened,
    createdAt: DateTime.now(),
  );

  static Collection wantToListen(String userId) => Collection(
    id: '${userId}_wishlist',
    name: 'Want to Listen',
    isSystem: true,
    type: CollectionType.wishlist,
    createdAt: DateTime.now(),
  );
}

/// Collection type
enum CollectionType {
  custom,
  favorites,
  recentlyListened,
  wishlist,
  finished,
  dnf;

  static CollectionType fromString(String? value) {
    switch (value) {
      case 'favorites':
        return CollectionType.favorites;
      case 'recentlyListened':
        return CollectionType.recentlyListened;
      case 'wishlist':
        return CollectionType.wishlist;
      case 'finished':
        return CollectionType.finished;
      case 'dnf':
        return CollectionType.dnf;
      default:
        return CollectionType.custom;
    }
  }

  String get displayName {
    switch (this) {
      case CollectionType.custom:
        return 'Custom';
      case CollectionType.favorites:
        return 'Favorites';
      case CollectionType.recentlyListened:
        return 'Recently Listened';
      case CollectionType.wishlist:
        return 'Want to Listen';
      case CollectionType.finished:
        return 'Finished';
      case CollectionType.dnf:
        return 'Did Not Finish';
    }
  }
}
