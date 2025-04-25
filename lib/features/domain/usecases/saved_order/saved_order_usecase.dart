import 'package:commerce_flutter_sdk/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/features/domain/enums/order_status.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SavedOrderUsecase extends BaseUseCase {
  Future<CartSettings?> loadSettings() async {
    final result = await commerceAPIServiceProvider
        .getSettingsService()
        .getCartSettingAsync();
    switch (result) {
      case Success(value: final value):
        return value;
      case Failure():
        return null;
    }
  }

  Future<CartCollectionModel?> loadSavedOrders({
    int? page,
    required CartSortOrder sortOrder,
  }) async {
    final result = await commerceAPIServiceProvider.getCartService().getCarts(
          parameters: CartsQueryParameters(
            sort: sortOrder.value,
            page: page ?? 1,
            pageSize: CoreConstants.defaultPageSize,
            status: 'Saved',
          ),
        );
    switch (result) {
      case Success(value: final value):
        return value;
      case Failure():
        return null;
    }
  }

  Future<Cart?> loadCart({required String cartId}) async {
    final parameter = CartQueryParameters(
      cartId: cartId,
      expand: ['cartlines', 'costcodes', 'hiddenproducts'],
    );

    final result = await commerceAPIServiceProvider
        .getCartService()
        .getCart(cartId, parameter);

    switch (result) {
      case Success(value: final value):
        return value;
      case Failure():
        return null;
    }
  }

  Future<bool> deleteSavedOrders({required String cartId}) async {
    final result =
        await commerceAPIServiceProvider.getCartService().deleteCart(cartId);

    switch (result) {
      case Success(value: final value):
        return value ?? false;
      case Failure():
        return false;
    }
  }

  Future<OrderStatus> placeOrder({required Cart cart}) async {
    if (cart.id.isNullOrEmpty) {
      return OrderStatus.addToCartFailure;
    }

    if (cart.cartLines == null) {
      return OrderStatus.addToCartFailure;
    }

    final addCartLines = cart.cartLines
            ?.map(
              (cartLine) => AddCartLine(
                productId: cartLine.productId,
                qtyOrdered: cartLine.qtyOrdered,
                unitOfMeasure: cartLine.unitOfMeasure,
              ),
            )
            .toList() ??
        [];

    final cartLinesResult = await commerceAPIServiceProvider
        .getCartService()
        .addCartLineCollection(addCartLines);

    switch (cartLinesResult) {
      case Failure():
        return OrderStatus.addToCartFailure;
      case Success(value: final value):
        if (value != null && value.isNotEmpty) {
          final deleteResponse = await commerceAPIServiceProvider
              .getCartService()
              .deleteCart(cart.id ?? '');

          switch (deleteResponse) {
            case Failure():
              return OrderStatus.deleteCartFailure;
            case Success(value: final value):
              if (value == true) {
                return OrderStatus.addToCartSuccess;
              } else {
                return OrderStatus.deleteCartFailure;
              }
          }
        } else {
          return OrderStatus.addToCartFailure;
        }
    }
  }

  Future<Cart?> addCartToSavedOrders({required Cart cart}) async {
    cart.status = 'Saved';
    final result =
        await commerceAPIServiceProvider.getCartService().updateCart(cart);

    return result.getResultSuccessValue();
  }

  Future<Result<ProductSettings, ErrorResponse>> loadProductSettings() async {
    return await commerceAPIServiceProvider
        .getSettingsService()
        .getProductSettingsAsync();
  }

  Future<CartLine?> addLineItemToCart({
    required AddCartLine addCartLine,
  }) async {
    final result = await commerceAPIServiceProvider
        .getCartService()
        .addCartLine(addCartLine);

    switch (result) {
      case Failure():
        return null;
      case Success(value: final newCartLine):
        return newCartLine;
    }
  }
}
