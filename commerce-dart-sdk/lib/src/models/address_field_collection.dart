import 'models.dart';

part 'address_field_collection.g.dart';

@JsonSerializable()
class AddressFieldCollection extends BaseModel {
  AddressFieldDisplayCollection? billToAddressFields;

  AddressFieldDisplayCollection? shipToAddressFields;

  AddressFieldCollection({
    this.billToAddressFields,
    this.shipToAddressFields,
  });

  factory AddressFieldCollection.fromJson(Map<String, dynamic> json) =>
      _$AddressFieldCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$AddressFieldCollectionToJson(this);
}
