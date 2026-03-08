// feed/feed_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post_model.dart';

class FeedService {
  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=12'));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    }
    return [];
  }
}