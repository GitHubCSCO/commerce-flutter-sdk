import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'wish_list_line_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class WishListLineQueryParameters extends BaseQueryParameters {
  String? query;

  int? defaultPageSize;

  String? changedSharedListLinesQuantities;

  @override
  String? get sort => super.sort ?? WishListLineSortOrder.customSort.value;

  WishListLineQueryParameters({
    this.query,
    this.defaultPageSize,
    this.changedSharedListLinesQuantities,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$WishListLineQueryParametersToJson(this));
}
