import 'package:commerce_flutter_app/main.dart';
import 'package:test/test.dart';

void main() {
  group(
      'TestableUnit',
      () => {
            test(
                'TestableUnit should have same attributes value as constractor parameters',
                () {
              const String checker = 'Hello';

              final testableUnit = TestableUnit(checker);

              expect(testableUnit.getPrompt, 'Dioxyde');
            })
          });
}
