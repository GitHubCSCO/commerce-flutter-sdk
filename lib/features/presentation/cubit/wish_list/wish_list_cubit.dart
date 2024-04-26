import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/wish_list_usecase/wish_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  final WishListUsecase _wishListUsecase;
  WishListCubit({required WishListUsecase wishListUsecase})
      : _wishListUsecase = wishListUsecase,
        super(
          const WishListState(
            sortOrder: WishListSortOrder.modifiedOnDescending,
            status: WishListStatus.initial,
            wishLists: WishListCollectionEntity(
              wishListCollection: [],
            ),
          ),
        );

  Future<void> loadWishLists() async {
    emit(state.copyWith(status: WishListStatus.loading));

    final result =
        await _wishListUsecase.getWishLists(sortOrder: state.sortOrder);

    result != null
        ? emit(
            state.copyWith(
              wishLists: result,
              status: WishListStatus.success,
            ),
          )
        : emit(state.copyWith(status: WishListStatus.failure));
  }
}
