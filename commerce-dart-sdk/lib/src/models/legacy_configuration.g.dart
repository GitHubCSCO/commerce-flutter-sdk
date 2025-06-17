// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legacy_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegacyConfiguration _$LegacyConfigurationFromJson(Map<String, dynamic> json) =>
    LegacyConfiguration(
      hasDefaults: json['hasDefaults'] as bool?,
      isKit: json['isKit'] as bool?,
      sections: (json['sections'] as List<dynamic>?)
          ?.map((e) => ConfigSection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LegacyConfigurationToJson(
        LegacyConfiguration instance) =>
    <String, dynamic>{
      if (instance.sections?.map((e) => e.toJson()).toList() case final value?)
        'sections': value,
      if (instance.hasDefaults case final value?) 'hasDefaults': value,
      if (instance.isKit case final value?) 'isKit': value,
    };

ConfigSection _$ConfigSectionFromJson(Map<String, dynamic> json) =>
    ConfigSection(
      id: json['id'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => ConfigSectionOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      sectionName: json['sectionName'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ConfigSectionToJson(ConfigSection instance) =>
    <String, dynamic>{
      if (instance.sectionName case final value?) 'sectionName': value,
      if (instance.options?.map((e) => e.toJson()).toList() case final value?)
        'options': value,
      if (instance.id case final value?) 'id': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
    };

ConfigSectionOption _$ConfigSectionOptionFromJson(Map<String, dynamic> json) =>
    ConfigSectionOption(
      description: json['description'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      price: json['price'] as num?,
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      quantity: json['quantity'] as num?,
      sectionName: json['sectionName'] as String?,
      sectionOptionId: json['sectionOptionId'] as String?,
      selected: json['selected'] as bool?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      userProductPrice: json['userProductPrice'] as bool?,
    );

Map<String, dynamic> _$ConfigSectionOptionToJson(
        ConfigSectionOption instance) =>
    <String, dynamic>{
      if (instance.sectionOptionId case final value?) 'sectionOptionId': value,
      if (instance.sectionName case final value?) 'sectionName': value,
      if (instance.productName case final value?) 'productName': value,
      if (instance.productId case final value?) 'productId': value,
      if (instance.description case final value?) 'description': value,
      if (instance.price case final value?) 'price': value,
      if (instance.userProductPrice case final value?)
        'userProductPrice': value,
      if (instance.selected case final value?) 'selected': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.quantity case final value?) 'quantity': value,
    };
