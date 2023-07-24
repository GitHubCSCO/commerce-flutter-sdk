import 'package:flutter_test/flutter_test.dart';
import 'package:commerce_flutter_app/main.dart';

void main() {
  group('TestableWidget', () {
    testWidgets('Tests if Text appears', (widgetTester) async {
      await widgetTester.pumpWidget(TestableWidget('Hello World!'));

      final textFinder = find.text('Hello World!');

      expect(textFinder, findsOneWidget);
    });
  });
}
