import 'package:flutter/material.dart';

import 'package:dart_flutter/services/services.dart';
import 'package:dart_flutter/widgets/widgets.dart';

class PostFormScreen extends StatefulWidget {
  const PostFormScreen({super.key});

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  final ApiService service = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Post Form'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: PostForm(
          post: null,
          onPress: ({int? id, required payload}) async {
            final messenger = ScaffoldMessenger.of(context);

            try {
              await service.createPost(payload);
            } catch (error) {
              if (!context.mounted) return;

              messenger.showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(error.toString()),
                ),
              );
            }
          },
          text: 'Create Post',
        ),
      ),
    );
  }
}
