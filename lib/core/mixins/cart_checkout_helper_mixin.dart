import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/features/domain/enums/fullfillment_method_type.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

mixin CartCheckoutHelperMixin {
  Future<String> getCartWarningMessage(
      Cart? cart, String? shippingMethod, BaseUseCase useCase) async {
    final errorMessageBuilder = StringBuffer();
    if (cart!.hasInsufficientInventory!) {
      if (shippingMethod == FulfillmentMethodType.Ship.name) {
        errorMessageBuilder.write(await useCase.getSiteMessage(
            SiteMessageConstants.nameCartInsufficientInventoryAtCheckout,
            SiteMessageConstants.defaultCartInsufficientInventoryAtCheckout));
      } else if (shippingMethod == FulfillmentMethodType.PickUp.name) {
        errorMessageBuilder.write(await useCase.getSiteMessage(
            SiteMessageConstants.nameCartInsufficientPickupInventory,
            SiteMessageConstants.defaultCartInsufficientPickupInventory));
      }
    }
    var productsCannotBePurchased = false;
    for (var cartLine in cart!.cartLines!) {
      if (!productsCannotBePurchased &&
          (!cartLine.isActive! || cartLine.isRestricted!)) {
        productsCannotBePurchased = true;
      }
    }
    if (productsCannotBePurchased) {
      var msg = await useCase.getSiteMessage(
          SiteMessageConstants.nameCartProductCannotBePurchased,
          SiteMessageConstants.defaultValueCartProductCannotBePurchased);
      errorMessageBuilder.write(msg);
    }

    if (cart!.cartLines!.isNotEmpty && cart!.cartNotPriced!) {
      var msg = await useCase.getSiteMessage(
          SiteMessageConstants.nameCartNoPriceAvailableAtCheckout,
          SiteMessageConstants.defaultValueCartNoPriceAvailableAtCheckout);
      errorMessageBuilder.write(msg);
    }

    if (_hasIncompleteStock(cart)) {
      var msg = await useCase.getSiteMessage(
          SiteMessageConstants
              .nameReviewAndPayNotEnoughInventoryInLocalWarehouse,
          SiteMessageConstants
              .nameReviewAndPayNotEnoughInventoryInLocalWarehouse);
      errorMessageBuilder.write(msg);
    }

    return Future.value(errorMessageBuilder.toString());
  }

  bool _hasIncompleteStock(Cart? cart) {
    String? incompleteStock;
    incompleteStock = cart?.properties?["incompleteStock"];

    if (incompleteStock == null || incompleteStock.isEmpty) {
      return false;
    }

    bool? isIncompleteStock = bool.tryParse(incompleteStock);
    if (isIncompleteStock != null) {
      return !cart!.hasInsufficientInventory! && isIncompleteStock;
    }

    return false;
  }
}
