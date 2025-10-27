import 'package:commerce_flutter_sdk/src/features/domain/entity/wish_list_filter_item_entity.dart';

class WishListFilterParametersEntity {
  final DateTime? fromCreatedDate;
  final DateTime? toCreatedDate;
  final DateTime? fromUpdatedOn;
  final DateTime? toUpdatedOn;
  final WishListFilterItemEntity? product;
  final WishListFilterItemEntity? brand;
  final WishListFilterItemEntity? sharedByUser;

  WishListFilterParametersEntity({
    required this.fromCreatedDate,
    required this.toCreatedDate,
    required this.fromUpdatedOn,
    required this.toUpdatedOn,
    required this.product,
    required this.brand,
    required this.sharedByUser,
  });
}
