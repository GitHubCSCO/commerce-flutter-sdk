// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_site_message_collection_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSiteMessageCollectionResult _$GetSiteMessageCollectionResultFromJson(
        Map<String, dynamic> json) =>
    GetSiteMessageCollectionResult(
      siteMessages: (json['siteMessages'] as List<dynamic>?)
          ?.map((e) => SiteMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSiteMessageCollectionResultToJson(
        GetSiteMessageCollectionResult instance) =>
    <String, dynamic>{
      if (instance.siteMessages?.map((e) => e.toJson()).toList()
          case final value?)
        'siteMessages': value,
    };
