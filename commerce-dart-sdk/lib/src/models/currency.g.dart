// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      currencyCode: json['currencyCode'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
      description: json['description'] as String?,
      iD: json['iD'] as String?,
      isDefault: json['isDefault'] as bool?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.iD case final value?) 'iD': value,
      if (instance.currencyCode case final value?) 'currencyCode': value,
      if (instance.description case final value?) 'description': value,
      if (instance.currencySymbol case final value?) 'currencySymbol': value,
      if (instance.isDefault case final value?) 'isDefault': value,
    };
