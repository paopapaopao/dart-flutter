import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart';
import 'package:dart_flutter/repositories/repositories.dart';

class PostProvider extends ChangeNotifier {
  final PostRepository repository;

  PostProvider(this.repository);

  final List<PostModel> _posts = [];

  List<PostModel> get posts => _posts;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  static const limit = 20;

  int skip = 0;

  Future<void> loadMore() async {
    if (isLoading || !hasMore) return;

    _isLoading = true;
    notifyListeners();

    final newPosts = await repository.readPosts(limit: limit, skip: skip);

    if (newPosts.isEmpty) {
      _hasMore = false;
    } else {
      _posts.addAll(newPosts);
      skip += limit;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() async {
    skip = 0;
    _hasMore = true;
    _posts.clear();

    await loadMore();
  }
}
