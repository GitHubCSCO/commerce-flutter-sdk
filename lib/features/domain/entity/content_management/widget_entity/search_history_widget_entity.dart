import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class SearchHistoryWidgetEntity extends WidgetEntity {
  final String? title;
  final String? itemsCount;
  final List<String>? histories;

  SearchHistoryWidgetEntity(
      {String? id,
      WidgetType? type,
      String? subType,
      this.title,
      this.itemsCount,
      List<String>? histories})
      : histories = histories ?? [],
        super(id: id, type: type, subType: subType);

  @override
  SearchHistoryWidgetEntity copyWith(
      {String? id,
      WidgetType? type,
      String? subType,
      String? title,
      String? itemsCount,
      List<String>? histories}) {
    return SearchHistoryWidgetEntity(
        id: id ?? this.id,
        type: type ?? this.type,
        subType: subType ?? this.subType,
        title: title ?? this.title,
        itemsCount: itemsCount ?? this.itemsCount,
        histories: histories ?? this.histories);
  }

  @override
  List<Object?> get props => [...super.props, title, itemsCount, histories];
}
