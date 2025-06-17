// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_order_approval_collection_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrderApprovalCollectionResult _$GetOrderApprovalCollectionResultFromJson(
        Map<String, dynamic> json) =>
    GetOrderApprovalCollectionResult(
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      cartCollection: (json['cartCollection'] as List<dynamic>?)
          ?.map((e) => Cart.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$GetOrderApprovalCollectionResultToJson(
        GetOrderApprovalCollectionResult instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      if (instance.pagination?.toJson() case final value?) 'pagination': value,
      if (instance.cartCollection?.map((e) => e.toJson()).toList()
          case final value?)
        'cartCollection': value,
    };
