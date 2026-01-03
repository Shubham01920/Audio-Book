import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/profile_model.dart';

// 🔹 Provider that controls all community logic
class CommunityProvider extends ChangeNotifier {
  // 🔹 List that holds posts shown in UI
  List<PostModel> posts = [];

  // 🔹 Used for pagination (last fetched document)
  DocumentSnapshot? lastDoc;

  // 🔹 Whether more posts are available
  bool hasMore = true;

  // 🔹 Loading state (avoid multiple calls)
  bool isLoading = false;

  // 🔹 Firestore query (latest posts first)
  final Query _postQuery = FirebaseFirestore.instance
      .collection('posts')
      .orderBy('createdAt', descending: true)
      .limit(10);

  // ================= FETCH INITIAL POSTS =================

  Future<void> fetchInitialPosts() async {
    // 🔹 Set loading true
    isLoading = true;
    notifyListeners();

    // 🔹 Fetch first batch of posts
    final snapshot = await _postQuery.get();

    // 🔹 Convert documents to PostModel list
    posts = snapshot.docs.map((doc) => PostModel.fromDoc(doc)).toList();

    // 🔹 Save last document for pagination
    if (snapshot.docs.isNotEmpty) {
      lastDoc = snapshot.docs.last;
    }

    // 🔹 Stop loading
    isLoading = false;
    notifyListeners();
  }

  // ================= PAGINATION =================

  Future<void> fetchMorePosts() async {
    // 🔹 Stop if no more data or already loading
    if (!hasMore || isLoading || lastDoc == null) return;

    isLoading = true;
    notifyListeners();

    // 🔹 Fetch next batch after last document
    final snapshot = await _postQuery.startAfterDocument(lastDoc!).get();

    // 🔹 If no documents → end pagination
    if (snapshot.docs.isEmpty) {
      hasMore = false;
    } else {
      // 🔹 Update last document
      lastDoc = snapshot.docs.last;

      // 🔹 Add new posts to existing list
      posts.addAll(snapshot.docs.map((doc) => PostModel.fromDoc(doc)));
    }

    isLoading = false;
    notifyListeners();
  }

  // ================= DELETE POST =================

  Future<void> deletePost(String postId) async {
    // 🔹 Delete post from Firestore
    await FirebaseFirestore.instance.collection('posts').doc(postId).delete();

    // 🔹 Remove post locally
    posts.removeWhere((p) => p.postId == postId);

    notifyListeners();
  }

  // ================= EDIT POST =================

  Future<void> editPost(String postId, String newText) async {
    // 🔹 Update text in Firestore
    await FirebaseFirestore.instance.collection('posts').doc(postId).update({
      'text': newText,
    });

    // 🔹 Update text locally
    final index = posts.indexWhere((p) => p.postId == postId);

    posts[index] = PostModel(
      postId: posts[index].postId,
      userId: posts[index].userId,
      text: newText,
      audioUrl: posts[index].audioUrl,
      createdAt: posts[index].createdAt,
    );

    notifyListeners();
  }
}
