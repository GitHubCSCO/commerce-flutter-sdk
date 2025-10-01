import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'wish_list_filter_state.dart';

class WishListFilterCubit extends Cubit<WishListFilterState> {
  WishListFilterCubit() : super(WishListFilterState());

  void initialize({
    required WishListsQueryParameters wishListsQueryParameters,
  }) {
    var newState = state.copyWith();
    newState.fromCreatedDate = wishListsQueryParameters.fromCreatedDate;
    newState.toCreatedDate = wishListsQueryParameters.toCreatedDate;
    newState.fromUpdatedOn = wishListsQueryParameters.fromUpdatedOn;
    newState.toUpdatedOn = wishListsQueryParameters.toUpdatedOn;
    newState.erpNumber = wishListsQueryParameters.erpNumber;
    newState.brandId = wishListsQueryParameters.brandId;
    newState.sharedBy = wishListsQueryParameters.sharedBy;
    emit(newState);
  }

  void reset() {
    emit(WishListFilterState());
  }

  void setFromCreatedDate(DateTime? fromCreatedDate) {
    var newState = state.copyWith();
    newState.fromCreatedDate = fromCreatedDate;
    emit(newState);
  }

  void setToCreatedDate(DateTime? toCreatedDate) {
    var newState = state.copyWith();
    newState.toCreatedDate = toCreatedDate;
    emit(newState);
  }

  void setFromUpdatedOn(DateTime? fromUpdatedOn) {
    var newState = state.copyWith();
    newState.fromUpdatedOn = fromUpdatedOn;
    emit(newState);
  }

  void setToUpdatedOn(DateTime? toUpdatedOn) {
    var newState = state.copyWith();
    newState.toUpdatedOn = toUpdatedOn;
    emit(newState);
  }

  void setErpNumber(String? erpNumber) {
    var newState = state.copyWith();
    newState.erpNumber = erpNumber;
    emit(newState);
  }

  void setBrandId(String? brandId) {
    var newState = state.copyWith();
    newState.brandId = brandId;
    emit(newState);
  }

  void setSharedBy(String? sharedBy) {
    var newState = state.copyWith();
    newState.sharedBy = sharedBy;
    emit(newState);
  }
}
