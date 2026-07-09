import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart';
import 'package:dart_flutter/services/services.dart';
import 'package:dart_flutter/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _api = ApiService();
  final ScrollController _scrollController = ScrollController();

  late final Future<List<PostModel>> _postsFuture;

  bool _isShown = false;

  void _listener() {
    const threshold = 300.0;
    final shouldShow = _scrollController.offset > threshold;

    if (shouldShow != _isShown) {
      setState(() {
        _isShown = shouldShow;
      });
    }
  }

  void _handlePress() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();

    _postsFuture = _api.readPosts();
    _scrollController.addListener(_listener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(_) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Home'),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: _postsFuture,
        builder: (_, AsyncSnapshot<List<PostModel>> snapshot) {
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

          final posts = snapshot.data;

          if (posts == null || posts.isEmpty) {
            return Center(child: Text('Posts not found'));
          }

          return PostList(posts: posts, controller: _scrollController);
        },
      ),
      floatingActionButton: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: _isShown
            ? FloatingActionButton(
                key: ValueKey('scrollToTop'),
                onPressed: _handlePress,
                child: Icon(Icons.arrow_upward),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}
