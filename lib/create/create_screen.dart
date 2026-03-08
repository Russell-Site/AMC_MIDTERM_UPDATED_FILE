// create/create_screen.dart

import 'package:flutter/material.dart';
import '../core/app_theme.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBg,
      appBar: AppBar(
        title: const Text('New Buzz',
            style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Post',
                style: TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 16)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.primary, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundColor: AppTheme.surfaceBg,
                    child: Text('🐝', style: TextStyle(fontSize: 22)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: TextField(
                    maxLines: null,
                    autofocus: true,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 17),
                    decoration: const InputDecoration(
                      hintText: "What's the buzz?",
                      border: InputBorder.none,
                      filled: false,
                      hintStyle: TextStyle(
                          color: AppTheme.textSecondary, fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Divider(color: AppTheme.dividerColor),
            Row(
              children: [
                _MediaButton(icon: Icons.image_outlined, label: 'Photo'),
                const SizedBox(width: 8),
                _MediaButton(
                    icon: Icons.video_camera_back_outlined,
                    label: 'Video'),
                const SizedBox(width: 8),
                _MediaButton(
                    icon: Icons.location_on_outlined,
                    label: 'Location'),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _MediaButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MediaButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppTheme.surfaceBg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primary, size: 18),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}