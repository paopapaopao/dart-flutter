import 'package:flutter/material.dart';

import 'package:dart_flutter/router.dart';
import 'package:dart_flutter/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(_) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dart Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
