import 'models.dart';

part 'ship_to.g.dart';

@JsonSerializable(explicitToJson: true)
class ShipTo extends Address {
  ShipTo({
    this.isDefault,
    this.isNew,
    this.oneTimeAddress,
    this.validation,
  });

  /// Indicates if the instance of the ShipTo is new
  bool? isNew;

  bool? oneTimeAddress;

  CustomerValidationDto? validation;

  /// Indicates if the ShipTo record is marked as the default customer/ShipTo for the current user
  bool? isDefault;

  factory ShipTo.fromJson(Map<String, dynamic> json) => _$ShipToFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ShipToToJson(this);
}
