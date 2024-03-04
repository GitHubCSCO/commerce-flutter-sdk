import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/usecases/porduct_details_usecase/product_details_id_fetch_usecase_dart.dart';
import 'package:commerce_flutter_app/features/domain/usecases/product_carousel_usecase/product_carousel_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_id_fetch_cubit/product_id_fetch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductIDFetchCubit extends Cubit<ProductIdFetchState> {
  final ProductDetailsIdFetchUseCase _productDetailsIdFetchUseCase;

  ProductIDFetchCubit(
      {required ProductDetailsIdFetchUseCase productDetailsIdFetchUseCase})
      : _productDetailsIdFetchUseCase = productDetailsIdFetchUseCase,
        super(ProductIdFetchInitial());

  Future<void> getProductId(ProductEntity productEntity) async {
    var productIdFromCatalog = '';
    var response = await _productDetailsIdFetchUseCase
        .getProductDetailsId(productEntity.urlSegment ?? '');
    switch (response) {
      case Success(value: final data):
        productIdFromCatalog = data ?? '';
        break;
      case Failure():
        break;
    }
    var productId =
        productEntity.styleParentId ?? productEntity.id ?? productIdFromCatalog;

    emit(ProductIdFetchSuccess(productId: productId));
  }
}
