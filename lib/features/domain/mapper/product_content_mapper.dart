import 'package:commerce_flutter_app/features/domain/entity/product_content_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductContentEntityMapper {
  ProductContentEntity toEntity(ProductContent? model) => ProductContentEntity(
        htmlContent: model?.htmlContent,
        metaDescription: model?.metaDescription,
        pageTitle: model?.pageTitle,
        metaKeywords: model?.metaKeywords,
        openGraphImage: model?.openGraphImage,
        openGraphTitle: model?.openGraphTitle,
        openGraphUrl: model?.openGraphUrl,
      );

  ProductContent? toModel(ProductContentEntity entity) => ProductContent(
        htmlContent: entity.htmlContent,
        metaDescription: entity.metaDescription,
        pageTitle: entity.pageTitle,
        metaKeywords: entity.metaKeywords,
        openGraphImage: entity.openGraphImage,
        openGraphTitle: entity.openGraphTitle,
        openGraphUrl: entity.openGraphUrl,
      );
}
