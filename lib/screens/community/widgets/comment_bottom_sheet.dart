// comment_bottom_sheet.dart
// Purpose: Show comments for a post in bottom sheet

import 'comment_input.dart';
import 'comment_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentBottomSheet extends StatelessWidget {
  // 🔹 ID of the post whose comments we are showing
  final String postId;

  const CommentBottomSheet({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    // 🔹 Reference to comments collection of a post
    final commentsRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy(
          'createdAt',
          descending: true, // newest comment on top
        );

    return Padding(
      // 🔹 Push UI above keyboard
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            // 🔹 Small drag handle UI
            const SizedBox(height: 12),
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 Title
            const Text(
              "Comments",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            // 🔹 COMMENTS LIST (REAL-TIME)
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: commentsRef.snapshots(), // live updates
                builder: (context, snapshot) {
                  // 🔹 Show loader while data is loading
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final comments = snapshot.data!.docs;

                  // 🔹 If no comments yet
                  if (comments.isEmpty) {
                    return const Center(child: Text("No comments yet"));
                  }

                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final data =
                          comments[index].data() as Map<String, dynamic>;

                      return CommentTile(
                        postId: postId,
                        commentId: comments[index].id,
                        userId: data['userId'],
                        text: data['text'],
                      );
                    },
                  );
                },
              ),
            ),

            // 🔹 Input box to add new comment
            CommentInput(postId: postId),
          ],
        ),
      ),
    );
  }
}
