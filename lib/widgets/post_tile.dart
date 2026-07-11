import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart';
import 'package:dart_flutter/routes.dart';
import 'package:dart_flutter/services/services.dart';

class PostTile extends StatelessWidget {
  final PostModel post;

  const PostTile({super.key, required this.post});

  VoidCallback _handlePress(BuildContext context, bool value) {
    return () {
      Navigator.of(context).pop(value);
    };
  }

  ConfirmDismissCallback _handleConfirmDismiss(BuildContext context) {
    return (_) async {
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

      if (confirmed != true) return false;

      final api = ApiService();

      try {
        await api.deletePost(post.id);

        if (!context.mounted) return true;

        return true;
      } catch (exception) {
        if (!context.mounted) return false;

        return false;
      }
    };
  }

  VoidCallback _handleTap(BuildContext context) {
    return () {
      // TODO: Refactor
      Navigator.pushNamed(context, AppRoutes.postDetails, arguments: post.id);
    };
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: _handleConfirmDismiss(context),
      key: Key(post.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: ListTile(
        onTap: _handleTap(context),
        title: Text(post.title),
        subtitle: Text(post.body),
      ),
    );
  }
}
