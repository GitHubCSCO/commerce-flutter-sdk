part of 'wish_list_cubit.dart';

class WishListState extends Equatable {
  final WishListCollectionEntity wishLists;
  final WishListStatus status;
  final WishListSortOrder sortOrder;
  final String searchQuery;
  final WishListSettingsEntity settings;

  const WishListState({
    required this.wishLists,
    required this.status,
    required this.sortOrder,
    required this.searchQuery,
    required this.settings,
  });

  @override
  List<Object> get props => [
        wishLists,
        status,
        sortOrder,
        searchQuery,
        settings,
      ];

  WishListState copyWith({
    WishListCollectionEntity? wishLists,
    WishListStatus? status,
    WishListSortOrder? sortOrder,
    String? searchQuery,
    WishListSettingsEntity? settings,
  }) {
    return WishListState(
      wishLists: wishLists ?? this.wishLists,
      status: status ?? this.status,
      sortOrder: sortOrder ?? this.sortOrder,
      searchQuery: searchQuery ?? this.searchQuery,
      settings: settings ?? this.settings,
    );
  }
}
