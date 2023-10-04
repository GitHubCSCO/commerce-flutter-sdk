import 'models.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address extends BaseModel {
  Address({
    this.address1,
    this.address2,
    this.address3,
    this.address4,
    this.attention,
    this.city,
    this.companyName,
    this.country,
    this.customerName,
    this.customerNumber,
    this.customerSequence,
    this.email,
    this.fax,
    this.firstName,
    this.fullAddress,
    this.id,
    this.isVmiLocation,
    this.label,
    this.lastName,
    this.phone,
    this.postalCode,
    this.state,
  });

  /// Identifier
  String? id;

  /// CustomerNumber along with CustomerSequence uniquely defines a customer record and may be different than the ERPNumber
  String? customerNumber;

  /// CustomerSequence is normally blank for the BillTo and has some value to define each ShipTo record
  String? customerSequence;

  /// CustomerName is derived from the CompanyName + LastName + FirstName fields
  String? customerName;

  /// Display label used in the BillTo/ShipTo selection dropdown. It is a concatenation of the CompanyNumber, CustomerName, City and State
  String? label;

  String? firstName;

  String? lastName;

  /// CompanyName is used as the first line of the address
  String? companyName;

  String? attention;

  String? address1;

  String? address2;

  String? address3;

  String? address4;

  String? city;

  String? postalCode;

  State? state;

  Country? country;

  String? phone;

  /// Concatenates the address fields, city, state, and postal code but not country
  String? fullAddress;

  String? email;

  String? fax;

  bool? isVmiLocation;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
