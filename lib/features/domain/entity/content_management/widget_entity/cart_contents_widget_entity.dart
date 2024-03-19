import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class CartContentsWidgetEntity extends WidgetEntity {
  final String? title;

  const CartContentsWidgetEntity(
      {String? id, WidgetType? type, String? subType, this.title})
      : super(id: id, type: type, subType: subType);

  @override
  List<Object?> get props => [title];

  @override
  CartContentsWidgetEntity copyWith({
    String? id,
    WidgetType? type,
    String? subType,
  }) {
    return CartContentsWidgetEntity(
        id: id ?? this.id,
        type: type ?? this.type,
        subType: subType ?? this.subType,
        title: title ?? this.title);
  }
}
