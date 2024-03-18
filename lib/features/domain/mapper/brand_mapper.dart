import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandEntityMapper {
  BrandEntity toEntity(Brand? model) => BrandEntity(
        id: model?.id,
        name: model?.name,
        manufacturer: model?.manufacturer,
        externalUrl: model?.externalUrl,
        detailPagePath: model?.detailPagePath,
        productListPagePage: model?.productListPagePage,
        logoSmallImagePath: model?.logoSmallImagePath,
        logoLargeImagePath: model?.logoLargeImagePath,
        logoAltText: model?.logoAltText,
        featuredImagePath: model?.featuredImagePath,
        featuredImageAltText: model?.featuredImageAltText,
        htmlContent: model?.htmlContent,
        topSellerProducts: model?.topSellerProducts
            ?.map((e) => ProductEntityMapper().toEntity(e))
            .toList(),
      );

  Brand toModel(BrandEntity entity) => Brand(
        id: entity.id,
        name: entity.name,
        manufacturer: entity.manufacturer,
        externalUrl: entity.externalUrl,
        detailPagePath: entity.detailPagePath,
        productListPagePage: entity.productListPagePage,
        logoSmallImagePath: entity.logoSmallImagePath,
        logoLargeImagePath: entity.logoLargeImagePath,
        logoAltText: entity.logoAltText,
        featuredImagePath: entity.featuredImagePath,
        featuredImageAltText: entity.featuredImageAltText,
        htmlContent: entity.htmlContent,
        topSellerProducts: entity.topSellerProducts
            ?.map((e) => ProductEntityMapper().toModel(e))
            .toList(),
      );
}

class BrandAlphabetEntityMapper {
  BrandAlphabetEntity toEntity(BrandAlphabet? model) => BrandAlphabetEntity(
        letter: model?.letter,
        count: model?.count,
      );
}
