part of 'wish_list_cubit.dart';

class WishListState extends Equatable {
  final WishListCollectionEntity wishLists;
  final WishListStatus status;
  final WishListSortOrder sortOrder;
  final String searchQuery;
  final WishListSettingsEntity settings;
  final String? message;

  const WishListState({
    required this.wishLists,
    required this.status,
    required this.sortOrder,
    required this.searchQuery,
    required this.settings,
    this.message,
  });

  @override
  List<Object> get props =>
      [wishLists, status, sortOrder, searchQuery, settings, message ?? ''];

  WishListState copyWith(
      {WishListCollectionEntity? wishLists,
      WishListStatus? status,
      WishListSortOrder? sortOrder,
      String? searchQuery,
      WishListSettingsEntity? settings,
      String? message}) {
    return WishListState(
      wishLists: wishLists ?? this.wishLists,
      status: status ?? this.status,
      sortOrder: sortOrder ?? this.sortOrder,
      searchQuery: searchQuery ?? this.searchQuery,
      settings: settings ?? this.settings,
      message: message ?? this.message,
    );
  }
}
