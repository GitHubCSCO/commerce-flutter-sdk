import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class CarouselWidget extends WidgetEntity {
  final List<CarouselSlideWidget> childWidgets;
  final int timerSpeed;
  final int animationSpeed;

  const CarouselWidget({
    required this.childWidgets,
    required this.timerSpeed,
    required this.animationSpeed,
  });

  @override
  List<Object?> get props => [childWidgets, timerSpeed, animationSpeed];
}
