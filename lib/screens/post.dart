import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart';
import 'package:dart_flutter/services/services.dart';
import 'package:dart_flutter/widgets/widgets.dart';

class PostScreen extends StatelessWidget {
  final int id;

  const PostScreen({super.key, required this.id});

  @override
  Widget build(_) {
    final api = ApiService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Post $id'),
      ),
      body: FutureBuilder<PostModel>(
        future: api.readPost(id),
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

          return PostTile(post: snapshot.data!);
        },
      ),
    );
  }
}
