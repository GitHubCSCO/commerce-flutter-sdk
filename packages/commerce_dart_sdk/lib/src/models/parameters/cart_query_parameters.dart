// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_dart_sdk/commerce_dart_sdk.dart';

@JsonSerializable(createFactory: false)
class CartQueryParameters extends BaseQueryParameters {
  // [QueryParameter(QueryOptions.DoNotQuery)]
  String? cartId;

  int? alsoPurchasedMaxResults;

  bool? forceRecalculation;

  bool? allowInvalidAddress;

  /// Here are parameters to be passed in the Expand List.
  /// Options: cartlines, costcodes, shipping, tax, carriers, paymentoptions,
  /// shiptos, validation, restrictions, creditcardbillingaddress, warehouses,
  /// alsopurchased, hiddenproducts, paymentoptions

  // [QueryParameter(queryType: QueryListParameterType.CommaSeparated)]
  List<String>? expand;
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
}
