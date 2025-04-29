import 'package:equatable/equatable.dart';

import 'package:commerce_flutter_sdk/src/features/domain/entity/pagination_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list/wish_list_entity.dart';

class WishListCollectionEntity extends Equatable {
  final List<WishListEntity>? wishListCollection;

  final PaginationEntity? pagination;

  const WishListCollectionEntity({
    this.wishListCollection,
    this.pagination,
  });

  @override
  List<Object?> get props => [
        wishListCollection,
        pagination,
      ];

  WishListCollectionEntity copyWith({
    List<WishListEntity>? wishListCollection,
    PaginationEntity? pagination,
  }) {
    return WishListCollectionEntity(
      wishListCollection: wishListCollection ?? this.wishListCollection,
      pagination: pagination ?? this.pagination,
    );
  }
}
