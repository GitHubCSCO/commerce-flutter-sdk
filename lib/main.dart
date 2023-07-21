import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MainApp(),
  ));
}

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
