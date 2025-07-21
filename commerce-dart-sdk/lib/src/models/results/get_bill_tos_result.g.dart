// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bill_tos_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBillTosResult _$GetBillTosResultFromJson(Map<String, dynamic> json) =>
    GetBillTosResult(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      billTos: (json['billTos'] as List<dynamic>?)
          ?.map((e) => BillTo.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetBillTosResultToJson(GetBillTosResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
      if (instance.billTos?.map((e) => e.toJson()).toList() case final value?)
        'billTos': value,
    };
