import 'package:commerce_flutter_app/core/utils/inventory_utils.dart';
import 'package:commerce_flutter_app/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/quote_usecase/request_quote_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote/request_quote_event.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/quote/request_quote/request_quote_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class RequestQuoteBloc extends Bloc<RequestQuoteEvent, RequestQuoteState> {
  final RequestQuoteUsecase _requestQuoteUsecase;
  ProductSettings? productSettings;
  RequestQuoteBloc({required RequestQuoteUsecase requestQuoteUsecase})
      : _requestQuoteUsecase = requestQuoteUsecase,
        super(RequestQuoteInitial()) {
    on<LoadRequestQuoteCartLinesEvent>(_onLoadRequestQuoteCartLinesEvent);
  }

  Future<void> _onLoadRequestQuoteCartLinesEvent(
      LoadRequestQuoteCartLinesEvent event,
      Emitter<RequestQuoteState> emit) async {
    emit(RequestQuoteCartLinesLoading());

    var productSettingsResult =
        await _requestQuoteUsecase.getProductSettingAsync();
    productSettings = productSettingsResult is Success
        ? (productSettingsResult as Success).value as ProductSettings
        : null;

    var cartlinesResponse = await _requestQuoteUsecase.getCartLinesAsync();

    switch (cartlinesResponse) {
      case Success(value: final data):
        emit(RequestQuoteCartLinesLoaded(
            cartLineEntities: getCartLineEntities(data?.cartLines ?? [])));
        break;
      case Failure(errorResponse: final errorResponse):
        emit(RequestQuoteCartLinesError(
            message: errorResponse.errorDescription ?? ''));
        break;
    }
  }

  Future<void> _onDeleteCartLine(
      DeleteCartLineEvent event, Emitter<RequestQuoteState> emit) async {
    emit(RequestQuoteCartLinesLoading());

    var cartLineModel = CartLineEntityMapper.toModel(event.cartLineEntity);

    var cartlineDeleteResponse =
        await _requestQuoteUsecase.deleteCartLine(cartLineModel);

    switch (cartlineDeleteResponse) {
      case Success(value: final data):
        if (data == true) {
          emit(DeleteCartLineSuccessState());
        }
        emit(DeleteCartLineErrorState());
        break;
      case Failure(errorResponse: final errorResponse):
        emit(DeleteCartLineErrorState());
        break;
    }
  }

  List<CartLineEntity> getCartLineEntities(List<CartLine>? cartLines) {
    List<CartLineEntity> cartLineEntities = [];
    for (var cartLine in cartLines ?? []) {
      var cartLineEntity = CartLineEntityMapper.toEntity(cartLine);
      var shouldShowWarehouseInventoryButton =
          InventoryUtils.isInventoryPerWarehouseButtonShownAsync(
                  productSettings) &&
              cartLine.availability.messageType != 0;
      cartLineEntity = cartLineEntity.copyWith(
          showInventoryAvailability: shouldShowWarehouseInventoryButton);
      cartLineEntities.add(cartLineEntity);
    }

    return cartLineEntities;
  }
}
