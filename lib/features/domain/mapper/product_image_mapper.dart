import 'package:commerce_flutter_sdk/features/domain/entity/product_image_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductImageEntityMapper {
  static ProductImageEntity toEntity(ProductImage model) => ProductImageEntity(
        id: model.id,
        sortOrder: model.sortOrder,
        name: model.name,
        smallImagePath: model.smallImagePath,
        mediumImagePath: model.mediumImagePath,
        largeImagePath: model.largeImagePath,
        altText: model.altText,
        imageType: model.imageType,
      );
  static ProductImage toModel(ProductImageEntity entity) => ProductImage(
        id: entity.id,
        sortOrder: entity.sortOrder,
        name: entity.name,
        smallImagePath: entity.smallImagePath,
        mediumImagePath: entity.mediumImagePath,
        largeImagePath: entity.largeImagePath,
        altText: entity.altText,
        imageType: entity.imageType,
      );
}
