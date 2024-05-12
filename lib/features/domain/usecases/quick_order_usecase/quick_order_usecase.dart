import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuickOrderUseCase extends BaseUseCase {
  QuickOrderUseCase() : super();

  Future<Result<ProductEntity, ErrorResponse>> getProduct(String productId, AutocompleteProduct product) async {
    var parameters = ProductQueryParameters(
      expand: "pricing,brand",
    );

    var resultResponse = await commerceAPIServiceProvider
        .getProductService()
        .getProduct(productId, parameters: parameters);

    switch (resultResponse) {
      case Success(value: final data):
        final productEntity = ProductEntityMapper().toEntity(data?.product ?? Product());
        // if (productEntity.styledProducts != null) {
        //   if (productEntity.styleParentId != null) {
        //     styledProduct = productEntity.styledProducts
        //         ?.firstWhere((o) => o.productId == productEntity.id);
        //   }
        // }
        return Success(productEntity);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<ProductEntity, ErrorResponse>> getScanProduct(String name) async {
    var parameters = ProductsQueryParameters(
      expand: [name],
    );

    var resultResponse = await commerceAPIServiceProvider
        .getProductService()
        .getProducts(parameters);

    switch (resultResponse) {
      case Success(value: final data):
        if ((data?.products ?? []).isNotEmpty && (data?.products ?? []).length == 1) {
          final productEntity = ProductEntityMapper().toEntity(data?.products![0] ?? Product());
          // if (productEntity.styledProducts != null) {
          //   if (productEntity.styleParentId != null) {
          //     styledProduct = productEntity.styledProducts
          //         ?.firstWhere((o) => o.productId == productEntity.id);
          //   }
          // }
          return Success(productEntity);
        } else {
          return const Success(null);
        }
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<GetProductResult, ErrorResponse>> getStyleProduct(String productId) async {
    var parameters = ProductQueryParameters();
    var result = await commerceAPIServiceProvider.getProductService().getProduct(productId, parameters: parameters);
    return result;
  }

  Future<Result<ProductSettings, ErrorResponse>> getProductSetting() async {
    var productSettingsResponse = await commerceAPIServiceProvider.getSettingsService().getProductSettingsAsync();
    return productSettingsResponse;
  }

  Future<Future<Result<bool, ErrorResponse>>> deleteCartLine(CartLine oldCartLine) async {
    return commerceAPIServiceProvider.getCartService().deleteCartLine(oldCartLine);
  }

  Future<Result<List<CartLine>, ErrorResponse>> addCartLineCollection(List<AddCartLine> addCartLines) async {
    return await commerceAPIServiceProvider.getCartService().addCartLineCollection(addCartLines);
  }

  Future<List<CartLine>> getCartLineCollection() async {
    var result = await commerceAPIServiceProvider.getCartService().getCartLines();
    var cartLines = result is Success
        ? (result as Success).value
        : [];
    return cartLines;
  }

  Future<bool> isAuthenticated() async {
    var result = await commerceAPIServiceProvider.getAuthenticationService().isAuthenticatedAsync();
    return result is Success ? (result as Success).value : false;
  }

}
