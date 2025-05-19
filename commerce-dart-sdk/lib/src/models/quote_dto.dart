import 'models.dart';

part 'quote_dto.g.dart';

@JsonSerializable()
class QuoteDto extends Cart {
  String? quoteLinesUri;

  String? quoteNumber;

  /// Gets or sets the quote expiration date.
  DateTime? expirationDate;

  String? customerNumber;

  String? customerName;

  String? shipToFullAddress;

  List<QuoteLine>? quoteLineCollection;

  String? userName;

  bool? isEditable;

  /// Gets or sets the message audits.
  List<QuoteMessage>? messageCollection;

  List<CalculationMethod>? calculationMethods;

  /// Gets or sets a value indicating whether its job quote.
  bool? isJobQuote;

  String? jobName;

  QuoteDto({
    this.quoteLinesUri,
    this.quoteNumber,
    this.expirationDate,
    this.customerNumber,
    this.customerName,
    this.shipToFullAddress,
    this.quoteLineCollection,
    this.userName,
    this.isEditable,
    this.messageCollection,
    this.calculationMethods,
    this.isJobQuote,
    this.jobName,
  });

  factory QuoteDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteDtoFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuoteDtoToJson(this);
}

@JsonSerializable()
class QuoteLine extends CartLine {
  PricingRfq? pricingRfq;
  num? maxQty;

  QuoteLine({
    this.pricingRfq,
    this.maxQty,
  });

  factory QuoteLine.fromJson(Map<String, dynamic> json) =>
      _$QuoteLineFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QuoteLineToJson(this);
}

@JsonSerializable()
class PricingRfq extends BaseModel {
  num? unitCost;
  String? unitCostDisplay;
  num? listPrice;
  String? listPriceDisplay;
  num? customerPrice;
  String? customerPriceDisplay;
  num? minimumPriceAllowed;
  String? minimumPriceAllowedDisplay;
  num? maxDiscountPct;
  num? minMarginAllowed;
  bool? showListPrice;
  bool? showCustomerPrice;
  bool? showUnitCost;
  List<BreakPrice>? priceBreaks;
  List<CalculationMethod>? calculationMethods;

  /// Gets or sets the validation messages.
  List<ValidationMessage>? validationMessages;

  PricingRfq({
    this.unitCost,
    this.unitCostDisplay,
    this.listPrice,
    this.listPriceDisplay,
    this.customerPrice,
    this.customerPriceDisplay,
    this.minimumPriceAllowed,
    this.minimumPriceAllowedDisplay,
    this.maxDiscountPct,
    this.minMarginAllowed,
    this.showListPrice,
    this.showCustomerPrice,
    this.showUnitCost,
    this.priceBreaks,
    this.calculationMethods,
    this.validationMessages,
  });

  factory PricingRfq.fromJson(Map<String, dynamic> json) =>
      _$PricingRfqFromJson(json);

  Map<String, dynamic> toJson() => _$PricingRfqToJson(this);
}

@JsonSerializable()
class CalculationMethod {
  String? value;
  String? name;
  String? displayName;
  String? maximumDiscount;
  String? minimumMargin;

  CalculationMethod({
    this.value,
    this.name,
    this.displayName,
    this.maximumDiscount,
    this.minimumMargin,
  });

  factory CalculationMethod.fromJson(Map<String, dynamic> json) =>
      _$CalculationMethodFromJson(json);

  Map<String, dynamic> toJson() => _$CalculationMethodToJson(this);
}

@JsonSerializable()
class BreakPrice {
  num? startQty;
  String? startQtyDisplay;
  num? endQty;
  String? endQtyDisplay;
  num? price;
  String? priceDispaly;
  int? percent;
  String? calculationMethod;

  BreakPrice({
    this.startQty,
    this.startQtyDisplay,
    this.endQty,
    this.endQtyDisplay,
    this.price,
    this.priceDispaly,
    this.percent,
    this.calculationMethod,
  });

  factory BreakPrice.fromJson(Map<String, dynamic> json) =>
      _$BreakPriceFromJson(json);

  Map<String, dynamic> toJson() => _$BreakPriceToJson(this);
}

@JsonSerializable()
class ValidationMessage {
  String key;
  String value;

  ValidationMessage({required this.key, required this.value});

  factory ValidationMessage.fromJson(Map<String, dynamic> json) =>
      _$ValidationMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ValidationMessageToJson(this);
}
