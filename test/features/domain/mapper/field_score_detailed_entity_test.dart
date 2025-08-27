import 'package:commerce_flutter_sdk/src/features/domain/entity/field_score_detailed_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/field_score_detailed_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  final mapper = FieldScoreDetailedEntityMapper();

  group('FieldScoreDetailedEntityMapper', () {
    test('should map FieldScoreDetailed to FieldScoreDetailedEntity correctly',
        () {
      // Arrange
      final model = FieldScoreDetailed(
        name: 'fieldName',
        score: 0.75,
        boost: 1.5,
        matchText: 'matched text',
        termFrequencyNormalized: 0.5,
        inverseDocumentFrequency: 0.25,
        scoreUsed: true,
      );

      // Act
      final entity = mapper.toEntity(model);

      // Assert
      expect(entity.name, 'fieldName');
      expect(entity.score, 0.75);
      expect(entity.boost, 1.5);
      expect(entity.matchText, 'matched text');
      expect(entity.termFrequencyNormalized, 0.5);
      expect(entity.inverseDocumentFrequency, 0.25);
      expect(entity.scoreUsed, true);
    });

    test('should map FieldScoreDetailedEntity to FieldScoreDetailed correctly',
        () {
      // Arrange
      const entity = FieldScoreDetailedEntity(
        name: 'fieldName',
        score: 0.75,
        boost: 1.5,
        matchText: 'matched text',
        termFrequencyNormalized: 0.5,
        inverseDocumentFrequency: 0.25,
        scoreUsed: true,
      );

      // Act
      final model = mapper.toModel(entity);

      // Assert
      expect(model.name, 'fieldName');
      expect(model.score, 0.75);
      expect(model.boost, 1.5);
      expect(model.matchText, 'matched text');
      expect(model.termFrequencyNormalized, 0.5);
      expect(model.inverseDocumentFrequency, 0.25);
      expect(model.scoreUsed, true);
    });

    test(
        'should handle null values correctly when mapping FieldScoreDetailed to FieldScoreDetailedEntity',
        () {
      // Arrange
      final model = FieldScoreDetailed(
        name: null,
        score: null,
        boost: null,
        matchText: null,
        termFrequencyNormalized: null,
        inverseDocumentFrequency: null,
        scoreUsed: null,
      );

      // Act
      final entity = mapper.toEntity(model);

      // Assert
      expect(entity.name, isNull);
      expect(entity.score, isNull);
      expect(entity.boost, isNull);
      expect(entity.matchText, isNull);
      expect(entity.termFrequencyNormalized, isNull);
      expect(entity.inverseDocumentFrequency, isNull);
      expect(entity.scoreUsed, isNull);
    });

    test(
        'should handle null values correctly when mapping FieldScoreDetailedEntity to FieldScoreDetailed',
        () {
      // Arrange
      const entity = FieldScoreDetailedEntity(
        name: null,
        score: null,
        boost: null,
        matchText: null,
        termFrequencyNormalized: null,
        inverseDocumentFrequency: null,
        scoreUsed: null,
      );

      // Act
      final model = mapper.toModel(entity);

      // Assert
      expect(model.name, isNull);
      expect(model.score, isNull);
      expect(model.boost, isNull);
      expect(model.matchText, isNull);
      expect(model.termFrequencyNormalized, isNull);
      expect(model.inverseDocumentFrequency, isNull);
      expect(model.scoreUsed, isNull);
    });
  });
}
