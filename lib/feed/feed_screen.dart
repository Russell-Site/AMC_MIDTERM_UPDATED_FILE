// feed/feed_screen.dart

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/app_theme.dart';
import '../core/video_widget.dart';
import 'post_model.dart';
import 'feed_service.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        title: Row(children: [
          const Text('🐝', style: TextStyle(fontSize: 22)),
          const SizedBox(width: 8),
          const Text(
            'HiVE',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: AppTheme.primary,
              fontSize: 26,
              letterSpacing: 2,
            ),
          ),
        ]),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded,
                color: Colors.white, size: 26),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.send_outlined,
                color: Colors.white, size: 24),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: FeedService.fetchPosts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(color: AppTheme.primary));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length + 1, // +1 for stories row
            itemBuilder: (context, index) {
              if (index == 0) return const _StoriesRow();
              return _PostCard(post: snapshot.data![index - 1]);
            },
          );
        },
      ),
    );
  }
}

// ─── Stories Row ────────────────────────────────────────────────────────────

class _StoriesRow extends StatelessWidget {
  const _StoriesRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        itemCount: 9,
        itemBuilder: (context, i) {
          final isAdd = i == 0;
          return Padding(
            padding: const EdgeInsets.only(right: 14),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: isAdd
                        ? null
                        : const LinearGradient(
                      colors: [AppTheme.primary, Color(0xFFFF8C00)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    color: isAdd ? AppTheme.surfaceBg : null,
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: AppTheme.surfaceBg,
                    backgroundImage: isAdd
                        ? null
                        : NetworkImage(
                        'https://i.pravatar.cc/150?u=story$i'),
                    child: isAdd
                        ? const Icon(Icons.add,
                        color: AppTheme.primary, size: 26)
                        : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isAdd ? 'Your Story' : 'bee_$i',
                  style: const TextStyle(
                      fontSize: 11, color: AppTheme.textSecondary),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ─── Post Card ───────────────────────────────────────────────────────────────

class _PostCard extends StatefulWidget {
  final Post post;
  const _PostCard({required this.post});
  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> {
  bool _liked = false;
  bool _saved = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      color: AppTheme.scaffoldBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header ─────────────────────────────────────────────────────────
          ListTile(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.primary, width: 2),
              ),
              child: CircleAvatar(
                radius: 19,
                backgroundImage:
                NetworkImage(widget.post.userAvatar),
              ),
            ),
            title: Text(
              widget.post.username,
              style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 14),
            ),
            subtitle: const Text('Just now',
                style: TextStyle(
                    color: AppTheme.textSecondary, fontSize: 11)),
            trailing: const Icon(Icons.more_horiz, color: Colors.white54),
          ),

          // 2. Media ───────────────────────────────────────────────────────────
          if (widget.post.videoUrl != null)
            VideoWidget(url: widget.post.videoUrl!)
          else
            CachedNetworkImage(
              imageUrl: widget.post.imageUrl,
              height: 380,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                  height: 380, color: AppTheme.surfaceBg),
              errorWidget: (_, __, ___) =>
                  Container(height: 380, color: AppTheme.surfaceBg),
            ),

          // 3. Actions ─────────────────────────────────────────────────────────
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                // Like button with animation
                GestureDetector(
                  onTap: () => setState(() => _liked = !_liked),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, anim) =>
                        ScaleTransition(scale: anim, child: child),
                    child: Icon(
                      _liked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      key: ValueKey(_liked),
                      color: _liked
                          ? AppTheme.primary
                          : Colors.white,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.chat_bubble_outline_rounded,
                    size: 26, color: Colors.white),
                const SizedBox(width: 16),
                const Icon(Icons.send_outlined,
                    size: 25, color: Colors.white),
                const Spacer(),
                GestureDetector(
                  onTap: () => setState(() => _saved = !_saved),
                  child: Icon(
                    _saved
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    size: 28,
                    color: _saved ? AppTheme.primary : Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // 4. Likes Count ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              '${widget.post.likes + (_liked ? 1 : 0)} likes',
              style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
          const SizedBox(height: 4),

          // 5. Caption ─────────────────────────────────────────────────────────
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                    color: Colors.white, fontSize: 13, height: 1.4),
                children: [
                  TextSpan(
                    text: '${widget.post.username} ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: widget.post.caption),
                ],
              ),
            ),
          ),

          // 6. Comments hint ───────────────────────────────────────────────────
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 6, 14, 2),
            child: Text('View all comments',
                style: TextStyle(
                    color: AppTheme.textSecondary, fontSize: 12)),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Text('2 HOURS AGO',
                style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 10,
                    letterSpacing: 0.5)),
          ),

          const Divider(
              color: AppTheme.dividerColor, thickness: 0.5, height: 0),
        ],
      ),
    );
  }
}