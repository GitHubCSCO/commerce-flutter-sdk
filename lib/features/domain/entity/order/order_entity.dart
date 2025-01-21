import 'package:commerce_flutter_app/features/domain/mapper/order_mapper.dart';
import 'package:equatable/equatable.dart';
import 'package:optimizely_commerce_api/optimizely_commerce_api.dart';

import 'package:commerce_flutter_app/features/domain/entity/order/order_history_tax_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_line_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/order_promotion_entity.dart';
import 'package:commerce_flutter_app/features/domain/entity/order/shipment_package_dto_entity.dart';

class OrderEntity extends Equatable {
  final String? id;
  final String? erpOrderNumber;
  final String? webOrderNumber;
  final DateTime? orderDate;
  final String? status;
  final String? statusDisplay;
  final String? customerNumber;
  final String? customerSequence;
  final String? customerPO;
  final String? currencyCode;
  final String? currencySymbol;
  final String? terms;
  final String? shipCode;
  final String? salesperson;
  final String? btCompanyName;
  final String? btAddress1;
  final String? btAddress2;
  final String? billToCity;
  final String? billToState;
  final String? billToPostalCode;
  final String? btCountry;
  final String? stCompanyName;
  final String? stAddress1;
  final String? stAddress2;
  final String? stAddress3;
  final String? stAddress4;
  final String? shipToCity;
  final String? shipToState;
  final String? shipToPostalCode;
  final String? stCountry;
  final String? notes;
  final num? productTotal;
  final num? orderSubTotal;
  final num? orderDiscountAmount;
  final num? productDiscountAmount;
  final num? shippingAndHandling;
  final num? shippingCharges;
  final num? handlingCharges;
  final num? otherCharges;
  final num? taxAmount;
  final num? orderTotal;
  final DateTime? modifyDate;
  final DateTime? requestedDeliveryDateDisplay;
  final List<OrderLineEntity>? orderLines;
  final List<OrderPromotionEntity>? orderPromotions;
  final List<ShipmentPackageDtoEntity>? shipmentPackages;
  final List<String?>? returnReasons;
  final List<OrderHistoryTaxDtoEntity>? orderHistoryTaxes;
  final String? productTotalDisplay;
  final String? orderSubTotalDisplay;
  final String? orderGrandTotalDisplay;
  final String? orderDiscountAmountDisplay;
  final String? productDiscountAmountDisplay;
  final String? taxAmountDisplay;
  final String? totalTaxDisplay;
  final String? shippingAndHandlingDisplay;
  final String? shippingChargesDisplay;
  final String? handlingChargesDisplay;
  final String? otherChargesDisplay;
  final bool? canAddToCart;
  final bool? canAddAllToCart;
  final bool? showTaxAndShipping;
  final String? shipViaDescription;
  final String? fulfillmentMethod;
  final String? vmiLocationId;
  final String? vmiLocationName;
  final bool? showWebOrderNumber;
  final bool? showPoNumber;
  final bool? showTermsCode;
  final String? orderNumberLabel;
  final String? webOrderNumberLabel;
  final String? poNumberLabel;

  const OrderEntity({
    this.id,
    this.erpOrderNumber,
    this.webOrderNumber,
    this.orderDate,
    this.status,
    this.statusDisplay,
    this.customerNumber,
    this.customerSequence,
    this.customerPO,
    this.currencyCode,
    this.currencySymbol,
    this.terms,
    this.shipCode,
    this.salesperson,
    this.btCompanyName,
    this.btAddress1,
    this.btAddress2,
    this.billToCity,
    this.billToState,
    this.billToPostalCode,
    this.btCountry,
    this.stCompanyName,
    this.stAddress1,
    this.stAddress2,
    this.stAddress3,
    this.stAddress4,
    this.shipToCity,
    this.shipToState,
    this.shipToPostalCode,
    this.stCountry,
    this.notes,
    this.productTotal,
    this.orderSubTotal,
    this.orderDiscountAmount,
    this.productDiscountAmount,
    this.shippingAndHandling,
    this.shippingCharges,
    this.handlingCharges,
    this.otherCharges,
    this.taxAmount,
    this.orderTotal,
    this.modifyDate,
    this.requestedDeliveryDateDisplay,
    this.orderLines,
    this.orderPromotions,
    this.shipmentPackages,
    this.returnReasons,
    this.orderHistoryTaxes,
    this.productTotalDisplay,
    this.orderSubTotalDisplay,
    this.orderGrandTotalDisplay,
    this.orderDiscountAmountDisplay,
    this.productDiscountAmountDisplay,
    this.taxAmountDisplay,
    this.totalTaxDisplay,
    this.shippingAndHandlingDisplay,
    this.shippingChargesDisplay,
    this.handlingChargesDisplay,
    this.otherChargesDisplay,
    this.canAddToCart,
    this.canAddAllToCart,
    this.showTaxAndShipping,
    this.shipViaDescription,
    this.fulfillmentMethod,
    this.vmiLocationId,
    this.vmiLocationName,
    this.showWebOrderNumber,
    this.showPoNumber,
    this.showTermsCode,
    this.orderNumberLabel,
    this.webOrderNumberLabel,
    this.poNumberLabel,
  });

