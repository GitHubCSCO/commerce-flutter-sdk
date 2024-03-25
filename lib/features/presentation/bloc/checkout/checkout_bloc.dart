import 'package:commerce_flutter_app/features/domain/usecases/checkout_usecase/checkout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'checkout_state.dart';
part 'checkout_event.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutUsecase _checkoutUseCase;

  CheckoutBloc({required CheckoutUsecase checkoutUsecase})
      : _checkoutUseCase = checkoutUsecase,
        super(CheckoutInitial()) {
    on<LoadCheckoutEvent>((event, emit) => _onCheckoutLoadEvent(event, emit));
  }

  Future<void> _onCheckoutLoadEvent(
      LoadCheckoutEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    var data = await _checkoutUseCase.getCart(event.cart.id!);
    switch (data) {
      case Success(value: final cart):
        final session = _checkoutUseCase.getCurrentSession();
        final billToAddress = session?.billTo;
        final shipToAddress = session?.shipTo;
        final wareHouse = session?.pickUpWarehouse;
        var shippingMethod = session?.fulfillmentMethod;
        var promotionsResult = await _checkoutUseCase.loadCartPromotions();
        PromotionCollectionModel? promotionCollection = promotionsResult is Success ? (promotionsResult as Success).value : null;
        var cartSettingResult = await _checkoutUseCase.getCartSetting();
        CartSettings cartSettings = cartSettingResult is Success ? (cartSettingResult as Success).value : null;

        emit(CheckoutDataLoaded(
            cart: cart!,
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
}
