import 'package:commerce_flutter_app/features/domain/usecases/cart_usecase/cart_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart/cart_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartPageBloc extends Bloc<CartPageEvent, CartPageState> {
  final CartUseCase _cartUseCase;

  CartPageBloc({required CartUseCase cartUseCase})
      : _cartUseCase = cartUseCase,
        super(CartPageInitialState()) {
    on<CartPageLoadEvent>(_onCartPageLoadEvent);
  }

  Future<void> _onCartPageLoadEvent(
      CartPageLoadEvent event, Emitter<CartPageState> emit) async {
    emit(CartPageLoadingState());
    var result = await _cartUseCase.loadData();
    switch (result) {
      case Success(value: final data):
        emit(CartPageLoadedState(pageWidgets: data ?? []));
      case Failure(errorResponse: final errorResponse):
        emit(CartPageFailureState(errorResponse.errorDescription ?? ''));
    }
  }
}
