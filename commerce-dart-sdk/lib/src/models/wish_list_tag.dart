import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'wish_list_tag.g.dart';

@JsonSerializable()
class WishListTagModel extends BaseModel {
  String? id;
  String? tag;

  WishListTagModel({
    this.id,
    this.tag,
  });

  factory WishListTagModel.fromJson(Map<String, dynamic> json) =>
      _$WishListTagModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishListTagModelToJson(this);
}
