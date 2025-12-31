import 'package:cloud_firestore/cloud_firestore.dart';

/// Types of coin transactions
enum CoinTransactionType { earned, spent }

/// Sources for earning/spending coins
enum CoinSource {
  share, // Earned by sharing
  dailyLogin, // Daily login bonus
  referral, // Referral reward
  episodeUnlock, // Spent on episode
  purchase, // Bought coins
  milestone, // Achievement reward
}

/// Model for coin transactions
class CoinTransaction {
  final String id;
  final int amount;
  final CoinTransactionType type;
  final CoinSource source;
  final String? description;
  final String? episodeId;
  final DateTime createdAt;

  const CoinTransaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.source,
    this.description,
    this.episodeId,
    required this.createdAt,
  });

  factory CoinTransaction.fromMap(Map<String, dynamic> data, String id) {
    return CoinTransaction(
      id: id,
      amount: data['amount'] ?? 0,
      type: CoinTransactionType.values.firstWhere(
        (e) => e.name == data['type'],
        orElse: () => CoinTransactionType.earned,
      ),
      source: CoinSource.values.firstWhere(
        (e) => e.name == data['source'],
        orElse: () => CoinSource.share,
      ),
      description: data['description'],
      episodeId: data['episodeId'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'type': type.name,
      'source': source.name,
      'description': description,
      'episodeId': episodeId,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}

/// Service for managing user coins and episode unlocking
/// Singleton pattern for easy access
class CoinService {
  // Singleton instance
  static final CoinService _instance = CoinService._internal();
  factory CoinService() => _instance;
  CoinService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Coin costs and rewards
  static const int episodeUnlockCost = 50;
  static const int shareReward = 10;
  static const int dailyLoginReward = 5;
  static const int referralReward = 20;
  static const int testFakeCoins = 100;

  // ==================== STREAM & REALTIME ====================

  /// Get user document stream for real-time coin updates
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(String userId) {
    return _firestore.collection('users').doc(userId).snapshots();
  }

  /// Get current coins from snapshot (safe - handles missing field)
  static int getCoinsFromSnapshot(DocumentSnapshot? snapshot) {
    try {
      final data = snapshot?.data() as Map<String, dynamic>?;
      return data?['coins'] ?? 0;
    } catch (e) {
      return 0;
    }
  }

  /// Get unlocked episodes from snapshot
  static List<String> getUnlockedFromSnapshot(DocumentSnapshot? snapshot) {
    try {
      final data = snapshot?.data() as Map<String, dynamic>?;
      return List<String>.from(data?['unlockedEpisodes'] ?? []);
    } catch (e) {
      return [];
    }
  }

  // ==================== HELPER METHODS ====================

  /// Generate episode ID in format "bookId_episodeIndex"
  static String generateEpisodeId(String bookId, int episodeIndex) {
    return '${bookId}_$episodeIndex';
  }

  /// Check if episode is unlocked from list
  static bool isEpisodeUnlocked(
    List<dynamic> unlockedList,
    String bookId,
    int episodeIndex,
  ) {
    final episodeId = generateEpisodeId(bookId, episodeIndex);
    return unlockedList.contains(episodeId);
  }

  // ==================== BALANCE OPERATIONS ====================

  /// Get user's current coin balance
  Future<int> getBalance(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      return doc.data()?['coins'] ?? 0;
    } catch (e) {
      print('Error getting coin balance: $e');
      return 0;
    }
  }

  /// 🧪 TEST MODE: Add 100 fake coins for testing
  Future<bool> addFakeCoins(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'coins': FieldValue.increment(testFakeCoins),
      });
      return true;
    } catch (e) {
      // If document doesn't exist, set it
      try {
        await _firestore.collection('users').doc(userId).set({
          'coins': testFakeCoins,
          'unlockedEpisodes': [],
        }, SetOptions(merge: true));
        return true;
      } catch (e2) {
        print('Error adding fake coins: $e2');
        return false;
      }
    }
  }

  /// Add coins to user account
  Future<bool> addCoins({
    required String userId,
    required int amount,
    required CoinSource source,
    String? description,
  }) async {
    try {
      final userRef = _firestore.collection('users').doc(userId);

      // Use transaction to ensure atomic update
      await _firestore.runTransaction((transaction) async {
        final userDoc = await transaction.get(userRef);
        final currentCoins = userDoc.data()?['coins'] ?? 0;

        transaction.update(userRef, {'coins': currentCoins + amount});
      });

      // Record transaction
      await _recordTransaction(
        userId: userId,
        amount: amount,
        type: CoinTransactionType.earned,
        source: source,
        description: description,
      );

      return true;
    } catch (e) {
      print('Error adding coins: $e');
      return false;
    }
  }

  // ==================== EPISODE UNLOCKING ====================

  /// Unlock an episode using coins (with transaction for safety)
  /// Returns true if successful, false if not enough coins
  Future<bool> unlockEpisode({
    required String userId,
    required String bookId,
    required int episodeIndex,
    int cost = 50,
  }) async {
    try {
      final userRef = _firestore.collection('users').doc(userId);
      final episodeId = generateEpisodeId(bookId, episodeIndex);

      // Run transaction to ensure atomic update
      final success = await _firestore.runTransaction<bool>((
        transaction,
      ) async {
        final userDoc = await transaction.get(userRef);
        final currentCoins = userDoc.data()?['coins'] ?? 0;

        // Check if enough coins
        if (currentCoins < cost) {
          return false;
        }

        // Deduct coins and add episode to unlocked list
        transaction.update(userRef, {
          'coins': currentCoins - cost,
          'unlockedEpisodes': FieldValue.arrayUnion([episodeId]),
        });

        return true;
      });

      return success;
    } catch (e) {
      print('Error unlocking episode: $e');
      return false;
    }
  }

  /// Check if user has unlocked an episode (async version)
  Future<bool> checkEpisodeUnlocked(
    String userId,
    String bookId,
    int episodeIndex,
  ) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      final unlockedList = List<String>.from(
        doc.data()?['unlockedEpisodes'] ?? [],
      );
      return isEpisodeUnlocked(unlockedList, bookId, episodeIndex);
    } catch (e) {
      return false;
    }
  }

  // ==================== REWARDS ====================

  /// Reward coins for sharing
  Future<bool> rewardForShare(String userId) async {
    return addCoins(
      userId: userId,
      amount: shareReward,
      source: CoinSource.share,
      description: 'Shared book with friend',
    );
  }

  /// Reward coins for daily login
  Future<bool> rewardDailyLogin(String userId) async {
    // Check if already claimed today
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);

    final existingClaim = await _firestore
        .collection('users')
        .doc(userId)
        .collection('coin_transactions')
        .where('source', isEqualTo: CoinSource.dailyLogin.name)
        .where(
          'createdAt',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
        )
        .limit(1)
        .get();

    if (existingClaim.docs.isNotEmpty) {
      return false; // Already claimed today
    }

    return addCoins(
      userId: userId,
      amount: dailyLoginReward,
      source: CoinSource.dailyLogin,
      description: 'Daily login bonus',
    );
  }

  /// Reward coins for referral
  Future<bool> rewardReferral(String userId) async {
    return addCoins(
      userId: userId,
      amount: referralReward,
      source: CoinSource.referral,
      description: 'Friend joined using your link',
    );
  }

  // ==================== TRANSACTION HISTORY ====================

  /// Get transaction history
  Future<List<CoinTransaction>> getHistory(
    String userId, {
    int limit = 20,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('coin_transactions')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs
          .map((doc) => CoinTransaction.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error fetching transaction history: $e');
      return [];
    }
  }

  /// Record a transaction
  Future<void> _recordTransaction({
    required String userId,
    required int amount,
    required CoinTransactionType type,
    required CoinSource source,
    String? description,
    String? episodeId,
  }) async {
    final transaction = CoinTransaction(
      id: '',
      amount: amount,
      type: type,
      source: source,
      description: description,
      episodeId: episodeId,
      createdAt: DateTime.now(),
    );

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('coin_transactions')
        .add(transaction.toMap());
  }
}
