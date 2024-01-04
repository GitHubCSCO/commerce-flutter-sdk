import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/recent_bin_note_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';

enum TopSellersCategoriesSpan {
  unknown,
  allCategories,
  selectCategories,
}

enum ProductCarouselType {
  unknown,
  featuredCategory,
  recentlyViewed,
  topSellers,
  webCrossSells,
}

class ProductCarouselWidget extends WidgetEntity {
  final ProductCarouselType carouselType;
  final String title;
  final int numberOfProductsToDisplay;
  final bool displayPartNumbers;
  final bool displayPrice;
  final TopSellersCategoriesSpan displayTopSellersFrom;
  final String selectedCategoryIdsString;
  final List<String> selectedCategoryIds;
  final bool shouldForceLoadData;

  const ProductCarouselWidget({
    required this.carouselType,
    required this.title,
    required this.numberOfProductsToDisplay,
    required this.displayPartNumbers,
    required this.displayPrice,
    required this.displayTopSellersFrom,
    required this.selectedCategoryIdsString,
    required this.selectedCategoryIds,
    required this.shouldForceLoadData,
  });

  @override
  List<Object?> get props => [
        carouselType,
        title,
        numberOfProductsToDisplay,
        displayPartNumbers,
        displayPrice,
        displayTopSellersFrom,
        selectedCategoryIdsString,
        selectedCategoryIds,
        shouldForceLoadData,
      ];
}
