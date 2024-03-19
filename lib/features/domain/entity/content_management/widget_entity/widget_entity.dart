import 'package:equatable/equatable.dart';

enum WidgetType {
  unknown,
  mobileCarousel,
  mobileCarouselSlide,
  mobileLinkList,
  productCarousel,
  mobileSearchHistory,
  mobileSpacer,
  mobileHeader,
  mobileCurrentLocation,
  mobileLocationNote,
  mobileRecentBinNote,
  mobilePreviousOrders,
  mobileCartButtonsWidget,
  mobileOrderSummary,
  mobileShippingMethod,
  mobileCartContents
}

class WidgetEntity extends Equatable {
  final String? id;
  final WidgetType? type;
  final String? subType;

  const WidgetEntity({this.id, this.type, this.subType});

  WidgetEntity copyWith({
    String? id,
    WidgetType? type,
    String? subType,
  }) {
    return WidgetEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      subType: subType ?? this.subType,
    );
  }

  @override
  List<Object?> get props => [id, type, subType];
}
