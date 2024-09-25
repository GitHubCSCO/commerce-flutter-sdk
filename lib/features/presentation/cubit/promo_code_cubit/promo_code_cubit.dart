import 'package:commerce_flutter_app/core/constants/analytics_constants.dart';
import 'package:commerce_flutter_app/features/domain/entity/analytics_event.dart';
import 'package:commerce_flutter_app/features/domain/usecases/promo_code_usecase/promo_code_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/promo_code_cubit/promo_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PromoCodeCubit extends Cubit<PromoCodeState> {
  final PromoCodeUsecase _promoCodeUsecase;
  bool showPromotionField = false;

  PromoCodeCubit({required PromoCodeUsecase promoCodeUsecase})
      : _promoCodeUsecase = promoCodeUsecase,
        super(PromoCodeInitialState());

  Future<void> applyPromoCode(String promoCode, bool isFromCartPage) async {
    if (isFromCartPage) {
      _promoCodeUsecase.trackEvent(AnalyticsEvent(
              AnalyticsConstants.eventApplyPromoCart,
              AnalyticsConstants.screenNameCart)
          .withProperty(
              name: AnalyticsConstants.eventPromoCode, strValue: promoCode));
    } else {
      _promoCodeUsecase.trackEvent(AnalyticsEvent(
              AnalyticsConstants.eventAddDiscountCheckout,
              AnalyticsConstants.screenNameCheckout)
          .withProperty(
              name: AnalyticsConstants.eventPromoCode, strValue: promoCode));
    }

    var promoCodeResponse = await _promoCodeUsecase
        .applyPromoCode(AddPromotion(promotionCode: promoCode));

    switch (promoCodeResponse) {
      case Success(value: final value):
        {
          emit(PromoCodeApplySuccessState());
          break;
        }

      case Failure(errorResponse: final errorResponse):
        {
          emit(PromoCodeFailureState(message: errorResponse.message ?? ""));
          break;
        }
    }
  }

  Future<void> loadCartPromotions() async {
    emit(PromoCodeLoadingState());
    var promotionsResult = await _promoCodeUsecase.loadCartPromotions();
    PromotionCollectionModel? promotionCollection = promotionsResult is Success
        ? (promotionsResult as Success).value as PromotionCollectionModel
        : null;

    emit(PromoCodeLoadedState(
        promotions: promotionCollection?.promotions ?? []));
  }

  void updateShowPromotionField() {
    showPromotionField = true;
  }

  void resetShowPromotionField() {
    showPromotionField = false;
  }
}
