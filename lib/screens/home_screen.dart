import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart' show PostModel;
import 'package:dart_flutter/widgets/widgets.dart' show PostList;

class HomeScreen extends StatelessWidget {
  final List<PostModel> _posts = [
    PostModel(
      title: 'Post 1',
      body:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean viverra elementum lorem vel commodo. Aliquam erat volutpat. Phasellus lobortis ullamcorper pulvinar.',
    ),
    PostModel(
      title: 'Post 2',
      body:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean viverra elementum lorem vel commodo. Aliquam erat volutpat. Phasellus lobortis ullamcorper pulvinar.',
    ),
    PostModel(
      title: 'Post 3',
      body:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean viverra elementum lorem vel commodo. Aliquam erat volutpat. Phasellus lobortis ullamcorper pulvinar.',
    ),
    PostModel(
      title: 'Post 4',
      body:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean viverra elementum lorem vel commodo. Aliquam erat volutpat. Phasellus lobortis ullamcorper pulvinar.',
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Home'),
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(4),
        child: PostList(posts: _posts),
      ),
    );
  }
}
