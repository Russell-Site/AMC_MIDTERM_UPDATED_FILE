import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Padding(padding: const EdgeInsets.all(15), child: TextField(decoration: InputDecoration(hintText: "Explore Space...", prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white10, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)))),
          Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2), itemCount: 21, itemBuilder: (context, i) => CachedNetworkImage(imageUrl: "https://picsum.photos/seed/$i/300/300", fit: BoxFit.cover))),
        ]),
      ),
    );
  }
}