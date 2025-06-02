import 'models.dart';

part 'wish_list_collection_model.g.dart';

@JsonSerializable()
class WishListCollectionModel extends BaseModel {
  List<WishList>? wishListCollection;

  Pagination? pagination;

  WishListCollectionModel({
    this.wishListCollection,
    this.pagination,
  });

  factory WishListCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$WishListCollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishListCollectionModelToJson(this);
}
