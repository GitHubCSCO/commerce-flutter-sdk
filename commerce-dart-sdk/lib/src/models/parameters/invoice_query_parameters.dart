import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'invoice_query_parameters.g.dart';

@JsonSerializable(createFactory: false)
class InvoiceQueryParameters extends BaseQueryParameters {
  /// Gets or sets a value indicating whether [show open only].
  bool? showOpenOnly;

  String? invoiceNumber;

  String? orderNumber;

  /// Gets or sets the customer po.
  String? poNumber;

  DateTime? fromDate;

  DateTime? toDate;

  String? customerSequence;

  @JsonKey(includeFromJson: false, includeToJson: false)
  ShipTo? shipTo;

  InvoiceQueryParameters({
    this.showOpenOnly,
    this.invoiceNumber,
    this.orderNumber,
    this.poNumber,
    this.fromDate,
    this.toDate,
    this.customerSequence = '-1', // show all
    this.shipTo,
    super.page,
    super.pageSize,
    super.sort,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$InvoiceQueryParametersToJson(this));
}

@JsonSerializable(createFactory: false)
class InvoiceDetailParameter extends BaseQueryParameters {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? invoiceNumber;

  @JsonKey(toJson: JsonEncodingMethods.commaSeparatedJson)
  List<String>? expand;

  InvoiceDetailParameter({
    this.invoiceNumber,
    this.expand,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$InvoiceDetailParameterToJson(this));
}

@JsonSerializable(createFactory: false)
class InvoiceEmailParameter extends BaseQueryParameters {
  String? emailTo;

  String? emailFrom;

  String? subject;

  String? message;

  String? entityId;

  String? entityName;

  InvoiceEmailParameter({
    this.emailTo,
    this.emailFrom,
    this.subject,
    this.message,
    this.entityId,
    this.entityName,
  });

  @override
  Map<String, dynamic> toJson() =>
      JsonEncodingMethods.convertAttributesToString(
          _$InvoiceEmailParameterToJson(this));
}
