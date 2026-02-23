import 'dart:convert'; // Required for converting raw JSON strings into Map objects
import 'package:http/http.dart' as http; // The package used to handle our API calls
import 'post_model.dart'; // Importing our model so we can map the data correctly

class FeedService {
  // We use a static method so we can call it directly without instantiating the class
  static Future<List<Post>> fetchPosts() async {

    // 1. Send a GET request to the API.
    // We added '_limit=10' to keep the feed clean and prevent loading too much data at once.
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=10'));

    // 2. Check if the server responded successfully (Status Code 200 = OK)
    if (response.statusCode == 200) {

      // 3. Decode the raw response body into a List of Maps
      List data = json.decode(response.body);

      // 4. Transform the raw data into a List of 'Post' objects using our model
      // This makes the data easier to handle in our UI (FeedScreen)
      return data.map((json) => Post.fromJson(json)).toList();
    }

    // 5. Return an empty list if the request fails to prevent the app from crashing
    return [];
  }
}