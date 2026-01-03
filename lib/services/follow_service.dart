// // Firestore database use karne ke liye
// import 'package:cloud_firestore/cloud_firestore.dart';

// /// =======================================
// /// FOLLOW SERVICE
// /// =======================================
// /// Is file ka kaam:
// /// - Follow logic
// /// - Unfollow logic
// /// - Database relations handle karna
// ///
// /// UI ya widgets yahan kabhi nahi honge
// class FollowService {
//   // Firestore instance
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   /// =======================================
//   /// FOLLOW USER FUNCTION
//   /// =======================================
//   /// currentUserId → jo follow kar raha hai
//   /// targetUserId  → jisko follow kiya ja raha hai
//   Future<void> followUser({
//     required String currentUserId,
//     required String targetUserId,
//   }) async {
//     // 🔹 Current user ka main document
//     final currentUserRef =
//         _firestore.collection('users').doc(currentUserId);

//     // 🔹 Target user ka main document
//     final targetUserRef =
//         _firestore.collection('users').doc(targetUserId);

//     // 🔹 Following relation
//     // Example: following/A/list/B
//     final followingRef = _firestore
//         .collection('following')
//         .doc(currentUserId)
//         .collection('list')
//         .doc(targetUserId);

//     // 🔹 Followers relation
//     // Example: followers/B/list/A
//     final followersRef = _firestore
//         .collection('followers')
//         .doc(targetUserId)
//         .collection('list')
//         .doc(currentUserId);

//     /// =======================================
//     /// TRANSACTION (ATOMIC OPERATION)
//     /// =======================================
//     /// Matlab:
//     /// - Sab steps ek saath honge
//     /// - Agar ek fail hua → sab rollback
//     await _firestore.runTransaction((transaction) async {
//       // 1️⃣ Following relation create karo
//       transaction.set(followingRef, {
//         'followedAt': FieldValue.serverTimestamp(),
//       });

//       // 2️⃣ Followers relation create karo
//       transaction.set(followersRef, {
//         'followedAt': FieldValue.serverTimestamp(),
//       });

//       // 3️⃣ Current user ka following count +1
//       transaction.update(currentUserRef, {
//         'followingCount': FieldValue.increment(1),
//       });

//       // 4️⃣ Target user ka followers count +1
//       transaction.update(targetUserRef, {
//         'followersCount': FieldValue.increment(1),
//       });
//     });
//   }

//   /// =======================================
//   /// UNFOLLOW USER FUNCTION
//   /// =======================================
//   Future<void> unfollowUser({
//     required String currentUserId,
//     required String targetUserId,
//   }) async {
//     // 🔹 User references same as follow
//     final currentUserRef =
//         _firestore.collection('users').doc(currentUserId);
//     final targetUserRef =
//         _firestore.collection('users').doc(targetUserId);

//     final followingRef = _firestore
//         .collection('following')
//         .doc(currentUserId)
//         .collection('list')
//         .doc(targetUserId);

//     final followersRef = _firestore
//         .collection('followers')
//         .doc(targetUserId)
//         .collection('list')
//         .doc(currentUserId);

//     await _firestore.runTransaction((transaction) async {
//       // 1️⃣ Following relation delete karo
//       transaction.delete(followingRef);

//       // 2️⃣ Followers relation delete karo
//       transaction.delete(followersRef);

//       // 3️⃣ Current user ka following count -1
//       transaction.update(currentUserRef, {
//         'followingCount': FieldValue.increment(-1),
//       });

//       // 4️⃣ Target user ka followers count -1
//       transaction.update(targetUserRef, {
//         'followersCount': FieldValue.increment(-1),
//       });
//     });
//   }

//   /// =======================================
//   /// CHECK IS FOLLOWING
//   /// =======================================
//   /// Jab profile open hoti hai
//   /// tab button state decide karne ke liye
//   Future<bool> isFollowing({
//     required String currentUserId,
//     required String targetUserId,
//   }) async {
//     final doc = await _firestore
//         .collection('following')
//         .doc(currentUserId)
//         .collection('list')
//         .doc(targetUserId)
//         .get();

//     // Agar document exist karta hai
//     // matlab already following
//     return doc.exists;
//   }
// }
