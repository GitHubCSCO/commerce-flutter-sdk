// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rma.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rma _$RmaFromJson(Map<String, dynamic> json) => Rma(
      orderNumber: json['orderNumber'] as String?,
      notes: json['notes'] as String?,
      message: json['message'] as String?,
      rmaLines: (json['rmaLines'] as List<dynamic>?)
          ?.map((e) => RmaLine.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$RmaToJson(Rma instance) => <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.orderNumber case final value?) 'orderNumber': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.message case final value?) 'message': value,
      if (instance.rmaLines?.map((e) => e.toJson()).toList() case final value?)
        'rmaLines': value,
    };

RmaLine _$RmaLineFromJson(Map<String, dynamic> json) => RmaLine(
      line: json['line'] as num?,
      rmaQtyRequested: (json['rmaQtyRequested'] as num?)?.toInt(),
      rmaReasonCode: json['rmaReasonCode'] as String?,
    );

Map<String, dynamic> _$RmaLineToJson(RmaLine instance) => <String, dynamic>{
      if (instance.line case final value?) 'line': value,
      if (instance.rmaQtyRequested case final value?) 'rmaQtyRequested': value,
      if (instance.rmaReasonCode case final value?) 'rmaReasonCode': value,
    };
