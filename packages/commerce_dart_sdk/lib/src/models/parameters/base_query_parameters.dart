import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

part 'base_query_parameters.g.dart';

/// The base class for all query parameters
///
/// Doesn't create [fromJson].
/// [JsonSerializable] is required to convert an object to a map
/// while requesting with an [Uri], the [queryparameters] need to be a map
/// so by using [Uri("...", queryParameter: BaseQueryParameters.toJson())]
/// the object is automatically converted to be used as query parameter.
@JsonSerializable(createFactory: false)
class BaseQueryParameters {
  BaseQueryParameters({
    this.page,
    this.pageSize,
    this.sort,
  });

  int? page;
  int? pageSize;
  String? sort;

  // Automatic conversion of map values ([int], [bool] etc.) to [String]
  // this is required since [toJson()] method converts an object to [Map]
  // and for sending request, the [queryParameters] needs to be set with a [Map]
  // and [queryParameters] Map cannot have any value that is in types like [int] or [bool]
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$BaseQueryParametersToJson(this));
}
