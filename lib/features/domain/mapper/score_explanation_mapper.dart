import 'package:commerce_flutter_sdk/features/domain/entity/score_explanation_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/mapper/field_score_detailed_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/mapper/field_score_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ScoreExplanationEntityMapper {
  static ScoreExplanationEntity toEntity(ScoreExplanation? model) =>
      ScoreExplanationEntity(
        totalBoost: model?.totalBoost,
        aggregateFieldScores: model?.aggregateFieldScores
            ?.map((fieldScore) => FieldScoreEntityMapper().toEntity(fieldScore))
            .toList(),
        detailedFieldScores: model?.detailedFieldScores
            ?.map((fieldScoreDetailed) =>
                FieldScoreDetailedEntityMapper().toEntity(fieldScoreDetailed))
            .toList(),
      );

  static ScoreExplanation? toModel(ScoreExplanationEntity entity) =>
      ScoreExplanation(
        totalBoost: entity.totalBoost,
        aggregateFieldScores: entity.aggregateFieldScores
            ?.map((fieldScoreEntity) =>
                FieldScoreEntityMapper().toModel(fieldScoreEntity))
            .toList(),
        detailedFieldScores: entity.detailedFieldScores
            ?.map((fieldScoreDetailedEntity) => FieldScoreDetailedEntityMapper()
                .toModel(fieldScoreDetailedEntity))
            .toList(),
      );
}
