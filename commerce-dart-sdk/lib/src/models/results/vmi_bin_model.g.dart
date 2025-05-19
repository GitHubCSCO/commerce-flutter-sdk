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

Map<String, dynamic> _$VmiBinModelToJson(VmiBinModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('uri', instance.uri);
  writeNotNull('properties', instance.properties);
  val['id'] = instance.id;
  val['vmiLocationId'] = instance.vmiLocationId;
  val['binNumber'] = instance.binNumber;
  writeNotNull('productId', instance.productId);
  writeNotNull('minimumQty', instance.minimumQty);
  writeNotNull('maximumQty', instance.maximumQty);
  writeNotNull('lastCountDate', instance.lastCountDate?.toIso8601String());
  writeNotNull('lastCountQty', instance.lastCountQty);
  writeNotNull('lastCountUserName', instance.lastCountUserName);
  writeNotNull(
      'previousCountDate', instance.previousCountDate?.toIso8601String());
  writeNotNull('previousCountQty', instance.previousCountQty);
  writeNotNull('previousCountUserName', instance.previousCountUserName);
  writeNotNull('lastOrderDate', instance.lastOrderDate?.toIso8601String());
  writeNotNull('product', instance.product?.toJson());
  return val;
}
