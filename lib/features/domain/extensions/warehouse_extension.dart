import 'package:commerce_flutter_app/features/domain/entity/warehouse_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

extension WarehouseExtension on Warehouse? {
  String wareHouseAddress() {
    String address = this!.address2 == null || this!.address2!.isEmpty
        ? this!.address1!
        : '${this!.address1}, ${this!.address2}';
    return address;
  }

  String wareHouseCity() {
    String city = '${this!.city}, ${this!.state} ${this!.postalCode}';
    return city;
  }
}

extension WarehouseEntityExtension on WarehouseEntity {
  String wareHouseAddress() {
    String address = this.address2 == null || this.address2!.isEmpty
        ? this.address1!
        : '${this!.address1}, ${this.address2}';
    return address;
  }

  String wareHouseCity() {
    String city = '${this.city}, ${this.state} ${this.postalCode}';
    return city;
  }
}
