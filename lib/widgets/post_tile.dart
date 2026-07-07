import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart';

class PostTile extends StatelessWidget {
  final PostModel post;

  const PostTile({super.key, required this.post});

  VoidCallback _handleTap(BuildContext context) {
    return () {
      Navigator.pushNamed(context, '/post-details', arguments: post.id);
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _handleTap(context),
      title: Text(post.title),
      subtitle: Text(post.body),
    );
  }
}
