import 'package:equatable/equatable.dart';

class OrderHistoryTaxDtoEntity extends Equatable {
  final String? taxCode;

  final String? taxDescription;

  final num? taxRate;

  final num? taxAmount;

  final String? taxAmountDisplay;

  final int? sortOrder;

  const OrderHistoryTaxDtoEntity({
    this.taxCode,
    this.taxDescription,
    this.taxRate,
    this.taxAmount,
    this.taxAmountDisplay,
    this.sortOrder,
  });

  @override
  List<Object?> get props => [
        taxCode,
        taxDescription,
        taxRate,
        taxAmount,
        taxAmountDisplay,
        sortOrder,
      ];

  OrderHistoryTaxDtoEntity copyWith({
    String? taxCode,
    String? taxDescription,
    num? taxRate,
    num? taxAmount,
    String? taxAmountDisplay,
    int? sortOrder,
  }) {
    return OrderHistoryTaxDtoEntity(
      taxCode: taxCode ?? this.taxCode,
      taxDescription: taxDescription ?? this.taxDescription,
      taxRate: taxRate ?? this.taxRate,
      taxAmount: taxAmount ?? this.taxAmount,
      taxAmountDisplay: taxAmountDisplay ?? this.taxAmountDisplay,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}
