import 'package:flutter/material.dart';

import 'package:dart_flutter/routes.dart';
import 'package:dart_flutter/models/models.dart';
import 'package:dart_flutter/services/services.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final bool isClickable;
  final Function()? onPress;

  const PostCard({
    super.key,
    required this.post,
    this.isClickable = true,
    this.onPress,
  });

  VoidCallback _handlePress(BuildContext context, bool value) {
    return () {
      Navigator.of(context).pop(value);
    };
  }

  VoidCallback _handleEditPress(BuildContext context) {
    return () {
      if (onPress != null) {
        Navigator.of(context).pop();
        onPress!();
      } else {
        Navigator.popAndPushNamed(
          context,
          AppRoutes.postDetails,
          arguments: post.id,
        );
      }
    };
  }

  VoidCallback _handleDeletePress(BuildContext context) {
    return () async {
      final api = ApiService();
      final messenger = ScaffoldMessenger.of(context);
      final navigator = Navigator.of(context);

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Delete Post'),
          content: Text('Are you sure you want to delete this post?'),
          actions: [
            TextButton(
              onPressed: _handlePress(context, false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: _handlePress(context, true),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Delete'),
            ),
          ],
        ),
      );

      if (confirmed != true) return;

      try {
        await api.deletePost(post.id);

        if (!context.mounted) return;

        navigator.pop();
      } catch (error) {
        if (!context.mounted) return;

        messenger.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(error.toString()),
          ),
        );
      }
    };
  }

  VoidCallback _handleMoreVertPress(BuildContext context) {
    return () {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext innerContext) {
          return Flex(
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: _handleEditPress(innerContext),
                leading: Icon(Icons.edit),
                title: Text('Edit'),
              ),
              ListTile(
                onTap: _handleDeletePress(innerContext),
                leading: Icon(Icons.delete),
                title: Text('Delete'),
              ),
            ],
          );
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: EdgeInsets.all(8),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                post.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: _handleMoreVertPress(context),
                icon: Icon(Icons.more_vert, color: Colors.black),
              ),
            ],
          ),
          Text(post.body),
        ],
      ),
    );

    if (!isClickable) return content;

    return InkWell(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(AppRoutes.postDetails, arguments: post.id);
      },
      child: content,
    );
  }
}
