import '../models.dart';

part 'get_bill_tos_result.g.dart';

@JsonSerializable()
class GetBillTosResult extends BaseModel {
  Pagination? pagination;

  List<BillTo>? billTos;

  GetBillTosResult({
    this.pagination,
    this.billTos,
  });

  factory GetBillTosResult.fromJson(Map<String, dynamic> json) =>
      _$GetBillTosResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetBillTosResultToJson(this);
}
