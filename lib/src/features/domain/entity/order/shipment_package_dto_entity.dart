import 'package:equatable/equatable.dart';

class ShipmentPackageDtoEntity extends Equatable {
  final String? id;

  final DateTime? shipmentDate;

  final String? carrier;

  final String? shipVia;

  final String? trackingUrl;

  final String? trackingNumber;

  final String? packSlip;

  final String? trackButtonTitle;

  final String? shipDateTitle;

  const ShipmentPackageDtoEntity({
    this.id,
    this.shipmentDate,
    this.carrier,
    this.shipVia,
    this.trackingUrl,
    this.trackingNumber,
    this.packSlip,
    this.trackButtonTitle,
    this.shipDateTitle,
  });

  @override
  List<Object?> get props => [
        id,
        shipmentDate,
        carrier,
        shipVia,
        trackingUrl,
        trackingNumber,
        packSlip,
        trackButtonTitle,
        shipDateTitle,
      ];

  ShipmentPackageDtoEntity copyWith({
    String? id,
    DateTime? shipmentDate,
    String? carrier,
    String? shipVia,
    String? trackingUrl,
    String? trackingNumber,
    String? packSlip,
    String? trackButtonTitle,
    String? shipDateTitle,
  }) {
    return ShipmentPackageDtoEntity(
      id: id ?? this.id,
      shipmentDate: shipmentDate ?? this.shipmentDate,
      carrier: carrier ?? this.carrier,
      shipVia: shipVia ?? this.shipVia,
      trackingUrl: trackingUrl ?? this.trackingUrl,
      trackingNumber: trackingNumber ?? this.trackingNumber,
      packSlip: packSlip ?? this.packSlip,
      trackButtonTitle: trackButtonTitle ?? this.trackButtonTitle,
      shipDateTitle: shipDateTitle ?? this.shipDateTitle,
    );
  }
}
