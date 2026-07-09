import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:dart_flutter/models/models.dart';

class ApiService {
  Future<PostModel> readPost(int id) async {
    final response = await http.get(
      Uri.parse(
        'https://dummyjson.com/posts/$id?limit=32&select=id,title,body',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load post');
    }

    final data = jsonDecode(response.body);

    return PostModel.fromJson(data);
  }

  Future<List<PostModel>> readPosts({
    required int limit,
    required int skip,
  }) async {
    final response = await http.get(
      Uri.parse(
        'https://dummyjson.com/posts?limit=$limit&skip=$skip&select=id,title,body',
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load posts');
    }

    final data = jsonDecode(response.body);

    return (data['posts'] as List).map((e) => PostModel.fromJson(e)).toList();
  }
}
