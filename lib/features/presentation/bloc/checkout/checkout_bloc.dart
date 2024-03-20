import 'package:commerce_flutter_app/features/domain/usecases/checkout_usecase/checkout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'checkout_state.dart';
part 'checkout_event.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CheckoutUsecase _checkoutUsecase;

  CheckoutBloc({required CheckoutUsecase checkoutUsecase})
      : _checkoutUsecase = checkoutUsecase,
        super(CheckoutInitial()) {
    on<LoadCheckoutEvent>((event, emit) => _fetchCheckoutData(event, emit));
  }

  Future<void> _fetchCheckoutData(
      LoadCheckoutEvent event, Emitter<CheckoutState> emit) async {
    emit(CheckoutLoading());
    var data = await _checkoutUsecase.getCart(event.cart.id!);
    switch (data) {
      case Success(value: final cart):
        emit(CheckoutDataLoaded(cart: cart!));
        break;
      case Failure(errorResponse: final errorResponse):
        emit(CheckoutDataFetchFailed(
            error: errorResponse.errorDescription ?? ''));
        break;
    }
  }
}
