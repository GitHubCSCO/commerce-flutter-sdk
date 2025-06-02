// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteMessage _$QuoteMessageFromJson(Map<String, dynamic> json) => QuoteMessage(
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      quoteId: json['quoteId'] as String?,
      message: json['message'] as String?,
      displayName: json['displayName'] as String?,
      body: json['body'] as String?,
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$QuoteMessageToJson(QuoteMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('createdDate', instance.createdDate?.toIso8601String());
  writeNotNull('quoteId', instance.quoteId);
  writeNotNull('message', instance.message);
  writeNotNull('displayName', instance.displayName);
  writeNotNull('body', instance.body);
  return val;
}
