import '../models.dart';

part 'get_real_time_inventory_result.g.dart';

@JsonSerializable()
class GetRealTimeInventoryResult extends BaseModel {
  List<ProductInventory>? realTimeInventoryResults;

  GetRealTimeInventoryResult({
    this.realTimeInventoryResults,
  });

  factory GetRealTimeInventoryResult.fromJson(Map<String, dynamic> json) =>
      _$GetRealTimeInventoryResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetRealTimeInventoryResultToJson(this);
}
