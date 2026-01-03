import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/community_provider.dart';
import '../../helper/postcard.dart';

class CommunityFeedScreen extends StatelessWidget {
  const CommunityFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommunityProvider()..fetchInitialPosts(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text(
            "Community",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: false,
        ),
        body: Consumer<CommunityProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.posts.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.posts.isEmpty) {
              return const Center(child: Text("No posts yet"));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: provider.posts.length,
              itemBuilder: (context, index) {
                final post = provider.posts[index];
                return PostCard(post: post);
              },
            );
          },
        ),
      ),
    );
  }
}
