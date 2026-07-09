import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart';
import 'package:dart_flutter/widgets/widgets.dart';

class PostList extends StatelessWidget {
  final List<PostModel> posts;
  final ScrollController? controller;

  const PostList({super.key, required this.posts, this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      itemCount: posts.length,
      itemBuilder: (_, int index) => PostTile(post: posts[index]),
      separatorBuilder: (_, __) => Divider(height: 1),
    );
  }
}
