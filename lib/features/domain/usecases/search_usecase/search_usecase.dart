import 'package:commerce_flutter_sdk/features/domain/usecases/base_usecase.dart';
import 'package:commerce_flutter_sdk/features/presentation/helper/menu/sort_tool_menu.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchUseCase extends BaseUseCase {
  Future<Result<AutocompleteResult, ErrorResponse>> loadAutocompleteResults(
      String searchQuery) async {
    var parameters = AutocompleteQueryParameters(
      query: searchQuery,
      categoryEnabled: true,
      brandEnabled: true,
      productEnabled: true,
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
                  title: item.product?.shortDescription,
                  subtitle: item.product?.pageTitle,
                  image: item.product?.mediumImagePath,
                  name: item.product?.name,
                  erpNumber: item.product?.erpNumber,
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
      query: searchQuery,
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
      expand: ["pricing", "facets", "brand", "varianttraits", "styledproducts"],
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
    return SortToolMenuHelper.convertOptionToAttribute(
      sortOptions: sortOptions,
    );
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
        ? (mobileSettingsResponse as Success).value as MobileAppSettings
        : null;

    return mobileSettings?.addToCartInProductList ?? false;
  }
}
