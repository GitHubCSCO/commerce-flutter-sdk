import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/mapper/product_mapper.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductCarouselUseCase extends BaseUseCase {
  ProductCarouselUseCase() : super();

  Future<Result<List<ProductEntity>, ErrorResponse>?> getProducts(
      ProductCarouselWidgetEntity productCarouselWidgetEntity) async {
    Result<List<ProductEntity>, ErrorResponse>? result;
    switch (productCarouselWidgetEntity.carouselType) {
      case ProductCarouselType.featuredCategory:
        result =
            await _getFeaturedCategoryProducts(productCarouselWidgetEntity);
      case ProductCarouselType.topSellers:
        result = await _getTopSellersProducts(productCarouselWidgetEntity);
      case ProductCarouselType.recentlyViewed:
        result = await _getRecentlyViewedProducts();
      case ProductCarouselType.webCrossSells:
        result = await _getWebsiteCrossSellsProducts();
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

  Future<Result<List<ProductEntity>, ErrorResponse>>
      _getFeaturedCategoryProducts(
          ProductCarouselWidgetEntity productCarouselWidgetEntity) async {
    var result = await commerceAPIServiceProvider
        .getProductService()
        .getProducts(_featuredCategoryParameters(productCarouselWidgetEntity));
    switch (result) {
      case Success(value: final data):
        return Success(data?.products
            ?.map((e) => ProductEntityMapper.toEntity(e))
            .toList());
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<List<ProductEntity>, ErrorResponse>> _getTopSellersProducts(
      ProductCarouselWidgetEntity productCarouselWidgetEntity) async {
    var result = await commerceAPIServiceProvider
        .getProductService()
        .getProducts(_topSellersParameters(productCarouselWidgetEntity));
    switch (result) {
      case Success(value: final data):
        return Success(data?.products
            ?.map((e) => ProductEntityMapper.toEntity(e))
            .toList());
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<List<ProductEntity>, ErrorResponse>>
      _getRecentlyViewedProducts() async {
    var result = await commerceAPIServiceProvider
        .getProductService()
        .getProducts(_recentlyViewedParameters());
    switch (result) {
      case Success(value: final data):
        return Success(data?.products
            ?.map((e) => ProductEntityMapper.toEntity(e))
            .toList());
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<List<ProductEntity>, ErrorResponse>>
      _getWebsiteCrossSellsProducts() async {
    var result =
        await commerceAPIServiceProvider.getWebsiteService().getCrosssells();

    switch (result) {
      case Success(value: final data):
        return Success(data?.products
            ?.map((e) => ProductEntityMapper.toEntity(e))
            .toList());
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  ProductsQueryParameters _featuredCategoryParameters(
      ProductCarouselWidgetEntity productCarouselWidgetEntity) {
    return ProductsQueryParameters(
      categoryId: productCarouselWidgetEntity.selectedCategoryIds?.first,
      pageSize: productCarouselWidgetEntity.numberOfProductsToDisplay,
      expand: ["pricing"],
    );
  }

  ProductsQueryParameters _topSellersParameters(
      ProductCarouselWidgetEntity productCarouselWidgetEntity) {
    List<String>? topSellersCategoryIds;
    switch (productCarouselWidgetEntity.displayTopSellersFrom) {
      case TopSellersCategoriesSpan.selectCategories:
        topSellersCategoryIds = productCarouselWidgetEntity.selectedCategoryIds;
      default:
        topSellersCategoryIds = null;
    }

    return ProductsQueryParameters(
        filter: "topsellers",
        topSellersMaxResults:
            productCarouselWidgetEntity.numberOfProductsToDisplay,
        topSellersCategoryIds: topSellersCategoryIds,
        makeBrandUrls: false,
        expand: ["brand"]);
  }

  ProductsQueryParameters _recentlyViewedParameters() {
    return ProductsQueryParameters(
        expand: ["pricing", "recentlyviewed", "brand"]);
  }
}
