import 'package:flutter/material.dart';

import 'package:dart_flutter/routes.dart';
import 'package:dart_flutter/screens/screens.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppRoutes.postDetails:
        final id = settings.arguments as int;

        return MaterialPageRoute(builder: (_) => PostScreen(id: id));
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
