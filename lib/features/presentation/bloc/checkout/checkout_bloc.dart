import 'package:commerce_flutter_app/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_app/core/mixins/cart_checkout_helper_mixin.dart';
import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/checkout/review_order_entity.dart';
import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/checkout_usecase/checkout_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'checkout_state.dart';
part 'checkout_event.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState>
    with CartCheckoutHelperMixin {
  final CheckoutUsecase _checkoutUseCase;
  DateTime? requestDeliveryDate;
  Cart? cart;
  CarrierDto? selectedCarrier;
  ShipViaDto? selectedService;
  PaymentOptionsDto? selectedPayment;
  Session? session;
  bool hasCheckout = true;
  ProductSettings? productSettings;
  String? promoItemMessage;

  CheckoutBloc({required CheckoutUsecase checkoutUseCase})
      : _checkoutUseCase = checkoutUseCase,
        super(CheckoutInitial()) {
    on<LoadCheckoutEvent>(
        (event, emit) async => _onCheckoutLoadEvent(event, emit));
    on<PlaceOrderEvent>((event, emit) async => _onPlaceOrderEvent(event, emit));
    on<RequestDeliveryDateEvent>(
        (event, emit) => _onRequestDeliveryDateSelect(event, emit));
    on<SelectCarrierEvent>(
        (event, emit) async => _onCarrierSelect(event, emit));
    on<SelectServiceEvent>(
        (event, emit) async => _onServiceSelect(event, emit));
    on<SelectPaymentMethodEvent>(
        (event, emit) async => _onPaymentMethodSelect(event, emit));
    on<SelectPaymentEvent>(
        (event, emit) async => _onPaymentSelect(event, emit));
    on<UpdatePONumberEvent>((event, emit) => _onUpdatePONumber(event, emit));
    on<AddShiptoAddressEvent>((event, emit) async => _onAddShipTo(event, emit));
    on<UpdateShiptoAddressEvent>(
        (event, emit) async => _onUpdateShipto(event, emit));
    on<OrderNotesEvent>((event, emit) => _onUpdateOrderNotes(event, emit));
  }

  Cart removeQuoteRequiredProductsIfNeeded(Cart cart) {
    if (hasQuoteRequiredProducts) {
      cart.cartLines =
          cart.cartLines?.where((x) => !(x.quoteRequired == true)).toList();
    }
    updateCheckoutData(cart);
    return cart;
  }

  void updateCheckoutData(Cart cart) {
    this.cart = cart;
    selectedCarrier = cart.carrier;
    selectedService = cart.shipVia;
  }

  Future<void> _onCheckoutLoadEvent(
      LoadCheckoutEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());

    promoItemMessage = await _checkoutUseCase.getSiteMessage(
        SiteMessageConstants.nameCartProductPromotionItem,
        SiteMessageConstants.defaultValueCartPromotionItem);
    hasCheckout = await _checkoutUseCase.hasCheckout();

    var data = await _checkoutUseCase.getCart(event.cart.id!);
    session ??= _checkoutUseCase.getCurrentSession();

    var productSettingsResult = await _checkoutUseCase.loadProductSettings();
    var settingsResult = (await _checkoutUseCase.loadSettingsCollection())
        .getResultSuccessValue();
    var allowCreateNewShipToAddress = settingsResult?.settingsCollection
            ?.customerSettings?.allowCreateNewShipToAddress ??
        false;
    productSettings = productSettingsResult is Success
        ? (productSettingsResult as Success).value as ProductSettings
        : null;

    switch (data) {
      case Success(value: var cartData):
        if (cartData?.cartLines == null || cartData!.cartLines!.isEmpty) {
          final message = await _checkoutUseCase.getSiteMessage(
              SiteMessageConstants.nameNoOrderLines,
              SiteMessageConstants.defaultValueNoOrderLines);
          emit(CheckoutNoDataState(message));
          return;
        }

        updateCheckoutData(cartData);
        cartData = removeQuoteRequiredProductsIfNeeded(cartData);

        final billToAddress = cartData.billTo;
        final shipToAddress = cartData.shipTo;
        final wareHouse = session?.pickUpWarehouse;
        var shippingMethod = session?.fulfillmentMethod;
        var promotionCollection = (await _checkoutUseCase.loadCartPromotions())
            .getResultSuccessValue();
        var cartSettings =
            (await _checkoutUseCase.getCartSetting()).getResultSuccessValue();
        final cartWarningMsg = await getCartWarningMessage(
            cartData, shippingMethod, _checkoutUseCase);
        final message = shippingMethod
                .equalsIgnoreCase(ShippingOption.pickUp.name)
            ? await _checkoutUseCase.getSiteMessage(
                SiteMessageConstants.nameCheckoutRequestedPickUpDateMessage,
                SiteMessageConstants
                    .defaultValueCheckoutRequestedPickUpDateMessage)
            : await _checkoutUseCase.getSiteMessage(
                SiteMessageConstants.nameCheckoutRequestedDeliveryDateMessage,
                SiteMessageConstants
                    .defaultValueCheckoutRequestedDeliveryDateMessage);

        if (billToAddress != null &&
            shipToAddress != null &&
            shippingMethod != null) {
          emit(
            CheckoutDataLoaded(
                cart: cartData,
                billToAddress: billToAddress,
                shipToAddress: shipToAddress,
                wareHouse: wareHouse,
                promotions: promotionCollection,
                shippingMethod: shippingMethod,
                cartSettings: cartSettings,
                selectedCarrier: selectedCarrier,
                selectedService: selectedService,
                requestDeliveryDate: requestDeliveryDate,
                allowCreateNewShipToAddress: allowCreateNewShipToAddress,
                requestDateWarningMessage: message,
                cartWarningMsg: cartWarningMsg,
                orderNotes: cart?.notes),
          );
        } else {
          var failedReason =
              'BillTo: $billToAddress, ShipTo: $shipToAddress, WareHouse: ${wareHouse?.toJson()}, ShippingMethod: $shippingMethod';
          _checkoutUseCase.trackError(ErrorResponse(message: failedReason));
          emit(
            CheckoutDataFetchFailed(error: failedReason),
          );
        }
      case Failure(errorResponse: final errorResponse):
        _checkoutUseCase.trackError(errorResponse);
        emit(CheckoutDataFetchFailed(
            error: errorResponse.errorDescription ?? ''));
    }
  }

  Future<void> _onPlaceOrderEvent(
      PlaceOrderEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    cart?.status =
        (cart?.requiresApproval ?? false) ? 'AwaitingApproval' : 'Submitted';

    final result = await _checkoutUseCase.patchCart(cart!);
    switch (result) {
      case Success(value: final cartData):
        var orderNumber = ((cartData?.erpOrderNumber != null &&
                    cartData!.erpOrderNumber!.isNotEmpty)
                ? cartData.erpOrderNumber
                : cartData?.orderNumber) ??
            '';

        await _checkoutUseCase.removeOrderApprovalCookieIfAvailable();

        String? message;

        if (cart?.requiresApproval ?? false) {
          message = SiteMessageConstants.defaultVaLueOrderApprovalOrderPlaced;
        } else {
          message = await _checkoutUseCase.getSiteMessage(
              SiteMessageConstants.nameMobileAppOrderConfirmationSuccessMessage,
              SiteMessageConstants
                  .defaultMobileAppOrderConfirmationSuccessMessage);
        }

        emit(CheckoutPlaceOrder(
          orderNumber: orderNumber,
          reviewOrderEntity: event.reviewOrderEntity,
          cart: cartData!,
          message: message,
        ));

      case Failure(errorResponse: final errorResponse):
        _checkoutUseCase.trackError(errorResponse);
        emit(CheckoutPlaceOrderFailed(
            error: errorResponse.errorDescription ?? ''));
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

  void _onRequestDeliveryDateSelect(
      RequestDeliveryDateEvent event, Emitter<CheckoutState> emit) {
    requestDeliveryDate = event.dateTime;
    cart?.requestedDeliveryDate = event.dateTime.toIso8601String();
  }

  Future<void> _onCarrierSelect(
      SelectCarrierEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    selectedCarrier = event.carrier;
    selectedService = event.carrier.shipVias?.first;
    cart?.carrier = selectedCarrier;
    cart?.shipVia = selectedService;
    await _checkoutUseCase.patchCart(cart!);
    add(LoadCheckoutEvent(cart: cart!));
  }

  Future<void> _onServiceSelect(
      SelectServiceEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    selectedService = event.service;
    cart?.shipVia = selectedService;
    await _checkoutUseCase.patchCart(cart!);
    add(LoadCheckoutEvent(cart: cart!));
  }

  Future<void> _onUpdateOrderNotes(
      OrderNotesEvent event, Emitter<CheckoutState> emit) async {
    cart?.notes = event.orderNotes;
  }

  Future<void> _onPaymentMethodSelect(
      SelectPaymentMethodEvent event, Emitter<CheckoutState> emit) async {
    cart?.paymentMethod = event.paymentMethod;
  }

  Future<void> _onPaymentSelect(
      SelectPaymentEvent event, Emitter<CheckoutState> emit) async {
    // selectedPayment = event.paymentOption;
    cart?.paymentOptions?.creditCard?.cardHolderName =
        selectedPayment?.creditCard?.cardHolderName;
    cart?.paymentOptions?.creditCard?.cardNumber =
        selectedPayment?.creditCard?.cardNumber;
    cart?.paymentOptions?.creditCard?.cardType =
        selectedPayment?.creditCard?.cardType;
    cart?.paymentOptions?.creditCard?.expirationMonth =
        selectedPayment?.creditCard?.expirationMonth;
    cart?.paymentOptions?.creditCard?.expirationYear =
        selectedPayment?.creditCard?.expirationYear;
  }

  void _onUpdatePONumber(
      UpdatePONumberEvent event, Emitter<CheckoutState> emit) {
    cart?.poNumber = event.poNumber;
  }

  String? getOrderNote() {
    return cart?.notes;
  }

  Future<void> _onAddShipTo(
      AddShiptoAddressEvent event, Emitter<CheckoutState> emit) async {
    var response =
        await _checkoutUseCase.postCurrentBillToShipToAsync(event.shipTo);

    cart?.shipTo = response is Success
        ? (response as Success).value as ShipTo
        : event.shipTo;

    session?.shipTo = cart?.shipTo;
    session = await _checkoutUseCase.updateCurrentSession(session);

    emit(CheckoutShipToAddressAddedState());
  }

  Future<void> _onUpdateShipto(
      UpdateShiptoAddressEvent event, Emitter<CheckoutState> emit) async {
    cart?.shipTo = event.shipTo;
    session?.shipTo = cart?.shipTo;
    session = await _checkoutUseCase.updateCurrentSession(session);

    emit(CheckoutShipToAddressAddedState());
  }

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

    /// TODO - check if all required data is entered
    return !_isCartCheckoutDisabled || !_hasOnlyQuoteRequiredProducts;
  }

  bool get hasQuoteRequiredProducts {
    return cart?.cartLines != null &&
        (cart?.cartLines ?? []).any((x) => x.quoteRequired ?? false);
  }

  bool get checkoutButtonVisible {
    if (cart == null) {
      return false;
    }

    return cart?.canCheckOut == true && !isCartEmpty && hasCheckout;
  }

  bool get shouldShowOrderNotes {
    return _checkoutUseCase.shouldShowOrderNotes;
  }
}
