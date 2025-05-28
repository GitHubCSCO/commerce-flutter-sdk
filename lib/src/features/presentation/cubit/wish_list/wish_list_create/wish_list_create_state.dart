part of 'wish_list_create_cubit.dart';

class WishListCreateState extends Equatable {
  const WishListCreateState({required this.status});

  final WishListStatus status;

  @override
  List<Object> get props => [
        status,
      ];

  WishListCreateState copyWith({
    WishListStatus? status,
  }) {
    return WishListCreateState(
      status: status ?? this.status,
    );
  }
}
