import 'models.dart';

part 'wish_list_add_to_cart_collection.g.dart';

@JsonSerializable()
class WishListAddToCartCollection extends BaseModel {
  List<AddCartLine>? wishListLines;

  WishListAddToCartCollection({this.wishListLines});

  factory WishListAddToCartCollection.fromJson(Map<String, dynamic> json) =>
      _$WishListAddToCartCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$WishListAddToCartCollectionToJson(this);
}
