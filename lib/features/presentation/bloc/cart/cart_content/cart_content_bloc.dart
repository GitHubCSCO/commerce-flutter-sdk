import 'package:commerce_flutter_sdk/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_sdk/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_sdk/features/domain/entity/cart_line_entity.dart';
import 'package:commerce_flutter_sdk/features/domain/mapper/cart_line_mapper.dart';
import 'package:commerce_flutter_sdk/features/domain/usecases/cart_usecase/cart_content_usecase.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/cart/cart_content/cart_content_event.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/cart/cart_content/cart_content_state.dart';
import 'package:commerce_flutter_sdk/features/presentation/bloc/root/root_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class CartContentBloc extends Bloc<CartContentEvent, CartContentState> {
  final CartContentUseCase _contentUseCase;

  CartContentBloc({required CartContentUseCase contentUseCase})
      : _contentUseCase = contentUseCase,
        super(CartContentDefaultState()) {
    on<CartContentQuantityChangedEvent>(_onCartContentQuantityChanged);
    on<CartContentRemoveEvent>(_onCartContentRemove);
    on<CartContentClearAllEvent>(_onCartContentClearAll);
  }

  Future<void> _onCartContentQuantityChanged(
      CartContentQuantityChangedEvent event,
      Emitter<CartContentState> emit) async {
    var cartLineEntity = event.cartLineEntity;

    _contentUseCase.trackEvent(AnalyticsEvent(
            AnalyticsConstants.eventUpdateCartLine,
            AnalyticsConstants.screenNameCart)
        .withProperty(
          name: AnalyticsConstants.eventPropertyErpNumber,
          strValue: cartLineEntity.erpNumber,
        )
        .withProperty(
          name: AnalyticsConstants.eventPropertyOrderNumber,
          strValue: event.orderNumber,
        ));

    final result = await _contentUseCase
        .updateCartLine(CartLineEntityMapper.toModel(cartLineEntity));

    switch (result) {
      case Success(value: final data):
        String? message;
        if (data?.isQtyAdjusted == true) {
          message = await _contentUseCase.getSiteMessage(
              SiteMessageConstants.nameAddToCartQuantityAdjusted,
              SiteMessageConstants.defaultValueAddToCartQuantityAdjusted);
        }
        emit(CartContentQuantityChangedSuccessState(message));
        break;
      case Failure(errorResponse: final errorResponse):
        emit(CartContentQuantityChangedFailureState(
            message: errorResponse.errorDescription ?? ''));
        break;
    }
  }

  Future<void> _onCartContentRemove(
      CartContentRemoveEvent event, Emitter<CartContentState> emit) async {
    _contentUseCase.trackEvent(AnalyticsEvent(
            AnalyticsConstants.eventRemoveCartLine,
            AnalyticsConstants.screenNameCart)
        .withProperty(
          name: AnalyticsConstants.eventPropertyErpNumber,
          strValue: event.cartLine.erpNumber,
        )
        .withProperty(
          name: AnalyticsConstants.eventPropertyOrderNumber,
          strValue: event.orderNumber,
        ));

    final result = await _contentUseCase.deleteCartLine(event.cartLine);
    switch (result) {
      case Success(value: final data):
        emit(CartContentItemRemovedSuccessState());
        break;
      case Failure(errorResponse: final errorResponse):
        emit(CartContentItemRemovedFailureState(
            errorResponse.errorDescription ?? ''));
        break;
    }
  }

  Future<void> _onCartContentClearAll(
      CartContentClearAllEvent event, Emitter<CartContentState> emit) async {
    final result = await _contentUseCase.clearCart();
    switch (result) {
      case Success(value: final data):
        emit(CartContentClearAllSuccessState());
        break;
      case Failure(errorResponse: final errorResponse):
        emit(CartContentClearAllFailureState(
            errorResponse.errorDescription ?? ''));
        break;
    }
  }

  bool showRemoveButtonForPromotionItem(CartLineEntity cartLineEntity) {
    if (cartLineEntity.isPromotionItem ?? false) {
      return false;
    }
    return true;
  }
}
