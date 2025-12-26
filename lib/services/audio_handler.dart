import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

// Ye function main.dart me call hoga
Future<AudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.myapp.audio',
      androidNotificationChannelName: 'Audiobook Player',
      androidNotificationOngoing: true,
      androidStopForegroundOnPause: true,
    ),
  );
}

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final _player = AudioPlayer(); // just_audio player

  MyAudioHandler() {
    // 1. Player state ko AudioService state me convert karke broadcast karo
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);

    // 2. Agar song complete ho jaye to kya karein (Next play logic yahan ayega)
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        skipToNext();
      }
    });
  }

  // --- Core Actions ---

  // Playlist load karke play start karna
  Future<void> loadPlaylist(List<MediaItem> items, int initialIndex) async {
    // Update queue
    final audioSource = ConcatenatingAudioSource(
      children: items
          .map((item) => AudioSource.uri(Uri.parse(item.id)))
          .toList(),
    );

    // Notify system about queue
    queue.add(items);

    // Set source and play
    await _player.setAudioSource(audioSource, initialIndex: initialIndex);
    play();
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  // --- Helper to Map States ---
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
