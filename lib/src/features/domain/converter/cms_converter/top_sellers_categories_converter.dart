import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';

class TopSellersCategoriesSpanConverter {
  static TopSellersCategoriesSpan convert(String enumString) {
    switch (enumString.toLowerCase()) {
      case "allcategories":
        return TopSellersCategoriesSpan.allCategories;
      case "selectcategories":
        return TopSellersCategoriesSpan.selectCategories;
      default:
        return TopSellersCategoriesSpan.unknown;
    }
  }
}
