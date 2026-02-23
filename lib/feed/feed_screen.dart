import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/video_widget.dart';
import 'post_model.dart';
import 'feed_service.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Setting up a bold, modern app bar with a custom brand color
      appBar: AppBar(
          title: const Text(
              "Instamax",
              style: TextStyle(fontWeight: FontWeight.w900, color: Colors.cyanAccent)
          )
      ),

      // FutureBuilder is used here to wait for data from the FeedService (API)
      body: FutureBuilder<List<Post>>(
        future: FeedService.fetchPosts(),
        builder: (context, snapshot) {
          // Show a loading spinner while the network request is in progress
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // Once data arrives, use ListView.builder for memory-efficient scrolling
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => _PostCard(post: snapshot.data![index]),
          );
        },
      ),
    );
  }
}

// _PostCard handles the UI layout for every individual post item
class _PostCard extends StatelessWidget {
  final Post post;
  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Header: Displaying user info and post options
        ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(post.userAvatar)),
          title: Text(post.username, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.more_horiz), // Standard "more" options icon
        ),

        // 2. Media Section: Check if the content is a video or an image
        if (post.videoUrl != null)
          VideoWidget(url: post.videoUrl!) // Render custom video player if URL exists
        else
          CachedNetworkImage(
            imageUrl: post.imageUrl,
            height: 400, // Uniform height for a consistent feed look
            width: double.infinity,
            fit: BoxFit.cover, // Crop image to fill the space without distortion
            placeholder: (context, url) => Container(color: Colors.white10),
          ),

        // 3. Interaction Bar: Likes, Comments, Share, and Bookmark
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(Icons.favorite_border, size: 28),
              SizedBox(width: 15),
              Icon(Icons.chat_bubble_outline, size: 26),
              SizedBox(width: 15),
              Icon(Icons.send_outlined, size: 26),
              Spacer(), // Push the bookmark icon to the far right
              Icon(Icons.bookmark_border, size: 28),
            ],
          ),
        ),

        // 4. Caption Section: Merging the username and caption for a clean look
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
                  children: [
                    // Highlight the username in bold for clear visual hierarchy
                    TextSpan(
                        text: "${post.username} ",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Secondary UI details to make the app feel complete and professional
              const Text(
                "View all 12 comments",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 4),
              const Text(
                "FEBRUARY 23", // Date placeholder for UI design
                style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 0.5),
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),
        // Subtle divider to separate posts while scrolling
        const Divider(color: Colors.white10, thickness: 0.5),
      ],
    );
  }
}