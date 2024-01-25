import 'package:commerce_flutter_app/features/domain/entity/brand.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandEntityMapper {
  BrandEntity toEntity(Brand model) => BrandEntity(
        id: model.id,
        name: model.name,
        manufacturer: model.manufacturer,
        externalUrl: model.externalUrl,
        detailPagePath: model.detailPagePath,
        productListPagePage: model.productListPagePage,
        logoSmallImagePath: model.logoSmallImagePath,
        logoLargeImagePath: model.logoLargeImagePath,
        logoAltText: model.logoAltText,
        featuredImagePath: model.featuredImagePath,
        featuredImageAltText: model.featuredImageAltText,
        htmlContent: model.htmlContent,
        topSellerProducts: model.topSellerProducts
            ?.map((e) => ProductEntityMapper().toEntity(e))
            .toList(),
      );
}

class BrandAlphabetEntityMapper {
  BrandAlphabetEntity toEntity(BrandAlphabet model) => BrandAlphabetEntity(
        letter: model.letter,
        count: model.count,
      );
}
