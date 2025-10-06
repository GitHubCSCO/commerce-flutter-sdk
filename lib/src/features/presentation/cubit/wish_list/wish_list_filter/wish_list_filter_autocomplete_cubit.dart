import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list_filter_item_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/wish_list_usecase/wish_list_filter_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'wish_list_filter_autocomplete_state.dart';

class WishListFilterAutocompleteCubit
    extends Cubit<WishListFilterAutocompleteState> {
  final WishListFilterUsecase _wishListFilterUsecase;

  WishListFilterAutocompleteCubit({
    required WishListFilterUsecase wishListFilterUsecase,
  })  : _wishListFilterUsecase = wishListFilterUsecase,
        super(WishListFilterAutocompleteInitial());

  Future<void> getBrands(String searchQuery) async {
    emit(WishListFilterAutocompleteLoading());
    final brands = await _wishListFilterUsecase.getBrands(searchQuery);
    if (brands != null) {
      emit(WishListFilterAutocompleteBrandsLoaded(brands));
    } else {
      emit(const WishListFilterError('Failed to load brands'));
    }
  }

  Future<void> getProducts(String searchQuery) async {
    emit(WishListFilterAutocompleteLoading());
    final products = await _wishListFilterUsecase.getProducts(searchQuery);
    if (products != null) {
      emit(WishListFilterAutocompleteProductsLoaded(products));
    } else {
      emit(const WishListFilterError('Failed to load products'));
    }
  }

  Future<void> getSharedByUsers(String searchQuery) async {
    emit(WishListFilterAutocompleteLoading());
    final users = await _wishListFilterUsecase.getSharedByUsers(searchQuery);
    if (users != null) {
      emit(WishListFilterAutocompleteSharedByUsersLoaded(users));
    } else {
      emit(const WishListFilterError('Failed to load users'));
    }
  }

  void reset() {
    emit(WishListFilterAutocompleteInitial());
  }
}
