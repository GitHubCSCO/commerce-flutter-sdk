import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/order_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/vmi_bin_model_entity_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuickOrderUseCase extends BaseUseCase {
  QuickOrderUseCase() : super();

  Future<Result<ProductEntity, ErrorResponse>> getProduct(String productId, AutocompleteProduct product) async {
    var parameters = ProductQueryParameters(
      // expand: "pricing,brand,styledproducts",
      expand: "documents,specifications,styledproducts,htmlcontent,attributes,crosssells,pricing,brand",
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

  Future<Result<VmiBinModelEntity, ErrorResponse>> getVmiBin(String binNumber) async {
    var parameters = VmiBinQueryParameters(
      vmiLocationId : coreServiceProvider.getVmiService().currentVmiLocation?.id ?? '',
      filter : binNumber,
      expand : 'product',
    );

    var resultResponse = await commerceAPIServiceProvider
        .getVmiLocationsService()
        .getVmiBins(parameters: parameters);

    switch (resultResponse) {
      case Success(value: final data):
        if ((data?.vmiBins ?? []).isNotEmpty && (data?.vmiBins ?? []).length == 1) {
          final vmiBin = VmiBinModelEntityMapper().toEntity(data!.vmiBins[0]);
          return Success(vmiBin);
        } else {
          return const Success(null);
        }
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<ProductEntity, ErrorResponse>> getScanProduct(String name) async {
    var parameters = ProductsQueryParameters(
      extendedNames: [name],
    );

    var resultResponse = await commerceAPIServiceProvider
        .getProductService()
        .getProducts(parameters);

    switch (resultResponse) {
      case Success(value: final data):
        if ((data?.products ?? []).isNotEmpty && (data?.products ?? []).length == 1) {
          final productEntity = ProductEntityMapper().toEntity(data?.products![0] ?? Product());
          return Success(productEntity);
        } else {
          return const Success(null);
        }
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<ProductEntity, ErrorResponse>> getStyleProduct(String productId) async {
    var parameters = ProductQueryParameters();
    var result = await commerceAPIServiceProvider.getProductService().getProduct(productId, parameters: parameters);

    switch (result) {
      case Success(value: final data):
        final productEntity = ProductEntityMapper().toEntity(data?.product ?? Product());
        return Success(productEntity);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<OrderEntity, ErrorResponse>> getPreviousOrder(String vmiBinId) async {
    String vmiLocationId = coreServiceProvider.getVmiService().currentVmiLocation!.id;

    var parameters = OrdersQueryParameters(
      vmiLocationId: vmiLocationId,
      vmiBinId: vmiBinId,
      expand: ['orderlines'],
    );
    var result = await commerceAPIServiceProvider.getOrderService().getOrders(parameters);

    switch (result) {
      case Success(value: final data):
        if ((data?.orders ?? []).isNotEmpty) {
          final orderEntity = OrderEntityMapper.toEntity(data?.orders![0] ?? Order());
          return Success(orderEntity);
        } else {
          return const Success(null);
        }
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
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
