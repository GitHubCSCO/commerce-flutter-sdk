import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/shop_usecase/shop_usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'shop_page_event.dart';
part 'shop_page_state.dart';

class ShopPageBloc extends Bloc<ShopPageEvent, ShopPageState> {
  final ShopUseCase _shopUseCase;

  ShopPageBloc({required ShopUseCase shopUseCase})
      : _shopUseCase = shopUseCase,
        super(ShopPageInitialState()) {
    on<ShopPageLoadEvent>(_onShopPageLoadEvent);
  }

  Future<void> _onShopPageLoadEvent(
      ShopPageLoadEvent event, Emitter<ShopPageState> emit) async {
    emit(ShopPageLoadingState());
    var result = await _shopUseCase.loadData();
    switch (result) {
      case Success(value: final data):
        emit(ShopPageLoadedState(pageWidgets: data ?? []));
      case Failure(errorResponse: final errorResponse):
        {
          _shopUseCase.trackError(errorResponse);
          emit(ShopPageFailureState(errorResponse.errorDescription ?? ''));
        }
    }
  }
}
