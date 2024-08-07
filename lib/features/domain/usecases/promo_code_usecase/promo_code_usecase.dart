import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class PromoCodeUsecase extends BaseUseCase {
  PromoCodeUsecase() : super();

  Future<Result<Promotion, ErrorResponse>> applyPromoCode(
      AddPromotion addPromotion) async {
    return await commerceAPIServiceProvider
        .getCartService()
        .applyPromotion(addPromotion);
  }

  Future<Result<PromotionCollectionModel, ErrorResponse>>
      loadCartPromotions() async {
    return await commerceAPIServiceProvider
        .getCartService()
        .getCurrentCartPromotions();
  }
}
