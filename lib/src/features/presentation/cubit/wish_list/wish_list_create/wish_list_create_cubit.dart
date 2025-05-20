import 'package:commerce_flutter_sdk/src/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_sdk/src/features/domain/usecases/wish_list_usecase/wish_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'wish_list_create_state.dart';

class WishListCreateCubit extends Cubit<WishListCreateState> {
  final WishListUsecase _wishListUsecase;

  WishListCreateCubit({required WishListUsecase wishListUsecase})
      : _wishListUsecase = wishListUsecase,
        super(
          const WishListCreateState(
            status: WishListStatus.initial,
          ),
        );

  Future<void> createWishList({
    required String name,
    String? description,
    WishListAddToCartCollection? addToCartCollection,
  }) async {
    emit(state.copyWith(status: WishListStatus.loading));

    if (name.isEmpty) {
      emit(state.copyWith(status: WishListStatus.listCreateEmptyNameFailure));
      return;
    }

    final result = addToCartCollection == null
        ? await _wishListUsecase.createWishList(
            name: name,
            description: description,
          )
        : await _wishListUsecase.createWishListAndAddToList(
            name: name,
            description: description,
            addToCartCollection: addToCartCollection,
          );

    emit(state.copyWith(status: result));
  }
}
