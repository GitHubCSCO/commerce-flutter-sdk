import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product/product_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'product_event.dart';
part 'product_state.dart';

//TODO confusing name: ProductCollectionBloc or ListProductBloc would've made sense
class ProductBloc extends Bloc<ProductEvent, ProductState> {

  final SearchUseCase _searchUseCase;

  ProductBloc({required SearchUseCase searchUseCase})
      : _searchUseCase = searchUseCase,
        super(ProductInitial()) {
    on<ProductLoadEvent>((event, emit) => _onProductLoadEvent(event, emit));
  }

  Future<void> _onProductLoadEvent(ProductLoadEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());

    Result<GetProductCollectionResult, ErrorResponse>? result;
    if (event.entity.parentType == ProductParentType.category) {
      result = await _searchUseCase.loadSearchProductsResults(event.entity.query, 1,
          selectedCategoryId: event.entity.category?.id ?? event.entity.categoryId ??'');
    }else if (event.entity.parentType == ProductParentType.brand || event.entity.parentType == ProductParentType.brandCategory) {
      result = await _searchUseCase.loadSearchProductsResults(event.entity.query, 1,
          selectedCategoryId: event.entity.categoryId,
          selectedBrandIds: [event.entity.brandEntity?.id ?? event.entity.brandEntityId ?? '']);
    }else if (event.entity.parentType == ProductParentType.brandProductLine) {
      result = await _searchUseCase.loadSearchProductsResults(event.entity.query, 1,
          selectedProductLineIds: [event.entity.brandProductLine?.id ?? ''],
          selectedBrandIds: [event.entity.brandEntity?.id ?? event.entity.brandEntityId ?? '']);
    }

    switch (result) {
      case Success(value: final data):
        emit(ProductLoaded(result: data));
      case Failure(errorResponse: final errorResponse):
        emit(ProductFailed(errorResponse.errorDescription ?? ''));
      default:
    }
  }

}
