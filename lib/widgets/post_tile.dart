import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart';

class PostTile extends StatelessWidget {
  final PostModel post;

  const PostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(post.title), subtitle: Text(post.body));
  }
}
