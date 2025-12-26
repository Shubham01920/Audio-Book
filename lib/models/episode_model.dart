import 'package:equatable/equatable.dart';

/// Enhanced Episode model with full metadata
class Episode extends Equatable {
  final String id;
  final String bookId;
  final String title;
  final String audioUrl;
  final int index;
  final bool isFree;
  final Duration duration;
  final String? synopsis;
  final bool isDownloaded;
  final String? localPath;
  final Duration? lastPosition;

  const Episode({
    required this.id,
    required this.bookId,
    required this.title,
    required this.audioUrl,
    required this.index,
    required this.duration,
    this.isFree = false,
    this.synopsis,
    this.isDownloaded = false,
    this.localPath,
    this.lastPosition,
  });

  @override
  List<Object?> get props => [
    id,
    bookId,
    title,
    audioUrl,
    index,
    isFree,
    duration,
    synopsis,
    isDownloaded,
    localPath,
    lastPosition,
  ];

  /// Create from Firestore document
  factory Episode.fromMap(
    Map<String, dynamic> data,
    String documentId, {
    String? bookId,
  }) {
    // Parse duration from string "MM:SS" or "HH:MM:SS" or seconds
    Duration parseDuration(dynamic value) {
      if (value == null) return Duration.zero;
      if (value is int) return Duration(seconds: value);
      if (value is String) {
        final parts = value.split(':').map(int.tryParse).toList();
        if (parts.length == 3 && parts.every((p) => p != null)) {
          return Duration(
            hours: parts[0]!,
            minutes: parts[1]!,
            seconds: parts[2]!,
          );
        } else if (parts.length == 2 && parts.every((p) => p != null)) {
          return Duration(minutes: parts[0]!, seconds: parts[1]!);
        }
      }
      return Duration.zero;
    }

    return Episode(
      id: documentId,
      bookId: bookId ?? data['bookId'] ?? '',
      title: data['title'] ?? 'Chapter ${data['index'] ?? 1}',
      audioUrl: data['audioUrl'] ?? '',
      index: data['index'] ?? 0,
      isFree: data['isFree'] ?? false,
      duration: parseDuration(data['duration'] ?? data['durationSeconds']),
      synopsis: data['synopsis'],
      isDownloaded: data['isDownloaded'] ?? false,
      localPath: data['localPath'],
    );
  }

  /// Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'title': title,
      'audioUrl': audioUrl,
      'index': index,
      'isFree': isFree,
      'durationSeconds': duration.inSeconds,
      'synopsis': synopsis,
      'isDownloaded': isDownloaded,
      'localPath': localPath,
    };
  }

  /// Copy with modified values
  Episode copyWith({
    String? id,
    String? bookId,
    String? title,
    String? audioUrl,
    int? index,
    bool? isFree,
    Duration? duration,
    String? synopsis,
    bool? isDownloaded,
    String? localPath,
    Duration? lastPosition,
  }) {
    return Episode(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      title: title ?? this.title,
      audioUrl: audioUrl ?? this.audioUrl,
      index: index ?? this.index,
      isFree: isFree ?? this.isFree,
      duration: duration ?? this.duration,
      synopsis: synopsis ?? this.synopsis,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      localPath: localPath ?? this.localPath,
      lastPosition: lastPosition ?? this.lastPosition,
    );
  }

  /// Get formatted duration string
  String get formattedDuration {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  /// Get display title with chapter number
  String get displayTitle => 'Chapter ${index + 1}: $title';

  /// Check if episode can be played (free or downloaded/purchased)
  bool get isPlayable => isFree || isDownloaded;

  /// Get audio source URL (prefer local if available)
  String get playableUrl =>
      isDownloaded && localPath != null ? localPath! : audioUrl;
}
