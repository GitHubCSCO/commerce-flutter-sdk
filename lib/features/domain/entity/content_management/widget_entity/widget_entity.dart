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
}

class WidgetEntity extends Equatable {
  final String? id;
  final WidgetType? type;
  final String? subType;

  const WidgetEntity({this.id, this.type, this.subType});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
