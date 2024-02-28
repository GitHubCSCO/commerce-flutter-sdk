import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/product_carousel_usecase/product_carousel_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_id_fetch_cubit/product_id_fetch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductIDFetchCubit extends Cubit<ProductIdFetchState> {
  final ProductCarouselUseCase _productCarouselUseCase;

  ProductIDFetchCubit({required ProductCarouselUseCase productCarouselUseCase})
      : _productCarouselUseCase = productCarouselUseCase,
        super(ProductIdFetchInitial());

  Future<void> getProductId(ProductEntity productEntity) async {
    emit(ProductIdFetchSuccess(productId: productEntity.id.toString()));
  }
}
