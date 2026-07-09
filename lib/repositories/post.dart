import 'package:dart_flutter/models/models.dart';
import 'package:dart_flutter/services/services.dart';

class PostRepository {
  final ApiService api;

  PostRepository(this.api);

  Future<List<PostModel>> readPosts({required int limit, required int skip}) {
    return api.readPosts(limit: limit, skip: skip);
  }
}
