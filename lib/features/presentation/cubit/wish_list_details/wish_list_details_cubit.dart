import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_line_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/wish_list_usecase/wish_list_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'wish_list_details_state.dart';

class WishListDetailsCubit extends Cubit<WishListDetailsState> {
  final WishListDetailsUsecase _wishListDetailsUsecase;

  WishListDetailsCubit({required WishListDetailsUsecase wishListDetailsUsecase})
      : _wishListDetailsUsecase = wishListDetailsUsecase,
        super(
          const WishListDetailsState(
            wishList: WishListEntity(),
            wishListLines: WishListLineCollectionEntity(),
            status: WishListStatus.initial,
            sortOrder: WishListLineSortOrder.customSort,
            searchQuery: '',
          ),
        );

  Future<void> loadWishListDetails(String id) async {
    emit(state.copyWith(status: WishListStatus.loading));

    final wishList = await _wishListDetailsUsecase.loadWishList(id);

    if (wishList == null) {
      emit(state.copyWith(status: WishListStatus.failure));
      return;
    }

    final wishListLines = await _wishListDetailsUsecase.loadWishListLines(
      wishListEntity: wishList,
      page: 1,
      sortOrder: state.sortOrder,
      searchText: state.searchQuery,
    );

    if (wishListLines != null) {
      emit(
        WishListDetailsState(
          searchQuery: state.searchQuery,
          sortOrder: state.sortOrder,
          wishList: wishList,
          wishListLines: wishListLines,
          status: WishListStatus.success,
        ),
      );
    } else {
      emit(state.copyWith(status: WishListStatus.failure));
    }
  }
}
