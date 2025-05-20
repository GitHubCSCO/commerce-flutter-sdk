import 'package:commerce_flutter_sdk/src/features/presentation/screens/cart/cart_shipping_widget.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

class BillingShippingEntity {
  final BillTo? billTo;
  final ShipTo? shipTo;
  final Warehouse? warehouse;
  final ShippingOption? shippingMethod;
  final List<CarrierDto>? carriers;
  final CartSettings? cartSettings;
  final CarrierDto? selectedCarrier;
  final ShipViaDto? selectedService;
  final DateTime? requestDeliveryDate;
  final bool? allowCreateNewShipToAddress;
  final String? requestDateWarningMessage;

  BillingShippingEntity({
    this.billTo,
    this.shipTo,
    this.warehouse,
    this.shippingMethod,
    this.carriers,
    this.cartSettings,
    this.selectedCarrier,
    this.selectedService,
    this.requestDeliveryDate,
    this.allowCreateNewShipToAddress = true,
    this.requestDateWarningMessage,
  });

  BillingShippingEntity copyWith({
    BillTo? billTo,
    ShipTo? shipTo,
    Warehouse? warehouse,
    ShippingOption? shippingMethod,
    List<CarrierDto>? carriers,
    CartSettings? cartSettings,
    CarrierDto? selectedCarrier,
    ShipViaDto? selectedService,
    DateTime? requestDeliveryDate,
    bool? allowCreateNewShipToAddress,
    String? requestDateWarningMessage,
  }) {
    return BillingShippingEntity(
      billTo: billTo ?? this.billTo,
      shipTo: shipTo ?? this.shipTo,
      warehouse: warehouse ?? this.warehouse,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      carriers: carriers ?? this.carriers,
      cartSettings: cartSettings ?? this.cartSettings,
      selectedCarrier: selectedCarrier ?? this.selectedCarrier,
      selectedService: selectedService ?? this.selectedService,
      requestDeliveryDate: requestDeliveryDate ?? this.requestDeliveryDate,
      allowCreateNewShipToAddress:
          allowCreateNewShipToAddress ?? this.allowCreateNewShipToAddress,
      requestDateWarningMessage:
          requestDateWarningMessage ?? this.requestDateWarningMessage,
    );
  }
}
