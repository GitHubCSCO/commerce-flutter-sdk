import 'package:commerce_flutter_sdk/src/features/domain/entity/brand.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BrandEntityMapper {
  static BrandEntity toEntity(Brand? model) => BrandEntity(
        id: model?.id,
        name: model?.name,
        urlSegment: model?.urlSegment,
        detailPagePath: model?.detailPagePath,
        logoSmallImagePath: model?.logoSmallImagePath,
        logoLargeImagePath: model?.logoLargeImagePath,
        logoAltText: model?.logoImageAltText,
        logoImageAltText: model?.logoImageAltText,
      );

  static Brand toModel(BrandEntity entity) => Brand(
        id: entity.id,
        name: entity.name,
        urlSegment: entity.urlSegment,
        detailPagePath: entity.detailPagePath,
        logoSmallImagePath: entity.logoSmallImagePath,
        logoLargeImagePath: entity.logoLargeImagePath,
        logoImageAltText: entity.logoImageAltText ?? entity.logoAltText,
      );
}

class BrandAlphabetEntityMapper {
  static BrandAlphabetEntity toEntity(BrandAlphabet? model) =>
      BrandAlphabetEntity(
        letter: model?.letter,
        count: model?.count,
      );
}
