// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_query_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$InvoiceQueryParametersToJson(
    InvoiceQueryParameters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('showOpenOnly', instance.showOpenOnly);
  writeNotNull('invoiceNumber', instance.invoiceNumber);
  writeNotNull('orderNumber', instance.orderNumber);
  writeNotNull('poNumber', instance.poNumber);
  writeNotNull('fromDate', instance.fromDate?.toIso8601String());
  writeNotNull('toDate', instance.toDate?.toIso8601String());
  writeNotNull('customerSequence', instance.customerSequence);
  return val;
}

Map<String, dynamic> _$InvoiceDetailParameterToJson(
    InvoiceDetailParameter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull(
      'expand', JsonEncodingMethods.commaSeparatedJson(instance.expand));
  return val;
}

Map<String, dynamic> _$InvoiceEmailParameterToJson(
    InvoiceEmailParameter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('page', instance.page);
  writeNotNull('pageSize', instance.pageSize);
  writeNotNull('sort', instance.sort);
  writeNotNull('emailTo', instance.emailTo);
  writeNotNull('emailFrom', instance.emailFrom);
  writeNotNull('subject', instance.subject);
  writeNotNull('message', instance.message);
  writeNotNull('entityId', instance.entityId);
  writeNotNull('entityName', instance.entityName);
  return val;
}
