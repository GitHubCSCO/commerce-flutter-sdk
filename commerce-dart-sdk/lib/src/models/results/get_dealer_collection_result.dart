import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'get_dealer_collection_result.g.dart';

@JsonSerializable()
class GetDealerCollectionResult extends BaseModel {
  Pagination? pagination;

  List<Dealer>? dealers;

  double? defaultLatitude;

  double? defaultLongitude;

  double? defaultRadius;

  String? distanceUnitOfMeasure;

  GetDealerCollectionResult({
    this.pagination,
    this.dealers,
    this.defaultLatitude,
    this.defaultLongitude,
    this.defaultRadius,
    this.distanceUnitOfMeasure,
  });

  factory GetDealerCollectionResult.fromJson(Map<String, dynamic> json) =>
      _$GetDealerCollectionResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetDealerCollectionResultToJson(this);
}