  String? get orderNumber =>
      erpOrderNumber!.isNullOrEmpty ? webOrderNumber : erpOrderNumber;

  @override
  List<Object?> get props => [
        id,
        erpOrderNumber,
        webOrderNumber,
        orderDate,
        status,
        statusDisplay,
        customerNumber,
        customerSequence,
        customerPO,
        currencyCode,
        currencySymbol,
        terms,
        shipCode,
        salesperson,
        btCompanyName,
        btAddress1,
        btAddress2,
        billToCity,
        billToState,
        billToPostalCode,
        btCountry,
        stCompanyName,
        stAddress1,
        stAddress2,
        stAddress3,
        stAddress4,
        shipToCity,
        shipToState,
        shipToPostalCode,
        stCountry,
        notes,
        productTotal,
        orderSubTotal,
        orderDiscountAmount,
        productDiscountAmount,
        shippingAndHandling,
        shippingCharges,
        handlingCharges,
        otherCharges,
        taxAmount,
        orderTotal,
        modifyDate,
        requestedDeliveryDateDisplay,
        orderLines,
        orderPromotions,
        shipmentPackages,
        returnReasons,
        orderHistoryTaxes,
        productTotalDisplay,
        orderSubTotalDisplay,
        orderGrandTotalDisplay,
        orderDiscountAmountDisplay,
        productDiscountAmountDisplay,
        taxAmountDisplay,
        totalTaxDisplay,
        shippingAndHandlingDisplay,
        shippingChargesDisplay,
        handlingChargesDisplay,
        otherChargesDisplay,
        canAddToCart,
        canAddAllToCart,
        showTaxAndShipping,
        shipViaDescription,
        fulfillmentMethod,
        vmiLocationId,
        vmiLocationName,
        showWebOrderNumber,
        showPoNumber,
        showTermsCode,
        orderNumberLabel,
        webOrderNumberLabel,
        poNumberLabel,
      ];

