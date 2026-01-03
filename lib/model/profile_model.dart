import 'package:cloud_firestore/cloud_firestore.dart';

// 🔹 This model represents ONE post in community feed
class PostModel {
  // 🔹 Unique id of the post (Firestore document id)
  final String postId;

  // 🔹 User id who created the post
  final String userId;

  // 🔹 Text content of the post
  final String text;

  // 🔹 Optional audio clip URL (null for text post)
  final String? audioUrl;

  // 🔹 Time when post was created
  final Timestamp createdAt;

  // 🔹 Constructor
  PostModel({
    required this.postId,
    required this.userId,
    required this.text,
    this.audioUrl,
    required this.createdAt,
  });

  // 🔹 Factory method to convert Firestore document → PostModel
  factory PostModel.fromDoc(DocumentSnapshot doc) {
    // 🔹 Convert Firestore data to Map
    final data = doc.data() as Map<String, dynamic>;

    return PostModel(
      postId: doc.id, // document id
      userId: data['userId'], // post owner
      text: data['text'], // post text
      audioUrl: data['audioUrl'], // optional audio
      createdAt: data['createdAt'], // timestamp
    );
  }
}
