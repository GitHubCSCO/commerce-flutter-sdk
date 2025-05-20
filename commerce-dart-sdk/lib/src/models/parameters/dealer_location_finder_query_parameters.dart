import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'dealer_location_finder_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class DealerLocationFinderQueryParameters extends BaseQueryParameters {
  double? latitude;

  double? longitude;

  double? radius;

  DealerLocationFinderQueryParameters({
    this.latitude,
    this.longitude,
    this.radius,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$DealerLocationFinderQueryParametersToJson(this));
}
