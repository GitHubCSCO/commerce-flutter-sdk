import 'package:commerce_flutter_sdk/src/features/domain/entity/field_score_detailed_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class FieldScoreDetailedEntityMapper {
  FieldScoreDetailedEntity toEntity(FieldScoreDetailed model) =>
      FieldScoreDetailedEntity(
        name: model.name,
        score: model.score,
        boost: model.boost,
        matchText: model.matchText,
        termFrequencyNormalized: model.termFrequencyNormalized,
        inverseDocumentFrequency: model.inverseDocumentFrequency,
        scoreUsed: model.scoreUsed,
      );

  FieldScoreDetailed toModel(FieldScoreDetailedEntity entity) =>
      FieldScoreDetailed(
        name: entity.name,
        score: entity.score,
        boost: entity.boost,
        matchText: entity.matchText,
        termFrequencyNormalized: entity.termFrequencyNormalized,
        inverseDocumentFrequency: entity.inverseDocumentFrequency,
        scoreUsed: entity.scoreUsed,
      );
}
