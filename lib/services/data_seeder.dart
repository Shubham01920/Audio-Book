import 'package:cloud_firestore/cloud_firestore.dart';

class DataSeeder {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Ye function call karte hi data upload ho jayega
  Future<void> uploadDummyBook() async {
    try {
      // 1. Batch initialize karein (Faster & Safer)
      WriteBatch batch = _db.batch();

      // --- BOOK DATA ---
      // Auto-ID generate karein taki hum pehle se ID reference kar sakein
      DocumentReference bookRef = _db.collection('books').doc();

      batch.set(bookRef, {
        'title': 'The Psychology of Money',
        'author': 'Morgan Housel',
        'description': 'Timeless lessons on wealth, greed, and happiness.',
        'coverUrl': 'https://placehold.co/600x400/png', // Dummy Image
        'category': 'Finance',
        'isPremium': true,
        'rating': 4.8,
        'totalEpisodes': 3,
        'createdAt': FieldValue.serverTimestamp(),
        'tags': ['finance', 'money', 'investing'], // Search ke liye
      });

      print("Preparing Book: ${bookRef.id}");

      // --- EPISODES DATA ---
      List<Map<String, dynamic>> episodes = [
        {
          'title': 'Introduction: The Greatest Show On Earth',
          'duration': 600, // 10 mins
          'audioUrl':
              'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3', // Dummy Audio
          'index': 0,
          'isFree': true,
        },
        {
          'title': 'Chapter 1: No One’s Crazy',
          'duration': 1250,
          'audioUrl':
              'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
          'index': 1,
          'isFree': false, // Premium
        },
        {
          'title': 'Chapter 2: Luck & Risk',
          'duration': 980,
          'audioUrl':
              'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
          'index': 2,
          'isFree': false,
        },
      ];

      // Episodes ko sub-collection me add karna
      for (var ep in episodes) {
        // Book reference ke andar sub-collection ka reference
        DocumentReference epRef = bookRef.collection('episodes').doc();

        // Data me ID bhi daal sakte hain agar future me chahiye ho
        batch.set(epRef, ep);
      }

      // 2. Commit Batch (Saara data ek saath cloud par jayega)
      await batch.commit();

      print("✅ SUCCESS: Book and Episodes uploaded!");
    } catch (e) {
      print("❌ ERROR: $e");
    }
  }
}
