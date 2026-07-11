import 'package:flutter/material.dart';

import 'package:dart_flutter/widgets/widgets.dart';

class PostFormScreen extends StatefulWidget {
  const PostFormScreen({super.key});

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Post Form'),
      ),
      body: Container(padding: EdgeInsets.all(8), child: PostForm()),
    );
  }
}
