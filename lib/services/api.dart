import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:dart_flutter/exceptions/exceptions.dart';
import 'package:dart_flutter/models/models.dart';

enum HttpMethod { post, get, put, delete }

class ApiService {
  static const String _baseUrl =
      'https://node-ts-fastify-production.up.railway.app';

  Future<http.Response> _request({
    required HttpMethod method,
    required Uri uri,
    Map<String, String>? headers,
    String? body,
    String? message,
  }) async {
    try {
      final http.Response response;

      switch (method) {
        case HttpMethod.post:
          response = await http.post(uri, headers: headers, body: body);

          break;
        case HttpMethod.get:
          response = await http.get(uri);

          break;
        case HttpMethod.put:
          response = await http.put(uri, headers: headers, body: body);

          break;
        case HttpMethod.delete:
          response = await http.delete(uri);

          break;
      }

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          data['success'] == true) {
        return response;
      }

      final errorMessage =
          data['message'] ??
          message ??
          'Something went wrong: ${method.name} $uri';

      throw ApiException(errorMessage);
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
    final response = await _request(
      method: HttpMethod.post,
      uri: Uri.parse('$_baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
      message: 'Create Post failed',
    );

    final Map<String, dynamic> data = jsonDecode(response.body);
    final post = PostModel.fromJson(data['data']);

    return post;
  }

  Future<PostModel> readPost(int id) async {
    final response = await _request(
      method: HttpMethod.get,
      uri: Uri.parse('$_baseUrl/posts/$id'),
      message: 'Read Post failed',
    );

    final Map<String, dynamic> data = jsonDecode(response.body);
    final post = PostModel.fromJson(data['data']);

    return post;
  }

  // TODO:?
  Future<List<PostModel>> readPosts({
    required int limit,
    required int skip,
  }) async {
    final response = await _request(
      method: HttpMethod.get,
      uri: Uri.parse('$_baseUrl/posts?limit=$limit&skip=$skip'),
      message: 'Read Posts failed',
    );

    final Map<String, dynamic> data = jsonDecode(response.body);

    // TODO: Why not List<Map<String, dynamic>>?
    final posts = (data['data'] as List<dynamic>)
        .map((dynamic post) => PostModel.fromJson(post))
        .toList();

    return posts;
  }

  Future<PostModel> updatePost({
    required int id,
    required Map<String, String> payload,
  }) async {
    final response = await _request(
      method: HttpMethod.put,
      uri: Uri.parse('$_baseUrl/posts/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
      message: 'Update Post failed',
    );

    final Map<String, dynamic> data = jsonDecode(response.body);
    final post = PostModel.fromJson(data['data']);

    return post;
  }

  Future<PostModel> deletePost(int id) async {
    final response = await _request(
      method: HttpMethod.delete,
      uri: Uri.parse('$_baseUrl/posts/$id'),
      message: 'Delete Post failed',
    );

    final Map<String, dynamic> data = jsonDecode(response.body);
    final post = PostModel.fromJson(data['data']);

    return post;
  }
}
