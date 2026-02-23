import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("New Vibe"), actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.check, color: Colors.cyanAccent))]),
      body: Padding(padding: const EdgeInsets.all(20), child: TextField(maxLines: null, decoration: InputDecoration(hintText: "What's happening?", border: InputBorder.none, hintStyle: TextStyle(color: Colors.white24, fontSize: 18)))),
    );
  }
}