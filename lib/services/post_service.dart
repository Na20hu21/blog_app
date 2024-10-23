import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class PostService {
  Future<List<Post>> fetchPosts(int start, int limit) async {
    final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$limit'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
