import 'package:commerce_flutter_sdk/src/features/domain/entity/product_line_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductLineEntityMapper {
  static ProductLineEntity toEntity(ProductLine? model) => ProductLineEntity(
        id: model?.id,
        name: model?.name,
        count: null,
        selected: null,
      );

  static ProductLine? toModel(ProductLineEntity entity) => ProductLine(
        id: entity.id,
        name: entity.name,
      );
}
