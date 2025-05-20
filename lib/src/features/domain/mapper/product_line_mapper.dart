import 'package:commerce_flutter_sdk/src/features/domain/entity/product_line_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductLineEntityMapper {
  static ProductLineEntity toEntity(ProductLine? model) => ProductLineEntity(
        id: model?.id,
        name: model?.name,
        count: model?.count,
        selected: model?.selected,
      );

  static ProductLine? toModel(ProductLineEntity entity) => ProductLine(
        id: entity.id,
        name: entity.name,
        count: entity.count,
        selected: entity.selected,
      );
}
