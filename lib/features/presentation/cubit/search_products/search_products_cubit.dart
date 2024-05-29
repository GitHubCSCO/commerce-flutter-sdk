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
          SearchProductsState(
            productEntities: null,
            searchProductStatus: SearchProductStatus.initial,
            availableSortOrders: const [],
            selectedSortOrder: SortOrderAttribute(
              groupTitle: '',
              title: '',
              value: '',
            ),
          ),
        );

  void loadInitialSearchProducts(
      GetProductCollectionResult productCollectionResult) {
    query = productCollectionResult.originalQuery;

    final sortOptions = productCollectionResult.pagination?.sortOptions ?? [];
    final availableSortOrders = _searchUseCase.getAvailableSortOrders(
      sortOptions: sortOptions,
    );
    final selectedSortOrder = _searchUseCase.getSelectedSortOrder(
      availableSortOrders: availableSortOrders,
      selectedSortOrderType: productCollectionResult.pagination?.sortType ?? '',
    );

    emit(
      state.copyWith(
        productEntities: productCollectionResult,
        searchProductStatus: SearchProductStatus.success,
        availableSortOrders: availableSortOrders,
        selectedSortOrder: selectedSortOrder,
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
      selectedSortOrder: state.selectedSortOrder,
    );

    if (result == null) {
      emit(state.copyWith(
          searchProductStatus: SearchProductStatus.moreLoadingFailure));
      return;
    }

    final products = state.productEntities?.products;

    switch (result) {
      case Success(value: final data):
        products?.addAll(data?.products ?? []);
        state.productEntities?.products = products;
        state.productEntities?.pagination = data?.pagination;
      case Failure():
    }

    emit(
      state.copyWith(
        productEntities: state.productEntities,
        searchProductStatus: SearchProductStatus.success,
      ),
    );
  }

}
