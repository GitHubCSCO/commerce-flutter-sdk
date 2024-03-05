import 'package:commerce_flutter_app/features/domain/entity/field_score_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class FieldScoreEntityMapper {
  FieldScoreEntity toEntity(FieldScore model) => FieldScoreEntity(
        name: model.name,
        score: model.score,
      );
}
