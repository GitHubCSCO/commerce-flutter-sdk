import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class ShippingEntity {

  final Warehouse? warehouse;

  ShippingEntity({this.warehouse});

  ShippingEntity copyWith({Warehouse? warehouse}) {
    return ShippingEntity(
      warehouse: warehouse ?? this.warehouse,
    );
  }

}