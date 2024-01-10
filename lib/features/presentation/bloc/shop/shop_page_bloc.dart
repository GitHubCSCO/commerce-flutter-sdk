import 'package:commerce_flutter_app/features/domain/usecases/shop_usecase/shop_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ShopPageBloc extends Bloc<ShopPageEvent, ShopPageState> {
  final ShopUseCase _shopUseCase;

  ShopPageBloc(this._shopUseCase) : super(ShopPageInitialState()) {
    on<ShopPageLoadEvent>(_onShopPageLoadEvent);
  }

  Future<void> _onShopPageLoadEvent(
      ShopPageLoadEvent event, Emitter<ShopPageState> emit) async {
    var result = await _shopUseCase.loadData();
    switch (result) {
      case Success(value: final data):
        emit(ShopPageLoadedState(pageWidgets: data ?? []));
      case Failure(errorResponse: final errorResponse):
        emit(ShopPageFailureState(errorResponse.errorDescription ?? ''));
    }
  }
}