  OrderEntity copyWith({
    String? id,
    String? erpOrderNumber,
    String? webOrderNumber,
    DateTime? orderDate,
    String? status,
    String? statusDisplay,
    String? customerNumber,
    String? customerSequence,
    String? customerPO,
    String? currencyCode,
    String? currencySymbol,
    String? terms,
    String? shipCode,
    String? salesperson,
    String? btCompanyName,
    String? btAddress1,
    String? btAddress2,
    String? billToCity,
    String? billToState,
    String? billToPostalCode,
    String? btCountry,
    String? stCompanyName,
    String? stAddress1,
    String? stAddress2,
    String? stAddress3,
    String? stAddress4,
    String? shipToCity,
    String? shipToState,
    String? shipToPostalCode,
    String? stCountry,
    String? notes,
    num? productTotal,
    num? orderSubTotal,
    num? orderDiscountAmount,
    num? productDiscountAmount,
    num? shippingAndHandling,
    num? shippingCharges,
    num? handlingCharges,
    num? otherCharges,
    num? taxAmount,
    num? orderTotal,
    DateTime? modifyDate,
    DateTime? requestedDeliveryDateDisplay,
    List<OrderLineEntity>? orderLines,
    List<OrderPromotionEntity>? orderPromotions,
    List<ShipmentPackageDtoEntity>? shipmentPackages,
    List<String?>? returnReasons,
    List<OrderHistoryTaxDtoEntity>? orderHistoryTaxes,
    String? productTotalDisplay,
    String? orderSubTotalDisplay,
    String? orderGrandTotalDisplay,
    String? orderDiscountAmountDisplay,
    String? productDiscountAmountDisplay,
    String? taxAmountDisplay,
    String? totalTaxDisplay,
    String? shippingAndHandlingDisplay,
    String? shippingChargesDisplay,
    String? handlingChargesDisplay,
    String? otherChargesDisplay,
    bool? canAddToCart,
    bool? canAddAllToCart,
    bool? showTaxAndShipping,
    String? shipViaDescription,
    String? fulfillmentMethod,
    String? vmiLocationId,
    String? vmiLocationName,
    bool? showWebOrderNumber,
    bool? showPoNumber,
    bool? showTermsCode,
    String? orderNumberLabel,
    String? webOrderNumberLabel,
    String? poNumberLabel,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      erpOrderNumber: erpOrderNumber ?? this.erpOrderNumber,
      webOrderNumber: webOrderNumber ?? this.webOrderNumber,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      statusDisplay: statusDisplay ?? this.statusDisplay,
      customerNumber: customerNumber ?? this.customerNumber,
      customerSequence: customerSequence ?? this.customerSequence,
      customerPO: customerPO ?? this.customerPO,
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      terms: terms ?? this.terms,
      shipCode: shipCode ?? this.shipCode,
      salesperson: salesperson ?? this.salesperson,
      btCompanyName: btCompanyName ?? this.btCompanyName,
      btAddress1: btAddress1 ?? this.btAddress1,
      btAddress2: btAddress2 ?? this.btAddress2,
      billToCity: billToCity ?? this.billToCity,
      billToState: billToState ?? this.billToState,
      billToPostalCode: billToPostalCode ?? this.billToPostalCode,
      btCountry: btCountry ?? this.btCountry,
      stCompanyName: stCompanyName ?? this.stCompanyName,
      stAddress1: stAddress1 ?? this.stAddress1,
      stAddress2: stAddress2 ?? this.stAddress2,
      stAddress3: stAddress3 ?? this.stAddress3,
      stAddress4: stAddress4 ?? this.stAddress4,
      shipToCity: shipToCity ?? this.shipToCity,
      shipToState: shipToState ?? this.shipToState,
      shipToPostalCode: shipToPostalCode ?? this.shipToPostalCode,
      stCountry: stCountry ?? this.stCountry,
      notes: notes ?? this.notes,
      productTotal: productTotal ?? this.productTotal,
      orderSubTotal: orderSubTotal ?? this.orderSubTotal,
      orderDiscountAmount: orderDiscountAmount ?? this.orderDiscountAmount,
      productDiscountAmount:
          productDiscountAmount ?? this.productDiscountAmount,
      shippingAndHandling: shippingAndHandling ?? this.shippingAndHandling,
      shippingCharges: shippingCharges ?? this.shippingCharges,
      handlingCharges: handlingCharges ?? this.handlingCharges,
      otherCharges: otherCharges ?? this.otherCharges,
      taxAmount: taxAmount ?? this.taxAmount,
      orderTotal: orderTotal ?? this.orderTotal,
      modifyDate: modifyDate ?? this.modifyDate,
      requestedDeliveryDateDisplay:
          requestedDeliveryDateDisplay ?? this.requestedDeliveryDateDisplay,
      orderLines: orderLines ?? this.orderLines,
      orderPromotions: orderPromotions ?? this.orderPromotions,
      shipmentPackages: shipmentPackages ?? this.shipmentPackages,
      returnReasons: returnReasons ?? this.returnReasons,
      orderHistoryTaxes: orderHistoryTaxes ?? this.orderHistoryTaxes,
      productTotalDisplay: productTotalDisplay ?? this.productTotalDisplay,
      orderSubTotalDisplay: orderSubTotalDisplay ?? this.orderSubTotalDisplay,
      orderGrandTotalDisplay:
          orderGrandTotalDisplay ?? this.orderGrandTotalDisplay,
      orderDiscountAmountDisplay:
          orderDiscountAmountDisplay ?? this.orderDiscountAmountDisplay,
      productDiscountAmountDisplay:
          productDiscountAmountDisplay ?? this.productDiscountAmountDisplay,
      taxAmountDisplay: taxAmountDisplay ?? this.taxAmountDisplay,
      totalTaxDisplay: totalTaxDisplay ?? this.totalTaxDisplay,
      shippingAndHandlingDisplay:
          shippingAndHandlingDisplay ?? this.shippingAndHandlingDisplay,
      shippingChargesDisplay:
          shippingChargesDisplay ?? this.shippingChargesDisplay,
      handlingChargesDisplay:
          handlingChargesDisplay ?? this.handlingChargesDisplay,
      otherChargesDisplay: otherChargesDisplay ?? this.otherChargesDisplay,
      canAddToCart: canAddToCart ?? this.canAddToCart,
      canAddAllToCart: canAddAllToCart ?? this.canAddAllToCart,
      showTaxAndShipping: showTaxAndShipping ?? this.showTaxAndShipping,
      shipViaDescription: shipViaDescription ?? this.shipViaDescription,
      fulfillmentMethod: fulfillmentMethod ?? this.fulfillmentMethod,
      vmiLocationId: vmiLocationId ?? this.vmiLocationId,
      vmiLocationName: vmiLocationName ?? this.vmiLocationName,
      showWebOrderNumber: showWebOrderNumber ?? this.showWebOrderNumber,
      showPoNumber: showPoNumber ?? this.showPoNumber,
      showTermsCode: showTermsCode ?? this.showTermsCode,
      orderNumberLabel: orderNumberLabel ?? this.orderNumberLabel,
      webOrderNumberLabel: webOrderNumberLabel ?? this.webOrderNumberLabel,
      poNumberLabel: poNumberLabel ?? this.poNumberLabel,
    );
  }

  factory OrderEntity.fromJson(Map<String, dynamic> json) =>
      OrderEntityMapper.toEntity(Order.fromJson(json));

  Map<String, dynamic> toJson() => OrderEntityMapper.toModel(this).toJson();
}
