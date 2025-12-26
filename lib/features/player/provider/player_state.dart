import 'package:equatable/equatable.dart';
import '../../../models/book_model.dart';
import '../../../models/episode_model.dart';

/// Player state for BLoC
enum PlayerStatus {
  initial,
  loading,
  ready,
  playing,
  paused,
  buffering,
  completed,
  error,
}

/// Audio player state
class PlayerState extends Equatable {
  final PlayerStatus status;
  final Book? currentBook;
  final Episode? currentEpisode;
  final List<Episode> playlist;
  final int currentIndex;
  final Duration position;
  final Duration bufferedPosition;
  final Duration? duration;
  final double speed;
  final double volume;
  final double volumeBoost;
  final bool isMuted;
  final LoopMode loopMode;
  final SleepTimerState sleepTimer;
  final String? errorMessage;
  final DateTime? lastPausedAt;

  const PlayerState({
    this.status = PlayerStatus.initial,
    this.currentBook,
    this.currentEpisode,
    this.playlist = const [],
    this.currentIndex = 0,
    this.position = Duration.zero,
    this.bufferedPosition = Duration.zero,
    this.duration,
    this.speed = 1.0,
    this.volume = 1.0,
    this.volumeBoost = 1.0,
    this.isMuted = false,
    this.loopMode = LoopMode.off,
    this.sleepTimer = const SleepTimerState(),
    this.errorMessage,
    this.lastPausedAt,
  });

  @override
  List<Object?> get props => [
    status,
    currentBook,
    currentEpisode,
    playlist,
    currentIndex,
    position,
    bufferedPosition,
    duration,
    speed,
    volume,
    volumeBoost,
    isMuted,
    loopMode,
    sleepTimer,
    errorMessage,
    lastPausedAt,
  ];

  /// Check if player is playing
  bool get isPlaying => status == PlayerStatus.playing;

  /// Check if player has content loaded
  bool get hasContent => currentBook != null && currentEpisode != null;

  /// Get progress as 0.0 - 1.0
  double get progress {
    if (duration == null || duration! == Duration.zero) return 0.0;
    return position.inMilliseconds / duration!.inMilliseconds;
  }

  /// Get remaining time
  Duration get remaining {
    if (duration == null) return Duration.zero;
    return duration! - position;
  }

  /// Check if can skip to next
  bool get canSkipNext => currentIndex < playlist.length - 1;

  /// Check if can skip to previous
  bool get canSkipPrevious => currentIndex > 0;

  /// Get effective volume (with boost applied)
  double get effectiveVolume => isMuted ? 0.0 : volume * volumeBoost;

  PlayerState copyWith({
    PlayerStatus? status,
    Book? currentBook,
    Episode? currentEpisode,
    List<Episode>? playlist,
    int? currentIndex,
    Duration? position,
    Duration? bufferedPosition,
    Duration? duration,
    double? speed,
    double? volume,
    double? volumeBoost,
    bool? isMuted,
    LoopMode? loopMode,
    SleepTimerState? sleepTimer,
    String? errorMessage,
    DateTime? lastPausedAt,
  }) {
    return PlayerState(
      status: status ?? this.status,
      currentBook: currentBook ?? this.currentBook,
      currentEpisode: currentEpisode ?? this.currentEpisode,
      playlist: playlist ?? this.playlist,
      currentIndex: currentIndex ?? this.currentIndex,
      position: position ?? this.position,
      bufferedPosition: bufferedPosition ?? this.bufferedPosition,
      duration: duration ?? this.duration,
      speed: speed ?? this.speed,
      volume: volume ?? this.volume,
      volumeBoost: volumeBoost ?? this.volumeBoost,
      isMuted: isMuted ?? this.isMuted,
      loopMode: loopMode ?? this.loopMode,
      sleepTimer: sleepTimer ?? this.sleepTimer,
      errorMessage: errorMessage ?? this.errorMessage,
      lastPausedAt: lastPausedAt ?? this.lastPausedAt,
    );
  }

  /// Initial state
  static const initial = PlayerState();
}

/// Loop mode for repeat functionality
enum LoopMode {
  off,
  one, // Repeat current episode
  all, // Repeat entire book/playlist
}

/// Sleep timer state
class SleepTimerState extends Equatable {
  final bool isActive;
  final Duration? duration;
  final Duration? remaining;
  final bool endOfChapter;
  final DateTime? startedAt;

  const SleepTimerState({
    this.isActive = false,
    this.duration,
    this.remaining,
    this.endOfChapter = false,
    this.startedAt,
  });

  @override
  List<Object?> get props => [
    isActive,
    duration,
    remaining,
    endOfChapter,
    startedAt,
  ];

  SleepTimerState copyWith({
    bool? isActive,
    Duration? duration,
    Duration? remaining,
    bool? endOfChapter,
    DateTime? startedAt,
  }) {
    return SleepTimerState(
      isActive: isActive ?? this.isActive,
      duration: duration ?? this.duration,
      remaining: remaining ?? this.remaining,
      endOfChapter: endOfChapter ?? this.endOfChapter,
      startedAt: startedAt ?? this.startedAt,
    );
  }

  /// Create timer for end of chapter
  factory SleepTimerState.endOfChapter() {
    return SleepTimerState(
      isActive: true,
      endOfChapter: true,
      startedAt: DateTime.now(),
    );
  }

  /// Create timer with duration
  factory SleepTimerState.withDuration(Duration duration) {
    return SleepTimerState(
      isActive: true,
      duration: duration,
      remaining: duration,
      startedAt: DateTime.now(),
    );
  }

  /// Get formatted remaining time
  String? get formattedRemaining {
    if (!isActive) return null;
    if (endOfChapter) return 'End of chapter';
    if (remaining == null) return null;

    final mins = remaining!.inMinutes;
    final secs = remaining!.inSeconds.remainder(60);
    return '${mins}m ${secs}s';
  }
}
