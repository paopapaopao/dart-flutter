import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart';
import 'package:dart_flutter/services/services.dart';
import 'package:dart_flutter/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService api = ApiService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Home'),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: api.readPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts found'));
          }

          return PostList(posts: snapshot.data!);
        },
      ),
    );
  }
}
