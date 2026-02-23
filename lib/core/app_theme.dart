import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand color used for accents, buttons, and active states
  static const primary = Colors.cyanAccent;

  // Custom deep black for an OLED-friendly dark mode (saves battery on mobile)
  static const scaffoldBg = Color(0xFF08090A);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: scaffoldBg,
    primaryColor: primary,

    // Applying 'Plus Jakarta Sans' globally for a modern, tech-focused look
    textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme),

    // Setting a minimalist look for all AppBars in the project
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent, // Blends the app bar into the background
      elevation: 0,                        // Removes the shadow for a flatter design
      centerTitle: false,                  // Aligns title to the left (standard social media layout)
    ),
  );
}