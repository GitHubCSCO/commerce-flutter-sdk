part of 'wish_list_information_cubit.dart';

class WishListInformationState extends Equatable {
  final WishListEntity wishList;
  final WishListSettingsEntity settings;
  final WishListStatus status;

  const WishListInformationState({
    required this.wishList,
    required this.settings,
    required this.status,
  });

  @override
  List<Object> get props => [
        wishList,
        settings,
        status,
      ];

  WishListInformationState copyWith({
    WishListEntity? wishList,
    WishListSettingsEntity? settings,
    WishListStatus? status,
  }) {
    return WishListInformationState(
      wishList: wishList ?? this.wishList,
      settings: settings ?? this.settings,
      status: status ?? this.status,
    );
  }
}
