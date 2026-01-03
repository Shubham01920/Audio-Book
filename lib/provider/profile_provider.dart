// import 'package:flutter/material.dart';
// import '../services/follow_service.dart';

// /// =======================================
// /// PROFILE PROVIDER
// /// =======================================
// /// UI yahan se data read karegi
// /// Follow / Unfollow yahin se call hoga
// class ProfileProvider extends ChangeNotifier {
//   final FollowService _followService = FollowService();

//   // TEMP DATA (Firebase se baad me aayega)
//   int followersCount = 1200;
//   int followingCount = 847;
//   bool isFollowing = false;

//   /// =======================================
//   /// LOAD FOLLOW STATUS (ON PROFILE OPEN)
//   /// =======================================
//   Future<void> loadFollowStatus(
//     String currentUserId,
//     String targetUserId,
//   ) async {
//     isFollowing = await _followService.isFollowing(
//       currentUserId: currentUserId,
//       targetUserId: targetUserId,
//     );

//     notifyListeners();
//   }

//   /// =======================================
//   /// TOGGLE FOLLOW BUTTON
//   /// =======================================
//   Future<void> toggleFollow({
//     required String currentUserId,
//     required String targetUserId,
//   }) async {
//     if (isFollowing) {
//       // 🔴 UNFOLLOW CASE
//       await _followService.unfollowUser(
//         currentUserId: currentUserId,
//         targetUserId: targetUserId,
//       );

//       followersCount--;
//       isFollowing = false;
//     } else {
//       // 🟢 FOLLOW CASE
//       await _followService.followUser(
//         currentUserId: currentUserId,
//         targetUserId: targetUserId,
//       );

//       followersCount++;
//       isFollowing = true;
//     }

//     // UI ko update karne ke liye
//     notifyListeners();
//   }
// }
