import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list_filter_item_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list_filter_parameters_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wish_list_filter_state.dart';

class WishListFilterCubit extends Cubit<WishListFilterState> {
  WishListFilterCubit() : super(WishListFilterState());

  void initialize({
    required WishListFilterParametersEntity wishListFilterParameters,
  }) {
    var newState = state.copyWith();
    newState.fromCreatedDate = wishListFilterParameters.fromCreatedDate;
    newState.toCreatedDate = wishListFilterParameters.toCreatedDate;
    newState.fromUpdatedOn = wishListFilterParameters.fromUpdatedOn;
    newState.toUpdatedOn = wishListFilterParameters.toUpdatedOn;
    newState.product = wishListFilterParameters.product;
    newState.brand = wishListFilterParameters.brand;
    newState.sharedByUser = wishListFilterParameters.sharedByUser;
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

  void setProduct(WishListFilterItemEntity? product) {
    var newState = state.copyWith();
    newState.product = product;
    emit(newState);
  }

  void setBrandId(WishListFilterItemEntity? brand) {
    var newState = state.copyWith();
    newState.brand = brand;
    emit(newState);
  }

  void setSharedBy(WishListFilterItemEntity? sharedByUser) {
    var newState = state.copyWith();
    newState.sharedByUser = sharedByUser;
    emit(newState);
  }
}
