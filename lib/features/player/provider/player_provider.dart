import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:rxdart/rxdart.dart';
import '../../../core/constants/app_constants.dart';
import '../../../models/book_model.dart';
import '../../../models/episode_model.dart';
import 'player_state.dart';

/// Audio player provider using ChangeNotifier
class PlayerProvider extends ChangeNotifier {
  final just_audio.AudioPlayer _audioPlayer;

  StreamSubscription<void>? _positionSubscription;
  StreamSubscription<just_audio.PlayerState>? _playerStateSubscription;
  StreamSubscription<int?>? _currentIndexSubscription;
  Timer? _sleepTimer;
  Timer? _positionSaveTimer;

  // Current state
  PlayerState _state = PlayerState.initial;
  PlayerState get state => _state;

  // Convenience getters
  PlayerStatus get status => _state.status;
  Book? get currentBook => _state.currentBook;
  Episode? get currentEpisode => _state.currentEpisode;
  List<Episode> get playlist => _state.playlist;
  int get currentIndex => _state.currentIndex;
  Duration get position => _state.position;
  Duration get bufferedPosition => _state.bufferedPosition;
  Duration? get duration => _state.duration;
  double get speed => _state.speed;
  double get volume => _state.volume;
  double get volumeBoost => _state.volumeBoost;
  bool get isMuted => _state.isMuted;
  LoopMode get loopMode => _state.loopMode;
  SleepTimerState get sleepTimer => _state.sleepTimer;
  String? get errorMessage => _state.errorMessage;
  bool get isPlaying => _state.isPlaying;
  bool get hasContent => _state.hasContent;
  double get progress => _state.progress;
  Duration get remaining => _state.remaining;
  bool get canSkipNext => _state.canSkipNext;
  bool get canSkipPrevious => _state.canSkipPrevious;

  PlayerProvider({just_audio.AudioPlayer? audioPlayer})
    : _audioPlayer = audioPlayer ?? just_audio.AudioPlayer() {
    _setupPlayerListeners();
  }

  void _updateState(PlayerState newState) {
    _state = newState;
    notifyListeners();
  }

  void _setupPlayerListeners() {
    // Combined position stream for efficiency
    _positionSubscription =
        Rx.combineLatest3<Duration, Duration, Duration?, void>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (position, buffered, duration) {
            _updateState(
              _state.copyWith(
                position: position,
                bufferedPosition: buffered,
                duration: duration ?? _state.duration,
              ),
            );
          },
        ).listen((_) {});

    // Player state changes
    _playerStateSubscription = _audioPlayer.playerStateStream.listen((
      playerState,
    ) {
      if (playerState.processingState == just_audio.ProcessingState.completed) {
        _onEpisodeCompleted();
      }

      final status = _mapProcessingState(playerState);
      _updateState(_state.copyWith(status: status));
    });

    // Current index changes (for playlist)
    _currentIndexSubscription = _audioPlayer.currentIndexStream.listen((index) {
      if (index != null && index != _state.currentIndex) {
        if (index < _state.playlist.length) {
          _updateState(
            _state.copyWith(
              currentIndex: index,
              currentEpisode: _state.playlist[index],
            ),
          );
        }
      }
    });

