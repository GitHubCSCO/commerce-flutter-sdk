// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCartModel _$AddCartModelFromJson(Map<String, dynamic> json) => AddCartModel(
      billToId: json['billToId'] as String?,
      shipToId: json['shipToId'] as String?,
      notes: json['notes'] as String?,
      vmiLocationId: json['vmiLocationId'] as String?,
    );

Map<String, dynamic> _$AddCartModelToJson(AddCartModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('billToId', instance.billToId);
  writeNotNull('shipToId', instance.shipToId);
  writeNotNull('notes', instance.notes);
  writeNotNull('vmiLocationId', instance.vmiLocationId);
  return val;
}
