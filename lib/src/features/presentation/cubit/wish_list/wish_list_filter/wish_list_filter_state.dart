part of 'wish_list_filter_cubit.dart';

class WishListFilterState {
  DateTime? fromCreatedDate;
  DateTime? toCreatedDate;
  DateTime? fromUpdatedOn;
  DateTime? toUpdatedOn;
  String? erpNumber;
  String? brandId;
  String? sharedBy;

  WishListFilterState({
    this.fromCreatedDate,
    this.toCreatedDate,
    this.fromUpdatedOn,
    this.toUpdatedOn,
    this.erpNumber,
    this.brandId,
    this.sharedBy,
  });

  WishListFilterState copyWith({
    DateTime? fromCreatedDate,
    DateTime? toCreatedDate,
    DateTime? fromUpdatedOn,
    DateTime? toUpdatedOn,
    String? erpNumber,
    String? brandId,
    String? sharedBy,
  }) {
    return WishListFilterState(
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
