import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/extensions/result_extension.dart';
import 'package:commerce_flutter_app/features/domain/entity/availability_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/product_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/search_product_status.dart';
import 'package:commerce_flutter_app/features/domain/mapper/availability_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_mapper.dart';
import 'package:commerce_flutter_app/features/domain/mapper/product_price_mapper.dart';
import 'package:commerce_flutter_app/features/domain/usecases/search_usecase/search_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/cubit/product_carousel/product_carousel_cubit.dart';
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
            productSettings: null,
            productPricingEnabled: false,
          ),
        );

  void setProductFilter(ProductPageEntity entity) {
    switch (entity.parentType) {
      case ProductParentType.category:
        emit(state.copyWith(selectedCategoryId: entity.category?.id));
        break;
      case ProductParentType.brandCategory:
        emit(state.copyWith(
            selectedCategoryId: entity.categoryId,
            selectedBrandIds: [entity.brandEntity?.id ?? '']));
        break;
      case ProductParentType.brand:
        emit(state.copyWith(selectedBrandIds: [entity.brandEntity?.id ?? entity.brandEntityId ?? '']));
      case ProductParentType.brandProductLine:
        emit(
          state.copyWith(
            selectedBrandIds: [
              entity.brandEntity?.id ?? entity.brandEntityId ?? ''
            ],
            selectedProductLineIds: [entity.brandProductLine?.id ?? '']
          ),
        );
        break;
    }
  }

  void loadInitialSearchProducts(
      GetProductCollectionResult? productCollectionResult) async {
    query = productCollectionResult?.originalQuery;

    final sortOptions = productCollectionResult?.pagination?.sortOptions ?? [];
    final availableSortOrders = _searchUseCase.getAvailableSortOrders(
      sortOptions: sortOptions,
    );
    final selectedSortOrder = _searchUseCase.getSelectedSortOrder(
      availableSortOrders: availableSortOrders,
      selectedSortOrderType: productCollectionResult?.pagination?.sortType ?? '',
    );

    final productSettings = (await _searchUseCase.loadProductSettings()).getResultSuccessValue();
    final productPricingEnabled = await _searchUseCase.getProductPricingEnable();

    final products = await updateProductPricingAndInventoryAvailability(productCollectionResult?.products);

    productCollectionResult?.products = products;

    emit(
      state.copyWith(
        productEntities: productCollectionResult,
        searchProductStatus: SearchProductStatus.success,
        availableSortOrders: availableSortOrders,
        selectedSortOrder: selectedSortOrder,
        productSettings: productSettings,
        productPricingEnabled: productPricingEnabled,
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

    final products = await updateProductPricingAndInventoryAvailability(state.productEntities?.products);

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

  Future<List<Product>> updateProductPricingAndInventoryAvailability(List<Product>? products) async {

    final productPricingEnabled =
        await _searchUseCase.getProductPricingEnable();
    final productAvailabilityEnabled = await _searchUseCase.getProductInventoryAvailable();

    final productList = products
        ?.map((product) => ProductEntityMapper().toEntity(product))
        .toList() ??
        [];

    final realTimeResult = await _searchUseCase.getRealtimeSupportType();

    if (productPricingEnabled && realTimeResult != null) {
      if (realTimeResult == RealTimeSupport.RealTimePricingOnly ||
          realTimeResult ==
              RealTimeSupport.RealTimePricingWithInventoryIncluded ||
          realTimeResult == RealTimeSupport.RealTimePricingAndInventory) {
        final productPriceParameters = productList
            .map((product) => ProductPriceQueryParameter(
          productId: product.id,
          qtyOrdered: 1,
          unitOfMeasure: product.unitOfMeasure,
        )).toList();

        final parameter = RealTimePricingParameters(
            productPriceParameters: productPriceParameters);

        final pricingResult =
            await _searchUseCase.getRealTimePricing(parameter);

        switch (pricingResult) {
          case Success():
            for (var productEntity in productList) {
              var matchingPrice = pricingResult.value?.realTimePricingResults
                  ?.firstWhere((o) => o.productId == productEntity!.id);
              productEntity?.pricing =
                  ProductPriceEntityMapper().toEntity(matchingPrice);
            }
          case Failure():
          default:
        }
      }
    }

    if (productAvailabilityEnabled && realTimeResult != null) {
      if (realTimeResult == RealTimeSupport.NoRealTimePricingAndInventory ||
          realTimeResult == RealTimeSupport.RealTimePricingAndInventory ||
          realTimeResult == RealTimeSupport.RealTimePricingWithInventoryIncluded ||
          realTimeResult == RealTimeSupport.RealTimeInventory) {
        final inventoryProducts = productList.map((product) => product?.id ?? '').toList();
        final parameters = RealTimeInventoryParameters(
          productIds: inventoryProducts,
        );

        final realTimeInventoryResult = (await _searchUseCase.getRealTimeInventory(parameters)).getResultSuccessValue();

        if (realTimeInventoryResult?.realTimeInventoryResults != null) {
          for (ProductInventory realTimeInventory in realTimeInventoryResult?.realTimeInventoryResults ?? []) {
            for (var productEntity in productList) {
              if (realTimeInventory.productId == productEntity?.id) {
                var product = productEntity;
                late AvailabilityEntity? productAvailability;
                final qtyOnHand = realTimeInventory.qtyOnHand;

                var inventoryAvailability = realTimeInventory.inventoryAvailabilityDtos
                    ?.singleWhere(
                        (ia) => ia.unitOfMeasure == product?.unitOfMeasure);
                if (inventoryAvailability != null) {
                  productAvailability = AvailabilityEntityMapper().toEntity(inventoryAvailability.availability);
                } else {
                  productAvailability = AvailabilityEntityMapper().toEntity(Availability(messageType: 0));
                }

                product?.productUnitOfMeasures?.forEach((productUnitOfMeasureEntity) {
                  var unitOfMeasureAvailability = realTimeInventory
                      .inventoryAvailabilityDtos
                      ?.singleWhere((i) => i.unitOfMeasure == productUnitOfMeasureEntity.unitOfMeasure);

                  late Availability? availability;
                  if (unitOfMeasureAvailability != null) {
                    availability = unitOfMeasureAvailability.availability;
                  } else {
                    availability = Availability(messageType: 0);
                  }

                  productUnitOfMeasureEntity.copyWith(
                    availability: AvailabilityEntityMapper().toEntity(availability),
                  );
                });

                if (product != null && (product.isStyleProductParent ?? false) &&
                    product.productUnitOfMeasures != null &&
                    product.selectedUnitOfMeasure != null) {
                  var productUnitOfMeasure = product.productUnitOfMeasures
                      ?.singleWhere(
                          (uom) => uom.unitOfMeasure == product.selectedUnitOfMeasure);
                  if (productUnitOfMeasure != null &&
                      productUnitOfMeasure.availability != null) {
                    productAvailability = productUnitOfMeasure.availability;
                  }
                }

                product.availability = productAvailability;

                // product = product.copyWith(
                //     availability: productAvailability,
                //     qtyOnHand: qtyOnHand
                // );
                //
                // final List<Product> dafaf = [];
                // dafaf.add(ProductEntityMapper().toModel(product));
              }
            }
          }
        } else {
          for (var product in productList) {
            final productAvailability = Availability(
              messageType: 0,
              message: LocalizationConstants.unableToRetrieveInventory,
            );

            product.availability = AvailabilityEntityMapper().toEntity(productAvailability);
            // product?.copyWith(
            //   availability: AvailabilityEntityMapper().toEntity(productAvailability),
            // );
          }
        }
      }
    }

    final List<Product> list = [];

    for (var product in productList) {
      list.add(ProductEntityMapper().toModel(product));
    }

    return list;

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
