import 'package:commerce_flutter_app/features/domain/enums/product_list_filter_status.dart';
import 'package:commerce_flutter_app/features/domain/enums/product_list_type.dart';
import 'package:commerce_flutter_app/features/domain/usecases/product_list_filter_usecase/product_list_filter_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'product_list_filter_state.dart';

class ProductListFilterCubit extends Cubit<ProductListFilterState> {
  final ProductListFilterUsecase _productListFilterUsecase;

  ProductListFilterCubit(
      {required ProductListFilterUsecase productListFilterUsecase})
      : _productListFilterUsecase = productListFilterUsecase,
        super(
          ProductListFilterState(
            productsParameters: ProductsQueryParameters(),
            productSettings: ProductSettings(),
            searchSettings: SearchSettings(),
            status: ProductListFilterStatus.initial,
            filterValues: const [],
          ),
        );

  Future<void> initialize({
    required ProductListType productListType,
    required ProductsQueryParameters productsParameters,
  }) async {
    emit(
      state.copyWith(
        status: ProductListFilterStatus.loading,
        productsParameters: productsParameters,
      ),
    );

    final settingsCollection =
        await _productListFilterUsecase.loadSettingsCollection();

    if (settingsCollection == null) {
      emit(state.copyWith(status: ProductListFilterStatus.failure));
      return;
    }

    emit(
      state.copyWith(
        productSettings: settingsCollection.productSettings,
        searchSettings: settingsCollection.searchSettings,
      ),
    );

    await loadFilters(productListType: productListType);
  }

  Future<void> loadFilters({
    required ProductListType productListType,
  }) async {
    if (state.status != ProductListFilterStatus.loading) {
      emit(state.copyWith(status: ProductListFilterStatus.loading));
    }

    final filters = await _productListFilterUsecase.loadFilters(
      productsQueryParameters: state.productsParameters,
      productSettings: state.productSettings,
      searchSettings: state.searchSettings,
      productListType: productListType,
      previouslyPurchased: state.productsParameters.previouslyPurchasedProducts,
      selectedStockedItems: state.productsParameters.stockedItemsOnly,
      selectedAttributeValueIds: state.productsParameters.attributeValueIds,
      selectedBrandIds: state.productsParameters.brandIds,
      selectedProductLineIds: state.productsParameters.productLineIds,
      selectedCategoryId: state.productsParameters.categoryId,
    );

    if (filters == null) {
      emit(state.copyWith(status: ProductListFilterStatus.failure));
      return;
    }

    emit(
      state.copyWith(
        filterValues: filters,
        status: ProductListFilterStatus.success,
      ),
    );
  }

  Future<void> selectFilter({
    required FilterValueViewModel filterValue,
    required ProductListType productListType,
  }) async {
    if (filterValue.facetType == null) {
      return;
    }

    switch (filterValue.facetType!) {
      case FacetType.previouslyPurchased:
        state.productsParameters.previouslyPurchasedProducts =
            filterValue.isSelected;
        break;

      case FacetType.stockedItemsFacet:
        state.productsParameters.stockedItemsOnly = filterValue.isSelected;
        break;

      case FacetType.categoryFacet:
        state.productsParameters.categoryId =
            (filterValue.isSelected ?? false) ? filterValue.id : null;
        break;

      case FacetType.brandFacet:
        state.productsParameters.brandIds = (filterValue.isSelected ?? false)
            ? [...?state.productsParameters.brandIds, filterValue.id]
            : state.productsParameters.brandIds
                ?.where((element) => element != filterValue.id)
                .toList();
        break;

      case FacetType.productLineFacet:
        state.productsParameters.productLineIds =
            (filterValue.isSelected ?? false)
                ? [...?state.productsParameters.productLineIds, filterValue.id]
                : state.productsParameters.productLineIds
                    ?.where((element) => element != filterValue.id)
                    .toList();
        break;

      case FacetType.attributeValueFacet:
        state.productsParameters.attributeValueIds = (filterValue.isSelected ??
                false)
            ? [...?state.productsParameters.attributeValueIds, filterValue.id]
            : state.productsParameters.attributeValueIds
                ?.where((element) => element != filterValue.id)
                .toList();
        break;
    }

    emit(state.copyWith(productsParameters: state.productsParameters));

    await loadFilters(
      productListType: productListType,
    );
  }

  Future<void> resetFilter({
    List<String>? selectedAttributeValueIds,
    List<String>? selectedBrandIds,
    List<String>? selectedProductLineIds,
    String? selectedCategoryId,
    bool? previouslyPurchased,
    bool? selectedStockedItems,
    String? searchText,
    required ProductListType productListType,
  }) async {
    state.productsParameters.attributeValueIds = selectedAttributeValueIds;
    state.productsParameters.brandIds = selectedBrandIds;
    state.productsParameters.productLineIds = selectedProductLineIds;
    state.productsParameters.categoryId = selectedCategoryId;
    state.productsParameters.previouslyPurchasedProducts = previouslyPurchased;
    state.productsParameters.stockedItemsOnly = selectedStockedItems;
    state.productsParameters.query = searchText;

    emit(state.copyWith(productsParameters: state.productsParameters));

    await loadFilters(
      productListType: productListType,
    );
  }
}
