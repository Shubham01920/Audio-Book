// Dart ka File class use karne ke liye
import 'dart:io';

// Flutter ka core material package
import 'package:flutter/material.dart';

// Image pick karne ke liye
import 'package:image_picker/image_picker.dart';

/// ===============================
/// PROFILE PROVIDER (LOGIC FILE)
/// ===============================
/// Is file me:
/// - Follow / Unfollow logic
/// - Followers count
/// - Profile image picker logic
/// Sab kuch yahin handle hoga
///
/// UI sirf data read karega
class ProfileProvider extends ChangeNotifier {
  // Image picker ka object
  final ImagePicker _picker = ImagePicker();

  /// -------------------------------
  /// PROFILE DATA (TEMP STATIC)
  /// -------------------------------
  /// Baad me ye data Firebase se aayega
  String userName = "Sarah Mitchell";

  int followersCount = 1200;
  int followingCount = 847;
  int booksCount = 156;

  // Ye batata hai current user follow kar raha hai ya nahi
  bool isFollowing = false;

  // Profile image file (gallery se pick hogi)
  File? profileImage;

  /// -------------------------------
  /// FOLLOW / UNFOLLOW FUNCTION
  /// -------------------------------
  /// Jab user Follow button dabaye
  void toggleFollow() {
    if (isFollowing) {
      // Agar already following hai → unfollow
      followersCount--;
      isFollowing = false;
    } else {
      // Agar follow nahi kar raha → follow
      followersCount++;
      isFollowing = true;
    }

    // UI ko notify karo ki data change ho gaya
    notifyListeners();
  }

  /// -------------------------------
  /// PICK PROFILE IMAGE FUNCTION
  /// -------------------------------
  /// Gallery se image pick karega
  Future<void> pickProfileImage() async {
    // Gallery open hoti hai
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70, // image thodi compress hoti hai
    );

    // Agar user ne image select ki
    if (image != null) {
      profileImage = File(image.path);

      // UI ko batao ki image update ho gayi
      notifyListeners();
    }
  }
}
