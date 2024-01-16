import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductCarouselUseCase {
  final IProductService _productService;

  ProductCarouselUseCase(this._productService);

  Future<Result<GetProductCollectionResult, ErrorResponse>?> getProducts(
      ProductCarouselWidgetEntity productCarouselWidgetEntity) async {
    print('ProductCarouselUseCase load data');

    Result<GetProductCollectionResult, ErrorResponse>? result;
    switch(productCarouselWidgetEntity.carouselType) {
      case ProductCarouselType.featuredCategory:
        result = await _getFeaturedCategoryProducts(productCarouselWidgetEntity);
      case ProductCarouselType.topSellers:
        result = await _getTopSellersProducts(productCarouselWidgetEntity);
      case ProductCarouselType.recentlyViewed:
        result = await _getRecentlyViewedProducts();
      default:
    }

    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
      case null:
        return null;
    }
  }

  Future<Result<GetProductCollectionResult, ErrorResponse>>
      _getFeaturedCategoryProducts(
          ProductCarouselWidgetEntity productCarouselWidgetEntity) async {
    var result = await _productService
        .getProducts(_featuredCategoryParameters(productCarouselWidgetEntity));
    return result;
  }

  Future<Result<GetProductCollectionResult, ErrorResponse>>
      _getTopSellersProducts(
          ProductCarouselWidgetEntity productCarouselWidgetEntity) async {
    var result = await _productService
        .getProducts(_topSellersParameters(productCarouselWidgetEntity));
    return result;
  }

  Future<Result<GetProductCollectionResult, ErrorResponse>>
      _getRecentlyViewedProducts() async {
    var result = await _productService.getProducts(_recentlyViewedParameters());
    return result;
  }

  ProductsQueryParameters _featuredCategoryParameters(
      ProductCarouselWidgetEntity productCarouselWidgetEntity) {
    return ProductsQueryParameters(
      categoryId: productCarouselWidgetEntity.selectedCategoryIds!.first,
      pageSize: productCarouselWidgetEntity.numberOfProductsToDisplay,
      expand: ["pricing"],
    );
  }

  ProductsQueryParameters _topSellersParameters(ProductCarouselWidgetEntity productCarouselWidgetEntity) {
    List<String>? topSellersCategoryIds;
    switch(productCarouselWidgetEntity.displayTopSellersFrom) {
      case TopSellersCategoriesSpan.selectCategories:
        topSellersCategoryIds = productCarouselWidgetEntity.selectedCategoryIds;
      default:
        topSellersCategoryIds = null;
    }

    return ProductsQueryParameters(
      filter: "topsellers",
      topSellersMaxResults: productCarouselWidgetEntity.numberOfProductsToDisplay,
      topSellersCategoryIds: topSellersCategoryIds,
      makeBrandUrls: false,
      expand: ["brand"]
    );
  }

  ProductsQueryParameters _recentlyViewedParameters() {
    return ProductsQueryParameters(
        expand: ["pricing", "recentlyviewed", "brand"]);
  }
}
