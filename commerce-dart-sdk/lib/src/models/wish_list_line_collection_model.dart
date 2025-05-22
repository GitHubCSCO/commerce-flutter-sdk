import 'models.dart';

part 'wish_list_line_collection_model.g.dart';

@JsonSerializable()
class WishListLineCollectionModel {
  List<WishListLine>? wishListLines;

  Pagination? pagination;

  WishListLineCollectionModel({
    this.wishListLines,
    this.pagination,
  });

  factory WishListLineCollectionModel.fromJson(Map<String, dynamic> json) =>
      _$WishListLineCollectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishListLineCollectionModelToJson(this);
}
