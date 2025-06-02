import 'package:commerce_flutter_sdk/src/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class SearchHistoryWidgetEntity extends WidgetEntity {
  final String? title;
  final String? itemsCount;

  SearchHistoryWidgetEntity({
    String? id,
    WidgetType? type,
    String? subType,
    this.title,
    this.itemsCount,
    List<String>? histories,
  }) : super(id: id, type: type, subType: subType);

  @override
  SearchHistoryWidgetEntity copyWith({
    String? id,
    WidgetType? type,
    String? subType,
    String? title,
    String? itemsCount,
  }) {
    return SearchHistoryWidgetEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      title: title ?? this.title,
      itemsCount: itemsCount ?? this.itemsCount,
    );
  }

  @override
  List<Object?> get props => [...super.props, title, itemsCount];
}
