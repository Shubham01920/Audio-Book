import 'package:equatable/equatable.dart';

/// Bookmark model with support for clips and notes
class Bookmark extends Equatable {
  final String id;
  final String bookId;
  final String episodeId;
  final String? episodeTitle;
  final Duration position;
  final Duration?
  clipDuration; // If null, it's a point bookmark, otherwise a clip
  final String? title;
  final String? note;
  final BookmarkColor color;
  final String? category;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Bookmark({
    required this.id,
    required this.bookId,
    required this.episodeId,
    this.episodeTitle,
    required this.position,
    this.clipDuration,
    this.title,
    this.note,
    this.color = BookmarkColor.yellow,
    this.category,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    bookId,
    episodeId,
    episodeTitle,
    position,
    clipDuration,
    title,
    note,
    color,
    category,
    createdAt,
    updatedAt,
  ];

  /// Check if this is a clip (has duration) vs point bookmark
  bool get isClip => clipDuration != null && clipDuration! > Duration.zero;

  /// Get end position for clips
  Duration get endPosition => position + (clipDuration ?? Duration.zero);

  /// Get display title
  String get displayTitle {
    if (title != null && title!.isNotEmpty) return title!;
    if (episodeTitle != null) return episodeTitle!;
    return 'Bookmark at ${_formatDuration(position)}';
  }

  /// Format duration to string
  static String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    if (hours > 0) {
      return '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  /// Get formatted position
  String get formattedPosition => _formatDuration(position);

  /// Get formatted clip duration
  String? get formattedClipDuration =>
      isClip ? _formatDuration(clipDuration!) : null;

  /// Create from Firestore document
  factory Bookmark.fromMap(Map<String, dynamic> data, String id) {
    return Bookmark(
      id: id,
      bookId: data['bookId'] ?? '',
      episodeId: data['episodeId'] ?? '',
      episodeTitle: data['episodeTitle'],
      position: Duration(milliseconds: data['positionMs'] ?? 0),
      clipDuration: data['clipDurationMs'] != null
          ? Duration(milliseconds: data['clipDurationMs'])
          : null,
      title: data['title'],
      note: data['note'],
      color: BookmarkColor.fromString(data['color']),
      category: data['category'],
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'])
          : DateTime.now(),
      updatedAt: data['updatedAt'] != null
          ? DateTime.parse(data['updatedAt'])
          : null,
    );
  }

  /// Convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'episodeId': episodeId,
      'episodeTitle': episodeTitle,
      'positionMs': position.inMilliseconds,
      'clipDurationMs': clipDuration?.inMilliseconds,
      'title': title,
      'note': note,
      'color': color.name,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Copy with modified values
  Bookmark copyWith({
    String? id,
    String? bookId,
    String? episodeId,
    String? episodeTitle,
    Duration? position,
    Duration? clipDuration,
    String? title,
    String? note,
    BookmarkColor? color,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Bookmark(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      episodeId: episodeId ?? this.episodeId,
      episodeTitle: episodeTitle ?? this.episodeTitle,
      position: position ?? this.position,
      clipDuration: clipDuration ?? this.clipDuration,
      title: title ?? this.title,
      note: note ?? this.note,
      color: color ?? this.color,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Export as text
  String toExportText() {
    final buffer = StringBuffer();
    buffer.writeln('📌 $displayTitle');
    buffer.writeln('   Position: $formattedPosition');
    if (isClip) buffer.writeln('   Duration: $formattedClipDuration');
    if (episodeTitle != null) buffer.writeln('   Chapter: $episodeTitle');
    if (note != null && note!.isNotEmpty) buffer.writeln('   Note: $note');
    buffer.writeln();
    return buffer.toString();
  }
}

/// Bookmark highlight color
enum BookmarkColor {
  yellow,
  blue,
  green,
  pink,
  orange;

  static BookmarkColor fromString(String? value) {
    switch (value) {
      case 'blue':
        return BookmarkColor.blue;
      case 'green':
        return BookmarkColor.green;
      case 'pink':
        return BookmarkColor.pink;
      case 'orange':
        return BookmarkColor.orange;
      default:
        return BookmarkColor.yellow;
    }
  }

  int get colorValue {
    switch (this) {
      case BookmarkColor.yellow:
        return 0xFFFDE047;
      case BookmarkColor.blue:
        return 0xFF60A5FA;
      case BookmarkColor.green:
        return 0xFF4ADE80;
      case BookmarkColor.pink:
        return 0xFFF472B6;
      case BookmarkColor.orange:
        return 0xFFFB923C;
    }
  }
}
