import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';
import 'package:equatable/equatable.dart';

class SpacerWidget extends WidgetEntity {
  final int height;
  final String backgroundColor;

  const SpacerWidget(this.height, this.backgroundColor);

  @override
  List<Object?> get props => [height, backgroundColor];
}
