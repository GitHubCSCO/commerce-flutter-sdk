// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legacy_configuration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegacyConfiguration _$LegacyConfigurationFromJson(Map<String, dynamic> json) =>
    LegacyConfiguration(
      configSections: (json['configSections'] as List<dynamic>?)
          ?.map((e) => ConfigSection.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasDefaults: json['hasDefaults'] as bool?,
      isKit: json['isKit'] as bool?,
    );

Map<String, dynamic> _$LegacyConfigurationToJson(
        LegacyConfiguration instance) =>
    <String, dynamic>{
      if (instance.configSections?.map((e) => e.toJson()).toList()
          case final value?)
        'configSections': value,
      if (instance.hasDefaults case final value?) 'hasDefaults': value,
      if (instance.isKit case final value?) 'isKit': value,
    };

ConfigSection _$ConfigSectionFromJson(Map<String, dynamic> json) =>
    ConfigSection(
      id: json['id'] as String?,
      sectionName: json['sectionName'] as String?,
      label: json['label'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      sectionOptions: (json['sectionOptions'] as List<dynamic>?)
          ?.map((e) => ConfigSectionOption.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConfigSectionToJson(ConfigSection instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.sectionName case final value?) 'sectionName': value,
      if (instance.label case final value?) 'label': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.sectionOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'sectionOptions': value,
    };

ConfigSectionOption _$ConfigSectionOptionFromJson(Map<String, dynamic> json) =>
    ConfigSectionOption(
      id: json['id'] as String?,
      productId: json['productId'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: json['price'] as num?,
      selected: json['selected'] as bool?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      quantity: json['quantity'] as num?,
      cantBuy: json['cantBuy'] as bool?,
    );

Map<String, dynamic> _$ConfigSectionOptionToJson(
        ConfigSectionOption instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.productId case final value?) 'productId': value,
      if (instance.name case final value?) 'name': value,
      if (instance.description case final value?) 'description': value,
      if (instance.price case final value?) 'price': value,
      if (instance.selected case final value?) 'selected': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.quantity case final value?) 'quantity': value,
      if (instance.cantBuy case final value?) 'cantBuy': value,
    };
