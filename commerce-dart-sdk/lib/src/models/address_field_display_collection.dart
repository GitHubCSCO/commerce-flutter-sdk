import 'models.dart';

part 'address_field_display_collection.g.dart';

@JsonSerializable()
class AddressFieldDisplayCollection extends BaseModel {
  AddressFieldDisplay? address1;

  AddressFieldDisplay? address2;

  AddressFieldDisplay? address3;

  AddressFieldDisplay? address4;

  AddressFieldDisplay? attention;

  AddressFieldDisplay? city;

  AddressFieldDisplay? companyName;

  AddressFieldDisplay? contactFullName;

  AddressFieldDisplay? country;

  AddressFieldDisplay? email;

  AddressFieldDisplay? fax;

  AddressFieldDisplay? firstName;

  AddressFieldDisplay? lastName;

  AddressFieldDisplay? phone;

  AddressFieldDisplay? postalCode;

  AddressFieldDisplay? state;

  AddressFieldDisplayCollection({
    this.address1,
    this.address2,
    this.address3,
    this.address4,
    this.attention,
    this.city,
    this.companyName,
    this.contactFullName,
    this.country,
    this.email,
    this.fax,
    this.firstName,
    this.lastName,
    this.phone,
    this.postalCode,
    this.state,
  });

  factory AddressFieldDisplayCollection.fromJson(Map<String, dynamic> json) =>
      _$AddressFieldDisplayCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$AddressFieldDisplayCollectionToJson(this);
}
