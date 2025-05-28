import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class LocationNoteWidgetEntity extends WidgetEntity {
  final String? title;

  LocationNoteWidgetEntity({
    this.title,
    String? id,
    WidgetType? type,
    String? subType,
  }) : super(id: id, type: type, subType: subType);

  @override
  LocationNoteWidgetEntity copyWith({
    String? title,
    String? id,
    WidgetType? type,
    String? subType,
  }) {
    return LocationNoteWidgetEntity(
      title: title ?? this.title,
    );
  }
}
