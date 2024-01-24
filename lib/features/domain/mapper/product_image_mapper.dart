import 'package:commerce_flutter_app/features/domain/entity/product_image_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductImageEntityMapper {
  ProductImageEntity toEntity(ProductImage model) => ProductImageEntity(
        id: model.id,
        sortOrder: model.sortOrder,
        name: model.name,
        smallImagePath: model.smallImagePath,
        mediumImagePath: model.mediumImagePath,
        largeImagePath: model.largeImagePath,
        altText: model.altText,
        imageType: model.imageType,
      );
}
