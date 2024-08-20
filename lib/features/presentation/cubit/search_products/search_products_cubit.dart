import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/core/mixins/realtime_pricing_inventory_update_mixin.dart';
import 'package:commerce_flutter_app/features/domain/entity/pagination_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/search_product_status.dart';
import 'package:commerce_flutter_app/features/domain/mapper/pagination_entity_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/pricing_inventory_usecase/pricing_inventory_usecase.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/screens/product/product_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'search_products_state.dart';

class SearchProductsCubit extends Cubit<SearchProductsState>
    with RealtimePricingInventoryUpdateMixin {
  final SearchUseCase _searchUseCase;
  final PricingInventoryUseCase _pricingInventoryUseCase;
  String? query;
  bool? hidePricingEnable;
  bool? hideInventoryEnable;
  bool? canAddToCartInProductList;

  SearchProductsCubit(
      {required SearchUseCase searchUseCase,
      required PricingInventoryUseCase pricingInventoryUseCase})
      : _searchUseCase = searchUseCase,
        _pricingInventoryUseCase = pricingInventoryUseCase,
        super(
          SearchProductsState(
            originalQuery: '',
            productEntities: null,
            paginationEntity: null,
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
            productSettings: null,
            productPricingEnabled: false,
            parentType: ProductParentType.search,
          ),
        );

  void setProductFilter(ProductPageEntity entity) {
    switch (entity.parentType) {
      case ProductParentType.category:
        emit(state.copyWith(
            selectedCategoryId: entity.category?.id,
            parentType: entity.parentType));
        break;
      case ProductParentType.brandCategory:
        emit(state.copyWith(
            selectedCategoryId: entity.categoryId,
            selectedBrandIds: [entity.brandEntity?.id ?? ''],
            parentType: entity.parentType));
        break;
      case ProductParentType.brand:
        emit(state.copyWith(selectedBrandIds: [
          entity.brandEntity?.id ?? entity.brandEntityId ?? '',
        ], parentType: entity.parentType));
      case ProductParentType.brandProductLine:
        emit(
          state.copyWith(selectedBrandIds: [
            entity.brandEntity?.id ?? entity.brandEntityId ?? ''
          ], selectedProductLineIds: [
            entity.brandProductLine?.id ?? ''
          ], parentType: entity.parentType),
        );
        break;
      case ProductParentType.search:
        break;
    }
  }

  void loadInitialSearchProducts(
      GetProductCollectionResult? productCollectionResult) async {
    emit(state.copyWith(searchProductStatus: SearchProductStatus.loading));

    query = productCollectionResult?.originalQuery;

    final sortOptions = productCollectionResult?.pagination?.sortOptions ?? [];
    final availableSortOrders = _searchUseCase.getAvailableSortOrders(
      sortOptions: sortOptions,
    );
    final selectedSortOrder = _searchUseCase.getSelectedSortOrder(
      availableSortOrders: availableSortOrders,
      selectedSortOrderType:
          productCollectionResult?.pagination?.sortType ?? '',
    );

    final productSettings =
        (await _pricingInventoryUseCase.loadProductSettings())
            .getResultSuccessValue();
    final productPricingEnabled =
        await _pricingInventoryUseCase.getProductPricingEnable();
    hidePricingEnable = _pricingInventoryUseCase.getHidePricingEnable();
    hideInventoryEnable = _pricingInventoryUseCase.getHideInventoryEnable();
    canAddToCartInProductList =
        await _searchUseCase.canAddToCartInProductList();

    List<ProductEntity> productEntities =
        await updateProductPricingAndInventoryAvailability(
            _pricingInventoryUseCase, productCollectionResult?.products,
            hidePricing: hidePricingEnable, hideInventory: hideInventoryEnable);

    emit(
      state.copyWith(
        originalQuery: query ?? '',
        productEntities: productEntities,
        paginationEntity: PaginationEntityMapper.toEntity(
            productCollectionResult?.pagination ?? Pagination()),
        searchProductStatus: SearchProductStatus.success,
        availableSortOrders: availableSortOrders,
        selectedSortOrder: selectedSortOrder,
        productSettings: productSettings,
        productPricingEnabled: productPricingEnabled,
        hidePricingEnabled: hidePricingEnable,
        hideInventoryEnabled: hideInventoryEnable,
        canAddToCartInProductList: canAddToCartInProductList,
      ),
    );
  }

  Future<void> loadMoreSearchProducts() async {
    if (state.paginationEntity?.page == null ||
        (state.paginationEntity?.page ?? 0) + 1 >
            (state.paginationEntity?.numberOfPages ?? 0) ||
        state.searchProductStatus == SearchProductStatus.moreLoading) {
      return;
    }

    emit(state.copyWith(searchProductStatus: SearchProductStatus.moreLoading));
    final result = await _searchUseCase.loadSearchProductsResults(
      state.originalQuery ?? '',
      (state.paginationEntity?.page ?? 0) + 1,
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

    switch (result) {
      case Success(value: final data):
        final productEntities =
            await updateProductPricingAndInventoryAvailability(
                _pricingInventoryUseCase, data?.products,
                hidePricing: hidePricingEnable,
                hideInventory: hideInventoryEnable);
        state.productEntities?.addAll(productEntities);
        emit(
          state.copyWith(
            productEntities: state.productEntities,
            paginationEntity: PaginationEntityMapper.toEntity(
                data?.pagination ?? Pagination()),
            searchProductStatus: SearchProductStatus.success,
          ),
        );
      case Failure():
        emit(state.copyWith(
            searchProductStatus: SearchProductStatus.moreLoadingFailure));
    }
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
      state.originalQuery ?? '',
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

        final productEntities =
            await updateProductPricingAndInventoryAvailability(
                _pricingInventoryUseCase, data.products,
                hidePricing: hidePricingEnable,
                hideInventory: hideInventoryEnable);

        emit(
          state.copyWith(
            productEntities: productEntities,
            paginationEntity: PaginationEntityMapper.toEntity(
                data.pagination ?? Pagination()),
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
    var valueIdsCount = state.selectedAttributeValueIds.length +
        (state.previouslyPurchased ? 1 : 0) +
        (state.selectedStockedItems ? 1 : 0);
    if (state.parentType == ProductParentType.search) {
      return valueIdsCount +
          state.selectedBrandIds.length +
          state.selectedProductLineIds.length +
          (state.selectedCategoryId.isNotEmpty ? 1 : 0);
    } else if (state.parentType == ProductParentType.category) {
      return valueIdsCount +
          state.selectedBrandIds.length +
          state.selectedProductLineIds.length;
    } else if (state.parentType == ProductParentType.brand) {
      return valueIdsCount +
          state.selectedProductLineIds.length +
          (state.selectedCategoryId.isNotEmpty ? 1 : 0);
    } else if (state.parentType == ProductParentType.brandCategory) {
      return valueIdsCount + state.selectedProductLineIds.length;
    } else if (state.parentType == ProductParentType.brandProductLine) {
      return valueIdsCount + (state.selectedCategoryId.isNotEmpty ? 1 : 0);
    } else {
      return 0;
    }
  }
}
