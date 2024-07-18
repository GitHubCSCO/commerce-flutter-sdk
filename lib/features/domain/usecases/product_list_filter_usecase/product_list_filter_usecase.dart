import 'package:collection/collection.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/features/domain/enums/product_list_type.dart';
import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_app/features/presentation/components/filter.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ProductListFilterUsecase extends BaseUseCase {
  Future<SettingsCollection?> loadSettingsCollection() async {
    final result = await commerceAPIServiceProvider
        .getSettingsService()
        .getSettingsAsync();
    switch (result) {
      case Success(value: final settings):
        return settings?.settingsCollection;
      case Failure():
        return null;
    }
  }

  Future<List<FilterValueViewModelCollection>?> loadFilters({
    List<String>? selectedAttributeValueIds,
    List<String>? selectedBrandIds,
    List<String>? selectedProductLineIds,
    String? selectedCategoryId,
    bool? previouslyPurchased,
    bool? selectedStockedItems,
    required ProductsQueryParameters productsQueryParameters,
    required ProductListType productListType,
    required SearchSettings searchSettings,
    required ProductSettings productSettings,
  }) async {
    productsQueryParameters.attributeValueIds = selectedAttributeValueIds;
    productsQueryParameters.brandIds = selectedBrandIds;
    productsQueryParameters.productLineIds = selectedProductLineIds;
    productsQueryParameters.categoryId = selectedCategoryId;
    productsQueryParameters.previouslyPurchasedProducts = previouslyPurchased;
    productsQueryParameters.stockedItemsOnly = selectedStockedItems;

    final result =
        await commerceAPIServiceProvider.getProductService().getProducts(
              productsQueryParameters,
            );

    switch (result) {
      case Success(value: final productResult):
        final availableFiltersCollection = await getAvailableFiltersCollection(
          requestResult: productResult,
          productListType: productListType,
          searchSettings: searchSettings,
          productSettings: productSettings,
          isFilteringByPreviouslyPurchased: previouslyPurchased ?? false,
          isFilteringByStockedItems: selectedStockedItems ?? false,
        );

        return availableFiltersCollection;
      case Failure():
        return null;
    }
  }

  Future<List<FilterValueViewModelCollection>> getAvailableFiltersCollection({
    GetProductCollectionResult? requestResult,
    required ProductListType productListType,
    required SearchSettings searchSettings,
    required ProductSettings productSettings,
    bool isFilteringByPreviouslyPurchased = false,
    bool isFilteringByStockedItems = false,
  }) async {
    final isAuthenticated = await commerceAPIServiceProvider
        .getAuthenticationService()
        .isAuthenticatedAsync();

    final previouslyPurchasedFilter = getPreviouslyPurchasedFilters(
      requestResult: requestResult,
      listType: productListType,
      searchSettings: searchSettings,
      isFilteringByPreviouslyPurchased: isFilteringByPreviouslyPurchased,
      isAuthenticated:
          isAuthenticated is Success && (isAuthenticated as Success).value,
    );

    final stockedItemsFilter = getStockedItemsFilters(
      requestResult: requestResult,
      listType: productListType,
      productSettings: productSettings,
      isFilteringByStockedItems: isFilteringByStockedItems,
    );

    final categories = getCategoriesFilters(
      requestResult: requestResult,
      listType: productListType,
    );

    final brands = getBrandsFilter(
      requestResult: requestResult,
      listType: productListType,
    );

    final productLines = getProductLinesFilter(
      requestResult: requestResult,
      listType: productListType,
    );

    final attributeValues = getAttributeValueFilters(
      requestResult: requestResult,
    );

    return [
      if (previouslyPurchasedFilter != null) ...previouslyPurchasedFilter,
      if (stockedItemsFilter != null) ...stockedItemsFilter,
      if (categories != null) ...categories,
      if (brands != null) ...brands,
      if (productLines != null) ...productLines,
      if (attributeValues != null) ...attributeValues,
    ];
  }

  List<FilterValueViewModelCollection>? getPreviouslyPurchasedFilters({
    GetProductCollectionResult? requestResult,
    required ProductListType listType,
    required SearchSettings searchSettings,
    bool isFilteringByPreviouslyPurchased = false,
    required bool isAuthenticated,
  }) {
    if (requestResult != null &&
        isAuthenticated &&
        searchSettings.enableBoostingByPurchaseHistory == true &&
        searchSettings.allowFilteringForPreviouslyPurchasedProducts == true) {
      return [
        FilterValueViewModelCollection(
          values: [
            FilterValueViewModel(
              id: 'PreviouslyPurchased',
              title: LocalizationConstants.previouslyPurchased.localized(),
              isSelected: isFilteringByPreviouslyPurchased,
              facetType: FacetType.previouslyPurchased,
            ),
          ],
          title: '',
        ),
      ];
    }

    return null;
  }

  List<FilterValueViewModelCollection>? getStockedItemsFilters({
    GetProductCollectionResult? requestResult,
    required ProductListType listType,
    required ProductSettings productSettings,
    bool isFilteringByStockedItems = false,
  }) {
    if (requestResult != null &&
        productSettings.displayFacetsForStockedItems == true) {
      return [
        FilterValueViewModelCollection(
          values: [
            FilterValueViewModel(
              id: 'StockedItems',
              title: LocalizationConstants.stockedItemsOnly.localized(),
              isSelected: isFilteringByStockedItems,
              facetType: FacetType.stockedItemsFacet,
            ),
          ],
          title: LocalizationConstants.stockedItems.localized(),
        ),
      ];
    }

    return null;
  }

  List<FilterValueViewModelCollection>? getCategoriesFilters({
    GetProductCollectionResult? requestResult,
    required ProductListType listType,
  }) {
    if (requestResult == null ||
        (requestResult.categoryFacets?.length ?? 0) == 0) {
      return null;
    }

    switch (listType) {
      case ProductListType.categoryProducts:
      case ProductListType.shopBrandCategoryProducts:
        return null;
      default:
        break;
    }

    return [
      FilterValueViewModelCollection(
        values: requestResult.categoryFacets
                ?.map(
                  (category) => FilterValueViewModel(
                    id: category.categoryId ?? '',
                    title: category.shortDescription ?? '',
                    isSelected: category.selected ?? false,
                    facetType: FacetType.categoryFacet,
                  ),
                )
                .toList() ??
            [],
        title: LocalizationConstants.categories.localized(),
      ),
    ];
  }

  List<FilterValueViewModelCollection>? getBrandsFilter({
    GetProductCollectionResult? requestResult,
    required ProductListType listType,
  }) {
    if (requestResult == null ||
        (requestResult.brandFacets?.length ?? 0) == 0) {
      return null;
    }

    switch (listType) {
      case ProductListType.shopBrandProducts:
      case ProductListType.shopBrandCategoryProducts:
      case ProductListType.shopBrandProductLineProducts:
        return null;
      default:
        break;
    }

    return [
      FilterValueViewModelCollection(
        values: requestResult.brandFacets
                ?.map(
                  (brand) => FilterValueViewModel(
                    id: brand.id ?? '',
                    title: brand.name ?? '',
                    isSelected: brand.selected ?? false,
                    facetType: FacetType.brandFacet,
                  ),
                )
                .toList() ??
            [],
        title: LocalizationConstants.brand.localized(),
      ),
    ];
  }

  List<FilterValueViewModelCollection>? getProductLinesFilter({
    GetProductCollectionResult? requestResult,
    required ProductListType listType,
  }) {
    if (requestResult == null ||
        (requestResult.productLineFacets?.length ?? 0) == 0 ||
        listType == ProductListType.shopBrandProductLineProducts) {
      return null;
    }

    return [
      FilterValueViewModelCollection(
        values: requestResult.productLineFacets
                ?.map(
                  (productLine) => FilterValueViewModel(
                    id: productLine.id ?? '',
                    title: productLine.name ?? '',
                    isSelected: productLine.selected ?? false,
                    facetType: FacetType.productLineFacet,
                  ),
                )
                .toList() ??
            [],
        title: LocalizationConstants.productLine.localized(),
      ),
    ];
  }

  List<FilterValueViewModelCollection>? getAttributeValueFilters({
    GetProductCollectionResult? requestResult,
  }) {
    return requestResult?.attributeTypeFacets != null
        ? requestResult?.attributeTypeFacets?.sorted(
            (a, b) {
              final compare = (a.sort ?? 0).compareTo(b.sort ?? 0);
              return compare == 0
                  ? (a.nameDisplay ?? '').compareTo(b.nameDisplay ?? '')
                  : compare;
            },
          ).map(
            (attributeType) {
              final sortedAttributeValueFacets =
                  attributeType.attributeValueFacets?.sorted(
                (a, b) {
                  final compare =
                      (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0);
                  return compare == 0
                      ? (a.valueDisplay ?? '').compareTo(b.valueDisplay ?? '')
                      : compare;
                },
              );

              return FilterValueViewModelCollection(
                values: sortedAttributeValueFacets
                        ?.map(
                          (attributeValue) => FilterValueViewModel(
                            id: attributeValue.attributeValueId ?? '',
                            title: attributeValue.valueDisplay ?? '',
                            isSelected: attributeValue.selected ?? false,
                            facetType: FacetType.attributeValueFacet,
                          ),
                        )
                        .toList() ??
                    [],
                title: attributeType.nameDisplay ?? '',
              );
            },
          ).toList()
        : [];
  }
}
