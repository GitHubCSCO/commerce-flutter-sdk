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

  bool get noWishListFound =>
      state.status == WishListStatus.success &&
      state.wishListLines.wishListLines?.isEmpty == true;

  List<WishListLineSortOrder> get availableSortOrders => _wishListDetailsUsecase.availableSortOrders;

  Future<void> changeSortOrder(WishListLineSortOrder sortOrder) async {
    emit(
      state.copyWith(
        sortOrder: sortOrder,
      ),
    );

    await loadWishListLines(state.wishList);
  }

  Future<void> searchQueryChanged(String query) async {
    emit(state.copyWith(searchQuery: query));
    await loadWishListLines(state.wishList);
  }

  Future<void> loadWishListDetails(String id) async {
    emit(state.copyWith(status: WishListStatus.loading));

    final wishList = await _wishListDetailsUsecase.loadWishList(id);

    if (wishList == null) {
      emit(state.copyWith(status: WishListStatus.failure));
      return;
    }

    await loadWishListLines(wishList);
  }

  Future<void> loadWishListLines(WishListEntity wishList) async {
    if (state.status != WishListStatus.loading) {
      emit(state.copyWith(status: WishListStatus.loading));
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

  Future<void> loadMoreWishListLines() async {
    if (state.wishListLines.pagination?.page == null ||
        state.wishListLines.pagination!.page! + 1 >
            state.wishListLines.pagination!.numberOfPages! ||
        state.status == WishListStatus.moreLoading) {
      return;
    }

    emit(state.copyWith(status: WishListStatus.moreLoading));
    final result = await _wishListDetailsUsecase.loadWishListLines(
      wishListEntity: state.wishList,
      page: state.wishListLines.pagination!.page! + 1,
      sortOrder: state.sortOrder,
      searchText: state.searchQuery,
    );

    if (result == null) {
      emit(state.copyWith(status: WishListStatus.moreLoadingFailure));
      return;
    }

    final newWishListLines = state.wishListLines.wishListLines;
    newWishListLines?.addAll(result.wishListLines!);

    emit(
      state.copyWith(
        wishListLines: state.wishListLines.copyWith(
          wishListLines: newWishListLines,
          pagination: result.pagination,
        ),
        status: WishListStatus.success,
      ),
    );
  }
}
