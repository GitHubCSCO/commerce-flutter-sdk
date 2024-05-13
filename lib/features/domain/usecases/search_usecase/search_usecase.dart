import 'package:commerce_flutter_app/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class SearchUseCase extends BaseUseCase {

  Future<Result<AutocompleteResult, ErrorResponse>?> loadAutocompleteResults(String searchQuery) async {
    var parameters = AutocompleteQueryParameters(
        query: searchQuery,
        categoryEnabled: true,
        brandEnabled: true,
        productEnabled: true,
    );
    var result = await commerceAPIServiceProvider.getAutocompleteService().getAutocompleteResults(parameters);
    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

  Future<Result<GetProductCollectionResult, ErrorResponse>?> loadSearchProductsResults(String searchQuery, int currentPage) async {
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
      expand: ["pricing", "facets", "brand"],
    );
    var result = await commerceAPIServiceProvider.getProductService().getProducts(parameters);
    switch (result) {
      case Success(value: final data):
        return Success(data);
      case Failure(errorResponse: final errorResponse):
        return Failure(errorResponse);
    }
  }

}