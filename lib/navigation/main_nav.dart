import 'package:flutter/material.dart';
// Importing our custom feature screens from their respective folders
import '../feed/feed_screen.dart';
import '../explore/explore_screen.dart';
import '../create/create_screen.dart';
import '../activity/activity_screen.dart';
import '../profile/profile_screen.dart';

class MainNav extends StatefulWidget {
  const MainNav({super.key});
  @override
  State<MainNav> createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  // Keeps track of the currently selected tab
  int _currentIndex = 0;

  // List of the main widgets for each navigation tab
  final _screens = [
    const FeedScreen(),
    const ExploreScreen(),
    const CreateScreen(),
    const ActivityScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body swaps the visible screen based on the current index
      body: _screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        // Update the state and rebuild the UI when a user taps a new icon
        onTap: (i) => setState(() => _currentIndex = i),

        type: BottomNavigationBarType.fixed, // Keeps icons stable (no shifting)
        backgroundColor: const Color(0xFF08090A), // Deep black background for an OLED look
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false, // Hidden labels for a minimalist, modern aesthetic

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }
}