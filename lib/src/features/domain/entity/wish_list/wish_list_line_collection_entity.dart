import 'package:equatable/equatable.dart';

import 'package:commerce_flutter_sdk/src/features/domain/entity/pagination_entity.dart';
import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list/wish_list_line_entity.dart';

class WishListLineCollectionEntity extends Equatable {
  final List<WishListLineEntity>? wishListLines;
  final PaginationEntity? pagination;

  const WishListLineCollectionEntity({
    this.wishListLines,
    this.pagination,
  });

  @override
  List<Object?> get props => [
        wishListLines,
        pagination,
      ];

  WishListLineCollectionEntity copyWith({
    List<WishListLineEntity>? wishListLines,
    PaginationEntity? pagination,
  }) {
    return WishListLineCollectionEntity(
      wishListLines: wishListLines ?? this.wishListLines,
      pagination: pagination ?? this.pagination,
    );
  }
}
