import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchUseCase extends BaseUseCase {
  Future<Result<AutocompleteResult, ErrorResponse>> loadAutocompleteResults(
      String searchQuery,
      {bool? relevancy = true,
      bool contentEnabled = false,
      bool spireContent = false}) async {
    var parameters = AutocompleteQueryParameters(
      query: searchQuery,
      categoryEnabled: true,
      brandEnabled: true,
      productEnabled: true,
      contentEnabled: contentEnabled,
      spireContent: spireContent,
      relevancy: relevancy,
    );
    var result = await commerceAPIServiceProvider
        .getAutocompleteService()
        .getAutocompleteResults(parameters);
    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<AutocompleteResult, ErrorResponse>> loadVmiAutocompleteResults(
      String searchQuery) async {
    var parameters = VmiBinQueryParameters(
      vmiLocationId:
          coreServiceProvider.getVmiService().currentVmiLocation?.id ?? '',
      filter: searchQuery,
      expand: 'product',
    );
    var result = await commerceAPIServiceProvider
        .getVmiLocationsService()
        .getVmiBins(parameters: parameters);
    switch (result) {
      case Success(value: final data):
        List<AutocompleteProduct> result = [];

        if (data?.vmiBins != null) {
          for (var item in data!.vmiBins) {
            if (item.product != null) {
              result.add(
                AutocompleteProduct(
                  id: item.product?.id,
                  title: item.product?.productTitle,
                  subtitle: item.product?.content?.pageTitle,
                  image: item.product?.mediumImagePath,
                  name: item.product?.productTitle,
                  erpNumber: item.product?.productNumber,
                  brandName: item.product?.brand?.name,
                  brandDetailPagePath: item.product?.brand?.logoSmallImagePath,
                  binNumber: item.binNumber,
                )..properties = item.product?.properties,
              );
            }
          }
        }
        return Success(AutocompleteResult(products: result));
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<GetProductCollectionResult, ErrorResponse>?>
      loadSearchProductsResults(
    String searchQuery,
    int currentPage, {
    SortOrderAttribute? selectedSortOrder,
    List<String>? selectedAttributeValueIds,
    List<String>? selectedBrandIds,
    List<String>? selectedProductLineIds,
    String? selectedCategoryId,
    bool? previouslyPurchased,
    bool? selectedStockedItems,
  }) async {
    var parameters = ProductsQueryParameters(
      search: searchQuery.isEmpty ? null : searchQuery,
      page: currentPage,
      // Sort = this.sortViewModel?.CurrentlySelectedSortOption?.SortType,
      // AttributeValueIds = this.SelectedAttributeValueIds,
      // BrandIds = this.SelectedBrandIds,
      // ProductLineIds = this.SelectedProductLineIds,
      // CategoryId = this.SelectedCategoryId,
      // PreviouslyPurchasedProducts = this.PreviouslyPurchased,
      // StockedItemsOnly = this.SelectedStockedItems,
      attributeValueIds: selectedAttributeValueIds,
      brandIds: selectedBrandIds,
      productLineIds: selectedProductLineIds,
      categoryId: selectedCategoryId,
      previouslyPurchasedProducts: previouslyPurchased,
      stockedItemsOnly: selectedStockedItems,
      expand: ["attributes", "facets", "variantTraits", "badges"],
      applyPersonalization: true,
      includeAttributes: "includeOnProduct",
      includeSuggestions: "true",
      relevancy: "true",
      sort: selectedSortOrder?.value,
    );
    var result = await commerceAPIServiceProvider
        .getProductService()
        .getProducts(parameters);
    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<Category, ErrorResponse>> getCategory(String categoryId) async {
    return await commerceAPIServiceProvider
        .getCategoryService()
        .getCategory(categoryId);
  }

  Future<Result<List<Category>, ErrorResponse>> getCategoryList(
      CategoryQueryParameters parameters) async {
    return await commerceAPIServiceProvider
        .getCategoryService()
        .getCategoryList(parameters: parameters);
  }

  Future<Result<Brand, ErrorResponse>> getBrand(String brandId) async {
    return await commerceAPIServiceProvider.getBrandService().getBrand(brandId);
  }

  List<SortOrderAttribute> getAvailableSortOrders({
    required List<SortOption> sortOptions,
  }) {
    return sortOptions
        .map(
          (e) => SortOrderAttribute(
            groupTitle: e.displayName ?? '',
            title: e.displayName ?? '',
            value: e.sortType ?? '',
          ),
        )
        .toList();
  }

  SortOrderAttribute getSelectedSortOrder({
    required List<SortOrderAttribute> availableSortOrders,
    required String selectedSortOrderType,
  }) {
    return SortToolMenuHelper.getSelectedSortOrder(
      availableSortOrders: availableSortOrders,
      selectedSortOrderType: selectedSortOrderType,
    );
  }

  Future<bool> canAddToCartInProductList() async {
    var mobileSettingsResponse = await commerceAPIServiceProvider
        .getSettingsService()
        .getMobileAppSettingAsync();
    MobileAppSettings? mobileSettings = (mobileSettingsResponse is Success)
        ? (mobileSettingsResponse as Success<MobileAppSettings, ErrorResponse>)
            .value
        : null;

    return mobileSettings?.addToCartInProductList ?? false;
  }
}
