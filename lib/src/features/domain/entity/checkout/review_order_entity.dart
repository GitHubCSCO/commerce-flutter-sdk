import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import 'package:commerce_flutter_sdk/src/features/presentation/screens/cart/cart_shipping_widget.dart';

class ReviewOrderEntity {
  final BillTo? billTo;
  final ShipTo? shipTo;
  final Warehouse? warehouse;
  final ShippingOption? shippingMethod;
  final List<CarrierDto>? carriers;
  final CartSettings? cartSettings;
  final PaymentMethodDto? paymentMethod;
  final CarrierDto? selectedCarrier;
  final ShipViaDto? selectedService;
  final DateTime? requestDeliveryDate;
  final bool? allowCreateNewShipToAddress;
  final String? orderNotes;

  ReviewOrderEntity(
      {this.billTo,
      this.shipTo,
      this.warehouse,
      this.shippingMethod,
      this.carriers,
      this.cartSettings,
      this.paymentMethod,
      this.selectedCarrier,
      this.selectedService,
      this.requestDeliveryDate,
      this.allowCreateNewShipToAddress,
      this.orderNotes});

  ReviewOrderEntity copyWith(
      {BillTo? billTo,
      ShipTo? shipTo,
      Warehouse? warehouse,
      ShippingOption? shippingMethod,
      List<CarrierDto>? carriers,
      CartSettings? cartSettings,
      PaymentMethodDto? paymentMethod,
      bool? allowCreateNewShipToAddress,
      String? orderNotes}) {
    return ReviewOrderEntity(
        selectedCarrier: selectedCarrier,
        selectedService: selectedService,
        requestDeliveryDate: requestDeliveryDate,
        billTo: billTo ?? this.billTo,
        shipTo: shipTo ?? this.shipTo,
        warehouse: warehouse ?? this.warehouse,
        shippingMethod: shippingMethod ?? this.shippingMethod,
        carriers: carriers ?? this.carriers,
        cartSettings: cartSettings ?? this.cartSettings,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        allowCreateNewShipToAddress:
            allowCreateNewShipToAddress ?? this.allowCreateNewShipToAddress,
        orderNotes: orderNotes ?? this.orderNotes);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'billTo': billTo?.toJson(),
      'shipTo': shipTo?.toJson(),
      'warehouse': warehouse?.toJson(),
      'shippingMethod': shippingMethod?.toJson(),
      'carriers': carriers?.map((x) => x.toJson()).toList(),
      'cartSettings': cartSettings?.toJson(),
      'paymentMethod': paymentMethod?.toJson(),
      'selectedCarrier': selectedCarrier?.toJson(),
      'selectedService': selectedService?.toJson(),
      'requestDeliveryDate': requestDeliveryDate?.millisecondsSinceEpoch,
      'allowCreateNewShipToAddress': allowCreateNewShipToAddress,
      'orderNotes': orderNotes,
    };
  }

  factory ReviewOrderEntity.fromJson(Map<String, dynamic> json) {
    return ReviewOrderEntity(
      billTo: json['billTo'] == null
          ? null
          : BillTo.fromJson(json['billTo'] as Map<String, dynamic>),
      shipTo: json['shipTo'] == null
          ? null
          : ShipTo.fromJson(json['shipTo'] as Map<String, dynamic>),
      warehouse: json['warehouse'] == null
          ? null
          : Warehouse.fromJson(json['warehouse'] as Map<String, dynamic>),
      shippingMethod: json['shippingMethod'] == null
          ? null
          : ShippingOption.fromJson(
              json['shippingMethod'] as Map<String, dynamic>),
      carriers: (json['carriers'] as List<dynamic>?)
          ?.map((e) => CarrierDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      cartSettings: json['cartSettings'] == null
          ? null
          : CartSettings.fromJson(json['cartSettings'] as Map<String, dynamic>),
      paymentMethod: json['paymentMethod'] == null
          ? null
          : PaymentMethodDto.fromJson(
              json['paymentMethod'] as Map<String, dynamic>),
      selectedCarrier: json['selectedCarrier'] == null
          ? null
          : CarrierDto.fromJson(
              json['selectedCarrier'] as Map<String, dynamic>),
      selectedService: json['selectedService'] == null
          ? null
          : ShipViaDto.fromJson(
              json['selectedService'] as Map<String, dynamic>),
      requestDeliveryDate: json['requestDeliveryDate'] == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(
              json['requestDeliveryDate'] as int),
      allowCreateNewShipToAddress: json['allowCreateNewShipToAddress'] as bool?,
      orderNotes: json['orderNotes'] as String?,
    );
  }
}
