import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Make sure this is imported

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. The Gradient Header
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.cyanAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),

          // 2. User Stats & Info
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 10),
                // Profile Picture
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage("https://www.bing.com/th/id/OIP.BBPXWetip7_L7cxt0nmlxAAAAA?w=160&h=211&c=8&rs=1&qlt=90&o=6&pid=3.1&rm=2"),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Username",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Social Media Influencer",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),

                // Stats Row
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _ProfileStat("Posts", "15"),
                    _ProfileStat("Followers", "1.2k"),
                    _ProfileStat("Following", "450"),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(color: Colors.white10, height: 1),
              ],
            ),
          ),

          // 3. The FIXED Image Grid
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, i) => CachedNetworkImage(
                // We use a different seed for each image so they are unique
                imageUrl: "https://picsum.photos/seed/profile${i + 20}/300/300",
                fit: BoxFit.cover,
                // Placeholder shown while loading
                placeholder: (context, url) => Container(color: Colors.white10),
                // Error widget if image fails to load
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              childCount: 15, // Number of posts
            ),
          ),
        ],
      ),
    );
  }
}

// Small helper widget for Stats
class _ProfileStat extends StatelessWidget {
  final String label, value;
  const _ProfileStat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }
}