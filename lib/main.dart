import 'package:flutter/material.dart';

import 'package:dart_flutter/screens/screens.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dart Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {'/': (_) => HomeScreen()},
      initialRoute: '/',
    );
  }
}

void main() {
  runApp(App());
}
