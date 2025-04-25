import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class ShippingMethodWidgetEntity extends WidgetEntity {
  final String? title;

  const ShippingMethodWidgetEntity(
      {String? id, WidgetType? type, String? subType, this.title})
      : super(id: id, type: type, subType: subType);

  @override
  List<Object?> get props => [title];

  @override
  ShippingMethodWidgetEntity copyWith({
    String? id,
    WidgetType? type,
    String? subType,
  }) {
    return ShippingMethodWidgetEntity(
        id: id ?? this.id,
        type: type ?? this.type,
        subType: subType ?? this.subType,
        title: title ?? this.title);
  }
}
