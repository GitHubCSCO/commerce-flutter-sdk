part of 'wish_list_cubit.dart';

class WishListState extends Equatable {
  final WishListCollectionEntity wishLists;
  final WishListStatus status;
  final WishListSortOrder sortOrder;
  final String searchQuery;
  final WishListSettingsEntity settings;
  final String? message;
  final DateTime? fromCreatedDate;
  final DateTime? toCreatedDate;
  final DateTime? fromUpdatedOn;
  final DateTime? toUpdatedOn;
  final String? erpNumber;
  final String? brandId;
  final String? sharedBy;

  const WishListState({
    required this.wishLists,
    required this.status,
    required this.sortOrder,
    required this.searchQuery,
    required this.settings,
    required this.fromCreatedDate,
    required this.toCreatedDate,
    required this.fromUpdatedOn,
    required this.toUpdatedOn,
    required this.erpNumber,
    required this.brandId,
    required this.sharedBy,
    this.message,
  });

  @override
  List<Object> get props => [
        wishLists,
        status,
        sortOrder,
        searchQuery,
        settings,
        fromCreatedDate ?? DateTime(0),
        toCreatedDate ?? DateTime(0),
        fromUpdatedOn ?? DateTime(0),
        toUpdatedOn ?? DateTime(0),
        erpNumber ?? '',
        brandId ?? '',
        sharedBy ?? '',
        message ?? '',
      ];

  WishListState copyWith({
    WishListCollectionEntity? wishLists,
    WishListStatus? status,
    WishListSortOrder? sortOrder,
    String? searchQuery,
    WishListSettingsEntity? settings,
    DateTime? fromCreatedDate,
    DateTime? toCreatedDate,
    DateTime? fromUpdatedOn,
    DateTime? toUpdatedOn,
    String? erpNumber,
    String? brandId,
    String? sharedBy,
    String? message,
  }) {
    return WishListState(
      wishLists: wishLists ?? this.wishLists,
      status: status ?? this.status,
      sortOrder: sortOrder ?? this.sortOrder,
      searchQuery: searchQuery ?? this.searchQuery,
      settings: settings ?? this.settings,
      message: message ?? this.message,
      fromCreatedDate: fromCreatedDate ?? this.fromCreatedDate,
      toCreatedDate: toCreatedDate ?? this.toCreatedDate,
      fromUpdatedOn: fromUpdatedOn ?? this.fromUpdatedOn,
      toUpdatedOn: toUpdatedOn ?? this.toUpdatedOn,
      erpNumber: erpNumber ?? this.erpNumber,
      brandId: brandId ?? this.brandId,
      sharedBy: sharedBy ?? this.sharedBy,
    );
  }
}
