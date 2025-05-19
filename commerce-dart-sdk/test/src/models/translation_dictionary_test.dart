import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('TranslationDictionary', () {
    test(
        'fromJson should correctly deserialize JSON to TranslationDictionary object',
        () {
      // Arrange
      final json = {
        "keyword": "greeting",
        "source": "Hello",
        "translation": "Hola",
        "languageId": "L1",
        "languageCode": "es",
      };

      // Act
      final translationDictionary = TranslationDictionary.fromJson(json);

      // Assert
      expect(translationDictionary.keyword, "greeting");
      expect(translationDictionary.source, "Hello");
      expect(translationDictionary.translation, "Hola");
      expect(translationDictionary.languageId, "L1");
      expect(translationDictionary.languageCode, "es");
    });

    test(
        'toJson should correctly serialize TranslationDictionary object to JSON',
        () {
      // Arrange
      final translationDictionary = TranslationDictionary(
        keyword: "greeting",
        source: "Hello",
        translation: "Hola",
        languageId: "L1",
        languageCode: "es",
      );

      // Act
      final json = translationDictionary.toJson();

      // Assert
      expect(json["keyword"], "greeting");
      expect(json["source"], "Hello");
      expect(json["translation"], "Hola");
      expect(json["languageId"], "L1");
      expect(json["languageCode"], "es");
    });

    test('fromJson should handle empty JSON gracefully', () {
      // Arrange
      Map<String, dynamic> json = {};

      // Act
      final translationDictionary = TranslationDictionary.fromJson(json);

      // Assert
      expect(translationDictionary.keyword, isNull);
      expect(translationDictionary.source, isNull);
      expect(translationDictionary.translation, isNull);
      expect(translationDictionary.languageId, isNull);
      expect(translationDictionary.languageCode, isNull);
    });

    test('toJson should handle empty TranslationDictionary object gracefully',
        () {
      // Arrange
      final translationDictionary = TranslationDictionary();

      // Act
      final json = translationDictionary.toJson();

      // Assert
      expect(json["keyword"], isNull);
      expect(json["source"], isNull);
      expect(json["translation"], isNull);
      expect(json["languageId"], isNull);
      expect(json["languageCode"], isNull);
    });
  });
}
