import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class CartButtonsWidgetEntity extends WidgetEntity {
  final String? title;
  final bool? isAddDiscountEnabled;
  final bool? isSavedOrderEnabled;
  final bool? isAddToListEnabled;

  const CartButtonsWidgetEntity(
      {String? id,
      WidgetType? type,
      String? subType,
      this.title,
      this.isAddDiscountEnabled,
      this.isSavedOrderEnabled,
      this.isAddToListEnabled})
      : super(id: id, type: type, subType: subType);

  @override
  List<Object?> get props => [title];

  @override
  CartButtonsWidgetEntity copyWith({
    String? id,
    WidgetType? type,
    String? subType,
    String? title,
    bool? isAddDiscountEnabled,
    bool? isSavedOrderEnabled,
    bool? isAddToListEnabled,
  }) {
    return CartButtonsWidgetEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      title: title ?? this.title,
      isAddDiscountEnabled: isAddDiscountEnabled ?? this.isAddDiscountEnabled,
      isSavedOrderEnabled: isSavedOrderEnabled ?? this.isSavedOrderEnabled,
      isAddToListEnabled: isAddToListEnabled ?? this.isAddToListEnabled,
    );
  }
}
