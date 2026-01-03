// comment_tile.dart
// Purpose: UI for single comment item

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentTile extends StatelessWidget {
  final String postId;
  final String commentId;
  final String userId;
  final String text;

  const CommentTile({
    super.key,
    required this.postId,
    required this.commentId,
    required this.userId,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    // 🔹 Logged-in user id
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return ListTile(
      leading: const CircleAvatar(
        radius: 16,
        child: Icon(Icons.person, size: 16),
      ),

      // 🔹 Comment text
      title: Text(text),

      // 🔹 Show delete icon ONLY for own comment
      trailing: currentUserId == userId
          ? IconButton(
              icon: const Icon(Icons.delete, size: 18, color: Colors.red),
              onPressed: () async {
                // 🔹 Delete only this comment
                await FirebaseFirestore.instance
                    .collection('posts')
                    .doc(postId)
                    .collection('comments')
                    .doc(commentId)
                    .delete();
              },
            )
          : null,
    );
  }
}
