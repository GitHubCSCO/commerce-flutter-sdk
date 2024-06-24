import 'package:commerce_flutter_app/features/domain/enums/search_product_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product/product_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
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
            selectedAttributeValueIds: const [],
            selectedBrandIds: const [],
            selectedProductLineIds: const [],
            selectedCategoryId: '',
            previouslyPurchased: false,
            selectedStockedItems: false,
          ),
        );

  void setProductFilter(ProductPageEntity entity) {
    switch (entity.parentType) {
      case ProductParentType.category:
        emit(state.copyWith(selectedCategoryId: entity.category?.id));
        break;
      case ProductParentType.brand:
      case ProductParentType.brandProductLine:
        emit(state.copyWith(selectedBrandIds: [entity.brandEntity?.id ?? '']));
        break;
    }
  }

  void loadInitialSearchProducts(
      GetProductCollectionResult? productCollectionResult) {
    query = productCollectionResult?.originalQuery;

    final sortOptions = productCollectionResult?.pagination?.sortOptions ?? [];
    final availableSortOrders = _searchUseCase.getAvailableSortOrders(
      sortOptions: sortOptions,
    );
    final selectedSortOrder = _searchUseCase.getSelectedSortOrder(
      availableSortOrders: availableSortOrders,
      selectedSortOrderType: productCollectionResult?.pagination?.sortType ?? '',
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
      selectedAttributeValueIds: state.selectedAttributeValueIds,
      selectedBrandIds: state.selectedBrandIds,
      selectedProductLineIds: state.selectedProductLineIds,
      selectedCategoryId: state.selectedCategoryId,
      previouslyPurchased: state.previouslyPurchased,
      selectedStockedItems: state.selectedStockedItems,
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

  Future<void> sortOrderChanged(SortOrderAttribute sortOrder) async {
    emit(state.copyWith(
      searchProductStatus: SearchProductStatus.loading,
      selectedSortOrder: sortOrder,
    ));

    await _loadSearchProducts();
  }

  Future<void> _loadSearchProducts() async {
    final result = await _searchUseCase.loadSearchProductsResults(
      state.productEntities?.originalQuery ?? '',
      1,
      selectedSortOrder: state.selectedSortOrder,
      selectedAttributeValueIds: state.selectedAttributeValueIds,
      selectedBrandIds: state.selectedBrandIds,
      selectedProductLineIds: state.selectedProductLineIds,
      selectedCategoryId: state.selectedCategoryId,
      previouslyPurchased: state.previouslyPurchased,
      selectedStockedItems: state.selectedStockedItems,
    );

    switch (result) {
      case Success(value: final data):
        if (data == null) {
          emit(
              state.copyWith(searchProductStatus: SearchProductStatus.failure));
          return;
        }

        final sortOptions = data.pagination?.sortOptions ?? [];
        final availableSortOrders = _searchUseCase.getAvailableSortOrders(
          sortOptions: sortOptions,
        );

        final selectedSortOrder = _searchUseCase.getSelectedSortOrder(
          availableSortOrders: availableSortOrders,
          selectedSortOrderType: data.pagination?.sortType ?? '',
        );

        emit(
          state.copyWith(
            productEntities: data,
            searchProductStatus: SearchProductStatus.success,
            availableSortOrders: availableSortOrders,
            selectedSortOrder: selectedSortOrder,
          ),
        );
      default:
        emit(state.copyWith(searchProductStatus: SearchProductStatus.failure));
    }
  }

  Future<void> applyFilter({
    required List<String> selectedAttributeValueIds,
    required List<String> selectedBrandIds,
    required List<String> selectedProductLineIds,
    required String selectedCategoryId,
    required bool previouslyPurchased,
    required bool selectedStockedItems,
  }) async {
    if (!listEquals(
            state.selectedAttributeValueIds, selectedAttributeValueIds) ||
        !listEquals(state.selectedBrandIds, selectedBrandIds) ||
        !listEquals(state.selectedProductLineIds, selectedProductLineIds) ||
        state.selectedCategoryId != selectedCategoryId ||
        previouslyPurchased != state.previouslyPurchased ||
        selectedStockedItems != state.selectedStockedItems) {
      emit(
        state.copyWith(
          selectedAttributeValueIds: selectedAttributeValueIds,
          selectedBrandIds: selectedBrandIds,
          selectedProductLineIds: selectedProductLineIds,
          selectedCategoryId: selectedCategoryId,
          previouslyPurchased: previouslyPurchased,
          selectedStockedItems: selectedStockedItems,
          searchProductStatus: SearchProductStatus.loading,
        ),
      );

      await _loadSearchProducts();
    }
  }

  int get selectedFiltersCount {
    /// Depending on the product list type, the number of selected filters will be different
    /// For now, we are only supporting search products
    var valueIdsCount = state.selectedAttributeValueIds.length +
        (state.previouslyPurchased ? 1 : 0) +
        (state.selectedStockedItems ? 1 : 0);
    // if (state.productListType == ProductListType.searchProducts) {
    return valueIdsCount +
        state.selectedBrandIds.length +
        state.selectedProductLineIds.length +
        (state.selectedCategoryId.isNotEmpty ? 1 : 0);
    // } else if (state.productListType == ProductListType.categoryProducts) {
    //   return valueIdsCount + state.selectedBrandIds.length + state.selectedProductLineIds.length;
    // } else if (state.productListType == ProductListType.shopBrandProducts) {
    //   return valueIdsCount + state.selectedProductLineIds.length + (state.selectedCategoryId.isNotEmpty ? 1 : 0);
    // } else if (state.productListType == ProductListType.shopBrandCategoryProducts) {
    //   return valueIdsCount + state.selectedProductLineIds.length;
    // } else if (state.productListType == ProductListType.shopBrandProductLineProducts) {
    //   return valueIdsCount + (state.selectedCategoryId.isNotEmpty ? 1 : 0);
    // } else {
    //   return 0;
    // }
  }
}
