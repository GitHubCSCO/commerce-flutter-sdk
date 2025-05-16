part of 'wish_list_tags_controller_cubit.dart';

sealed class WishListTagsControllerState extends Equatable {
  const WishListTagsControllerState();

  @override
  List<Object> get props => [];
}

final class WishListTagsControllerInitial extends WishListTagsControllerState {
  final List<WishListTagEntity>? wishListTags;

  const WishListTagsControllerInitial({this.wishListTags});

  @override
  List<Object> get props => [wishListTags ?? []];
}

final class WishListTagsControllerEditing extends WishListTagsControllerState {
  final List<WishListTagEntity>? wishListTags;
  final List<WishListTagEntity>? deletedTags;
  final List<WishListTagEntity>? addedTags;

  const WishListTagsControllerEditing({
    this.wishListTags,
    this.deletedTags,
    this.addedTags,
  });

  @override
  List<Object> get props => [
        wishListTags ?? [],
        deletedTags ?? [],
        addedTags ?? [],
      ];
}

final class WishListTagsControllerLoading extends WishListTagsControllerState {
  final List<WishListTagEntity>? wishListTags;

  const WishListTagsControllerLoading({this.wishListTags});

  @override
  List<Object> get props => [wishListTags ?? []];
}

final class WishListTagsControllerError extends WishListTagsControllerState {
  final String errorMessage;

  const WishListTagsControllerError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class WishListTagsControllerSuccess extends WishListTagsControllerState {
  final List<WishListTagEntity>? wishListTags;

  const WishListTagsControllerSuccess({this.wishListTags});

  @override
  List<Object> get props => [wishListTags ?? []];
}
