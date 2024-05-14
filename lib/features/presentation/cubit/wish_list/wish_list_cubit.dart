import 'package:commerce_flutter_app/features/domain/entity/settings/wish_list_settings_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_collection_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/wish_list/wish_list_entity.dart';
import 'package:commerce_flutter_app/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_app/features/domain/usecases/wish_list_usecase/wish_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  final WishListUsecase wishListUsecase;
  WishListCubit({required this.wishListUsecase})
      : super(
          const WishListState(
            sortOrder: WishListSortOrder.modifiedOnDescending,
            status: WishListStatus.initial,
            wishLists: WishListCollectionEntity(),
            searchQuery: '',
            settings: WishListSettingsEntity(),
          ),
        );

  bool get noWishListFound =>
      state.status == WishListStatus.success &&
      state.wishLists.wishListCollection?.isEmpty == true;

  List<WishListSortOrder> get availableSortOrders =>
      wishListUsecase.availableSortOrders;

  Future<void> changeSortOrder(WishListSortOrder sortOrder) async {
    emit(
      state.copyWith(
        sortOrder: sortOrder,
      ),
    );

    await loadWishLists();
  }

  Future<void> loadWishLists() async {
    emit(state.copyWith(status: WishListStatus.loading));

    final settings = await wishListUsecase.loadWishListSettings();

    final result = await wishListUsecase.getWishLists(
      sortOrder: state.sortOrder,
      page: 1,
      searchText: state.searchQuery,
    );

    result != null && settings != null
        ? emit(
            WishListState(
              wishLists: result,
              status: WishListStatus.success,
              sortOrder: state.sortOrder,
              searchQuery: state.searchQuery,
              settings: settings,
            ),
          )
        : emit(state.copyWith(status: WishListStatus.failure));
  }

  Future<void> searchQueryChanged(String query) async {
    emit(state.copyWith(searchQuery: query));
    await loadWishLists();
  }

  Future<void> loadMoreWishlists() async {
    if (state.wishLists.pagination?.page == null ||
        state.wishLists.pagination!.page! + 1 >
            state.wishLists.pagination!.numberOfPages! ||
        state.status == WishListStatus.moreLoading) {
      return;
    }

    emit(state.copyWith(status: WishListStatus.moreLoading));
    final result = await wishListUsecase.getWishLists(
      page: state.wishLists.pagination!.page! + 1,
      sortOrder: state.sortOrder,
      searchText: state.searchQuery,
    );

    if (result == null) {
      emit(state.copyWith(status: WishListStatus.moreLoadingFailure));
      return;
    }

    final newWishLists = state.wishLists.wishListCollection;
    newWishLists?.addAll(result.wishListCollection!);

    emit(
      state.copyWith(
        wishLists: state.wishLists.copyWith(
          wishListCollection: newWishLists,
          pagination: result.pagination,
        ),
        status: WishListStatus.success,
      ),
    );
  }

  Future<void> deleteWishList({required String? wishListId}) async {
    emit(state.copyWith(status: WishListStatus.listDeleteLoading));
    final result = await wishListUsecase.deleteWishList(
      wishListId: wishListId,
    );

    emit(state.copyWith(status: result));
  }

  bool canDeleteWishList({required WishListEntity wishList}) {
    return wishListUsecase.canDeleteWishList(
      settings: state.settings,
      wishList: wishList,
    );
  }
}
