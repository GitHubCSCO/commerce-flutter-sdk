// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String?,
      name: json['name'] as String?,
      shortDescription: json['shortDescription'] as String?,
      urlSegment: json['urlSegment'] as String?,
      smallImagePath: json['smallImagePath'] as String?,
      largeImagePath: json['largeImagePath'] as String?,
      imageAltText: json['imageAltText'] as String?,
      activateOn: json['activateOn'] == null
          ? null
          : DateTime.parse(json['activateOn'] as String),
      deactivateOn: json['deactivateOn'] == null
          ? null
          : DateTime.parse(json['deactivateOn'] as String),
      metaKeywords: json['metaKeywords'] as String?,
      metaDescription: json['metaDescription'] as String?,
      htmlContent: json['htmlContent'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      isFeatured: json['isFeatured'] as bool?,
      isDynamic: json['isDynamic'] as bool?,
      subCategories: (json['subCategories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String?,
      mobileBannerImageUrl: json['mobileBannerImageUrl'] as String?,
      mobilePrimaryText: json['mobilePrimaryText'] as String?,
      mobileSecondaryText: json['mobileSecondaryText'] as String?,
      mobileTextJustification: json['mobileTextJustification'] as String?,
      mobileTextColor: json['mobileTextColor'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$CategoryToJson(Category instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('shortDescription', instance.shortDescription);
  writeNotNull('urlSegment', instance.urlSegment);
  writeNotNull('smallImagePath', instance.smallImagePath);
  writeNotNull('largeImagePath', instance.largeImagePath);
  writeNotNull('imageAltText', instance.imageAltText);
  writeNotNull('activateOn', instance.activateOn?.toIso8601String());
  writeNotNull('deactivateOn', instance.deactivateOn?.toIso8601String());
  writeNotNull('metaKeywords', instance.metaKeywords);
  writeNotNull('metaDescription', instance.metaDescription);
  writeNotNull('htmlContent', instance.htmlContent);
  writeNotNull('sortOrder', instance.sortOrder);
  writeNotNull('isFeatured', instance.isFeatured);
  writeNotNull('isDynamic', instance.isDynamic);
  writeNotNull(
      'subCategories', instance.subCategories?.map((e) => e.toJson()).toList());
  writeNotNull('path', instance.path);
  writeNotNull('mobileBannerImageUrl', instance.mobileBannerImageUrl);
  writeNotNull('mobilePrimaryText', instance.mobilePrimaryText);
  writeNotNull('mobileSecondaryText', instance.mobileSecondaryText);
  writeNotNull('mobileTextJustification', instance.mobileTextJustification);
  writeNotNull('mobileTextColor', instance.mobileTextColor);
  return val;
}
