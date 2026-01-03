import 'package:audiobooks/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/community_provider.dart';
import '../model/profile_model.dart';
import 'audio_clip_player.dart';

// 🔹 Widget for single post
class PostCard extends StatelessWidget {
  // 🔹 Post data
  final PostModel post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    // 🔹 Access provider methods
    final provider = context.read<CommunityProvider>();

    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Show post text
            Text(post.text, style: const TextStyle(fontSize: 15)),

            const SizedBox(height: 8),

            // 🔹 Show audio clip if exists
            if (post.audioUrl != null)
              AudioClipPlayer(audioUrl: post.audioUrl!),

            const SizedBox(height: 8),

            // 🔹 Action buttons
            Row(
              children: [
                // ✏️ Edit post
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    provider.editPost(post.postId, "Edited text");
                  },
                ),

                // 🗑 Delete post
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    provider.deletePost(post.postId);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
