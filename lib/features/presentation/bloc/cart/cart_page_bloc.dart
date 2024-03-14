import 'package:commerce_flutter_app/features/domain/usecases/cart_usecase/cart_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'cart_page_event.dart';
part 'cart_page_state.dart';

class CartPageBloc extends Bloc<CartPageEvent, CartPageState> {

  final CartUseCase _cartUseCase;
  Cart? cart;

  CartPageBloc({required CartUseCase cartUseCase})
      : _cartUseCase = cartUseCase,
        super(CartPageInitialState()) {
    on<CartPageLoadEvent>(_onCurrentCartLoadEvent);
  }

  Future<void> _onCurrentCartLoadEvent(CartPageLoadEvent event, Emitter<CartPageState> emit) async {
    emit(CartPageLoadingState());
    var result = await _cartUseCase.loadCurrentCart();
    switch (result) {
      case Success(value: final data):
        cart = data;
        var wareHouse = _cartUseCase.getPickUpWareHouse();
        var isCustomerOrderApproval = _cartUseCase.isCustomerOrderApproval();
        var promotionsResult = await _cartUseCase.loadCartPromotions();
        PromotionCollectionModel? promotionCollection = promotionsResult is Success ? (promotionsResult as Success).value : null;

        var settingResult = await _cartUseCase.loadCartSetting();
        switch (settingResult) {
          case Success(value: final setting):
            emit(CartPageLoadedState(cart: data!, warehouse: wareHouse!, promotions: promotionCollection!, isCustomerOrderApproval: isCustomerOrderApproval, cartSettings: setting!));
            break;
          case Failure(errorResponse: final errorResponse):
            emit(CartPageFailureState(error: errorResponse.errorDescription ?? ''));
            break;
        }
        break;
      case Failure(errorResponse: final errorResponse):
        emit(CartPageFailureState(error: errorResponse.errorDescription ?? ''));
        break;
    }
  }

}
