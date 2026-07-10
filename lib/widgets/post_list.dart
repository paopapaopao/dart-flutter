import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart';
import 'package:dart_flutter/widgets/widgets.dart';

class PostList extends StatelessWidget {
  final List<PostModel> posts;
  final ScrollController? controller;
  final bool isLoading;
  final bool hasMore;

  const PostList({
    super.key,
    required this.posts,
    this.controller,
    required this.isLoading,
    required this.hasMore,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      itemCount: posts.length + (hasMore ? 1 : 0),
      separatorBuilder: (_, __) => Divider(height: 1),
      itemBuilder: (_, index) {
        if (index == posts.length) {
          if (hasMore) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text(
                "You've reached the end.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        }

        return PostTile(post: posts[index]);
      },
    );
  }
}
