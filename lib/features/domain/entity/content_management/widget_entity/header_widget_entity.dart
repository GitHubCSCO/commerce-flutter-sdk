import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class HeaderWidget extends WidgetEntity {
  final String? title;

  const HeaderWidget({this.title});

  @override
  List<Object?> get props => [title];
}
