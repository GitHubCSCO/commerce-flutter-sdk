import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/core/mixins/cart_checkout_helper_mixin.dart';
import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/cart_usecase/cart_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'cart_page_event.dart';
part 'cart_page_state.dart';

class CartPageBloc extends Bloc<CartPageEvent, CartPageState>
    with CartCheckoutHelperMixin {
  final CartUseCase _cartUseCase;
  final PricingInventoryUseCase _pricingInventoryUseCase;
  Cart? cart;
  Session? session;
  bool hasCheckout = true;
  ProductSettings? productSettings;
  String? promoItemMessage;
  bool hasInvalidPrice = false;
  CartPageBloc(
      {required CartUseCase cartUseCase,
      required PricingInventoryUseCase pricingInventoryUseCase})
      : _cartUseCase = cartUseCase,
        _pricingInventoryUseCase = pricingInventoryUseCase,
        super(CartPageInitialState()) {
    on<CartPageLoadEvent>(_onCurrentCartLoadEvent);
    on<CartPagePickUpLocationChangeEvent>(_onCartPagePickUpLocationChangeEvent);
    on<CartPageCheckoutEvent>(_onCartCheckoutSubmitEvent);
  }

  void _trackViewCartScreen() {
    var viewScreenEvent = AnalyticsEvent(AnalyticsConstants.eventViewScreen,
            AnalyticsConstants.screenNameCart)
        .withProperty(
            name: AnalyticsConstants.eventPropertyOrderNumber,
            strValue: cart?.orderNumber ?? '');
    _cartUseCase.trackEvent(viewScreenEvent);
  }

  Future<void> _onCurrentCartLoadEvent(
      CartPageLoadEvent event, Emitter<CartPageState> emit) async {
    emit(CartPageLoadingState());

    promoItemMessage = await _cartUseCase.getSiteMessage(
        SiteMessageConstants.nameCartProductPromotionItem,
        SiteMessageConstants.defaultValueCartPromotionItem);
    hasCheckout = await _cartUseCase.hasCheckout();

    try {
      var result = await _cartUseCase.loadCurrentCart();
      var productSettingsResult = await _cartUseCase.loadProductSettings();
      productSettings = productSettingsResult.getResultSuccessValue();

      var sessionResponse = await _cartUseCase.getCurrentSession();
      session = sessionResponse is Success
          ? (sessionResponse as Success).value as Session
          : null;

      switch (result) {
        case Success(value: final data):
          cart = data;
          if (event.trackScreen) {
            _trackViewCartScreen();
          }
          if (cart?.cartLines == null || cart!.cartLines!.isEmpty) {
            final message = await _cartUseCase.getSiteMessage(
                SiteMessageConstants.nameNoOrderLines,
                SiteMessageConstants.defaultValueNoOrderLines);
            emit(CartPageNoDataState(message));
            return;
          }
          final hasWillCall = await _cartUseCase.hasWillCall();
          var wareHouse = session?.pickUpWarehouse;
          var isCustomerOrderApproval =
              await _cartUseCase.isCustomerOrderApproval();
          var shippingMethod = session?.fulfillmentMethod;
          var promotionsResult = await _cartUseCase.loadCartPromotions();
          var cartWarningMsg =
              await getCartWarningMessage(cart, shippingMethod, _cartUseCase);
          PromotionCollectionModel? promotionCollection =
              promotionsResult.getResultSuccessValue();

          var settingResult = await _cartUseCase.loadCartSetting();
          switch (settingResult) {
            case Success(value: final setting):
              final hidePricingEnable =
                  _pricingInventoryUseCase.getHidePricingEnable();
              final hideInventoryEnable =
                  _pricingInventoryUseCase.getHideInventoryEnable();

              hasInvalidPrice = _hasInvalidPrice;

              emit(CartPageLoadedState(
                cart: data,
                warehouse: wareHouse,
                promotions: promotionCollection,
                isCustomerOrderApproval: isCustomerOrderApproval,
                cartSettings: setting,
                shippingMethod: shippingMethod ?? '',
                hasWillCall: hasWillCall,
                cartWarningMsg: cartWarningMsg,
                hidePricingEnable: hidePricingEnable,
                hideInventoryEnable: hideInventoryEnable,
              ));
              break;
            case Failure(errorResponse: final errorResponse):
              {
                _cartUseCase.trackError(errorResponse);
                emit(CartPageFailureState(
                    error: errorResponse.errorDescription ?? ''));
                break;
              }
          }
          break;
        case Failure(errorResponse: final errorResponse):
          {
            _cartUseCase.trackError(errorResponse);
            emit(CartPageFailureState(
                error: errorResponse.errorDescription ?? ''));
            break;
          }
      }
    } catch (e) {
      _cartUseCase.trackError(e);
      emit(CartPageFailureState(error: 'An unexpected error occurred'));
    }
  }

  Future<void> _onCartPagePickUpLocationChangeEvent(
      CartPagePickUpLocationChangeEvent event,
      Emitter<CartPageState> emit) async {
    await _cartUseCase.patchPickUpLocation(event.wareHouse);
    add(CartPageLoadEvent());
  }

  Future<void> _onCartCheckoutSubmitEvent(
      CartPageCheckoutEvent event, Emitter<CartPageState> emit) async {
    emit(CartPageCheckoutButtonLoadingState());
    if (_hasQuoteRequiredProducts) {
      var warningMsg = await _cartUseCase.getSiteMessage(
          SiteMessageConstants.orderApprovalRequiresQuoteMessage,
          SiteMessageConstants.defaultOrderApprovalRequiresQuoteMessage);

      emit(CartPageWarningDialogShowState(warningMsg));
    } else {
      emit(CartProceedToCheckoutState());
    }
  }

  List<CartLineEntity> getCartLines() {
    var cartLines = <CartLineEntity>[];
    for (var cartLine in cart?.cartLines ?? []) {
      var cartLineEntity = CartLineEntityMapper.toEntity(cartLine);
      var shouldShowWarehouseInventoryButton =
          InventoryUtils.isInventoryPerWarehouseButtonShownAsync(
                  productSettings) &&
              cartLine.availability.messageType != 0;
      cartLineEntity = cartLineEntity.copyWith(
          showInventoryAvailability: shouldShowWarehouseInventoryButton,
          promoItemMessage: promoItemMessage);
      cartLines.add(cartLineEntity);
    }
    return cartLines;
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

  bool get _hasQuoteRequiredProducts {
    return cart?.cartLines != null &&
        cart!.cartLines!.any((line) => line.quoteRequired == true);
  }

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

    return cart?.canCheckOut == true &&
        !isCartEmpty &&
        hasCheckout &&
        !hasInvalidPrice;
  }

  bool get canSubmitForQuote {
    if (cart == null) {
      return false;
    }

    return cart?.canRequestQuote == true &&
        cart?.isAwaitingApproval == false &&
        !isCartEmpty;
  }

  String get submitForQuoteTitle {
    if (session != null && session?.isSalesPerson == true) {
      return LocalizationConstants.createAQuote.localized();
    } else {
      return LocalizationConstants.submitForQuote.localized();
    }
  }

  bool get _hasInvalidPrice {
    return cart?.cartLines != null &&
        cart!.cartLines!.any(
          (cartLine) =>
              cartLine.allowZeroPricing != true &&
              cartLine.pricing?.unitNetPrice == 0 &&
              cartLine.isPromotionItem != true &&
              cartLine.isDiscounted != true,
        );
  }
}
