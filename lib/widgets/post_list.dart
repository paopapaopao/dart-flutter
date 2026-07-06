import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart';
import 'package:dart_flutter/widgets/widgets.dart';

class PostList extends StatelessWidget {
  final List<PostModel> posts;

  const PostList({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (_, int index) => PostTile(post: posts[index]),
      separatorBuilder: (_, __) => Divider(height: 1),
    );
  }
}
