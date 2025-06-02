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

Map<String, dynamic> _$CurrencyCollectionToJson(CurrencyCollection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull(
      'currencies', instance.currencies?.map((e) => e.toJson()).toList());
  return val;
}
