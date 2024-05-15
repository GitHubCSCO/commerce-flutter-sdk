import 'package:equatable/equatable.dart';

class WishListSettingsEntity extends Equatable {
  final bool? allowMultipleWishLists;
  final bool? allowEditingOfWishLists;
  final bool? allowWishListsByCustomer;
  final bool? allowListSharing;
  final int? productsPerPage;
  final bool? enableWishListReminders;

  const WishListSettingsEntity({
    this.allowMultipleWishLists,
    this.allowEditingOfWishLists,
    this.allowWishListsByCustomer,
    this.allowListSharing,
    this.productsPerPage,
    this.enableWishListReminders,
  });

  @override
  List<Object?> get props => [
        allowMultipleWishLists,
        allowEditingOfWishLists,
        allowWishListsByCustomer,
        allowListSharing,
        productsPerPage,
        enableWishListReminders,
      ];

  WishListSettingsEntity copyWith({
    bool? allowMultipleWishLists,
    bool? allowEditingOfWishLists,
    bool? allowWishListsByCustomer,
    bool? allowListSharing,
    int? productsPerPage,
    bool? enableWishListReminders,
  }) {
    return WishListSettingsEntity(
      allowMultipleWishLists:
          allowMultipleWishLists ?? this.allowMultipleWishLists,
      allowEditingOfWishLists:
          allowEditingOfWishLists ?? this.allowEditingOfWishLists,
      allowWishListsByCustomer:
          allowWishListsByCustomer ?? this.allowWishListsByCustomer,
      allowListSharing: allowListSharing ?? this.allowListSharing,
      productsPerPage: productsPerPage ?? this.productsPerPage,
      enableWishListReminders:
          enableWishListReminders ?? this.enableWishListReminders,
    );
  }
}
