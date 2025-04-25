import 'package:commerce_flutter_sdk/features/domain/enums/fullfillment_method_type.dart';

extension StringFormatExtension on String? {
  FulfillmentMethodType toFulfillmentMethodType() {
    switch (this?.toLowerCase()) {
      case 'Ship':
        return FulfillmentMethodType.Ship;
      case 'PickUp':
        return FulfillmentMethodType.PickUp;
      default:
        throw ArgumentError('Invalid FulfillmentMethodType: $this');
    }
  }
}
