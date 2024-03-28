import 'package:commerce_flutter_app/features/domain/usecases/checkout_usecase/checkout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'checkout_state.dart';
part 'checkout_event.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutUsecase _checkoutUseCase;
  DateTime? requestDeliveryDate;
  Cart? cart;
  CarrierDto? selectedCarrier;
  ShipViaDto? selectedService;
  PaymentOptionsDto? selectedPayment;

  CheckoutBloc({required CheckoutUsecase checkoutUsecase})
      : _checkoutUseCase = checkoutUsecase,
        super(CheckoutInitial()) {
    on<LoadCheckoutEvent>((event, emit) => _onCheckoutLoadEvent(event, emit));
    on<PlaceOrderEvent>((event, emit) => _onPlaceOrderEvent(event, emit));
    on<RequestDeliveryDateEvent>(
        (event, emit) => _onRequestDeliveryDateSelect(event, emit));
    on<SelectCarrierEvent>((event, emit) => _onCarrierSelect(event, emit));
    on<SelectServiceEvent>((event, emit) => _onServiceSelect(event, emit));
    on<SelectPaymentEvent>((event, emit) => _onPaymentSelect(event, emit));
  }

  void updateCheckoutData(Cart cart) {
    this.cart = cart;
    selectedCarrier = cart.carrier;
    selectedService = cart.shipVia;
  }

  Future<void> _onCheckoutLoadEvent(
      LoadCheckoutEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    var data = await _checkoutUseCase.getCart(event.cart.id!);
    switch (data) {
      case Success(value: final cartData):
        updateCheckoutData(cartData!);
        final session = _checkoutUseCase.getCurrentSession();
        final billToAddress = session?.billTo;
        final shipToAddress = session?.shipTo;
        final wareHouse = session?.pickUpWarehouse;
        var shippingMethod = session?.fulfillmentMethod;
        var promotionsResult = await _checkoutUseCase.loadCartPromotions();
        PromotionCollectionModel? promotionCollection =
            promotionsResult is Success
                ? (promotionsResult as Success).value
                : null;
        var cartSettingResult = await _checkoutUseCase.getCartSetting();
        CartSettings cartSettings = cartSettingResult is Success
            ? (cartSettingResult as Success).value
            : null;

        emit(CheckoutDataLoaded(
            cart: cartData,
            billToAddress: billToAddress!,
            shipToAddress: shipToAddress!,
            wareHouse: wareHouse!,
            promotions: promotionCollection!,
            shippingMethod: shippingMethod!,
            cartSettings: cartSettings));
        break;
      case Failure(errorResponse: final errorResponse):
        emit(CheckoutDataFetchFailed(
            error: errorResponse.errorDescription ?? ''));
        break;
    }
  }

  Future<void> _onPlaceOrderEvent(
      PlaceOrderEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    final result = await _checkoutUseCase.patchCart(cart!);
    switch (result) {
      case Success(value: final cartData):
        emit(CheckoutPlaceOrder(
            orderNumber:
                (cartData?.erpOrderNumber ?? cartData?.orderNumber) ?? ''));
        break;
      case Failure(errorResponse: final errorResponse):
        emit(CheckoutDataFetchFailed(
            error: errorResponse.errorDescription ?? ''));
        break;
    }
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

  Future<void> _onPaymentSelect(
      SelectPaymentEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    selectedPayment = event.paymentMethod;
    cart?.paymentOptions = selectedPayment;
  }
}
