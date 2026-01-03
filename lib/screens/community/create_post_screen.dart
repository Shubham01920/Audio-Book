import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  // 🔹 Controller to read text entered by user
  final TextEditingController _controller = TextEditingController();

  // 🔹 Used to disable button while posting
  bool isPosting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Post")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= TEXT INPUT =================
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Share your thoughts...",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // ================= POST BUTTON =================
            ElevatedButton(
              onPressed: isPosting ? null : _createPost,
              child: isPosting
                  ? const CircularProgressIndicator()
                  : const Text("Post"),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Function that saves post to Firestore
  Future<void> _createPost() async {
    // 🔹 Prevent empty posts
    if (_controller.text.trim().isEmpty) return;

    setState(() => isPosting = true);

    // 🔹 Save post in Firestore
    await FirebaseFirestore.instance.collection('posts').add({
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'text': _controller.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    setState(() => isPosting = false);

    // 🔹 Go back to community feed
    Navigator.pop(context);
  }
}
