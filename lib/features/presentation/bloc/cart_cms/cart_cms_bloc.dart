import 'package:commerce_flutter_app/features/domain/usecases/cart_cms_usecase/cart_cms_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart_cms/cart_cms_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/cart_cms/cart_cms_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartCmsPageBloc extends Bloc<CartCmsPageEvent, CartCmsPageState> {
  final CartCmsUsecase _cartCmsUsecase;

  CartCmsPageBloc({required CartCmsUsecase cartCmsUsecase})
      : _cartCmsUsecase = cartCmsUsecase,
        super(CartCmsPageInitialState()) {
    on<CartCmsPageLoadEvent>(_onCartCmsPageLoadEvent);
  }

  Future<void> _onCartCmsPageLoadEvent(
      CartCmsPageLoadEvent event, Emitter<CartCmsPageState> emit) async {
    emit(CartCmsPageLoadingState());
    var result = await _cartCmsUsecase.loadData();
    switch (result) {
      case Success(value: final data):
        emit(CartCmsPageLoadedState(pageWidgets: data ?? []));
      case Failure(errorResponse: final errorResponse):
        {
          _cartCmsUsecase.trackError(errorResponse);
          emit(CartCmsPageFailureState(errorResponse.errorDescription ?? ''));
        }
    }
  }
}
