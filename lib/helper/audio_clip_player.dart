import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

// 🔹 Simple audio clip player widget
class AudioClipPlayer extends StatefulWidget {
  // 🔹 Audio file URL
  final String audioUrl;

  const AudioClipPlayer({super.key, required this.audioUrl});

  @override
  State<AudioClipPlayer> createState() => _AudioClipPlayerState();
}

class _AudioClipPlayerState extends State<AudioClipPlayer> {
  // 🔹 Audio player instance
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // 🔹 Load audio file
    _player.setUrl(widget.audioUrl);
  }

  @override
  void dispose() {
    // 🔹 Release audio resources
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.play_arrow),

      // 🔹 Play audio on tap
      onPressed: () {
        _player.play();
      },
    );
  }
}
