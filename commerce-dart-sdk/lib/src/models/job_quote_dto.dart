import 'models.dart';

part 'job_quote_dto.g.dart';

@JsonSerializable()
class JobQuoteDto extends Cart {
  String? jobQuoteId;

  bool? isEditable;

  DateTime? expirationDate;

  String? jobName;

  List<JobQuoteLine>? jobQuoteLineCollection;

  String? customerName;

  String? shipToFullAddress;

  num? orderTotal;

  String? orderTotalDisplay;

  JobQuoteDto({
    this.jobQuoteId,
    this.isEditable,
    this.expirationDate,
    this.jobName,
    this.jobQuoteLineCollection,
    this.customerName,
    this.shipToFullAddress,
    this.orderTotal,
    this.orderTotalDisplay,
  });

  factory JobQuoteDto.fromJson(Map<String, dynamic> json) =>
      _$JobQuoteDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JobQuoteDtoToJson(this);
}

@JsonSerializable()
class JobQuoteLine extends CartLine {
  PricingRfq? pricingRfq;

  /// Gets or sets the max quantity.
  num? maxQty;

  /// Gets or sets the quantity sold.
  num? qtySold;

  /// Gets or sets the quantity order.
  num? qtyRequested;

  JobQuoteLine({
    this.pricingRfq,
    this.maxQty,
    this.qtySold,
    this.qtyRequested,
  });

  factory JobQuoteLine.fromJson(Map<String, dynamic> json) =>
      _$JobQuoteLineFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JobQuoteLineToJson(this);
}
