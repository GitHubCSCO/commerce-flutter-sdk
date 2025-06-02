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

Map<String, dynamic> _$RmaToJson(Rma instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  writeNotNull('orderNumber', instance.orderNumber);
  writeNotNull('notes', instance.notes);
  writeNotNull('message', instance.message);
  writeNotNull('rmaLines', instance.rmaLines?.map((e) => e.toJson()).toList());
  return val;
}

RmaLine _$RmaLineFromJson(Map<String, dynamic> json) => RmaLine(
      line: json['line'] as num?,
      rmaQtyRequested: (json['rmaQtyRequested'] as num?)?.toInt(),
      rmaReasonCode: json['rmaReasonCode'] as String?,
    );

Map<String, dynamic> _$RmaLineToJson(RmaLine instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('line', instance.line);
  writeNotNull('rmaQtyRequested', instance.rmaQtyRequested);
  writeNotNull('rmaReasonCode', instance.rmaReasonCode);
  return val;
}
