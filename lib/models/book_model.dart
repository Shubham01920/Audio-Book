import 'package:equatable/equatable.dart';

/// Enhanced Book model with full metadata support
class Book extends Equatable {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String? narrator;
  final String? synopsis;
  final String? genre;
  final String? language;
  final Duration? duration;
  final DateTime? releaseDate;
  final double? rating;
  final int? reviewCount;
  final bool isDownloaded;
  final double progress; // 0.0 - 1.0
  final BookStatus status;
  final List<String> tags;
  final String? seriesName;
  final int? seriesOrder;
  final Duration? lastPosition;
  final DateTime? lastListenedAt;
  final int episodeCount;
  final bool isFavorite;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    this.narrator,
    this.synopsis,
    this.genre,
    this.language,
    this.duration,
    this.releaseDate,
    this.rating,
    this.reviewCount,
    this.isDownloaded = false,
    this.progress = 0.0,
    this.status = BookStatus.notStarted,
    this.tags = const [],
    this.seriesName,
    this.seriesOrder,
    this.lastPosition,
    this.lastListenedAt,
    this.episodeCount = 0,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    author,
    coverUrl,
    narrator,
    synopsis,
    genre,
    language,
    duration,
    releaseDate,
    rating,
    reviewCount,
    isDownloaded,
    progress,
    status,
    tags,
    seriesName,
    seriesOrder,
    lastPosition,
    lastListenedAt,
    episodeCount,
    isFavorite,
  ];

  /// Create from Firestore document
  factory Book.fromMap(Map<String, dynamic> data, String id) {
    return Book(
      id: id,
      title: data['title'] ?? 'Unknown Title',
      author: data['author'] ?? 'Unknown Author',
      coverUrl: data['coverUrl'] ?? '',
      narrator: data['narrator'],
      synopsis: data['synopsis'],
      genre: data['genre'],
      language: data['language'],
      duration: data['durationSeconds'] != null
          ? Duration(seconds: data['durationSeconds'])
          : null,
      releaseDate: data['releaseDate'] != null
          ? DateTime.tryParse(data['releaseDate'])
          : null,
      rating: (data['rating'] as num?)?.toDouble(),
      reviewCount: data['reviewCount'],
      isDownloaded: data['isDownloaded'] ?? false,
      progress: (data['progress'] as num?)?.toDouble() ?? 0.0,
      status: BookStatus.fromString(data['status']),
      tags: List<String>.from(data['tags'] ?? []),
      seriesName: data['seriesName'],
      seriesOrder: data['seriesOrder'],
      episodeCount: data['episodeCount'] ?? 0,
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  /// Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'coverUrl': coverUrl,
      'narrator': narrator,
      'synopsis': synopsis,
      'genre': genre,
      'language': language,
      'durationSeconds': duration?.inSeconds,
      'releaseDate': releaseDate?.toIso8601String(),
      'rating': rating,
      'reviewCount': reviewCount,
      'isDownloaded': isDownloaded,
      'progress': progress,
      'status': status.name,
      'tags': tags,
      'seriesName': seriesName,
      'seriesOrder': seriesOrder,
      'episodeCount': episodeCount,
      'isFavorite': isFavorite,
    };
  }

  /// Copy with modified values
  Book copyWith({
    String? id,
    String? title,
    String? author,
    String? coverUrl,
    String? narrator,
    String? synopsis,
    String? genre,
    String? language,
    Duration? duration,
    DateTime? releaseDate,
    double? rating,
    int? reviewCount,
    bool? isDownloaded,
    double? progress,
    BookStatus? status,
    List<String>? tags,
    String? seriesName,
    int? seriesOrder,
    Duration? lastPosition,
    DateTime? lastListenedAt,
    int? episodeCount,
    bool? isFavorite,
  }) {
    return Book(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverUrl: coverUrl ?? this.coverUrl,
      narrator: narrator ?? this.narrator,
      synopsis: synopsis ?? this.synopsis,
      genre: genre ?? this.genre,
      language: language ?? this.language,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      progress: progress ?? this.progress,
      status: status ?? this.status,
      tags: tags ?? this.tags,
      seriesName: seriesName ?? this.seriesName,
      seriesOrder: seriesOrder ?? this.seriesOrder,
      lastPosition: lastPosition ?? this.lastPosition,
      lastListenedAt: lastListenedAt ?? this.lastListenedAt,
      episodeCount: episodeCount ?? this.episodeCount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  /// Get progress percentage as string
  String get progressPercentage => '${(progress * 100).toInt()}%';

  /// Check if book is started
  bool get isStarted => progress > 0;

  /// Check if book is completed
  bool get isCompleted => progress >= 0.99;
}

/// Book reading status
enum BookStatus {
  notStarted,
  inProgress,
  finished,
  dnf, // Did Not Finish
  onHold;

  static BookStatus fromString(String? value) {
    switch (value) {
      case 'inProgress':
        return BookStatus.inProgress;
      case 'finished':
        return BookStatus.finished;
      case 'dnf':
        return BookStatus.dnf;
      case 'onHold':
        return BookStatus.onHold;
      default:
        return BookStatus.notStarted;
    }
  }

  String get displayName {
    switch (this) {
      case BookStatus.notStarted:
        return 'Not Started';
      case BookStatus.inProgress:
        return 'In Progress';
      case BookStatus.finished:
        return 'Finished';
      case BookStatus.dnf:
        return 'Did Not Finish';
      case BookStatus.onHold:
        return 'On Hold';
    }
  }
}
