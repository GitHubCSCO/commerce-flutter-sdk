import 'package:commerce_flutter_app/features/domain/entity/score_explanation_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/field_score_detailed_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/field_score_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ScoreExplanationEntityMapper {
  ScoreExplanationEntity toEntity(ScoreExplanation? model) =>
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
}
