import 'package:flutter/material.dart';

import 'package:dart_flutter/models/models.dart';

class PostForm extends StatefulWidget {
  final PostModel? post;
  final Future<void> Function(int, Map<String, String>) onPress;
  final String text;

  const PostForm({
    super.key,
    this.post,
    required this.onPress,
    this.text = 'Submit',
  });

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  String? _validateTitle(String? value) =>
      value == null || value.isEmpty ? 'Title is required' : null;

  String? _validateBody(String? value) =>
      value == null || value.isEmpty ? 'Body is required' : null;

  Future<void> _handlePress() async {
    if (!_key.currentState!.validate()) return;

    final data = {'title': _titleController.text, 'body': _bodyController.text};

    await widget.onPress(widget.post?.id ?? 0, data);
  }

  @override
  void initState() {
    super.initState();

    final title = widget.post?.title ?? '';
    final body = widget.post?.body ?? '';
    _titleController = TextEditingController(text: title);
    _bodyController = TextEditingController(text: body);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _titleController,
            validator: _validateTitle,
            decoration: InputDecoration(hintText: 'Enter title'),
          ),
          SizedBox(height: 32),
          TextFormField(
            controller: _bodyController,
            validator: _validateBody,
            decoration: InputDecoration(hintText: 'Enter body'),
          ),
          SizedBox(height: 64),
          ElevatedButton(onPressed: _handlePress, child: Text(widget.text)),
        ],
      ),
    );
  }
}
