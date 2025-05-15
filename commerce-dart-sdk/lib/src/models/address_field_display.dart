import 'models.dart';

part 'address_field_display.g.dart';

@JsonSerializable()
class AddressFieldDisplay extends BaseModel {
  String? displayName;

  bool? isVisible;

  AddressFieldDisplay({
    this.displayName,
    this.isVisible,
  });

  factory AddressFieldDisplay.fromJson(Map<String, dynamic> json) =>
      _$AddressFieldDisplayFromJson(json);

  Map<String, dynamic> toJson() => _$AddressFieldDisplayToJson(this);
}
