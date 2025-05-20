import 'models.dart';

part 'credit_card_billing_address.g.dart';

@JsonSerializable()
class CreditCardBillingAddress {
  String? address1;

  String? address2;

  String? city;

  String? stateAbbreviation;

  String? countryAbbreviation;

  String? postalCode;

  CreditCardBillingAddress({
    this.address1,
    this.address2,
    this.city,
    this.stateAbbreviation,
    this.countryAbbreviation,
    this.postalCode,
  });

  factory CreditCardBillingAddress.fromJson(Map<String, dynamic> json) =>
      _$CreditCardBillingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardBillingAddressToJson(this);
}
