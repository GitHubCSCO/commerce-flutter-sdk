// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class CurrentLocationWidgetEntity extends WidgetEntity {
  final String? title;

  CurrentLocationWidgetEntity({
    this.title,
    String? id,
    WidgetType? type,
    String? subType,
  }) : super(id: id, type: type, subType: subType);

  @override
  CurrentLocationWidgetEntity copyWith({
    String? title,
    String? id,
    WidgetType? type,
    String? subType,
  }) {
    return CurrentLocationWidgetEntity(
      title: title ?? this.title,
    );
  }
}
