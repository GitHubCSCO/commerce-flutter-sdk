import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/fullfillment_method_type.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/cart_usecase/cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'cart_page_event.dart';
part 'cart_page_state.dart';

class CartPageBloc extends Bloc<CartPageEvent, CartPageState> {
  final CartUseCase _cartUseCase;
  Cart? cart;
  bool hasCheckout = true;
  ProductSettings? productSettings;
  CartPageBloc({required CartUseCase cartUseCase})
      : _cartUseCase = cartUseCase,
        super(CartPageInitialState()) {
    on<CartPageLoadEvent>(_onCurrentCartLoadEvent);
    on<CartPagePickUpLocationChangeEvent>(_onCartPagePickUpLocationChangeEvent);
  }

  Future<void> _onCurrentCartLoadEvent(
      CartPageLoadEvent event, Emitter<CartPageState> emit) async {
    emit(CartPageLoadingState());

    await _cartUseCase.trackEvent(AnalyticsEvent(
      AnalyticsConstants.eventViewScreen,
      AnalyticsConstants.screenNameCart,
    ));

    hasCheckout = await _cartUseCase.hasCheckout();

    try {
      var result = await _cartUseCase.loadCurrentCart();
      var productSettingsResult = await _cartUseCase.loadProductSettings();
      productSettings = productSettingsResult is Success
          ? (productSettingsResult as Success).value as ProductSettings
          : null;

      switch (result) {
        case Success(value: final data):
          cart = data;
          if (cart?.cartLines == null || cart!.cartLines!.isEmpty) {
            emit(CartPageNoDataState());
            return;
          }
          var wareHouse = _cartUseCase.getPickUpWareHouse();
          var isCustomerOrderApproval =
              await _cartUseCase.isCustomerOrderApproval();
          var shippingMethod = _cartUseCase.getShippingMethod();
          var promotionsResult = await _cartUseCase.loadCartPromotions();
          var cartWarningMsg = await _getCartWarningMessage(shippingMethod);
          PromotionCollectionModel? promotionCollection =
              promotionsResult is Success
                  ? (promotionsResult as Success).value
                  : null;

          var settingResult = await _cartUseCase.loadCartSetting();
          switch (settingResult) {
            case Success(value: final setting):
              emit(CartPageLoadedState(
                  cart: data!,
                  warehouse: wareHouse!,
                  promotions: promotionCollection!,
                  isCustomerOrderApproval: isCustomerOrderApproval,
                  cartSettings: setting!,
                  shippingMethod: shippingMethod ?? '',
                  cartWarningMsg: cartWarningMsg));
              break;
            case Failure(errorResponse: final errorResponse):
              emit(CartPageFailureState(
                  error: errorResponse.errorDescription ?? ''));
              break;
          }
          break;
        case Failure(errorResponse: final errorResponse):
          emit(CartPageFailureState(
              error: errorResponse.errorDescription ?? ''));
          break;
      }
    } catch (e) {
      emit(CartPageFailureState(error: 'An unexpected error occurred'));
    }
  }

  Future<void> _onCartPagePickUpLocationChangeEvent(
      CartPagePickUpLocationChangeEvent event,
      Emitter<CartPageState> emit) async {
    await _cartUseCase.patchPickUpLocation(event.wareHouse);
    add(CartPageLoadEvent());
  }

  Future<String> _getCartWarningMessage(String? shippingMethod) async {
    final errorMessageBuilder = StringBuffer();
    if (cart!.hasInsufficientInventory!) {
      if (shippingMethod == FulfillmentMethodType.Ship.name) {
        errorMessageBuilder.write(await _cartUseCase.getSiteMessage(
            SiteMessageConstants.nameCartInsufficientInventoryAtCheckout,
            SiteMessageConstants.defaultCartInsufficientInventoryAtCheckout));
      } else if (shippingMethod == FulfillmentMethodType.PickUp.name) {
        errorMessageBuilder.write(await _cartUseCase.getSiteMessage(
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
      var msg = await _cartUseCase.getSiteMessage(
          SiteMessageConstants.nameCartProductCannotBePurchased,
          SiteMessageConstants.defaultValueCartProductCannotBePurchased);
      errorMessageBuilder.write(msg);
    }

    if (cart!.cartLines!.isNotEmpty && cart!.cartNotPriced!) {
      var msg = await _cartUseCase.getSiteMessage(
          SiteMessageConstants.nameCartNoPriceAvailableAtCheckout,
          SiteMessageConstants.defaultValueCartNoPriceAvailableAtCheckout);
      errorMessageBuilder.write(msg);
    }

    if (_hasIncompleteStock()) {
      var msg = await _cartUseCase.getSiteMessage(
          SiteMessageConstants
              .nameReviewAndPayNotEnoughInventoryInLocalWarehouse,
          SiteMessageConstants
              .nameReviewAndPayNotEnoughInventoryInLocalWarehouse);
      errorMessageBuilder.write(msg);
    }

    return Future.value(errorMessageBuilder.toString());
  }

  bool _hasIncompleteStock() {
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

  List<CartLineEntity> getCartLines() {
    List<CartLineEntity> cartlines = [];
    for (var cartLine in cart?.cartLines ?? []) {
      var cartLineEntity = CartLineEntityMapper().toEntity(cartLine);
      var shouldShowWarehouseInventoryButton =
          InventoryUtils.isInventoryPerWarehouseButtonShownAsync(
                  productSettings) &&
              cartLine.availability.messageType != 0;
      cartLineEntity = cartLineEntity.copyWith(
          showInventoryAvailability: shouldShowWarehouseInventoryButton);
      cartlines.add(cartLineEntity);
    }
    return cartlines;
  }

  List<AddCartLine> getAddCartLines() {
    return (cart?.cartLines ?? [])
        .map(
          (cartLine) => AddCartLine(
            productId: cartLine.productId,
            qtyOrdered: cartLine.qtyOrdered,
            unitOfMeasure: cartLine.unitOfMeasure,
          ),
        )
        .toList();
  }

  bool get approvalButtonVisible => cart?.requiresApproval ?? false;

  bool get isCartEmpty =>
      // ignore: prefer_is_empty
      cart?.cartLines == null || (cart?.cartLines?.length == 0);

  bool get _hasRestrictedCartLines =>
      cart?.cartLines != null &&
      cart!.cartLines!.any((x) => x.isRestricted == true);

  bool get _hasOnlyQuoteRequiredProducts =>
      (cart?.cartLines != null || cart!.cartLines!.isNotEmpty) &&
      cart!.cartLines!.every((x) => x.quoteRequired == true);

  bool get _isCartCheckoutDisabled =>
      cart != null &&
      ((cart?.canCheckOut != true && cart?.canRequisition != true) ||
          isCartEmpty ||
          _hasRestrictedCartLines);

  bool get isCheckoutButtonEnabled {
    if (cart == null) {
      return false;
    }

    return !_isCartCheckoutDisabled || !_hasOnlyQuoteRequiredProducts;
  }

  bool get checkoutButtonVisible {
    if (cart == null) {
      return false;
    }

    return cart?.canCheckOut == true && !isCartEmpty && hasCheckout;
  }
}
