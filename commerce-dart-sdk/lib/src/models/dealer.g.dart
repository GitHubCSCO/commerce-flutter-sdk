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

Map<String, dynamic> _$DealerToJson(Dealer instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.address1 case final value?) 'address1': value,
      if (instance.address2 case final value?) 'address2': value,
      if (instance.city case final value?) 'city': value,
      if (instance.state case final value?) 'state': value,
      if (instance.postalCode case final value?) 'postalCode': value,
      if (instance.countryId case final value?) 'countryId': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.latitude case final value?) 'latitude': value,
      if (instance.longitude case final value?) 'longitude': value,
      if (instance.webSiteUrl case final value?) 'webSiteUrl': value,
      if (instance.htmlContent case final value?) 'htmlContent': value,
      if (instance.distance case final value?) 'distance': value,
    };
