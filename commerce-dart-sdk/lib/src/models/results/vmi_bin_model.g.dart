// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vmi_bin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VmiBinModel _$VmiBinModelFromJson(Map<String, dynamic> json) => VmiBinModel(
      id: json['id'] as String,
      vmiLocationId: json['vmiLocationId'] as String,
      binNumber: json['binNumber'] as String? ?? '',
      productId: json['productId'] as String?,
      minimumQty: (json['minimumQty'] as num?)?.toDouble(),
      maximumQty: (json['maximumQty'] as num?)?.toDouble(),
      lastCountDate: json['lastCountDate'] == null
          ? null
          : DateTime.parse(json['lastCountDate'] as String),
      lastCountQty: (json['lastCountQty'] as num?)?.toDouble(),
      lastCountUserName: json['lastCountUserName'] as String?,
      previousCountDate: json['previousCountDate'] == null
          ? null
          : DateTime.parse(json['previousCountDate'] as String),
      previousCountQty: (json['previousCountQty'] as num?)?.toDouble(),
      previousCountUserName: json['previousCountUserName'] as String?,
      lastOrderDate: json['lastOrderDate'] == null
          ? null
          : DateTime.parse(json['lastOrderDate'] as String),
      product: json['product'] == null
          ? null
          : Product.fromJson(json['product'] as Map<String, dynamic>),
    )
      ..uri = json['uri'] as String?
      ..properties = (json['properties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String?),
      );

Map<String, dynamic> _$VmiBinModelToJson(VmiBinModel instance) =>
    <String, dynamic>{
      if (instance.uri case final value?) 'uri': value,
      if (instance.properties case final value?) 'properties': value,
      'id': instance.id,
      'vmiLocationId': instance.vmiLocationId,
      'binNumber': instance.binNumber,
      if (instance.productId case final value?) 'productId': value,
      if (instance.minimumQty case final value?) 'minimumQty': value,
      if (instance.maximumQty case final value?) 'maximumQty': value,
      if (instance.lastCountDate?.toIso8601String() case final value?)
        'lastCountDate': value,
      if (instance.lastCountQty case final value?) 'lastCountQty': value,
      if (instance.lastCountUserName case final value?)
        'lastCountUserName': value,
      if (instance.previousCountDate?.toIso8601String() case final value?)
        'previousCountDate': value,
      if (instance.previousCountQty case final value?)
        'previousCountQty': value,
      if (instance.previousCountUserName case final value?)
        'previousCountUserName': value,
      if (instance.lastOrderDate?.toIso8601String() case final value?)
        'lastOrderDate': value,
      if (instance.product?.toJson() case final value?) 'product': value,
    };
