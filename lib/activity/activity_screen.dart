import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Activity",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
        ),
      ),
      body: ListView(
        children: [
          // Section 1: New Notifications
          const _ActivityHeader(title: "New"),
          _buildActivityItem(0, "liked your photo.", true),
          _buildActivityItem(1, "started following you.", false, isFollow: true),

          const Divider(color: Colors.white10, indent: 70),

          // Section 2: This Week
          const _ActivityHeader(title: "This Week"),
          _buildActivityItem(2, "commented: 'Amazing shot! 🔥'", true),
          _buildActivityItem(3, "liked your photo.", true),
          _buildActivityItem(4, "started following you.", false, isFollow: true),
          _buildActivityItem(5, "mentioned you in a comment.", true),

          const Divider(color: Colors.white10, indent: 70),

          // Section 3: Suggested for you
          const _ActivityHeader(title: "Suggested for you"),
          _buildActivityItem(6, "is on Instamax. Follow them to see their posts.", false, isFollow: true, isSuggestion: true),
        ],
      ),
    );
  }

  // Helper function to build different types of activity rows
  Widget _buildActivityItem(int i, String action, bool hasThumbnail, {bool isFollow = false, bool isSuggestion = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          // User Profile Picture
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white10,
            backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=user$i"),
          ),
          const SizedBox(width: 12),

          // Notification Text
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.3),
                children: [
                  TextSpan(
                    text: "username_$i ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: action),
                  TextSpan(
                    text: "  ${i + 1}h",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Action: Either a Thumbnail of a post OR a Follow Button
          if (hasThumbnail)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                "https://picsum.photos/seed/post$i/100/100",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            )
          else if (isFollow)
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                minimumSize: const Size(80, 32),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text("Follow", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}

// Custom Header Widget for sections
class _ActivityHeader extends StatelessWidget {
  final String title;
  const _ActivityHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
      ),
    );
  }
}