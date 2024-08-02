part of 'wish_list_details_cubit.dart';

class WishListDetailsState extends Equatable {
  final WishListEntity wishList;
  final WishListLineCollectionEntity wishListLines;
  final WishListStatus status;
  final WishListLineSortOrder sortOrder;
  final String searchQuery;
  final WishListSettingsEntity settings;
  final String? message;

  const WishListDetailsState(
      {required this.wishList,
      required this.wishListLines,
      required this.status,
      required this.sortOrder,
      required this.searchQuery,
      required this.settings,
      this.message});

  @override
  List<Object> get props => [
        wishList,
        wishListLines,
        status,
        sortOrder,
        searchQuery,
        settings,
        message ?? ''
      ];

  WishListDetailsState copyWith(
      {WishListEntity? wishList,
      WishListLineCollectionEntity? wishListLines,
      WishListStatus? status,
      WishListLineSortOrder? sortOrder,
      String? searchQuery,
      WishListSettingsEntity? settings,
      String? message}) {
    return WishListDetailsState(
      wishList: wishList ?? this.wishList,
      wishListLines: wishListLines ?? this.wishListLines,
      status: status ?? this.status,
      sortOrder: sortOrder ?? this.sortOrder,
      searchQuery: searchQuery ?? this.searchQuery,
      settings: settings ?? this.settings,
      message: message ?? this.message,
    );
  }
}
