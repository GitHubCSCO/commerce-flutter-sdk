// ignore_for_file: unintended_html_in_doc_comment
import 'models.dart';

part 'customer_validation_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class CustomerValidationDto {
  CustomerValidationDto({
    this.address1,
    this.address2,
    this.address3,
    this.address4,
    this.attention,
    this.city,
    this.companyName,
    this.country,
    this.email,
    this.fax,
    this.firstName,
    this.lastName,
    this.phone,
    this.postalCode,
    this.state,
  });

  /// <summary>Gets or sets the first name.</summary>
  FieldValidationDto? firstName;

  /// Gets or sets the last name.
  FieldValidationDto? lastName;

  /// Gets or sets the company.
  FieldValidationDto? companyName;

  FieldValidationDto? attention;

  /// Gets or sets the address1.
  FieldValidationDto? address1;

  /// Gets or sets the address2.
  FieldValidationDto? address2;

  FieldValidationDto? address3;

  FieldValidationDto? address4;

  /// Gets or sets the country.
  FieldValidationDto? country;

  /// Gets or sets the state.
  FieldValidationDto? state;

  /// Gets or sets the city.
  FieldValidationDto? city;

  /// Gets or sets the postal code.
  FieldValidationDto? postalCode;

  /// Gets or sets the phone.
  FieldValidationDto? phone;

  /// Gets or sets the email.
  FieldValidationDto? email;

  FieldValidationDto? fax;

  factory CustomerValidationDto.fromJson(Map<String, dynamic> json) =>
      _$CustomerValidationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerValidationDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FieldValidationDto {
  FieldValidationDto({
    this.isDisabled,
    this.isRequired,
    this.maxLength,
  });

  bool? isRequired;

  bool? isDisabled;

  int? maxLength;

  factory FieldValidationDto.fromJson(Map<String, dynamic> json) =>
      _$FieldValidationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$FieldValidationDtoToJson(this);
}
