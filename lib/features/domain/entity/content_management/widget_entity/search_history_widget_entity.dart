import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:equatable/equatable.dart';

class SearchHistoryWidgetEntity extends WidgetEntity {
  final String title;
  final String itemsCount;

  const SearchHistoryWidgetEntity(this.title, this.itemsCount);

  @override
  List<Object?> get props => [title, itemsCount];
}
