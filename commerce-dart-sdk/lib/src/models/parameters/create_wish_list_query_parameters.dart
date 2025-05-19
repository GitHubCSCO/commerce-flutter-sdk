import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'create_wish_list_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class CreateWishListQueryParameters extends BaseQueryParameters {
  WishList? wishListObj;
  CreateWishListQueryParameters({
    this.wishListObj,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$CreateWishListQueryParametersToJson(this));
}
