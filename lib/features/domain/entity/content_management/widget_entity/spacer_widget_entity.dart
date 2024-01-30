import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class SpacerWidgetEntity extends WidgetEntity {
  final int height;
  final String backgroundColor;

  const SpacerWidgetEntity(this.height, this.backgroundColor);

  @override
  List<Object?> get props => [height, backgroundColor];
}
