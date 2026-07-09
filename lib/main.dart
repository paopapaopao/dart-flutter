import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dart_flutter/app.dart';
import 'package:dart_flutter/providers/providers.dart';
import 'package:dart_flutter/repositories/repositories.dart';
import 'package:dart_flutter/services/services.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PostProvider(PostRepository(ApiService())),
        ),
      ],
      child: App(),
    ),
  );
}
