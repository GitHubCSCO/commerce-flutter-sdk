import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list_filter_item_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/base_usecase.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListFilterUsecase extends BaseUseCase {
  Future<List<AutocompleteBrand>?> getBrands(String searchQuery) async {
    final result = await commerceAPIServiceProvider
        .getAutocompleteService()
        .getAutocompleteResults(
          AutocompleteQueryParameters(
            query: searchQuery,
            relevancy: true,
            spireContent: true,
            searchOnTyping: true,
          ),
        );

    switch (result) {
      case Success(value: final value):
        return value?.brands;
      case Failure():
        return null;
    }
  }

  Future<List<AutocompleteProduct>?> getProducts(String searchQuery) async {
    final result = await commerceAPIServiceProvider
        .getAutocompleteService()
        .getAutocompleteResults(
          AutocompleteQueryParameters(
            query: searchQuery,
            brandEnabled: false,
            categoryEnabled: false,
            contentEnabled: false,
            productEnabled: true,
            relevancy: true,
            spireContent: true,
          ),
        );

    switch (result) {
      case Success(value: final value):
        return value?.products;
      case Failure():
        return null;
    }
  }

  Future<List<WishListFilterItemEntity>?> getSharedByUsers(
      String searchQuery) async {
    final result =
        await commerceAPIServiceProvider.getWishListService().getWishLists(
              WishListsQueryParameters(
                sharedByQuery: searchQuery,
                pageSize: 10,
              ),
            );

    switch (result) {
      case Success(value: final value):
        return (value?.wishListCollection ?? [])
            .map(
              (e) => WishListFilterItemEntity(
                displayValue: e.sharedByDisplayName,
                actualValue: e.sharedByUserName,
              ),
            )
            .toSet()
            .toList();
      case Failure():
        return null;
    }
  }
}
