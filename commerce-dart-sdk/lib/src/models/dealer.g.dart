// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dealer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dealer _$DealerFromJson(Map<String, dynamic> json) => Dealer(
      id: json['id'] as String?,
      name: json['name'] as String?,
      address1: json['address1'] as String?,
      address2: json['address2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postalCode: json['postalCode'] as String?,
      countryId: json['countryId'] as String?,
      phone: json['phone'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      webSiteUrl: json['webSiteUrl'] as String?,
      htmlContent: json['htmlContent'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$DealerToJson(Dealer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('address1', instance.address1);
  writeNotNull('address2', instance.address2);
  writeNotNull('city', instance.city);
  writeNotNull('state', instance.state);
  writeNotNull('postalCode', instance.postalCode);
  writeNotNull('countryId', instance.countryId);
  writeNotNull('phone', instance.phone);
  writeNotNull('latitude', instance.latitude);
  writeNotNull('longitude', instance.longitude);
  writeNotNull('webSiteUrl', instance.webSiteUrl);
  writeNotNull('htmlContent', instance.htmlContent);
  writeNotNull('distance', instance.distance);
  return val;
}
