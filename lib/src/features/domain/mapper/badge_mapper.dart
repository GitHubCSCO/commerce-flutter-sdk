import 'package:commerce_flutter_sdk/src/features/domain/entity/badge_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BadgeEntityMapper {
  static BadgeEntity toEntity(Badge model) => BadgeEntity(
        id: model.id,
        name: model.name,
        tagName: model.tagName,
        badgeStyle: model.badgeStyle,
        sortOrder: model.sortOrder,
        badgeType: model.badgeType,
        displayOnProductImages: model.displayOnProductImages,
        displayOnBadgeWidget: model.displayOnBadgeWidget,
        displayText: model.displayText,
        textColorHexCode: model.textColorHexCode,
        badgeColorHexCode: model.badgeColorHexCode,
        largeImageBadgePath: model.largeImageBadgePath,
        largeImageTextSize: model.largeImageTextSize,
        largeImagePlacement: model.largeImagePlacement,
        otherImageBadgePath: model.otherImageBadgePath,
        otherImageTextSize: model.otherImageTextSize,
        otherImagePlacement: model.otherImagePlacement,
        imageAltText: model.imageAltText,
        detailWidgetBadgeSize: model.detailWidgetBadgeSize,
      );

  static Badge toModel(BadgeEntity entity) => Badge(
        id: entity.id,
        name: entity.name,
        tagName: entity.tagName,
        badgeStyle: entity.badgeStyle,
        sortOrder: entity.sortOrder,
        badgeType: entity.badgeType,
        displayOnProductImages: entity.displayOnProductImages,
        displayOnBadgeWidget: entity.displayOnBadgeWidget,
        displayText: entity.displayText,
        textColorHexCode: entity.textColorHexCode,
        badgeColorHexCode: entity.badgeColorHexCode,
        largeImageBadgePath: entity.largeImageBadgePath,
        largeImageTextSize: entity.largeImageTextSize,
        largeImagePlacement: entity.largeImagePlacement,
        otherImageBadgePath: entity.otherImageBadgePath,
        otherImageTextSize: entity.otherImageTextSize,
        otherImagePlacement: entity.otherImagePlacement,
        imageAltText: entity.imageAltText,
        detailWidgetBadgeSize: entity.detailWidgetBadgeSize,
      );
}
