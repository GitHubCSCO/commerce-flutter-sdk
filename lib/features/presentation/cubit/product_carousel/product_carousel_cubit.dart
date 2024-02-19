import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/product_carousel_widget_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/product_carousel_usecase/product_carousel_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'product_carousel_state.dart';

class ProductCarouselCubit extends Cubit<ProductCarouselState> {
  final ProductCarouselUseCase _productCarouselUseCase;

  ProductCarouselCubit({required ProductCarouselUseCase productCarouselUseCase})
      : _productCarouselUseCase = productCarouselUseCase,
        super(ProductCarouselInitialState());

  Future<void> getProducts(ProductCarouselWidgetEntity widgetEntity) async {
    var result = await _productCarouselUseCase.getProducts(widgetEntity);
    if (!isClosed) {
      switch (result) {
        case Success():
          emit(ProductCarouselLoadedState(productList: result.value!));
        case Failure():
          emit(ProductCarouselFailureState(
              error: result.errorResponse.errorDescription!));
        case null:
        // TODO: Handle this case.
      }
    }
  }

  Future<void> getProductId(ProductEntity productEntity) async {
    emit(ProductIdFetchState(productId: productEntity.id.toString()));
  }
}
