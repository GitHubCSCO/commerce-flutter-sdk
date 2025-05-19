import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

part 'account_payment_profile.g.dart';

@JsonSerializable()
class AccountPaymentProfile extends BaseModel {
  /// Gets or sets the identifier.
  String? id;

  /// Gets or sets the description.
  String? description;

  /// Gets or sets the card type.
  String? cardType;

  /// Gets or sets the expiration date month/year.
  String? expirationDate;

  /// Gets or sets the masked card number.
  String? maskedCardNumber;

  /// Gets or sets the card identifier.
  String? cardIdentifier;

  /// Gets or sets the card holder name.
  String? cardHolderName;

  /// Gets or sets the address1.
  String? address1;

  /// Gets or sets the address2.
  String? address2;

  /// Gets or sets the address3.
  String? address3;

  /// Gets or sets the address4.
  String? address4;

  /// Gets or sets the city.
  String? city;

  /// Gets or sets the state.
  String? state;

  /// Gets or sets the postcode.
  String? postalCode;

  /// Gets or sets the country.
  String? country;

  /// Gets or sets a value indicating whether gets or sets the is payment profile default.
  bool? isDefault;

  /// Gets or sets the token scheme.
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? tokenScheme;

  /// Return 4 letters ending of card number.
  @JsonKey(includeFromJson: false, includeToJson: false)
  String get cardNumberEnding {
    int length = 4;
    if (maskedCardNumber.isNullOrEmpty) {
      return '';
    }

    if (maskedCardNumber!.length <= length) {
      return maskedCardNumber!;
    }

    return maskedCardNumber!
        .substring(maskedCardNumber!.length - length, length);
  }

  /// Return month of expiration.
  @JsonKey(includeFromJson: false, includeToJson: false)
  int get expirationMonth {
    if (expirationDate.isNullorWhitespace) {
      return 0;
    }

    List<String> expiration = expirationDate!.split(
      '/',
      // Omitting StringSplitOptions.RemoveEmptyEntries, as Dart's split function removes empty strings by default
    );

    if (int.tryParse(expiration[0]) != null) {
      return int.parse(expiration[0]);
    } else {
      return 0;
    }
  }

  /// Return month of expiration.
  @JsonKey(includeFromJson: false, includeToJson: false)
  int get expirationYear {
    if (expirationDate.isNullorWhitespace) {
      return 0;
    }

    List<String> expiration = expirationDate!.split(
      '/',
      // Omitting StringSplitOptions.RemoveEmptyEntries, as Dart's split function removes empty strings by default
    );

    if (expiration.length <= 1) {
      return 0;
    }

    if (int.tryParse(expiration[1]) != null) {
      return int.parse(expiration[1]);
    } else {
      return 0;
    }
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool get isExpired {
    int yearTwoLetter = DateTime.now().year % 100;

    if (expirationYear < yearTwoLetter) {
      return true;
    }

    if (expirationYear > yearTwoLetter) {
      return false;
    }

    // Current year
    if (expirationMonth < DateTime.now().month) {
      return true;
    }

    return false;
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? securityCode;

  AccountPaymentProfile({
    this.id,
    this.description,
    this.cardType,
    this.expirationDate,
    this.maskedCardNumber,
    this.cardIdentifier,
    this.cardHolderName,
    this.address1,
    this.address2,
    this.address3,
    this.address4,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.isDefault,
    this.tokenScheme,
    this.securityCode,
  });

  factory AccountPaymentProfile.fromJson(Map<String, dynamic> json) =>
      _$AccountPaymentProfileFromJson(json);

  Map<String, dynamic> toJson() => _$AccountPaymentProfileToJson(this);
}
