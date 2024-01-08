import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/shop_usecase/shop_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/shop/shop_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopPageBloc extends Bloc<ShopPageEvent, ShopPageState> {
  final ShopUseCase _shopUseCase;

  ShopPageBloc(this._shopUseCase) : super(ShopPageInitialState()) {
    on<ShopPageLoadEvent>(_onShopPageLoadEvent);
  }

  Future<void> _onShopPageLoadEvent(
      ShopPageLoadEvent event, Emitter<ShopPageState> emit) async {
    _shopUseCase.loadData();
    emit(ShopPageLoadedState(pageWidgets: List.empty()));
  }
}