    // Auto-save position every 30 seconds
    _positionSaveTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => savePosition(),
    );
  }

  PlayerStatus _mapProcessingState(just_audio.PlayerState playerState) {
    if (playerState.playing) return PlayerStatus.playing;

    switch (playerState.processingState) {
      case just_audio.ProcessingState.idle:
        return PlayerStatus.initial;
      case just_audio.ProcessingState.loading:
        return PlayerStatus.loading;
      case just_audio.ProcessingState.buffering:
        return PlayerStatus.buffering;
      case just_audio.ProcessingState.ready:
        return PlayerStatus.paused;
      case just_audio.ProcessingState.completed:
        return PlayerStatus.completed;
    }
  }

  // ==================== Public Methods ====================

  /// Load and play a book starting from specific episode
  Future<void> loadBook({
    required Book book,
    required List<Episode> episodes,
    int startIndex = 0,
    Duration? startPosition,
  }) async {
    _updateState(_state.copyWith(status: PlayerStatus.loading));

    try {
      // Create playlist from episodes
      final audioSources = episodes.map((episode) {
        return just_audio.AudioSource.uri(
          Uri.parse(episode.playableUrl),
          tag: episode,
        );
      }).toList();

      final playlist = just_audio.ConcatenatingAudioSource(
        children: audioSources,
      );

      await _audioPlayer.setAudioSource(
        playlist,
        initialIndex: startIndex,
        initialPosition: startPosition,
      );

      _updateState(
        _state.copyWith(
          status: PlayerStatus.ready,
          currentBook: book,
          currentEpisode: episodes[startIndex],
          playlist: episodes,
          currentIndex: startIndex,
          position: startPosition ?? Duration.zero,
        ),
      );

      // Auto-play after loading
      await _audioPlayer.play();
    } catch (e) {
      _updateState(
        _state.copyWith(
          status: PlayerStatus.error,
          errorMessage: 'Failed to load audio: ${e.toString()}',
        ),
      );
    }
  }

  /// Play current audio with smart resume
  Future<void> play() async {
    // Smart Resume: Check if we need to rewind after a long pause
    if (_state.lastPausedAt != null) {
      final pauseDuration = DateTime.now().difference(_state.lastPausedAt!);

      if (pauseDuration.inSeconds > AppConstants.longPauseThresholdSeconds) {
        // Long pause: rewind more
        final rewindDuration = Duration(
          seconds: AppConstants.longRewindSeconds,
        );
        final newPosition = _state.position - rewindDuration;
        await _audioPlayer.seek(
          newPosition.isNegative ? Duration.zero : newPosition,
        );
      } else if (pauseDuration.inSeconds >
          AppConstants.shortPauseThresholdSeconds) {
        // Short pause: small rewind
        final rewindDuration = Duration(
          seconds: AppConstants.shortRewindSeconds,
        );
        final newPosition = _state.position - rewindDuration;
        await _audioPlayer.seek(
          newPosition.isNegative ? Duration.zero : newPosition,
        );
      }
    }

    await _audioPlayer.play();
    _updateState(_state.copyWith(lastPausedAt: null));
  }

  /// Pause current audio
  Future<void> pause() async {
    await _audioPlayer.pause();
    _updateState(_state.copyWith(lastPausedAt: DateTime.now()));
  }

  /// Toggle play/pause
  Future<void> togglePlayPause() async {
    if (_state.isPlaying) {
      await pause();
    } else {
      await play();
    }
  }

  /// Seek to position
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  /// Seek forward by duration
  Future<void> seekForward(Duration duration) async {
    final newPosition = _state.position + duration;
    final maxPosition = _state.duration ?? Duration.zero;
    await _audioPlayer.seek(
      newPosition > maxPosition ? maxPosition : newPosition,
    );
  }

  /// Seek backward by duration
  Future<void> seekBackward(Duration duration) async {
    final newPosition = _state.position - duration;
    await _audioPlayer.seek(
      newPosition.isNegative ? Duration.zero : newPosition,
    );
  }

  /// Skip to next episode
  Future<void> skipNext() async {
    if (_state.canSkipNext) {
      await _audioPlayer.seekToNext();
    }
  }

  /// Skip to previous episode
  Future<void> skipPrevious() async {
    // If position is past 3 seconds, restart current episode instead
    if (_state.position.inSeconds > 3) {
      await _audioPlayer.seek(Duration.zero);
    } else if (_state.canSkipPrevious) {
      await _audioPlayer.seekToPrevious();
    }
  }

  /// Skip to specific episode in playlist
  Future<void> skipToIndex(int index) async {
    if (index >= 0 && index < _state.playlist.length) {
      await _audioPlayer.seek(Duration.zero, index: index);
    }
  }

  /// Set playback speed
  Future<void> setSpeed(double speed) async {
    final clampedSpeed = speed.clamp(
      AppConstants.minPlaybackSpeed,
      AppConstants.maxPlaybackSpeed,
    );
    await _audioPlayer.setSpeed(clampedSpeed);
    _updateState(_state.copyWith(speed: clampedSpeed));
  }

  /// Increase speed
  Future<void> increaseSpeed() async {
    final newSpeed = (_state.speed + AppConstants.speedIncrement).clamp(
      AppConstants.minPlaybackSpeed,
      AppConstants.maxPlaybackSpeed,
    );
    await setSpeed(newSpeed);
  }

  /// Decrease speed
  Future<void> decreaseSpeed() async {
    final newSpeed = (_state.speed - AppConstants.speedIncrement).clamp(
      AppConstants.minPlaybackSpeed,
      AppConstants.maxPlaybackSpeed,
    );
    await setSpeed(newSpeed);
  }

  /// Set volume
  Future<void> setVolume(double volume) async {
    final clampedVolume = volume.clamp(0.0, 1.0);
    await _audioPlayer.setVolume(clampedVolume * _state.volumeBoost);
    _updateState(_state.copyWith(volume: clampedVolume, isMuted: false));
  }

  /// Set volume boost
  Future<void> setVolumeBoost(double boost) async {
    final clampedBoost = boost.clamp(
      AppConstants.minVolumeBoost,
      AppConstants.maxVolumeBoost,
    );
    await _audioPlayer.setVolume(_state.volume * clampedBoost);
    _updateState(_state.copyWith(volumeBoost: clampedBoost));
  }

  /// Toggle mute
  Future<void> toggleMute() async {
    final newMuted = !_state.isMuted;
    await _audioPlayer.setVolume(
      newMuted ? 0.0 : _state.volume * _state.volumeBoost,
    );
    _updateState(_state.copyWith(isMuted: newMuted));
  }

  /// Set loop mode
  void setLoopMode(LoopMode mode) {
    switch (mode) {
      case LoopMode.off:
        _audioPlayer.setLoopMode(just_audio.LoopMode.off);
        break;
      case LoopMode.one:
        _audioPlayer.setLoopMode(just_audio.LoopMode.one);
        break;
      case LoopMode.all:
        _audioPlayer.setLoopMode(just_audio.LoopMode.all);
        break;
    }
    _updateState(_state.copyWith(loopMode: mode));
  }

  /// Cycle through loop modes
  void cycleLoopMode() {
    final modes = LoopMode.values;
    final nextIndex = (modes.indexOf(_state.loopMode) + 1) % modes.length;
    setLoopMode(modes[nextIndex]);
  }

  /// Start sleep timer with duration
  void startSleepTimer(Duration duration) {
    _sleepTimer?.cancel();

    final timerState = SleepTimerState.withDuration(duration);
    _updateState(_state.copyWith(sleepTimer: timerState));

    // Update timer every second
    _sleepTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = duration - Duration(seconds: timer.tick);
      if (remaining <= Duration.zero) {
        timer.cancel();
        pause();
        cancelSleepTimer();
      } else {
        _updateState(
          _state.copyWith(
            sleepTimer: _state.sleepTimer.copyWith(remaining: remaining),
          ),
        );
      }
    });
  }

  /// Start sleep timer for end of chapter
  void startEndOfChapterTimer() {
    _sleepTimer?.cancel();
    _updateState(_state.copyWith(sleepTimer: SleepTimerState.endOfChapter()));
  }

  /// Cancel sleep timer
  void cancelSleepTimer() {
    _sleepTimer?.cancel();
    _updateState(_state.copyWith(sleepTimer: const SleepTimerState()));
  }

  /// Extend sleep timer
  void extendSleepTimer(Duration extension) {
    if (_state.sleepTimer.isActive && _state.sleepTimer.remaining != null) {
      final newDuration = _state.sleepTimer.remaining! + extension;
      startSleepTimer(newDuration);
    }
  }

  void _onEpisodeCompleted() async {
    // Handle end of chapter sleep timer
    if (_state.sleepTimer.endOfChapter) {
      cancelSleepTimer();
      // Don't auto-advance to next
      return;
    }

    // Handle loop modes
    switch (_state.loopMode) {
      case LoopMode.one:
        await _audioPlayer.seek(Duration.zero);
        await _audioPlayer.play();
        break;
      case LoopMode.all:
        if (!_state.canSkipNext) {
          await _audioPlayer.seek(Duration.zero, index: 0);
          await _audioPlayer.play();
        }
        break;
      case LoopMode.off:
        if (!_state.canSkipNext) {
          _updateState(_state.copyWith(status: PlayerStatus.completed));
        }
        break;
    }
  }

  /// Stop playback and clear state
  Future<void> stop() async {
    await _audioPlayer.stop();
    _updateState(PlayerState.initial);
  }

  /// Save current position to storage
  void savePosition() {
    // TODO: Implement position persistence to local storage/cloud
    // This would save state.currentBook.id, state.currentEpisode.id, state.position
  }

  /// Get the underlying audio player for advanced use cases
  just_audio.AudioPlayer get audioPlayer => _audioPlayer;

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _currentIndexSubscription?.cancel();
    _sleepTimer?.cancel();
    _positionSaveTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
}
