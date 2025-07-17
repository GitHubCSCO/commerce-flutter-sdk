// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyCollection _$CurrencyCollectionFromJson(Map<String, dynamic> json) =>
    CurrencyCollection(
      currencies: (json['currencies'] as List<dynamic>?)
          ?.map((e) => Currency.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$CurrencyCollectionToJson(CurrencyCollection instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.currencies?.map((e) => e.toJson()).toList()
          case final value?)
        'currencies': value,
    };
