import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wish_list_handler_state.dart';

class WishListHandlerCubit extends Cubit<WishListHandlerState> {
  WishListHandlerCubit()
      : super(
          const WishListHandlerState(
            status: WishListHandlerStatus.initial,
          ),
        );

  void shouldRefreshWishList() {
    emit(
      state.copyWith(
        status: WishListHandlerStatus.shouldRefreshWishList,
      ),
    );
  }

  void shouldRefreshWishListWithoutDetails() {
    emit(
      state.copyWith(
        status: WishListHandlerStatus.shouldRefreshWishListWithoutDetails,
      ),
    );
  }

  void resetState() {
    emit(
      const WishListHandlerState(
        status: WishListHandlerStatus.initial,
      ),
    );
  }
}
