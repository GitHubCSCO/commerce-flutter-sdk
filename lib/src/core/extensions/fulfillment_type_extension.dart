import 'package:commerce_flutter_sdk/src/features/domain/enums/fullfillment_method_type.dart';

extension StringFormatExtension on String? {
  FulfillmentMethodType toFulfillmentMethodType() {
    switch (this?.toLowerCase()) {
      case 'ship':
        return FulfillmentMethodType.Ship;
      case 'pickup':
        return FulfillmentMethodType.PickUp;
      default:
        throw ArgumentError('Invalid FulfillmentMethodType: $this');
    }
  }
}
