import 'package:commerce_flutter_sdk/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class HeaderWidgetEntity extends WidgetEntity {
  final String? title;

  const HeaderWidgetEntity({this.title});

  @override
  List<Object?> get props => [title];
}
