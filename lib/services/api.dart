import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:dart_flutter/models/models.dart';

class ApiService {
  static const String _baseUrl =
      'https://node-ts-fastify-production.up.railway.app';

  Future<PostModel> readPost(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/posts/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load post');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data['success'] == true) {
      // The API returns a wrapper with a 'data' field containing the post
      return PostModel.fromJson(data['data']);
    }
    throw Exception('API error: ${data['message']}');
  }

  Future<List<PostModel>> readPosts({
    required int limit,
    required int skip,
  }) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/posts?limit=$limit&skip=$skip'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load posts');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data['success'] == true) {
      final List<dynamic> posts = data['data'];
      return posts.map((e) => PostModel.fromJson(e)).toList();
    }
    throw Exception('API error: ${data['message']}');
  }
}
