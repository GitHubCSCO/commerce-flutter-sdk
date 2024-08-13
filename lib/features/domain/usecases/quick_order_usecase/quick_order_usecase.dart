import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/vmi_bin_model_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/order_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/vmi_bin_model_entity_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class QuickOrderUseCase extends BaseUseCase {
  QuickOrderUseCase() : super();

  Future<void> createAlternateCart() async {
    final vmiLocationId =
        coreServiceProvider.getVmiService().currentVmiLocation?.id ?? '';
    final addCartModel = AddCartModel(
      vmiLocationId: vmiLocationId,
    );

    await commerceAPIServiceProvider
        .getCartService()
        .createAlternateCart(addCartModel);
  }

  Future<void> removeAlternateCart() async {
    await commerceAPIServiceProvider
        .getClientService()
        .removeAlternateCartCookie();
  }

  Future<Result<ProductEntity, ErrorResponse>> getProduct(
      String productId, AutocompleteProduct product) async {
    var parameters = ProductQueryParameters(
      // expand: "pricing,brand,styledproducts",
      expand:
          "documents,specifications,styledproducts,htmlcontent,attributes,crosssells,pricing,brand",
    );

    var resultResponse = await commerceAPIServiceProvider
        .getProductService()
        .getProduct(productId, parameters: parameters);

    switch (resultResponse) {
      case Success(value: final data):
        final productEntity =
            ProductEntityMapper().toEntity(data?.product ?? Product());
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

  Future<Result<VmiBinModelEntity, ErrorResponse>> getVmiBin(
      String? binNumber) async {
    var parameters = VmiBinQueryParameters(
      vmiLocationId:
          coreServiceProvider.getVmiService().currentVmiLocation?.id ?? '',
      searchCriteria: binNumber,
      expand: 'product',
    );

    var resultResponse = await commerceAPIServiceProvider
        .getVmiLocationsService()
        .getVmiBins(parameters: parameters);

    switch (resultResponse) {
      case Success(value: final data):
        if ((data?.vmiBins ?? []).isNotEmpty &&
            (data?.vmiBins ?? []).length == 1) {
          final vmiBin = VmiBinModelEntityMapper().toEntity(data!.vmiBins[0]);
          return Success(vmiBin);
        } else {
          return const Success(null);
        }
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<ProductEntity, ErrorResponse>> getScanProduct(
      String? name, BarcodeFormat? barcodeFormat) async {
    var parameters = ProductsQueryParameters(
      extendedNames: [name ?? ''],
    );

    var resultResponse = await commerceAPIServiceProvider
        .getProductService()
        .getProducts(parameters);
    int totalItemCount =
        resultResponse.getResultSuccessValue()?.pagination?.totalItemCount ?? 0;
    //This is a workaround for ICM-4422 where leading 0 in EAN-13 code gets dropped by the MLKit
    if (totalItemCount == 0 && barcodeFormat != null) {
      /*
        For example we have a product: 012546011099
        It's UPC-A will be: 0-12546-01109-9
        It's EAN-13 will be: 0-125460-110998
        When we scan UPC-A, it return successfully and we get 012546011099 and barcode format is BarcodeFormat.upca
        But, when we scan EAN-13, it returns 125460110998 and barcode format is BarcodeFormat.upca
        */
      if ((barcodeFormat == BarcodeFormat.ean13 ||
              barcodeFormat == BarcodeFormat.upca) &&
          name?.length == 12) {
        //since in both cases result text is 12 digit it's difficult to know whether it's upc-a or ean13
        //upc-a can also have non-zero leading digit, since we didn't find any result with that
        //let's assume it's ean-13
        if (name?[0] != '0') {
          parameters = ProductsQueryParameters(
            extendedNames: ["0$name"],
          );
          resultResponse = await commerceAPIServiceProvider
              .getProductService()
              .getProducts(parameters);
        }
      }
    }

    switch (resultResponse) {
      case Success(value: final data):
        final products = data?.products ?? [];
        if (products.isNotEmpty) {
          final product = products[0];
          if (product.isStyleProductParent ?? false) {
            var parameters = ProductQueryParameters(expand: "styledproducts");

            var result = (await commerceAPIServiceProvider
                    .getProductService()
                    .getProduct(product.id ?? '', parameters: parameters))
                .getResultSuccessValue();

            if (result?.product != null) {
              final productEntity =
                  ProductEntityMapper().toEntity(result!.product!);
              return Success(productEntity);
            }
          } else {
            final productEntity = ProductEntityMapper().toEntity(product);
            return Success(productEntity);
          }
        }
        return const Success(null);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<ProductEntity, ErrorResponse>> getStyleProduct(
      String productId) async {
    var parameters = ProductQueryParameters();
    var result = await commerceAPIServiceProvider
        .getProductService()
        .getProduct(productId, parameters: parameters);

    switch (result) {
      case Success(value: final data):
        final productEntity =
            ProductEntityMapper().toEntity(data?.product ?? Product());
        return Success(productEntity);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<OrderEntity, ErrorResponse>> getPreviousOrder(
      String vmiBinId) async {
    String vmiLocationId =
        coreServiceProvider.getVmiService().currentVmiLocation!.id;

    var parameters = OrdersQueryParameters(
      vmiLocationId: vmiLocationId,
      vmiBinId: vmiBinId,
      expand: ['orderlines'],
    );
    var result = await commerceAPIServiceProvider
        .getOrderService()
        .getOrders(parameters);

    switch (result) {
      case Success(value: final data):
        if ((data?.orders ?? []).isNotEmpty) {
          final orderEntity =
              OrderEntityMapper.toEntity(data?.orders![0] ?? Order());
          return Success(orderEntity);
        } else {
          return const Success(null);
        }
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<Cart, ErrorResponse>> getCart() async {
    // cart get for IsAcceptQuote is different,, need to implement it later
    var cartParameters = CartQueryParameters(expand: [
      'cartlines',
      'costcodes',
      'shipping',
      'tax',
      'carriers',
      'paymentoptions'
    ]);
    return await commerceAPIServiceProvider
        .getCartService()
        .getCurrentCart(cartParameters);
  }

  Future<Result<ProductSettings, ErrorResponse>> getProductSetting() async {
    var productSettingsResponse = await commerceAPIServiceProvider
        .getSettingsService()
        .getProductSettingsAsync();
    return productSettingsResponse;
  }

  Future<Future<Result<bool, ErrorResponse>>> deleteCartLine(
      CartLine oldCartLine) async {
    return commerceAPIServiceProvider
        .getCartService()
        .deleteCartLine(oldCartLine);
  }

  Future<Result<List<CartLine>, ErrorResponse>> addCartLineCollection(
      List<AddCartLine> addCartLines) async {
    return await commerceAPIServiceProvider
        .getCartService()
        .addCartLineCollection(addCartLines);
  }

  Future<Result<GetCartLinesResult, ErrorResponse>>
      getCartLineCollection() async {
    var result =
        await commerceAPIServiceProvider.getCartService().getCartLines();

    return result;
  }

  Future<bool> isAuthenticated() async {
    var result = await commerceAPIServiceProvider
        .getAuthenticationService()
        .isAuthenticatedAsync();
    return result is Success ? (result as Success).value : false;
  }
}
