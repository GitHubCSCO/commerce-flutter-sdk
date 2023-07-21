import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  // Remove anything related to TestableUnit later
  final testableUnit = TestableUnit('Hello World!');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(testableUnit.getPrompt),
        ),
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
