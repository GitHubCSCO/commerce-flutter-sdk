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

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.shortDescription case final value?)
        'shortDescription': value,
      if (instance.urlSegment case final value?) 'urlSegment': value,
      if (instance.smallImagePath case final value?) 'smallImagePath': value,
      if (instance.largeImagePath case final value?) 'largeImagePath': value,
      if (instance.imageAltText case final value?) 'imageAltText': value,
      if (instance.activateOn?.toIso8601String() case final value?)
        'activateOn': value,
      if (instance.deactivateOn?.toIso8601String() case final value?)
        'deactivateOn': value,
      if (instance.metaKeywords case final value?) 'metaKeywords': value,
      if (instance.metaDescription case final value?) 'metaDescription': value,
      if (instance.htmlContent case final value?) 'htmlContent': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.isFeatured case final value?) 'isFeatured': value,
      if (instance.isDynamic case final value?) 'isDynamic': value,
      if (instance.subCategories?.map((e) => e.toJson()).toList()
          case final value?)
        'subCategories': value,
      if (instance.path case final value?) 'path': value,
      if (instance.mobileBannerImageUrl case final value?)
        'mobileBannerImageUrl': value,
      if (instance.mobilePrimaryText case final value?)
        'mobilePrimaryText': value,
      if (instance.mobileSecondaryText case final value?)
        'mobileSecondaryText': value,
      if (instance.mobileTextJustification case final value?)
        'mobileTextJustification': value,
      if (instance.mobileTextColor case final value?) 'mobileTextColor': value,
    };
