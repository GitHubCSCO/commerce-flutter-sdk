import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListFilterUsecase extends BaseUseCase {
  Future<List<AutocompleteBrand>?> getBrands(String searchQuery) async {
    final result = await commerceAPIServiceProvider
        .getAutocompleteService()
        .getAutocompleteBrands(searchQuery);

    switch (result) {
      case Success(value: final value):
        return value;
      case Failure():
        return null;
    }
  }

  Future<List<AutocompleteProduct>?> getProducts(String searchQuery) async {
    final result = await commerceAPIServiceProvider
        .getAutocompleteService()
        .getAutocompleteProducts(searchQuery);

    switch (result) {
      case Success(value: final value):
        return value;
      case Failure():
        return null;
    }
  }

  Future<List<String>?> getSharedByUsers(String searchQuery) async {
    final result =
        await commerceAPIServiceProvider.getWishListService().getWishLists(
              WishListsQueryParameters(
                sharedByQuery: searchQuery,
              ),
            );

    switch (result) {
      case Success(value: final value):
        return (value?.wishListCollection ?? [])
            .map((e) => e.sharedByDisplayName ?? '')
            .toSet()
            .toList();
      case Failure():
        return null;
    }
  }
}
