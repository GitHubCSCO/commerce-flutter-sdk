import 'package:commerce_flutter_sdk/src/core/constants/site_message_constants.dart';
import 'package:commerce_flutter_sdk/src/features/domain/enums/wish_list_status.dart';
import 'package:commerce_flutter_sdk/src/features/presentation/cubit/wish_list/wish_list_cubit.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class WishListAddToCubit extends WishListCubit {
  WishListAddToCubit({required super.wishListUsecase});

  Future<void> createEmptyWishListAndAddToList({
    required WishListAddToCartCollection listItems,
  }) async {
    emit(
      state.copyWith(
        status: WishListStatus.listItemAddToListLoading,
      ),
    );

    final result = await wishListUsecase.createWishListAndAddToList(
      addToCartCollection: listItems,
      emptyWishList: true,
    );

    if (result == WishListStatus.listItemAddToListSuccess) {
      final message = await wishListUsecase.getSiteMessage(
          SiteMessageConstants.nameWishListProductAdded,
          SiteMessageConstants.defaultValueWishListProductAdded);
      emit(state.copyWith(status: result, message: message));
    } else {
      emit(state.copyWith(status: result));
    }
  }

  Future<void> loadSettings() async {
    emit(state.copyWith(status: WishListStatus.allowMultipleListsLoading));
    final settings = await wishListUsecase.loadWishListSettings();

    settings != null && settings.allowMultipleWishLists == true
        ? emit(
            state.copyWith(
              settings: settings,
              status: WishListStatus.allowMultipleListsSuccess,
            ),
          )
        : emit(
            state.copyWith(status: WishListStatus.allowMultipleListsFailure));
  }

  Future<void> addToWishList({
    required String wishListId,
    required WishListAddToCartCollection listItems,
  }) async {
    emit(
      state.copyWith(
        status: WishListStatus.listItemAddToListLoading,
      ),
    );

    final result = await wishListUsecase.addToWishList(
      wishListId: wishListId,
      addToCartCollection: listItems,
    );

    if (result == WishListStatus.listItemAddToListSuccess) {
      final message = await wishListUsecase.getSiteMessage(
          SiteMessageConstants.nameWishListProductAdded,
          SiteMessageConstants.defaultValueWishListProductAdded);
      emit(state.copyWith(status: result, message: message));
    } else {
      emit(state.copyWith(status: result));
    }
  }
}
