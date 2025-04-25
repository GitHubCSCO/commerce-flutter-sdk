import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_carousel/product_carousel_entity.dart';

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

class ProductCarouselWidgetEntity extends WidgetEntity {
  final ProductCarouselType? carouselType;
  final String? title;
  final int? numberOfProductsToDisplay;
  final bool? displayPartNumbers;
  final bool? displayPrice;
  final TopSellersCategoriesSpan? displayTopSellersFrom;
  final String? selectedCategoryIdsString;
  final List<String>? selectedCategoryIds;
  final bool? shouldForceLoadData;
  final List<ProductCarouselEntity>? productCarouselList;

  ProductCarouselWidgetEntity({
    String? id,
    WidgetType? type,
    String? subType,
    this.carouselType,
    this.title,
    this.numberOfProductsToDisplay,
    this.displayPartNumbers,
    this.displayPrice,
    this.displayTopSellersFrom,
    this.selectedCategoryIdsString,
    this.selectedCategoryIds,
    this.shouldForceLoadData,
    List<ProductCarouselEntity>? productCarouselList,
  })  : productCarouselList = productCarouselList ?? [],
        super(id: id, type: type, subType: subType);

  @override
  ProductCarouselWidgetEntity copyWith(
      {String? id,
      WidgetType? type,
      String? subType,
      ProductCarouselType? carouselType,
      String? title,
      int? numberOfProductsToDisplay,
      bool? displayPartNumbers,
      bool? displayPrice,
      TopSellersCategoriesSpan? displayTopSellersFrom,
      String? selectedCategoryIdsString,
      List<String>? selectedCategoryIds,
      bool? shouldForceLoadData,
      List<ProductCarouselEntity>? productCarouselList}) {
    return ProductCarouselWidgetEntity(
        id: id ?? this.id,
        type: type ?? this.type,
        subType: subType ?? this.subType,
        carouselType: carouselType ?? this.carouselType,
        title: title ?? this.title,
        numberOfProductsToDisplay:
            numberOfProductsToDisplay ?? this.numberOfProductsToDisplay,
        displayPartNumbers: displayPartNumbers ?? this.displayPartNumbers,
        displayPrice: displayPrice ?? this.displayPrice,
        displayTopSellersFrom:
            displayTopSellersFrom ?? this.displayTopSellersFrom,
        selectedCategoryIdsString:
            selectedCategoryIdsString ?? this.selectedCategoryIdsString,
        selectedCategoryIds: selectedCategoryIds ?? this.selectedCategoryIds,
        shouldForceLoadData: shouldForceLoadData ?? this.shouldForceLoadData,
        productCarouselList: productCarouselList ?? this.productCarouselList);
  }

  @override
  List<Object?> get props => [
        ...super.props,
        carouselType,
        title,
        numberOfProductsToDisplay,
        displayPartNumbers,
        displayPrice,
        displayTopSellersFrom,
        selectedCategoryIdsString,
        selectedCategoryIds,
        shouldForceLoadData,
        productCarouselList,
      ];
}
