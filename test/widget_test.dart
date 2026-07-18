// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dart_flutter/app.dart';
import 'package:dart_flutter/providers/providers.dart';
import 'package:dart_flutter/repositories/repositories.dart';
import 'package:dart_flutter/services/services.dart';

void main() {
  testWidgets('AppBar displays the title "Home"', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<PostProvider>(
            create: (_) => PostProvider(PostRepository(ApiService())),
          ),
        ],
        child: const App(),
      ),
    );

    expect(
      find.byWidgetPredicate(
        (w) => w is AppBar && (w.title as Text).data == 'Home',
      ),
      findsOneWidget,
    );
  });
}
