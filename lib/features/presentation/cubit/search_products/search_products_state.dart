part of 'search_products_cubit.dart';

class SearchProductsState extends Equatable {
  final GetProductCollectionResult? productEntities;
  final SearchProductStatus searchProductStatus;
  final List<SortOrderAttribute> availableSortOrders;
  final SortOrderAttribute selectedSortOrder;
  final List<String> selectedAttributeValueIds;
  final List<String> selectedBrandIds;
  final List<String> selectedProductLineIds;
  final String selectedCategoryId;
  final bool previouslyPurchased;
  final bool selectedStockedItems;
  final ProductSettings? productSettings;
  final bool productPricingEnabled;

  const SearchProductsState({
    required this.productEntities,
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
  });

  @override
  List<Object> get props => [
        productEntities ?? GetProductCollectionResult(),
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
      ];

  SearchProductsState copyWith({
    GetProductCollectionResult? productEntities,
    SearchProductStatus? searchProductStatus,
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
  }) {
    return SearchProductsState(
      productEntities: productEntities ?? this.productEntities,
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
      productPricingEnabled: productPricingEnabled ?? this.productPricingEnabled,
    );
  }
}
