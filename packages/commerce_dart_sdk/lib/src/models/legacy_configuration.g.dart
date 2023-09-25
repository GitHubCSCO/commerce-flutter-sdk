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

Map<String, dynamic> _$LegacyConfigurationToJson(LegacyConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sections', instance.sections?.map((e) => e.toJson()).toList());
  writeNotNull('hasDefaults', instance.hasDefaults);
  writeNotNull('isKit', instance.isKit);
  return val;
}

ConfigSection _$ConfigSectionFromJson(Map<String, dynamic> json) =>
    ConfigSection(
      id: json['id'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => ConfigSectionOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      sectionName: json['sectionName'] as String?,
      sortOrder: json['sortOrder'] as int?,
    );

Map<String, dynamic> _$ConfigSectionToJson(ConfigSection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sectionName', instance.sectionName);
  writeNotNull('options', instance.options?.map((e) => e.toJson()).toList());
  writeNotNull('id', instance.id);
  writeNotNull('sortOrder', instance.sortOrder);
  return val;
}

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

Map<String, dynamic> _$ConfigSectionOptionToJson(ConfigSectionOption instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sectionOptionId', instance.sectionOptionId);
  writeNotNull('sectionName', instance.sectionName);
  writeNotNull('productName', instance.productName);
  writeNotNull('productId', instance.productId);
  writeNotNull('description', instance.description);
  writeNotNull('price', instance.price);
  writeNotNull('userProductPrice', instance.userProductPrice);
  writeNotNull('selected', instance.selected);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('quantity', instance.quantity);
  return val;
}
