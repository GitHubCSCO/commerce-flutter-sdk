// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_view.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScreenView _$ScreenViewFromJson(Map<String, dynamic> json) => ScreenView(
      screenName: json['screenName'] as String?,
      properties: json['properties'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ScreenViewToJson(ScreenView instance) =>
    <String, dynamic>{
      if (instance.screenName case final value?) 'screenName': value,
      if (instance.properties case final value?) 'properties': value,
    };
