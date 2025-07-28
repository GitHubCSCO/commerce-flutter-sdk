// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$InvoiceQueryParametersToJson(
        InvoiceQueryParameters instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.showOpenOnly case final value?) 'showOpenOnly': value,
      if (instance.invoiceNumber case final value?) 'invoiceNumber': value,
      if (instance.orderNumber case final value?) 'orderNumber': value,
      if (instance.poNumber case final value?) 'poNumber': value,
      if (instance.fromDate?.toIso8601String() case final value?)
        'fromDate': value,
      if (instance.toDate?.toIso8601String() case final value?) 'toDate': value,
      if (instance.customerSequence case final value?)
        'customerSequence': value,
    };

Map<String, dynamic> _$InvoiceDetailParameterToJson(
        InvoiceDetailParameter instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (JsonEncodingMethods.commaSeparatedJson(instance.expand)
          case final value?)
        'expand': value,
    };

Map<String, dynamic> _$InvoiceEmailParameterToJson(
        InvoiceEmailParameter instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pageSize case final value?) 'pageSize': value,
      if (instance.sort case final value?) 'sort': value,
      if (instance.emailTo case final value?) 'emailTo': value,
      if (instance.emailFrom case final value?) 'emailFrom': value,
      if (instance.subject case final value?) 'subject': value,
      if (instance.message case final value?) 'message': value,
      if (instance.entityId case final value?) 'entityId': value,
      if (instance.entityName case final value?) 'entityName': value,
    };
