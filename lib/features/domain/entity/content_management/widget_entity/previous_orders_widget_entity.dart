import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class PreviousOrdersWidgetEntity extends WidgetEntity {
  final String? title;

  PreviousOrdersWidgetEntity({
    this.title,
    String? id,
    WidgetType? type,
    String? subType,
  }) : super(id: id, type: type, subType: subType);

  @override
  PreviousOrdersWidgetEntity copyWith({
    String? title,
    String? id,
    WidgetType? type,
    String? subType,
  }) {
    return PreviousOrdersWidgetEntity(
      title: title ?? this.title,
    );
  }
}
