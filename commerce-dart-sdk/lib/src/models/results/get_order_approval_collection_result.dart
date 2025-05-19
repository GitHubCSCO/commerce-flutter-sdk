import '../models.dart';

part 'get_order_approval_collection_result.g.dart';

@JsonSerializable()
class GetOrderApprovalCollectionResult extends BaseModel {
  Pagination? pagination;

  List<Cart>? cartCollection;
  GetOrderApprovalCollectionResult({
    this.pagination,
    this.cartCollection,
  });

  factory GetOrderApprovalCollectionResult.fromJson(
          Map<String, dynamic> json) =>
      _$GetOrderApprovalCollectionResultFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetOrderApprovalCollectionResultToJson(this);
}
