import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/community_provider.dart';
import '../helper/postcard.dart';

// 🔹 Main community feed screen (displayed as Profile for now)
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    // 🔹 Load first posts when screen opens
    // Use addPostFrameCallback to avoid unsafe provider access during init if not ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CommunityProvider>().fetchInitialPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 🔹 Listen to provider updates
    final provider = context.watch<CommunityProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Community")),

      // 🔹 Detect scroll for pagination
      body: NotificationListener<ScrollNotification>(
        onNotification: (scroll) {
          // 🔹 If reached bottom → load more
          if (scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
            provider.fetchMorePosts();
          }
          return true;
        },

        child: ListView.builder(
          // 🔹 Extra item for loader
          itemCount: provider.posts.length + (provider.hasMore ? 1 : 0),

          itemBuilder: (context, index) {
            // 🔹 Show loader at bottom
            if (index == provider.posts.length) {
              // Only show loader if we have more
              if (!provider.hasMore) return const SizedBox.shrink();
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            // 🔹 Show post card
            return PostCard(post: provider.posts[index]);
          },
        ),
      ),
    );
  }
}
