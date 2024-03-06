import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';

class ProductCarouselTypeConverter {
  static ProductCarouselType convert(String enumString) {
    switch (enumString.toLowerCase()) {
      case "featuredcategory":
        return ProductCarouselType.featuredCategory;
      case "recentlyviewed":
        return ProductCarouselType.recentlyViewed;
      case "topsellers":
        return ProductCarouselType.topSellers;
      case "webcrosssells":
      case "crosssells":
        return ProductCarouselType.webCrossSells;
      default:
        return ProductCarouselType.unknown;
    }
  }
}
