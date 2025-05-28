import 'models.dart';

part 'dealer.g.dart';

@JsonSerializable()
class Dealer extends BaseModel {
  String? id;

  String? name;

  String? address1;

  String? address2;

  String? city;

  String? state;

  String? postalCode;

  String? countryId;

  String? phone;

  double? latitude;

  double? longitude;

  String? webSiteUrl;

  String? htmlContent;

  double? distance;

  Dealer({
    this.id,
    this.name,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postalCode,
    this.countryId,
    this.phone,
    this.latitude,
    this.longitude,
    this.webSiteUrl,
    this.htmlContent,
    this.distance,
  });

  factory Dealer.fromJson(Map<String, dynamic> json) => _$DealerFromJson(json);

  Map<String, dynamic> toJson() => _$DealerToJson(this);
}
