import 'package:commerce_flutter_sdk/src/features/domain/entity/field_score_detailed_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/field_score_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/score_explanation_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/mapper/score_explanation_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

void main() {
  group('ScoreExplanationEntityMapper', () {
    group('toEntity', () {
      test('should map ScoreExplanation to ScoreExplanationEntity correctly',
          () {
        // Arrange
        final aggregateFieldScores = [
          FieldScore(name: 'field1', score: 1.5),
          FieldScore(name: 'field2', score: 2.0),
        ];

        final detailedFieldScores = [
          FieldScoreDetailed(
            name: 'detailedField1',
            score: 3.0,
            boost: 1.2,
            matchText: 'match text 1',
            termFrequencyNormalized: 0.8,
            inverseDocumentFrequency: 2.5,
            scoreUsed: true,
          ),
          FieldScoreDetailed(
            name: 'detailedField2',
            score: 4.0,
            boost: 1.5,
            matchText: 'match text 2',
            termFrequencyNormalized: 0.9,
            inverseDocumentFrequency: 3.0,
            scoreUsed: false,
          ),
        ];

        final scoreExplanation = ScoreExplanation(
          totalBoost: 10.5,
          aggregateFieldScores: aggregateFieldScores,
          detailedFieldScores: detailedFieldScores,
        );

        // Act
        final result = ScoreExplanationEntityMapper.toEntity(scoreExplanation);

        // Assert
        expect(result.totalBoost, equals(10.5));
        expect(result.aggregateFieldScores?.length, equals(2));
        expect(result.aggregateFieldScores?[0].name, equals('field1'));
        expect(result.aggregateFieldScores?[0].score, equals(1.5));
        expect(result.aggregateFieldScores?[1].name, equals('field2'));
        expect(result.aggregateFieldScores?[1].score, equals(2.0));

        expect(result.detailedFieldScores?.length, equals(2));
        expect(result.detailedFieldScores?[0].name, equals('detailedField1'));
        expect(result.detailedFieldScores?[0].score, equals(3.0));
        expect(result.detailedFieldScores?[0].boost, equals(1.2));
        expect(
            result.detailedFieldScores?[0].matchText, equals('match text 1'));
        expect(result.detailedFieldScores?[0].termFrequencyNormalized,
            equals(0.8));
        expect(result.detailedFieldScores?[0].inverseDocumentFrequency,
            equals(2.5));
        expect(result.detailedFieldScores?[0].scoreUsed, equals(true));

        expect(result.detailedFieldScores?[1].name, equals('detailedField2'));
        expect(result.detailedFieldScores?[1].score, equals(4.0));
        expect(result.detailedFieldScores?[1].boost, equals(1.5));
        expect(
            result.detailedFieldScores?[1].matchText, equals('match text 2'));
        expect(result.detailedFieldScores?[1].termFrequencyNormalized,
            equals(0.9));
        expect(result.detailedFieldScores?[1].inverseDocumentFrequency,
            equals(3.0));
        expect(result.detailedFieldScores?[1].scoreUsed, equals(false));
      });

      test('should handle null ScoreExplanation', () {
        // Act
        final result = ScoreExplanationEntityMapper.toEntity(null);

        // Assert
        expect(result.totalBoost, isNull);
        expect(result.aggregateFieldScores, isNull);
        expect(result.detailedFieldScores, isNull);
      });

      test('should handle ScoreExplanation with null fields', () {
        // Arrange
        final scoreExplanation = ScoreExplanation(
          totalBoost: null,
          aggregateFieldScores: null,
          detailedFieldScores: null,
        );

        // Act
        final result = ScoreExplanationEntityMapper.toEntity(scoreExplanation);

        // Assert
        expect(result.totalBoost, isNull);
        expect(result.aggregateFieldScores, isNull);
        expect(result.detailedFieldScores, isNull);
      });

      test('should handle ScoreExplanation with empty lists', () {
        // Arrange
        final scoreExplanation = ScoreExplanation(
          totalBoost: 5.0,
          aggregateFieldScores: [],
          detailedFieldScores: [],
        );

        // Act
        final result = ScoreExplanationEntityMapper.toEntity(scoreExplanation);

        // Assert
        expect(result.totalBoost, equals(5.0));
        expect(result.aggregateFieldScores, isEmpty);
        expect(result.detailedFieldScores, isEmpty);
      });
    });

    group('toModel', () {
      test('should map ScoreExplanationEntity to ScoreExplanation correctly',
          () {
        // Arrange
        final aggregateFieldScores = [
          const FieldScoreEntity(name: 'field1', score: 1.5),
          const FieldScoreEntity(name: 'field2', score: 2.0),
        ];

        final detailedFieldScores = [
          const FieldScoreDetailedEntity(
            name: 'detailedField1',
            score: 3.0,
            boost: 1.2,
            matchText: 'match text 1',
            termFrequencyNormalized: 0.8,
            inverseDocumentFrequency: 2.5,
            scoreUsed: true,
          ),
          const FieldScoreDetailedEntity(
            name: 'detailedField2',
            score: 4.0,
            boost: 1.5,
            matchText: 'match text 2',
            termFrequencyNormalized: 0.9,
            inverseDocumentFrequency: 3.0,
            scoreUsed: false,
          ),
        ];

        final scoreExplanationEntity = ScoreExplanationEntity(
          totalBoost: 10.5,
          aggregateFieldScores: aggregateFieldScores,
          detailedFieldScores: detailedFieldScores,
        );

        // Act
        final result =
            ScoreExplanationEntityMapper.toModel(scoreExplanationEntity);

        // Assert
        expect(result?.totalBoost, equals(10.5));
        expect(result?.aggregateFieldScores?.length, equals(2));
        expect(result?.aggregateFieldScores?[0].name, equals('field1'));
        expect(result?.aggregateFieldScores?[0].score, equals(1.5));
        expect(result?.aggregateFieldScores?[1].name, equals('field2'));
        expect(result?.aggregateFieldScores?[1].score, equals(2.0));

        expect(result?.detailedFieldScores?.length, equals(2));
        expect(result?.detailedFieldScores?[0].name, equals('detailedField1'));
        expect(result?.detailedFieldScores?[0].score, equals(3.0));
        expect(result?.detailedFieldScores?[0].boost, equals(1.2));
        expect(
            result?.detailedFieldScores?[0].matchText, equals('match text 1'));
        expect(result?.detailedFieldScores?[0].termFrequencyNormalized,
            equals(0.8));
        expect(result?.detailedFieldScores?[0].inverseDocumentFrequency,
            equals(2.5));
        expect(result?.detailedFieldScores?[0].scoreUsed, equals(true));

        expect(result?.detailedFieldScores?[1].name, equals('detailedField2'));
        expect(result?.detailedFieldScores?[1].score, equals(4.0));
        expect(result?.detailedFieldScores?[1].boost, equals(1.5));
        expect(
            result?.detailedFieldScores?[1].matchText, equals('match text 2'));
        expect(result?.detailedFieldScores?[1].termFrequencyNormalized,
            equals(0.9));
        expect(result?.detailedFieldScores?[1].inverseDocumentFrequency,
            equals(3.0));
        expect(result?.detailedFieldScores?[1].scoreUsed, equals(false));
      });

      test('should handle ScoreExplanationEntity with null fields', () {
        // Arrange
        const scoreExplanationEntity = ScoreExplanationEntity(
          totalBoost: null,
          aggregateFieldScores: null,
          detailedFieldScores: null,
        );

        // Act
        final result =
            ScoreExplanationEntityMapper.toModel(scoreExplanationEntity);

        // Assert
        expect(result?.totalBoost, isNull);
        expect(result?.aggregateFieldScores, isNull);
        expect(result?.detailedFieldScores, isNull);
      });

      test('should handle ScoreExplanationEntity with empty lists', () {
        // Arrange
        const scoreExplanationEntity = ScoreExplanationEntity(
          totalBoost: 5.0,
          aggregateFieldScores: [],
          detailedFieldScores: [],
        );

        // Act
        final result =
            ScoreExplanationEntityMapper.toModel(scoreExplanationEntity);

        // Assert
        expect(result?.totalBoost, equals(5.0));
        expect(result?.aggregateFieldScores, isEmpty);
        expect(result?.detailedFieldScores, isEmpty);
      });
    });

    group('roundtrip conversion', () {
      test(
          'should maintain data integrity through toEntity -> toModel conversion',
          () {
        // Arrange
        final original = ScoreExplanation(
          totalBoost: 15.7,
          aggregateFieldScores: [
            FieldScore(name: 'title', score: 8.2),
            FieldScore(name: 'description', score: 3.4),
            FieldScore(name: 'brand', score: 2.1),
          ],
          detailedFieldScores: [
            FieldScoreDetailed(
              name: 'title_detailed',
              score: 8.2,
              boost: 2.0,
              matchText: 'laptop computer',
              termFrequencyNormalized: 0.95,
              inverseDocumentFrequency: 4.2,
              scoreUsed: true,
            ),
            FieldScoreDetailed(
              name: 'description_detailed',
              score: 3.4,
              boost: 1.0,
              matchText: 'high performance',
              termFrequencyNormalized: 0.67,
              inverseDocumentFrequency: 2.8,
              scoreUsed: true,
            ),
          ],
        );

        // Act
        final entity = ScoreExplanationEntityMapper.toEntity(original);
        final converted = ScoreExplanationEntityMapper.toModel(entity);

        // Assert
        expect(converted?.totalBoost, equals(original.totalBoost));
        expect(converted?.aggregateFieldScores?.length,
            equals(original.aggregateFieldScores?.length));
        expect(converted?.detailedFieldScores?.length,
            equals(original.detailedFieldScores?.length));

        // Check aggregate field scores
        for (int i = 0; i < (original.aggregateFieldScores?.length ?? 0); i++) {
          expect(converted?.aggregateFieldScores?[i].name,
              equals(original.aggregateFieldScores?[i].name));
          expect(converted?.aggregateFieldScores?[i].score,
              equals(original.aggregateFieldScores?[i].score));
        }

        // Check detailed field scores
        for (int i = 0; i < (original.detailedFieldScores?.length ?? 0); i++) {
          expect(converted?.detailedFieldScores?[i].name,
              equals(original.detailedFieldScores?[i].name));
          expect(converted?.detailedFieldScores?[i].score,
              equals(original.detailedFieldScores?[i].score));
          expect(converted?.detailedFieldScores?[i].boost,
              equals(original.detailedFieldScores?[i].boost));
          expect(converted?.detailedFieldScores?[i].matchText,
              equals(original.detailedFieldScores?[i].matchText));
          expect(converted?.detailedFieldScores?[i].termFrequencyNormalized,
              equals(original.detailedFieldScores?[i].termFrequencyNormalized));
          expect(
              converted?.detailedFieldScores?[i].inverseDocumentFrequency,
              equals(
                  original.detailedFieldScores?[i].inverseDocumentFrequency));
          expect(converted?.detailedFieldScores?[i].scoreUsed,
              equals(original.detailedFieldScores?[i].scoreUsed));
        }
      });

      test(
          'should maintain data integrity through toModel -> toEntity conversion',
          () {
        // Arrange
        const original = ScoreExplanationEntity(
          totalBoost: 12.3,
          aggregateFieldScores: [
            FieldScoreEntity(name: 'category', score: 5.5),
            FieldScoreEntity(name: 'tags', score: 1.8),
          ],
          detailedFieldScores: [
            FieldScoreDetailedEntity(
              name: 'category_detailed',
              score: 5.5,
              boost: 1.5,
              matchText: 'electronics',
              termFrequencyNormalized: 0.82,
              inverseDocumentFrequency: 3.7,
              scoreUsed: false,
            ),
          ],
        );

        // Act
        final model = ScoreExplanationEntityMapper.toModel(original);
        final converted = ScoreExplanationEntityMapper.toEntity(model);

        // Assert
        expect(converted.totalBoost, equals(original.totalBoost));
        expect(converted.aggregateFieldScores?.length,
            equals(original.aggregateFieldScores?.length));
        expect(converted.detailedFieldScores?.length,
            equals(original.detailedFieldScores?.length));

        // Check aggregate field scores
        for (int i = 0; i < (original.aggregateFieldScores?.length ?? 0); i++) {
          expect(converted.aggregateFieldScores?[i].name,
              equals(original.aggregateFieldScores?[i].name));
          expect(converted.aggregateFieldScores?[i].score,
              equals(original.aggregateFieldScores?[i].score));
        }

        // Check detailed field scores
        for (int i = 0; i < (original.detailedFieldScores?.length ?? 0); i++) {
          expect(converted.detailedFieldScores?[i].name,
              equals(original.detailedFieldScores?[i].name));
          expect(converted.detailedFieldScores?[i].score,
              equals(original.detailedFieldScores?[i].score));
          expect(converted.detailedFieldScores?[i].boost,
              equals(original.detailedFieldScores?[i].boost));
          expect(converted.detailedFieldScores?[i].matchText,
              equals(original.detailedFieldScores?[i].matchText));
          expect(converted.detailedFieldScores?[i].termFrequencyNormalized,
              equals(original.detailedFieldScores?[i].termFrequencyNormalized));
          expect(
              converted.detailedFieldScores?[i].inverseDocumentFrequency,
              equals(
                  original.detailedFieldScores?[i].inverseDocumentFrequency));
          expect(converted.detailedFieldScores?[i].scoreUsed,
              equals(original.detailedFieldScores?[i].scoreUsed));
        }
      });
    });

    group('edge cases', () {
      test('should handle negative scores and boosts', () {
        // Arrange
        final scoreExplanation = ScoreExplanation(
          totalBoost: -2.5,
          aggregateFieldScores: [
            FieldScore(name: 'penalty_field', score: -1.0),
          ],
          detailedFieldScores: [
            FieldScoreDetailed(
              name: 'penalty_detailed',
              score: -3.0,
              boost: -0.5,
              matchText: 'excluded term',
              termFrequencyNormalized: 0.0,
              inverseDocumentFrequency: 0.1,
              scoreUsed: false,
            ),
          ],
        );

        // Act
        final entity = ScoreExplanationEntityMapper.toEntity(scoreExplanation);
        final converted = ScoreExplanationEntityMapper.toModel(entity);

        // Assert
        expect(entity.totalBoost, equals(-2.5));
        expect(entity.aggregateFieldScores?[0].score, equals(-1.0));
        expect(entity.detailedFieldScores?[0].score, equals(-3.0));
        expect(entity.detailedFieldScores?[0].boost, equals(-0.5));
        expect(converted?.totalBoost, equals(-2.5));
      });

      test('should handle zero values', () {
        // Arrange
        final scoreExplanation = ScoreExplanation(
          totalBoost: 0.0,
          aggregateFieldScores: [
            FieldScore(name: 'zero_field', score: 0.0),
          ],
          detailedFieldScores: [
            FieldScoreDetailed(
              name: 'zero_detailed',
              score: 0.0,
              boost: 0.0,
              matchText: '',
              termFrequencyNormalized: 0.0,
              inverseDocumentFrequency: 0.0,
              scoreUsed: false,
            ),
          ],
        );

        // Act
        final entity = ScoreExplanationEntityMapper.toEntity(scoreExplanation);

        // Assert
        expect(entity.totalBoost, equals(0.0));
        expect(entity.aggregateFieldScores?[0].score, equals(0.0));
        expect(entity.detailedFieldScores?[0].score, equals(0.0));
        expect(entity.detailedFieldScores?[0].boost, equals(0.0));
        expect(entity.detailedFieldScores?[0].matchText, equals(''));
        expect(entity.detailedFieldScores?[0].termFrequencyNormalized,
            equals(0.0));
        expect(entity.detailedFieldScores?[0].inverseDocumentFrequency,
            equals(0.0));
      });
    });
  });
}
