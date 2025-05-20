import 'package:commerce_flutter_sdk/src/features/domain/entity/warehouse_entity.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

String getAddress(String? address1, String? address2) {
  final addressBuffer = StringBuffer();
  if (address1 != null) {
    addressBuffer.write(address1);
  }
  if (address2 != null) {
    if (addressBuffer.isNotEmpty) {
      addressBuffer.write(', ');
    }
    addressBuffer.write(address2);
  }
  return addressBuffer.toString();
}

String getCity(String? city, String? state, String? postalCode) {
  final cityBuffer = StringBuffer();
  if (city != null) {
    cityBuffer.write(city);
  }
  if (state != null) {
    if (cityBuffer.isNotEmpty) {
      cityBuffer.write(', ');
    }
    cityBuffer.write(state);
  }
  if (postalCode != null) {
    if (cityBuffer.isNotEmpty) {
      cityBuffer.write(', ');
    }
    cityBuffer.write(postalCode);
  }
  return cityBuffer.toString();
}

extension WarehouseExtension on Warehouse? {
  String wareHouseAddress() {
    return getAddress(this?.address1, this?.address2);
  }

  String wareHouseCity() {
    return getCity(this?.city, this?.state, this?.postalCode);
  }
}

extension WarehouseEntityExtension on WarehouseEntity {
  String wareHouseAddress() {
    return getAddress(address1, address2);
  }

  String wareHouseCity() {
    return getCity(city, state, postalCode);
  }
}
