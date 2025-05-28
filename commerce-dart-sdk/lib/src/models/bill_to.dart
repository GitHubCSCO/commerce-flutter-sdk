import 'models.dart';

part 'bill_to.g.dart';

@JsonSerializable(explicitToJson: true)
class BillTo extends Address {
  BillTo({
    this.accountsReceivable,
    this.budgetEnforcementLevel,
    this.costCodeTitle,
    this.costCodes,
    this.customerCurrencySymbol,
    this.isDefault,
    this.isGuest,
    this.shipTos,
    this.shipTosUri,
    this.validation,
  });

  /// URI to ShipTo collection, could also use expand parameter
  String? shipTosUri;

  /// A boolean value indicating whether the current customer record is processed as a guest which acts like an anonymous customer
  bool? isGuest;

  /// Budgets are enforced at either the Customer (across all ShipTos), specific ShipTo or None (no enforcement)
  String? budgetEnforcementLevel;

  /// Cost codes are defined by Customer and are used to assign a G/L code or other designator to specific purchases.  The title field is used to define what the code represents (i.e. Job #, Account #, Department)
  String? costCodeTitle;

  /// The currency symbol associated to their assigned currency
  String? customerCurrencySymbol;

  /// Collection of cost codes defined for the customer
  List<CostCode>? costCodes;

  /// ShipTo collection
  List<ShipTo>? shipTos;

  /// Validation information for addresses based on the BillTo address setup.
  CustomerValidationDto? validation;

  /// Indicates if this BillTo is set as the user's default
  bool? isDefault;

  /// The accounts receivable information for the customer.
  AccountsReceivable? accountsReceivable;

  factory BillTo.fromJson(Map<String, dynamic> json) => _$BillToFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$BillToToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CostCode {
  CostCode({
    this.code,
    this.description,
    this.id,
    this.isActive,
  });

  String? id;

  /// Cost code itself such as a General Ledger account number
  @JsonKey(name: 'CostCode')
  String? code;

  /// Description of the cost code
  String? description;

  bool? isActive;

  factory CostCode.fromJson(Map<String, dynamic> json) =>
      _$CostCodeFromJson(json);
  Map<String, dynamic> toJson() => _$CostCodeToJson(this);
}
