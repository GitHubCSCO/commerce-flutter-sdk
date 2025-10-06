part of 'wish_list_filter_autocomplete_cubit.dart';

sealed class WishListFilterAutocompleteState extends Equatable {
  const WishListFilterAutocompleteState();

  @override
  List<Object> get props => [];
}

final class WishListFilterAutocompleteInitial
    extends WishListFilterAutocompleteState {}

final class WishListFilterAutocompleteLoading
    extends WishListFilterAutocompleteState {}

final class WishListFilterError extends WishListFilterAutocompleteState {
  final String message;

  const WishListFilterError(this.message);

  @override
  List<Object> get props => [message];
}

final class WishListFilterAutocompleteBrandsLoaded
    extends WishListFilterAutocompleteState {
  final List<AutocompleteBrand> brands;

  const WishListFilterAutocompleteBrandsLoaded(this.brands);

  @override
  List<Object> get props => [brands];
}

final class WishListFilterAutocompleteProductsLoaded
    extends WishListFilterAutocompleteState {
  final List<AutocompleteProduct> products;

  const WishListFilterAutocompleteProductsLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class WishListFilterAutocompleteSharedByUsersLoaded
    extends WishListFilterAutocompleteState {
  final List<String> users;

  const WishListFilterAutocompleteSharedByUsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}
