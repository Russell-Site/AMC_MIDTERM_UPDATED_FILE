// profile/profile_screen.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../auth/auth_service.dart';
import '../core/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName ?? 'HiVE User';
    final photoUrl    = user?.photoURL;

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      body: CustomScrollView(
        slivers: [

          // ── Sliver App Bar with Honeycomb Gradient ─────────────────────
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: AppTheme.scaffoldBg,
            actions: [
              IconButton(
                icon: const Icon(Icons.menu_rounded, color: Colors.white),
                onPressed: () => _showMenu(context),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1A1200), AppTheme.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text('🍯',
                      style: TextStyle(fontSize: 70, height: 1.2)),
                ),
              ),
            ),
          ),

          // ── Profile Info ───────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Avatar + Edit Row
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppTheme.primary, width: 3),
                        ),
                        child: CircleAvatar(
                          radius: 44,
                          backgroundColor: AppTheme.surfaceBg,
                          backgroundImage:
                          photoUrl != null ? NetworkImage(photoUrl) : null,
                          child: photoUrl == null
                              ? const Text('🐝',
                              style: TextStyle(fontSize: 36))
                              : null,
                        ),
                      ),
                      const Spacer(),
                      _ActionButton(
                        label: 'Edit Profile',
                        onTap: () {},
                      ),
                      const SizedBox(width: 8),
                      _ActionButton(
                        label: 'Share',
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // Name
                  Text(
                    displayName,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '🐝 Living life in the hive',
                    style: TextStyle(
                        color: AppTheme.textSecondary, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'hive.app/me',
                    style: TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13),
                  ),
                  const SizedBox(height: 20),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _Stat('Posts',     '15'),
                      _dividerV(),
                      _Stat('Followers', '1.4K'),
                      _dividerV(),
                      _Stat('Following', '312'),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Grid / Reels Tab Row
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: const BoxDecoration(
                            color: AppTheme.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      Expanded(child: Container(height: 1, color: AppTheme.dividerColor)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.grid_on_rounded, color: AppTheme.primary, size: 24),
                      Icon(Icons.play_circle_outline_rounded, color: AppTheme.textSecondary, size: 24),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ),

          // ── Posts Grid ─────────────────────────────────────────────────
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, i) => Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl:
                    'https://picsum.photos/seed/hive${i + 10}/300/300',
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        Container(color: AppTheme.surfaceBg),
                  ),
                  // Video badge for every 4th post
                  if (i % 4 == 0)
                    const Positioned(
                      top: 6,
                      right: 6,
                      child: Icon(Icons.play_circle_filled_rounded,
                          color: AppTheme.primary, size: 18),
                    ),
                ],
              ),
              childCount: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dividerV() => Container(
      width: 1, height: 36, color: AppTheme.dividerColor);

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.settings_outlined, color: Colors.white),
            title: const Text('Settings',
                style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            title: const Text('Sign Out',
                style: TextStyle(color: Colors.redAccent)),
            onTap: () async {
              Navigator.pop(context);
              await AuthService.signOut();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label, value;
  const _Stat(this.label, this.value);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(value,
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: Colors.white)),
      const SizedBox(height: 2),
      Text(label,
          style: const TextStyle(
              color: AppTheme.textSecondary, fontSize: 12)),
    ]);
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _ActionButton({required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.surfaceBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppTheme.dividerColor),
        ),
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13),
        ),
      ),
    );
  }
}