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

Map<String, dynamic> _$AddCartModelToJson(AddCartModel instance) =>
    <String, dynamic>{
      if (instance.billToId case final value?) 'billToId': value,
      if (instance.shipToId case final value?) 'shipToId': value,
      if (instance.notes case final value?) 'notes': value,
      if (instance.vmiLocationId case final value?) 'vmiLocationId': value,
    };
