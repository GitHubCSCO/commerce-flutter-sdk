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
    GetSiteMessageCollectionResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'siteMessages', instance.siteMessages?.map((e) => e.toJson()).toList());
  return val;
}
