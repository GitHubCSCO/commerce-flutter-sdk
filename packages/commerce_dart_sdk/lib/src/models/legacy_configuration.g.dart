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
      'sections': instance.sections?.map((e) => e.toJson()).toList(),
      'hasDefaults': instance.hasDefaults,
      'isKit': instance.isKit,
    };

ConfigSection _$ConfigSectionFromJson(Map<String, dynamic> json) =>
    ConfigSection(
      id: json['id'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => ConfigSectionOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      sectionName: json['sectionName'] as String?,
      sortOrder: json['sortOrder'] as int?,
    );

Map<String, dynamic> _$ConfigSectionToJson(ConfigSection instance) =>
    <String, dynamic>{
      'sectionName': instance.sectionName,
      'options': instance.options?.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'sortOrder': instance.sortOrder,
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
      sortOrder: json['sortOrder'] as int?,
      userProductPrice: json['userProductPrice'] as bool?,
    );

Map<String, dynamic> _$ConfigSectionOptionToJson(
        ConfigSectionOption instance) =>
    <String, dynamic>{
      'sectionOptionId': instance.sectionOptionId,
      'sectionName': instance.sectionName,
      'productName': instance.productName,
      'productId': instance.productId,
      'description': instance.description,
      'price': instance.price,
      'userProductPrice': instance.userProductPrice,
      'selected': instance.selected,
      'sortOrder': instance.sortOrder,
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
    };
