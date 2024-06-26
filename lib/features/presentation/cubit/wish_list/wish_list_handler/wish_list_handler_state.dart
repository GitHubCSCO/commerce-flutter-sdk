part of 'wish_list_handler_cubit.dart';

enum WishListHandlerStatus {
  initial,
  shouldRefreshWishList,
}

class WishListHandlerState extends Equatable {
  final WishListHandlerStatus status;

  const WishListHandlerState({
    required this.status,
  });

  @override
  List<Object> get props => [
        status,
      ];

  WishListHandlerState copyWith({
    WishListHandlerStatus? status,
  }) {
    return WishListHandlerState(
      status: status ?? this.status,
    );
  }
}
