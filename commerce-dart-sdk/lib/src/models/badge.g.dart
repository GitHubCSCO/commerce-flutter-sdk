// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Badge _$BadgeFromJson(Map<String, dynamic> json) => Badge(
      id: json['id'] as String?,
      name: json['name'] as String?,
      tagName: json['tagName'] as String?,
      badgeStyle: json['badgeStyle'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
      badgeType: json['badgeType'] as String?,
      displayOnProductImages: json['displayOnProductImages'] as bool?,
      displayOnBadgeWidget: json['displayOnBadgeWidget'] as bool?,
      displayText: json['displayText'] as String?,
      textColorHexCode: json['textColorHexCode'] as String?,
      badgeColorHexCode: json['badgeColorHexCode'] as String?,
      largeImageBadgePath: json['largeImageBadgePath'] as String?,
      largeImageTextSize: json['largeImageTextSize'] as String?,
      largeImagePlacement: json['largeImagePlacement'] as String?,
      otherImageBadgePath: json['otherImageBadgePath'] as String?,
      otherImageTextSize: json['otherImageTextSize'] as String?,
      otherImagePlacement: json['otherImagePlacement'] as String?,
      imageAltText: json['imageAltText'] as String?,
      detailWidgetBadgeSize: json['detailWidgetBadgeSize'] as String?,
    );

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.tagName case final value?) 'tagName': value,
      if (instance.badgeStyle case final value?) 'badgeStyle': value,
      if (instance.sortOrder case final value?) 'sortOrder': value,
      if (instance.badgeType case final value?) 'badgeType': value,
      if (instance.displayOnProductImages case final value?)
        'displayOnProductImages': value,
      if (instance.displayOnBadgeWidget case final value?)
        'displayOnBadgeWidget': value,
      if (instance.displayText case final value?) 'displayText': value,
      if (instance.textColorHexCode case final value?)
        'textColorHexCode': value,
      if (instance.badgeColorHexCode case final value?)
        'badgeColorHexCode': value,
      if (instance.largeImageBadgePath case final value?)
        'largeImageBadgePath': value,
      if (instance.largeImageTextSize case final value?)
        'largeImageTextSize': value,
      if (instance.largeImagePlacement case final value?)
        'largeImagePlacement': value,
      if (instance.otherImageBadgePath case final value?)
        'otherImageBadgePath': value,
      if (instance.otherImageTextSize case final value?)
        'otherImageTextSize': value,
      if (instance.otherImagePlacement case final value?)
        'otherImagePlacement': value,
      if (instance.imageAltText case final value?) 'imageAltText': value,
      if (instance.detailWidgetBadgeSize case final value?)
        'detailWidgetBadgeSize': value,
    };
