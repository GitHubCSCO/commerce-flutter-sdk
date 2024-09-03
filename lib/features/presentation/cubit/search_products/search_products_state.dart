part of 'search_products_cubit.dart';

class SearchProductsState extends Equatable {
  final String? originalQuery;
  final List<ProductEntity>? productEntities;
  final PaginationEntity? paginationEntity;
  final StateStatus searchProductStatus;
  final List<SortOrderAttribute> availableSortOrders;
  final SortOrderAttribute selectedSortOrder;
  final List<String> selectedAttributeValueIds;
  final List<String> selectedBrandIds;
  final List<String> selectedProductLineIds;
  final String selectedCategoryId;
  final bool previouslyPurchased;
  final bool selectedStockedItems;
  final ProductSettings? productSettings;
  final ProductParentType? parentType;
  final bool productPricingEnabled;
  final bool? hidePricingEnabled;
  final bool? hideInventoryEnabled;
  final bool? canAddToCartInProductList;
  final String? message;

  const SearchProductsState({
    required this.originalQuery,
    required this.productEntities,
    required this.paginationEntity,
    required this.searchProductStatus,
    required this.availableSortOrders,
    required this.selectedSortOrder,
    required this.selectedAttributeValueIds,
    required this.selectedBrandIds,
    required this.selectedProductLineIds,
    required this.selectedCategoryId,
    required this.previouslyPurchased,
    required this.selectedStockedItems,
    required this.productSettings,
    required this.productPricingEnabled,
    required this.parentType,
    this.hidePricingEnabled,
    this.hideInventoryEnabled,
    this.canAddToCartInProductList,
    this.message,
  });

  @override
  List<Object> get props => [
        originalQuery ?? '',
        productEntities ?? [],
        searchProductStatus,
        availableSortOrders,
        selectedSortOrder,
        selectedAttributeValueIds,
        selectedBrandIds,
        selectedProductLineIds,
        selectedCategoryId,
        previouslyPurchased,
        selectedStockedItems,
        productSettings ?? ProductSettings(),
        productPricingEnabled,
        parentType == ProductParentType.search,
        hidePricingEnabled ?? false,
        hideInventoryEnabled ?? false,
        canAddToCartInProductList ?? false,
        message ?? '',
      ];

  SearchProductsState copyWith({
    String? originalQuery,
    List<ProductEntity>? productEntities,
    PaginationEntity? paginationEntity,
    StateStatus? searchProductStatus,
    List<SortOrderAttribute>? availableSortOrders,
    SortOrderAttribute? selectedSortOrder,
    List<String>? selectedAttributeValueIds,
    List<String>? selectedBrandIds,
    List<String>? selectedProductLineIds,
    String? selectedCategoryId,
    bool? previouslyPurchased,
    bool? selectedStockedItems,
    ProductSettings? productSettings,
    bool? productPricingEnabled,
    bool? hidePricingEnabled,
    bool? hideInventoryEnabled,
    bool? canAddToCartInProductList,
    ProductParentType? parentType,
    String? message,
  }) {
    return SearchProductsState(
      originalQuery: originalQuery ?? this.originalQuery,
      productEntities: productEntities ?? this.productEntities,
      paginationEntity: paginationEntity ?? this.paginationEntity,
      searchProductStatus: searchProductStatus ?? this.searchProductStatus,
      availableSortOrders: availableSortOrders ?? this.availableSortOrders,
      selectedSortOrder: selectedSortOrder ?? this.selectedSortOrder,
      selectedAttributeValueIds:
          selectedAttributeValueIds ?? this.selectedAttributeValueIds,
      selectedBrandIds: selectedBrandIds ?? this.selectedBrandIds,
      selectedProductLineIds:
          selectedProductLineIds ?? this.selectedProductLineIds,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      previouslyPurchased: previouslyPurchased ?? this.previouslyPurchased,
      selectedStockedItems: selectedStockedItems ?? this.selectedStockedItems,
      productSettings: productSettings ?? this.productSettings,
      productPricingEnabled:
          productPricingEnabled ?? this.productPricingEnabled,
      hidePricingEnabled: hidePricingEnabled ?? this.hidePricingEnabled,
      hideInventoryEnabled: hideInventoryEnabled ?? this.hideInventoryEnabled,
      canAddToCartInProductList:
          canAddToCartInProductList ?? this.canAddToCartInProductList,
      parentType: parentType ?? this.parentType,
      message: message ?? this.message,
    );
  }
}
