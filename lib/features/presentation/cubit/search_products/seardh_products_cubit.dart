import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_products_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/search_products/search_products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchProductsCubit extends Cubit<SearchProductsState> {
  final SearchProductsusecase _searchProductsusecase;

  SearchProductsCubit({required SearchProductsusecase searchProductsusecase})
      : _searchProductsusecase = searchProductsusecase,
        super(SearchProductsInitial());

  Future<void> searchPorductAddToCard(String productId) async {
    var addCartLine = AddCartLine(
      productId: productId,
    );

    final response = await _searchProductsusecase.addToCart(addCartLine);

    switch (response) {
      case Success(value: final data):
        emit(SearchProductsAddToCartSuccess());
        break;
      case Failure(errorResponse: final errorResponse):
        emit(SearchProductsAddToCartFailure(
            errorResponse: errorResponse.errorDescription ?? ''));
        break;
    }
  }
}
