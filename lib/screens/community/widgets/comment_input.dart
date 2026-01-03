// comment_input.dart
// Purpose: Input field to add a new comment

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentInput extends StatefulWidget {
  final String postId;

  const CommentInput({super.key, required this.postId});

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  // 🔹 Controller to read input text
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          // 🔹 Comment text field
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "Write a comment..."),
            ),
          ),

          // 🔹 Send comment button
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () async {
              // 🔹 Avoid empty comments
              if (controller.text.trim().isEmpty) return;

              await FirebaseFirestore.instance
                  .collection('posts')
                  .doc(widget.postId)
                  .collection('comments')
                  .add({
                    'userId': FirebaseAuth.instance.currentUser!.uid,
                    'text': controller.text.trim(),
                    'createdAt': FieldValue.serverTimestamp(),
                  });

              // 🔹 Clear input after sending
              controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
