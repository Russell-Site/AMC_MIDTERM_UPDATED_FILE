import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import '/navigation/main_nav.dart';

void main() => runApp(const IgApp());

class IgApp extends StatelessWidget {
  const IgApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instamax Social',
      theme: AppTheme.darkTheme,
      home: const MainNav(),
    );
  }
}