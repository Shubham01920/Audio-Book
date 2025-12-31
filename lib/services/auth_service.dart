import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

/// Authentication state
enum AuthState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  needsVerification,
  needs2FA,
  error,
}

/// User model for app
class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool emailVerified;
  final bool is2FAEnabled;
  final String? phoneNumber;
  final DateTime? createdAt;
  final String? authProvider; // email, google, apple
  final bool isAdmin; // Admin role - set manually in Firestore

  // Premium & Coins System
  final bool isPremium; // Subscription status
  final int coins; // User's coin balance
  final List<String> unlockedEpisodes; // Episode IDs unlocked with coins
  final DateTime? premiumExpiry; // Subscription end date

  const AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.emailVerified = false,
    this.is2FAEnabled = false,
    this.phoneNumber,
    this.createdAt,
    this.authProvider,
    this.isAdmin = false,
    this.isPremium = false,
    this.coins = 0,
    this.unlockedEpisodes = const [],
    this.premiumExpiry,
  });

  factory AppUser.fromFirebaseUser(
    User user, {
    Map<String, dynamic>? userData,
  }) {
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName ?? userData?['displayName'],
      photoUrl: user.photoURL ?? userData?['photoUrl'],
      emailVerified: user.emailVerified,
      is2FAEnabled: userData?['is2FAEnabled'] ?? false,
      phoneNumber: user.phoneNumber ?? userData?['phoneNumber'],
      createdAt: userData?['createdAt'] != null
          ? DateTime.parse(userData!['createdAt'])
          : null,
      authProvider: userData?['authProvider'] ?? _getProvider(user),
      isAdmin: userData?['isAdmin'] ?? false,
      // Premium & Coins
      isPremium: userData?['isPremium'] ?? false,
      coins: userData?['coins'] ?? 0,
      unlockedEpisodes: List<String>.from(userData?['unlockedEpisodes'] ?? []),
      premiumExpiry: userData?['premiumExpiry'] != null
          ? DateTime.parse(userData!['premiumExpiry'])
          : null,
    );
  }

  static String _getProvider(User user) {
    if (user.providerData.isNotEmpty) {
      final providerId = user.providerData.first.providerId;
      if (providerId.contains('google')) return 'google';
      if (providerId.contains('apple')) return 'apple';
      return 'email';
    }
    return 'email';
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'emailVerified': emailVerified,
      'is2FAEnabled': is2FAEnabled,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt?.toIso8601String(),
      'authProvider': authProvider,
      'isAdmin': isAdmin,
      'isPremium': isPremium,
      'coins': coins,
      'unlockedEpisodes': unlockedEpisodes,
      'premiumExpiry': premiumExpiry?.toIso8601String(),
    };
  }

  /// Check if user can access a locked episode
  bool canAccessEpisode(String episodeId) {
    return isPremium || unlockedEpisodes.contains(episodeId);
  }

  /// Check if premium subscription is active
  bool get hasPremiumAccess {
    if (!isPremium) return false;
    if (premiumExpiry == null) return true;
    return premiumExpiry!.isAfter(DateTime.now());
  }
}

