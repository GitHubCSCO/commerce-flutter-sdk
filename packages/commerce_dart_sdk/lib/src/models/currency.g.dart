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
        (k, e) => MapEntry(k, e as String),
      );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'uri': instance.uri,
      'properties': instance.properties,
      'iD': instance.iD,
      'currencyCode': instance.currencyCode,
      'description': instance.description,
      'currencySymbol': instance.currencySymbol,
      'isDefault': instance.isDefault,
    };
