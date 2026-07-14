import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:dart_flutter/exceptions/exceptions.dart';
import 'package:dart_flutter/models/models.dart';

class ApiService {
  static const String _baseUrl =
      'https://node-ts-fastify-production.up.railway.app';

  Future<PostModel> readPost(int id) async {
    try {
      final uri = Uri.parse('$_baseUrl/posts/$id');
      final response = await http.get(uri);
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          data['success'] == true) {
        final post = PostModel.fromJson(data['data']);

        return post;
      }

      throw ApiException(data['message'] ?? 'Read Post failed');
    } on ApiException catch (error, stackTrace) {
      log(
        'ApiException',
        name: 'ApiService',
        error: error,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );

      rethrow;
    } catch (error, stackTrace) {
      log(
        'Exception',
        name: 'ApiService',
        error: error,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );

      throw ApiException('Unexpected error');
    }
  }

  Future<List<PostModel>> readPosts({
    required int limit,
    required int skip,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/posts?limit=$limit&skip=$skip');
      final response = await http.get(uri);
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          data['success'] == true) {
        // TODO: Why not List<Map<String, dynamic>>?
        final posts = (data['data'] as List<dynamic>)
            .map((post) => PostModel.fromJson(post))
            .toList();

        return posts;
      }

      throw ApiException(data['message'] ?? 'Read Posts failed');
    } on ApiException catch (error, stackTrace) {
      log(
        'ApiException',
        name: 'ApiService',
        error: error,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );

      rethrow;
    } catch (error, stackTrace) {
      log(
        'Exception',
        name: 'ApiService',
        error: error,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );

      throw ApiException('Unexpected error');
    }
  }

  Future<PostModel> createPost(Map<String, String> payload) async {
    try {
      final uri = Uri.parse('$_baseUrl/posts');

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          data['success'] == true) {
        final post = PostModel.fromJson(data['data']);

        return post;
      }

      throw ApiException(data['message'] ?? 'Create Post failed');
    } on ApiException catch (error, stackTrace) {
      log(
        'ApiException',
        name: 'ApiService',
        error: error,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );

      rethrow;
    } catch (error, stackTrace) {
      log(
        'Exception',
        name: 'ApiService',
        error: error,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );

      throw ApiException('Unexpected error');
    }
  }

  Future<PostModel> updatePost({
    required int id,
    required Map<String, String> payload,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/posts/$id');

      final response = await http.put(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          data['success'] == true) {
        final post = PostModel.fromJson(data['data']);

        return post;
      }

      throw ApiException(data['message'] ?? 'Update Post failed');
    } on ApiException catch (error, stackTrace) {
      log(
        'ApiException',
        name: 'ApiService',
        error: error,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );

      rethrow;
    } catch (error, stackTrace) {
      log(
        'Exception',
        name: 'ApiService',
        error: error,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );

      throw ApiException('Unexpected error');
    }
  }

  Future<PostModel> deletePost(int id) async {
    try {
      final uri = Uri.parse('$_baseUrl/posts/$id');
      final response = await http.delete(uri);
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          data['success'] == true) {
        final post = PostModel.fromJson(data['data']);

        return post;
      }

      throw ApiException(data['message'] ?? 'Delete Post failed');
    } on ApiException catch (error, stackTrace) {
      log(
        'ApiException',
        name: 'ApiService',
        error: error,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );

      rethrow;
    } catch (error, stackTrace) {
      log(
        'Exception',
        name: 'ApiService',
        error: error,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );

      throw ApiException('Unexpected error');
    }
  }
}
