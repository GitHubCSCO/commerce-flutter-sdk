import 'package:commerce_flutter_app/features/domain/enums/search_product_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'search_products_state.dart';

class SearchProductsCubit extends Cubit<SearchProductsState> {
  final SearchUseCase _searchUseCase;
  String? query;

  SearchProductsCubit({required SearchUseCase searchUseCase})
      : _searchUseCase = searchUseCase,
        super(
        const SearchProductsState(
          productEntities: null,
          searchProductStatus: SearchProductStatus.initial,
        ),
      );

  void loadInitialSearchProducts(GetProductCollectionResult productCollectionResult) {
    query = productCollectionResult.originalQuery;
    emit(
      state.copyWith(
        productEntities: productCollectionResult,
        searchProductStatus: SearchProductStatus.success,
      ),
    );
  }

  Future<void> loadMoreSearchProducts() async {
    if (state.productEntities?.pagination?.page == null ||
        (state.productEntities?.pagination?.page ?? 0) + 1 >
            state.productEntities!.pagination!.numberOfPages! ||
        state.searchProductStatus == SearchProductStatus.moreLoading) {
      return;
    }

    emit(state.copyWith(searchProductStatus: SearchProductStatus.moreLoading));
    final result = await _searchUseCase.loadSearchProductsResults(
      state.productEntities?.originalQuery ?? '',
      (state.productEntities?.pagination?.page ?? 0) + 1,
    );

    if (result == null) {
      emit(state.copyWith(searchProductStatus: SearchProductStatus.moreLoadingFailure));
      return;
    }

    final products = state.productEntities?.products;

    switch (result) {
      case Success(value: final data):
        products?.addAll(data?.products ?? []);
        state.productEntities?.products = products;
        state.productEntities?.pagination = data?.pagination;
      case Failure(errorResponse: final errorResponse):
      default:
    }

    emit(
      state.copyWith(
        productEntities: state.productEntities,
        searchProductStatus: SearchProductStatus.success,
      ),
    );
  }

}
