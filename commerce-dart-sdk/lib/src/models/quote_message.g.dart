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

Map<String, dynamic> _$QuoteMessageToJson(QuoteMessage instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.createdDate?.toIso8601String() case final value?)
        'createdDate': value,
      if (instance.quoteId case final value?) 'quoteId': value,
      if (instance.message case final value?) 'message': value,
      if (instance.displayName case final value?) 'displayName': value,
      if (instance.body case final value?) 'body': value,
    };
