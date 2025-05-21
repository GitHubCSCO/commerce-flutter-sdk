import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'wish_list_tag_collection.g.dart';

@JsonSerializable()
class WishListTagCollectionModel extends BaseModel {
  List<WishListTagModel>? wishListTags;

  Pagination? pagination;

  WishListTagCollectionModel({
    this.wishListTags,
    this.pagination,
  });

  factory WishListTagCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$WishListTagCollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishListTagCollectionModelToJson(this);
}
