import 'package:commerce_flutter_app/src/routes/router.dart';
import 'package:flutter/material.dart';

class CommerceApp extends StatelessWidget {
  const CommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: globalRouter,
      title: 'Configured Commerce Flutter',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// These classes are for dummy testing only

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TestableWidget('Hello B2B!'), // only for setting up testing
      ),
    );
  }
}

// Dummy Unit to test
class TestableUnit {
  TestableUnit(this._string);

  final String _string;

  String get getPrompt {
    return _string;
  }
}

// Dummy Widget to test
class TestableWidget extends StatelessWidget {
  TestableWidget(this.message, {super.key});

  final String message;
  late final testableUnit = TestableUnit(message);

  @override
  Widget build(BuildContext context) {
    return Text(testableUnit.getPrompt, textDirection: TextDirection.ltr);
  }
}
