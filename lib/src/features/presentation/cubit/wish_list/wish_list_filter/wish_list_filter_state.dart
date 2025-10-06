part of 'wish_list_filter_cubit.dart';

class WishListFilterState {
  DateTime? fromCreatedDate;
  DateTime? toCreatedDate;
  DateTime? fromUpdatedOn;
  DateTime? toUpdatedOn;
  WishListFilterItemEntity? product;
  WishListFilterItemEntity? brand;
  WishListFilterItemEntity? sharedByUser;

  WishListFilterState({
    this.fromCreatedDate,
    this.toCreatedDate,
    this.fromUpdatedOn,
    this.toUpdatedOn,
    this.product,
    this.brand,
    this.sharedByUser,
  });

  WishListFilterState copyWith({
    DateTime? fromCreatedDate,
    DateTime? toCreatedDate,
    DateTime? fromUpdatedOn,
    DateTime? toUpdatedOn,
    WishListFilterItemEntity? product,
    WishListFilterItemEntity? brand,
    WishListFilterItemEntity? sharedByUser,
  }) {
    return WishListFilterState(
      fromCreatedDate: fromCreatedDate ?? this.fromCreatedDate,
      toCreatedDate: toCreatedDate ?? this.toCreatedDate,
      fromUpdatedOn: fromUpdatedOn ?? this.fromUpdatedOn,
      toUpdatedOn: toUpdatedOn ?? this.toUpdatedOn,
      product: product ?? this.product,
      brand: brand ?? this.brand,
      sharedByUser: sharedByUser ?? this.sharedByUser,
    );
  }
}
