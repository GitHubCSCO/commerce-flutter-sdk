import '../models.dart';

part 'get_order_collection_result.g.dart';

@JsonSerializable()
class GetOrderCollectionResult extends BaseModel {
  Pagination? pagination;

  List<Order>? orders;

  /// Gets or sets a value indicating whether [show erp order number].
  bool? showErpOrderNumber;

  GetOrderCollectionResult({
    this.pagination,
    this.orders,
    this.showErpOrderNumber,
  });

  factory GetOrderCollectionResult.fromJson(Map<String, dynamic> json) =>
      _$GetOrderCollectionResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetOrderCollectionResultToJson(this);
}
