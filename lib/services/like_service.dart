// import 'package:flutter/material.dart';

// class LikeButton extends StatelessWidget {
//   // 🔹 postId = ID of the post on which user is liking
//   final String postId;

//   // 🔹 currentUserId = logged-in user's UID
//   final String currentUserId;

//   const LikeButton({
//     super.key,
//     required this.postId,
//     required this.currentUserId,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // 🔹 Reference to:
//     // posts/{postId}/likes
//     // This collection will store who liked this post
//     final likesRef = FirebaseFirestore.instance
//         .collection('posts')
//         .doc(postId)
//         .collection('likes');

//     // 🔹 StreamBuilder listens to real-time changes in likes collection
//     return StreamBuilder<QuerySnapshot>(
//       stream: likesRef.snapshots(), // 👈 live updates
//       builder: (context, snapshot) {
//         // 🔹 If data not loaded yet, return empty widget
//         if (!snapshot.hasData) {
//           return const SizedBox();
//         }

//         // 🔹 All like documents for this post
//         final docs = snapshot.data!.docs;

//         // 🔹 Check if current user already liked this post
//         // If a document exists with ID == currentUserId → liked
//         final isLiked = docs.any((doc) => doc.id == currentUserId);

//         return Row(
//           children: [
//             // ❤️ LIKE BUTTON
//             IconButton(
//               icon: Icon(
//                 // 🔹 If liked → filled heart
//                 // 🔹 Else → outline heart
//                 isLiked ? Icons.favorite : Icons.favorite_border,

//                 // 🔹 Red color when liked
//                 color: isLiked ? Colors.red : Colors.grey,
//               ),

//               // 🔹 When user taps heart
//               onPressed: () async {
//                 // 🔹 Reference to:
//                 // posts/{postId}/likes/{userId}
//                 final likeDoc = likesRef.doc(currentUserId);

//                 if (isLiked) {
//                   // ❌ UNLIKE
//                   // If user already liked → delete document
//                   await likeDoc.delete();
//                 } else {
//                   // ✅ LIKE
//                   // If user has not liked → create document
//                   await likeDoc.set({'likedAt': FieldValue.serverTimestamp()});
//                 }
//               },
//             ),

//             // 🔢 LIKE COUNT
//             // Number of documents = number of likes
//             Text(
//               docs.length.toString(),
//               style: const TextStyle(fontWeight: FontWeight.w500),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
