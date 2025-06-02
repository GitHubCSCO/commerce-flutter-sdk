import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:test/test.dart';

void main() {
  group('SuggestionDto', () {
    test('fromJson should correctly deserialize JSON to SuggestionDto object',
        () {
      // Arrange
      final json = {
        "highlightedSuggestion": "best suggestion",
        "score": 9.5,
        "suggestion": "Try this option",
      };

      // Act
      final suggestionDto = SuggestionDto.fromJson(json);

      // Assert
      expect(suggestionDto.highlightedSuggestion, "best suggestion");
      expect(suggestionDto.score, 9.5);
      expect(suggestionDto.suggestion, "Try this option");
    });

    test('toJson should correctly serialize SuggestionDto object to JSON', () {
      // Arrange
      final suggestionDto = SuggestionDto(
        highlightedSuggestion: "best suggestion",
        score: 9.5,
        suggestion: "Try this option",
      );

      // Act
      final json = suggestionDto.toJson();

      // Assert
      expect(json["highlightedSuggestion"], "best suggestion");
      expect(json["score"], 9.5);
      expect(json["suggestion"], "Try this option");
    });

    test('fromJson should handle empty JSON gracefully', () {
      // Arrange
      Map<String, dynamic> json = {};

      // Act
      final suggestionDto = SuggestionDto.fromJson(json);

      // Assert
      expect(suggestionDto.highlightedSuggestion, isNull);
      expect(suggestionDto.score, isNull);
      expect(suggestionDto.suggestion, isNull);
    });

    test('toJson should handle empty SuggestionDto object gracefully', () {
      // Arrange
      final suggestionDto = SuggestionDto();

      // Act
      final json = suggestionDto.toJson();

      // Assert
      expect(json["highlightedSuggestion"], isNull);
      expect(json["score"], isNull);
      expect(json["suggestion"], isNull);
    });
  });
}
