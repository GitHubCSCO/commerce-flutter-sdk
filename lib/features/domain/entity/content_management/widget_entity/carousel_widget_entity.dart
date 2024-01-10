import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/carousel_slide_widget.dart';
import 'package:commerce_flutter_app/features/domain/entity/content_management/widget_entity/widget_entity.dart';

class CarouselWidgetEntity extends WidgetEntity {
  final List<CarouselSlideWidgetEntity>? childWidgets;
  final int? timerSpeed;
  final int? animationSpeed;

  const CarouselWidgetEntity({
    this.childWidgets,
    this.timerSpeed,
    this.animationSpeed,
  });

  CarouselWidgetEntity copyWith({
    List<CarouselSlideWidgetEntity>? childWidgets,
    int? timerSpeed,
    int? animationSpeed,
  }) {
    return CarouselWidgetEntity(
      childWidgets: childWidgets ?? this.childWidgets,
      timerSpeed: timerSpeed ?? this.timerSpeed,
      animationSpeed: animationSpeed ?? this.animationSpeed,
    );
  }

  @override
  List<Object?> get props => [childWidgets, timerSpeed, animationSpeed];
}
