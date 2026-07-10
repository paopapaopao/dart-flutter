import 'dart:developer';

import 'package:flutter/material.dart';

class PostFormScreen extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  PostFormScreen({super.key});

  String? _validateTitle(String? value) =>
      value == null || value.isEmpty ? 'Title is required' : null;

  String? _validateBody(String? value) =>
      value == null || value.isEmpty ? 'Body is required' : null;

  Future<void> _handlePress() async {
    if (!_key.currentState!.validate()) return;

    log('currentState: ${_key.currentState!.validate()}');
  }

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
        child: Form(
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
              ElevatedButton(
                onPressed: _handlePress,
                child: Text('Create Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
