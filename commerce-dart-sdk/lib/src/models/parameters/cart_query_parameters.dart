// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';
import 'package:optimizely_commerce_api/src/utils/json_encoding_methods.dart';

part 'cart_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class CartQueryParameters extends BaseQueryParameters {
  // Similar to: [QueryParameter(QueryOptions.DoNotQuery)]
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? cartId;

  int? alsoPurchasedMaxResults;

  bool? forceRecalculation;

  bool? allowInvalidAddress;

  /// Here are parameters to be passed in the Expand List.
  /// Options: cartlines, costcodes, shipping, tax, carriers, paymentoptions,
  /// shiptos, validation, restrictions, creditcardbillingaddress, warehouses,
  /// alsopurchased, hiddenproducts, paymentoptions.
  /// Since it is only a single element, no need to use comma separated
  // Similar to: [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;
  // static String? _commaSeparatedJson(List<String>? stringList) =>
  //     stringList?.join(',');

  CartQueryParameters({
    this.cartId,
    this.alsoPurchasedMaxResults,
    this.forceRecalculation,
    this.allowInvalidAddress,
    this.expand,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$CartQueryParametersToJson(this));
}
