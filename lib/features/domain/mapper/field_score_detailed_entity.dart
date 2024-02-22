import 'package:commerce_flutter_app/features/domain/entity/field_score_detailed_entity.dart';
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
}
