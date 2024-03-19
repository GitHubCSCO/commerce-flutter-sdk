import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class PageWidgetTypeConverter {
  static WidgetType convert(String enumString) {
    switch (enumString.toLowerCase()) {
      case "mobile/slideshow":
      case "mobilecarousel":
        return WidgetType.mobileCarousel;
      case "mobilecarouselslide":
        return WidgetType.mobileCarouselSlide;
      case "mobile/linklist":
      case "mobilelinklist":
        return WidgetType.mobileLinkList;
      case "mobile/productcarousel":
      case "productcarousel":
        return WidgetType.productCarousel;
      case "mobile/searchhistory":
      case "mobilesearchhistory":
        return WidgetType.mobileSearchHistory;
      case "mobile/cart":
      case "mobilecart":
        return WidgetType.mobileCartButtonsWidget;
      default:
        return WidgetType.unknown;
    }
  }
}
