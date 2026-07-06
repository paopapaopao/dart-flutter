import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:dart_flutter/models/models.dart';

class ApiService {
  Future<List<PostModel>> readPosts() async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/posts?limit=20&select=id,title,body'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load posts');
    }

    final data = jsonDecode(response.body);

    return (data['posts'] as List).map((e) => PostModel.fromJson(e)).toList();
  }
}
