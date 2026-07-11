import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart';
import 'package:dart_flutter/services/services.dart';
import 'package:dart_flutter/widgets/widgets.dart';

class PostScreen extends StatefulWidget {
  final int id;

  const PostScreen({super.key, required this.id});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool _isView = true;

  void _handleEditPress() {
    setState(() {
      _isView = false;
    });
  }

  @override
  Widget build(_) {
    final api = ApiService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Post ${widget.id}'),
      ),
      body: FutureBuilder<PostModel>(
        future: api.readPost(widget.id),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Container(
              alignment: Alignment.center,
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              child: Text('Post not found'),
            );
          }

          return Flex(
            direction: Axis.vertical,
            children: [
              if (_isView) ...[
                PostTile(post: snapshot.data!),
                ElevatedButton(
                  onPressed: _handleEditPress,
                  child: Text('Edit'),
                ),
              ] else
                PostForm(
                  post: snapshot.data!,
                  onPress: api.updatePost,
                  text: 'Update Post',
                ),
            ],
          );
        },
      ),
    );
  }
}
