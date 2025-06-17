// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_invoice_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInvoiceResult _$GetInvoiceResultFromJson(Map<String, dynamic> json) =>
    GetInvoiceResult(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      invoices: (json['invoices'] as List<dynamic>?)
          ?.map((e) => Invoice.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetInvoiceResultToJson(GetInvoiceResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
      if (instance.invoices?.map((e) => e.toJson()).toList() case final value?)
        'invoices': value,
    };
