part of 'wish_list_cubit.dart';

class WishListState extends Equatable {
  final WishListCollectionEntity wishLists;
  final WishListStatus status;
  final WishListSortOrder sortOrder;

  const WishListState({
    required this.wishLists,
    required this.status,
    required this.sortOrder,
  });

  @override
  List<Object> get props => [
        wishLists,
        status,
        sortOrder,
      ];

  WishListState copyWith({
    WishListCollectionEntity? wishLists,
    WishListStatus? status,
    WishListSortOrder? sortOrder,
  }) {
    return WishListState(
      wishLists: wishLists ?? this.wishLists,
      status: status ?? this.status,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
