import 'package:commerce_flutter_sdk/src/core/constants/core_constants.dart';
import 'package:commerce_flutter_sdk/src/core/extensions/result_extension.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class OrderApprovalUseCase extends BaseUseCase {
  Future<GetOrderApprovalCollectionResult?> loadOrderApproval({
    int? page,
    required OrderApprovalParameters orderApprovalParameters,
  }) async {
    orderApprovalParameters.page = page;
    orderApprovalParameters.pageSize = CoreConstants.defaultPageSize;

    final result = await commerceAPIServiceProvider
        .getOrderService()
        .getOrderApprovalList(orderApprovalParameters);

    return result.getResultSuccessValue();
  }

  Future<Cart?> loadCart({required String cartId}) async {
    final result = await commerceAPIServiceProvider
        .getOrderService()
        .getOrderApproval(cartId);

    return result.getResultSuccessValue();
  }

  Future<bool> deleteOrder({required String cartId}) async {
    final deleteResponse =
        await commerceAPIServiceProvider.getCartService().deleteCart(cartId);

    return deleteResponse.getResultSuccessValue() != null;
  }

  Future<bool> approveOrder({required Cart cart}) async {
    cart.status = 'Cart';
    final approveResponse =
        await commerceAPIServiceProvider.getCartService().approveCart(cart);

    return approveResponse.getResultSuccessValue() != null;
  }

  Future<BillTo?> getBillToAddress() async {
    var session = commerceAPIServiceProvider
        .getSessionService()
        .getCachedCurrentSession();
    session ??= (await commerceAPIServiceProvider
            .getSessionService()
            .getCurrentSession())
        .getResultSuccessValue();

    return session?.billTo;
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
