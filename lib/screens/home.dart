import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart';
import 'package:dart_flutter/services/services.dart';
import 'package:dart_flutter/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(_) {
    final api = ApiService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Home'),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: api.readPosts(),
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

          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Container(
              alignment: Alignment.center,
              child: Text('Posts not found'),
            );
          }

          return PostList(posts: snapshot.data!);
        },
      ),
    );
  }
}
