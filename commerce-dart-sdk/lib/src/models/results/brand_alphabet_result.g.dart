// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_alphabet_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandAlphabetResult _$BrandAlphabetResultFromJson(Map<String, dynamic> json) =>
    BrandAlphabetResult(
      alphabet: (json['alphabet'] as List<dynamic>?)
          ?.map((e) => BrandAlphabet.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$BrandAlphabetResultToJson(
        BrandAlphabetResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.alphabet?.map((e) => e.toJson()).toList() case final value?)
        'alphabet': value,
    };
