import '../models.dart';

part 'get_warehouse_collection_result.g.dart';

@JsonSerializable()
class GetWarehouseCollectionResult extends BaseModel {
  Pagination? pagination;

  List<Warehouse>? warehouses;

  String? distanceUnitOfMeasure;

  double? defaultLatitude;

  double? defaultLongitude;

  int? defaultRadius;

  GetWarehouseCollectionResult({
    this.pagination,
    this.warehouses,
    this.distanceUnitOfMeasure,
    this.defaultLatitude,
    this.defaultLongitude,
    this.defaultRadius,
  });

  factory GetWarehouseCollectionResult.fromJson(Map<String, dynamic> json) =>
      _$GetWarehouseCollectionResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetWarehouseCollectionResultToJson(this);
}
