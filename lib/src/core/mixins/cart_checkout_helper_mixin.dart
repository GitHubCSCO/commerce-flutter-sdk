import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/fullfillment_method_type.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

mixin CartCheckoutHelperMixin {
  Future<String> getCartWarningMessage(
    Cart? cart,
    String? shippingMethod,
    BaseUseCase useCase,
  ) async {
    final siteMessages = await getCartSiteMessages(useCase);
    return getCartWarningMessageNoAsync(
      cart,
      shippingMethod,
      siteMessages[0],
      siteMessages[1],
      siteMessages[2],
      siteMessages[3],
      siteMessages[4],
      siteMessages[5],
    );
  }

  Future<List<String>> getCartSiteMessages(BaseUseCase useCase) async {
    final errorMessages = await Future.wait(
      [
        useCase.getSiteMessage(
          SiteMessageConstants.nameCartInsufficientInventoryAtCheckout,
          SiteMessageConstants.defaultCartInsufficientInventoryAtCheckout,
        ),
        useCase.getSiteMessage(
          SiteMessageConstants.nameCartInsufficientPickupInventory,
          SiteMessageConstants.defaultCartInsufficientPickupInventory,
        ),
        useCase.getSiteMessage(
          SiteMessageConstants.nameCartProductCannotBePurchased,
          SiteMessageConstants.defaultValueCartProductCannotBePurchased,
        ),
        useCase.getSiteMessage(
          SiteMessageConstants.nameCartNoPriceAvailableAtCheckout,
          SiteMessageConstants.defaultValueCartNoPriceAvailableAtCheckout,
        ),
        useCase.getSiteMessage(
          SiteMessageConstants
              .nameReviewAndPayNotEnoughInventoryInLocalWarehouse,
          SiteMessageConstants
              .defaultReviewAndPayNotEnoughInventoryInLocalWarehouse,
        ),
        useCase.getSiteMessage(
          SiteMessageConstants.nameCartInvalidPriceAtCheckout,
          SiteMessageConstants.defaultValueCartInvalidPriceAtCheckout,
        ),
      ],
    );

    return errorMessages;
  }

  String getCartWarningMessageNoAsync(
    Cart? cart,
    String? shippingMethod,
    String messageCartInsufficientInventoryAtCheckout,
    String messageCartInsufficientPickupInventory,
    String messageCartProductCannotBePurchased,
    String messageCartNoPriceAvailableAtCheckout,
    String messageReviewAndPayNotEnoughInventoryInLocalWarehouse,
    String messageCartInvalidPriceAtCheckout,
  ) {
    final errorMessageBuilder = StringBuffer();
    if (cart!.hasInsufficientInventory!) {
      if (shippingMethod == FulfillmentMethodType.Ship.name) {
        errorMessageBuilder.write(messageCartInsufficientInventoryAtCheckout);
      } else if (shippingMethod == FulfillmentMethodType.PickUp.name) {
        errorMessageBuilder.write(messageCartInsufficientPickupInventory);
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
      errorMessageBuilder.write(messageCartProductCannotBePurchased);
    }

    if (cart!.cartLines!.isNotEmpty && cart!.cartNotPriced!) {
      errorMessageBuilder.write(messageCartNoPriceAvailableAtCheckout);
    }

    if (_hasIncompleteStock(cart)) {
      errorMessageBuilder
          .write(messageReviewAndPayNotEnoughInventoryInLocalWarehouse);
    }

    final hasInvalidPrice = cart.cartLines != null &&
        cart.cartLines!.any(
          (cartLine) =>
              cartLine.allowZeroPricing != true &&
              cartLine.pricing?.unitNetPrice == 0 &&
              cartLine.isPromotionItem != true &&
              cartLine.isDiscounted != true,
        );

    if (hasInvalidPrice) {
      errorMessageBuilder.write(messageCartInvalidPriceAtCheckout);
    }

    return errorMessageBuilder.toString();
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