/// Complete Auth Service with Email, Google, Apple, and 2FA
class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // iOS Client ID from GoogleService-Info.plist
  static const String _iosClientId =
      '486578984214-gmmmnrb9g5n57r9qjkskp52q94pjuhvu.apps.googleusercontent.com';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: _iosClientId,
    scopes: ['email', 'profile'],
  );

  static const String _boxName = 'auth_cache';
  Box? _authBox;

  AuthState _state = AuthState.initial;
  AppUser? _currentUser;
  String? _errorMessage;
  String? _verificationId; // For phone 2FA

  // Getters
  AuthState get state => _state;
  AppUser? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _state == AuthState.authenticated;
  bool get isLoading => _state == AuthState.loading;

  /// Initialize auth service
  Future<void> init() async {
    _authBox = await Hive.openBox(_boxName);

    // Listen to auth state changes
    _auth.authStateChanges().listen(_onAuthStateChanged);

    // Check current user
    final user = _auth.currentUser;
    if (user != null) {
      await _loadUserData(user);
    } else {
      _state = AuthState.unauthenticated;
      notifyListeners();
    }
  }

  void _onAuthStateChanged(User? user) async {
    if (user != null) {
      await _loadUserData(user);
    } else {
      _state = AuthState.unauthenticated;
      _currentUser = null;
      notifyListeners();
    }
  }

  Future<void> _loadUserData(User user) async {
    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      final userData = doc.data();

      _currentUser = AppUser.fromFirebaseUser(user, userData: userData);

      // Check if 2FA is required
      if (_currentUser!.is2FAEnabled) {
        final verified = _authBox?.get('2fa_verified_${user.uid}') ?? false;
        if (!verified) {
          _state = AuthState.needs2FA;
          notifyListeners();
          return;
        }
      }

      // Check email verification for email sign-in
      if (_currentUser!.authProvider == 'email' && !user.emailVerified) {
        _state = AuthState.needsVerification;
      } else {
        _state = AuthState.authenticated;
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error loading user data: $e");
      _state = AuthState.authenticated;
      _currentUser = AppUser.fromFirebaseUser(user);
      notifyListeners();
    }
  }

  // ==================== EMAIL AUTHENTICATION ====================

  /// Sign up with email and password
  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      _state = AuthState.loading;
      _errorMessage = null;
      notifyListeners();

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // Update display name
        if (displayName != null) {
          await credential.user!.updateDisplayName(displayName);
        }

        // Send verification email
        await credential.user!.sendEmailVerification();

        // Save user to Firestore
        await _saveUserToFirestore(credential.user!, authProvider: 'email');

        _state = AuthState.needsVerification;
        notifyListeners();
        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    }
  }

  /// Sign in with email and password
  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      _state = AuthState.loading;
      _errorMessage = null;
      notifyListeners();

      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await _loadUserData(credential.user!);
        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    }
  }

  /// Resend email verification
  Future<bool> resendVerificationEmail() async {
    try {
      final user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return true;
      }
      return false;
    } catch (e) {
      _errorMessage = 'Failed to send verification email';
      notifyListeners();
      return false;
    }
  }

  /// Check if email is verified
  Future<bool> checkEmailVerification() async {
    try {
      await _auth.currentUser?.reload();
      final user = _auth.currentUser;

      if (user != null && user.emailVerified) {
        await _loadUserData(user);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      _errorMessage = 'Failed to send reset email';
      notifyListeners();
      return false;
    }
  }

  // ==================== GOOGLE SIGN-IN ====================

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    try {
      _state = AuthState.loading;
      _errorMessage = null;
      notifyListeners();

      debugPrint("🔵 Starting Google Sign-in...");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        debugPrint("🔴 Google Sign-in cancelled by user");
        _state = AuthState.unauthenticated;
        notifyListeners();
        return false;
      }

      debugPrint("🟢 Google user: ${googleUser.email}");
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      debugPrint("🟢 Got Google auth tokens");
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        debugPrint("🟢 Firebase auth success: ${userCredential.user!.email}");
        await _saveUserToFirestore(
          userCredential.user!,
          authProvider: 'google',
        );
        await _loadUserData(userCredential.user!);
        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      debugPrint("🔴 Firebase Auth Error: ${e.code} - ${e.message}");
      _handleAuthError(e);
      return false;
    } catch (e, stackTrace) {
      debugPrint("🔴 Google sign-in error: $e");
      debugPrint("🔴 Stack: $stackTrace");
      _errorMessage = 'Google sign-in failed: $e';
      _state = AuthState.error;
      notifyListeners();
      return false;
    }
  }

  // ==================== APPLE SIGN-IN ====================

  /// Sign in with Apple
  Future<bool> signInWithApple() async {
    try {
      _state = AuthState.loading;
      _errorMessage = null;
      notifyListeners();

      debugPrint("🍎 Starting Apple Sign-in...");

      // Generate nonce for security
      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      debugPrint("🍎 Got Apple credential");

      final oauthCredential = OAuthProvider(
        "apple.com",
      ).credential(idToken: appleCredential.identityToken, rawNonce: rawNonce);

      final userCredential = await _auth.signInWithCredential(oauthCredential);

      if (userCredential.user != null) {
        debugPrint("🍎 Firebase auth success: ${userCredential.user!.email}");
        // Apple only provides name on first sign-in
        String? displayName;
        if (appleCredential.givenName != null) {
          displayName =
              '${appleCredential.givenName} ${appleCredential.familyName ?? ''}'
                  .trim();
          await userCredential.user!.updateDisplayName(displayName);
        }

        await _saveUserToFirestore(
          userCredential.user!,
          authProvider: 'apple',
          displayName: displayName,
        );
        await _loadUserData(userCredential.user!);
        return true;
      }

      return false;
    } on SignInWithAppleAuthorizationException catch (e) {
      debugPrint("🍎 Apple Auth Error: ${e.code} - ${e.message}");
      if (e.code == AuthorizationErrorCode.canceled) {
        _state = AuthState.unauthenticated;
      } else {
        _errorMessage = 'Apple sign-in failed: ${e.message}';
        _state = AuthState.error;
      }
      notifyListeners();
      return false;
    } catch (e, stackTrace) {
      debugPrint("🍎 Apple sign-in error: $e");
      debugPrint("🍎 Stack: $stackTrace");
      _errorMessage = 'Apple sign-in failed: $e';
      _state = AuthState.error;
      notifyListeners();
      return false;
    }
  }

  // ==================== 2-FACTOR AUTHENTICATION ====================

  /// Enable 2FA with phone number
  Future<bool> enable2FA(String phoneNumber) async {
    try {
      _state = AuthState.loading;
      notifyListeners();

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification (Android)
          await _complete2FASetup(credential, phoneNumber);
        },
        verificationFailed: (FirebaseAuthException e) {
          _errorMessage = e.message ?? 'Verification failed';
          _state = AuthState.error;
          notifyListeners();
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _state = AuthState.needs2FA;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );

      return true;
    } catch (e) {
      _errorMessage = 'Failed to enable 2FA';
      _state = AuthState.error;
      notifyListeners();
      return false;
    }
  }

  /// Verify 2FA code
  Future<bool> verify2FACode(String code) async {
    try {
      if (_verificationId == null) {
        _errorMessage = 'Verification session expired';
        notifyListeners();
        return false;
      }

      _state = AuthState.loading;
      notifyListeners();

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );

      // Link phone credential to current user (for enabling 2FA)
      final user = _auth.currentUser;
      if (user != null) {
        await user.linkWithCredential(credential);
        await _enable2FAInFirestore(user.uid, user.phoneNumber ?? '');
        await _authBox?.put('2fa_verified_${user.uid}', true);
        await _loadUserData(user);
        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    }
  }

  /// Verify 2FA on login
  Future<bool> verify2FAOnLogin(String code) async {
    try {
      if (_verificationId == null) {
        _errorMessage = 'Verification session expired';
        notifyListeners();
        return false;
      }

      _state = AuthState.loading;
      notifyListeners();

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );

      // Verify the code
      await _auth.signInWithCredential(credential);

      final user = _auth.currentUser;
      if (user != null) {
        await _authBox?.put('2fa_verified_${user.uid}', true);
        await _loadUserData(user);
        return true;
      }

      return false;
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
      return false;
    }
  }

  /// Request 2FA code for login
  Future<bool> send2FACode() async {
    try {
      final user = _auth.currentUser;
      if (user == null || user.phoneNumber == null) return false;

      await _auth.verifyPhoneNumber(
        phoneNumber: user.phoneNumber!,
        verificationCompleted: (credential) async {
          await _authBox?.put('2fa_verified_${user.uid}', true);
          await _loadUserData(user);
        },
        verificationFailed: (e) {
          _errorMessage = e.message;
          notifyListeners();
        },
        codeSent: (verificationId, _) {
          _verificationId = verificationId;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        },
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Disable 2FA
  Future<bool> disable2FA() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      await _firestore.collection('users').doc(user.uid).update({
        'is2FAEnabled': false,
        'phoneNumber': null,
      });

      await _authBox?.delete('2fa_verified_${user.uid}');
      await _loadUserData(user);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _complete2FASetup(
    PhoneAuthCredential credential,
    String phoneNumber,
  ) async {
    final user = _auth.currentUser;
    if (user != null) {
      await user.linkWithCredential(credential);
      await _enable2FAInFirestore(user.uid, phoneNumber);
      await _authBox?.put('2fa_verified_${user.uid}', true);
      await _loadUserData(user);
    }
  }

  Future<void> _enable2FAInFirestore(String uid, String phoneNumber) async {
    await _firestore.collection('users').doc(uid).update({
      'is2FAEnabled': true,
      'phoneNumber': phoneNumber,
    });
  }

  // ==================== SIGN OUT ====================

  /// Sign out from all providers
  Future<void> signOut() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _authBox?.delete('2fa_verified_${user.uid}');
      }

      // Try Google sign out - ignore errors if not signed in with Google
      try {
        if (await _googleSignIn.isSignedIn()) {
          await _googleSignIn.signOut();
        }
      } catch (e) {
        // Ignore Google sign out errors - may not be signed in with Google
        debugPrint("Google sign out skipped: $e");
      }

      // Firebase sign out
      await _auth.signOut();

      _currentUser = null;
      _state = AuthState.unauthenticated;
      notifyListeners();
    } catch (e) {
      debugPrint("Sign out error: $e");
      // Still force unauthenticated state
      _currentUser = null;
      _state = AuthState.unauthenticated;
      notifyListeners();
    }
  }

  /// Delete account
  Future<bool> deleteAccount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return false;

      // Delete user data from Firestore
      await _firestore.collection('users').doc(user.uid).delete();

      // Delete auth cache
      await _authBox?.delete('2fa_verified_${user.uid}');

      // Delete Firebase user
      await user.delete();

      _currentUser = null;
      _state = AuthState.unauthenticated;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage =
          'Failed to delete account. Please re-login and try again.';
      notifyListeners();
      return false;
    }
  }

  // ==================== HELPERS ====================

  Future<void> _saveUserToFirestore(
    User user, {
    required String authProvider,
    String? displayName,
  }) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    final existing = await userDoc.get();

    if (!existing.exists) {
      await userDoc.set({
        'email': user.email,
        'displayName': displayName ?? user.displayName,
        'photoUrl': user.photoURL,
        'authProvider': authProvider,
        'createdAt': DateTime.now().toIso8601String(),
        'is2FAEnabled': false,
      });
    } else {
      await userDoc.update({'lastLoginAt': DateTime.now().toIso8601String()});
    }
  }

  void _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        _errorMessage = 'This email is already registered';
        break;
      case 'invalid-email':
        _errorMessage = 'Invalid email address';
        break;
      case 'weak-password':
        _errorMessage = 'Password is too weak';
        break;
      case 'user-not-found':
        _errorMessage = 'No account found with this email';
        break;
      case 'wrong-password':
        _errorMessage = 'Incorrect password';
        break;
      case 'invalid-verification-code':
        _errorMessage = 'Invalid verification code';
        break;
      case 'too-many-requests':
        _errorMessage = 'Too many attempts. Please try again later';
        break;
      default:
        _errorMessage = e.message ?? 'Authentication error';
    }
    _state = AuthState.error;
    notifyListeners();
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    if (_state == AuthState.error) {
      _state = _currentUser != null
          ? AuthState.authenticated
          : AuthState.unauthenticated;
    }
    notifyListeners();
  }
}
