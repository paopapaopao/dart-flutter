import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dart_flutter/providers/providers.dart';
import 'package:dart_flutter/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _isShown = false;

  void _listener() {
    const threshold = 300.0;

    final provider = context.read<PostProvider>();

    // Infinite scroll
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - threshold) {
      provider.loadMore();
    }

    // Scroll-to-top button
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
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_listener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().loadMore();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Home'),
      ),
      body: Consumer<PostProvider>(
        builder: (_, provider, __) {
          if (provider.posts.isEmpty && provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.posts.isEmpty) {
            return Center(child: Text('Posts not found'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              await context.read<PostProvider>().refresh();
            },
            child: PostList(
              posts: provider.posts,
              controller: _scrollController,
              isLoading: provider.isLoading,
              hasMore: provider.hasMore,
            ),
          );
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
